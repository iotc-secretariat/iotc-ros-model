window.dbTables_columns = %s;
window.dbTables_dependencies = %s;
window.dbTables_usages = %s;
window.dbTables_descriptions = %s;

function selectNode(nodeId) {
  window.myNetwork.setSelection( { nodes: [nodeId] });
  navigateToNode(nodeId);
}

function navigateToNode(nodeId) {
  showNodeDetails(nodeId);
  highlightNeighborhood(nodeId)
}

function handleHashChange() {
  const nodeId = decodeURIComponent( window.location.hash.substring(1) );
  if (!nodeId) clearNodeDetails(); else selectNode(nodeId);
}
function highlightNeighborhood(nodeId) {
    const connectedEdges = window.myNetwork.getConnectedEdges(nodeId);
    const edges = window.myNetwork.body.data.edges;
    edges.get().forEach(edge => { edges.update({ id: edge.id, width: 1 }); });
    connectedEdges.forEach(edgeId => { edges.update({ id: edgeId, width: 2 });});
}
window.addEventListener("load", function() {
  setTimeout(function() {
    window.addEventListener("hashchange", handleHashChange);
    handleHashChange();
    }, 500);
});

function clearNodeDetails() {
  document.getElementById('table-details').innerHTML = '<p>Select a node in the graph.</p>';
  const edges = window.myNetwork.body.data.edges;
  edges.get().forEach(edge => { edges.update({ id: edge.id, width: 1 }); });
}

function showNodeDetails(nodeId) {
  var columns = window.dbTables_columns[nodeId] || [];
  var dependencies = window.dbTables_dependencies[nodeId] || [];
  var usages = window.dbTables_usages[nodeId] || [];
  var description = window.dbTables_descriptions[nodeId] || '';
  description= !description || description === '' ? '<p class="error"><b><i>Not filled</i></b></p>' : '<p><b><i>' + description + '</i></b></p>';
  var html = `
  <h3>Table <b><i>${nodeId}</i></b></h3>
  <h4>Description</h4>
  ${description}
  ${generate_table_columns(nodeId, columns)}
  ${generate_table_dependencies(nodeId, dependencies)}
  ${generate_table_usages(nodeId, usages)}
  `;
  document.getElementById( 'table-details' ).innerHTML = html;
  document.querySelector('.details-panel') ?.scrollTo({ top: 0, behavior: 'smooth' });
}

function generate_table_columns(nodeId, data) {
  const rows = data.map(datum => `
    <tr${isTrue(datum.primary_key) ? ' class="primary_key"' : ''}>
      <td>${renderColumnName(datum.column, datum.mandatory, datum.primary_key, datum.foreign_key)}</td>
      <td>${datum.type}</td>
      <td>${!datum.description || datum.description === '' ? '<p class="error">Not filled</p>' : datum.description}</td>
    </tr>
  `).join('');

  return `
    <h4>Columns</h4>
    <table>
      <thead>
        <tr>
          <th>Column</th>
          <th>Type</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
        ${rows}
      </tbody>
    </table>
  `;
}
function patchReportAnchors(html) {
  if (!html) { return html; }
  return html.replace( /href=(['"])#table_([^'"]+)\1/g, 'href=$1#$2$1' );
}

function generate_table_dependencies(nodeId, data) {
  if (data.length == 0) {
  return `
    <h4>Dependencies</h4>
    <p>No dependency</p>
  `;
  }
  const rows = data.map(datum => `
    <tr${isTrue(datum.primary_key) ? ' class="mandatory"' : ''}>
      <td>${renderColumnNames(datum.columns, datum.mandatory, datum.primary_key, false)}</td>
      <td>${datum.dependency_type}</td>
      <td>${patchReportAnchors(datum.dependency_table)}</td>
      <td>${renderColumnNames(datum.dependency_columns, datum.dependency_mandatory, datum.dependency_primary_key, false)}</td>
    </tr>
  `).join('');
  return `
    <h4>Dependencies</h4>
    <table>
      <thead>
        <tr>
          <th>Column</th>
          <th>Relation type</th>
          <th>Dependency table</th>
          <th>Dependency column</th>
        </tr>
      </thead>
      <tbody>
        ${rows}
      </tbody>
    </table>
  `;
}

function generate_table_usages(nodeId, data) {
  if (data.length == 0) {
  return `
    <h4>Usages</h4>
    <p>No usage</p>
    <br/>
  `;
  }
  const rows = data.map(datum => `
    <tr>
      <td>${renderColumnNames(datum.columns, datum.mandatory, datum.primary_key, false)}</td>
      <td>${datum.usage_type}</td>
      <td>${patchReportAnchors(datum.usage_table)}</td>
      <td>${renderColumnNames(datum.usage_columns, datum.usage_mandatory, datum.usage_primary_key, false)}</td>
    </tr>
  `).join('');

  return `
    <h4>Usages</h4>
    <table>
      <thead>
        <tr>
          <th>Column</th>
          <th>Relation type</th>
          <th>Usage table</th>
          <th>Usage column</th>
        </tr>
      </thead>
      <tbody>
        ${rows}
      </tbody>
    </table>
  `;
}

function hasValue(value) {
  return value !== null && value !== undefined && String(value).trim() !== "";
}

function isTrue(value) {
  return value === true || value === "TRUE" || value === "true" || value === "YES";
}

function iconSpan(className, title) {
  return `<span class="${className}" title="${title}" aria-hidden="true"></span>`;
}

function escapeHtml(value) {
  if (value === null || value === undefined) return "";
  return String(value)
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}

function renderColumnNames(columns, mandatory, primary_key, foreign_key) {
  const cols = Array.isArray(columns) ? columns : [columns];
  const mandatoryValues = Array.isArray(mandatory) ? mandatory : cols.map(() => mandatory);
  const pkValues = Array.isArray(primary_key) ? primary_key : cols.map(() => primary_key);
  const fkValues = Array.isArray(foreign_key) ? foreign_key : cols.map(() => foreign_key);

  return cols.map((column, index) =>
    renderColumnName(
      column,
      mandatoryValues[index],
      pkValues[index],
      fkValues[index]
    )
  ).join("<br/>");
}

function renderColumnName(column, mandatory, primary_key, foreign_key) {
  const is_mandatory = isTrue(mandatory);
  const is_pk = isTrue(primary_key);
  const is_fk = isTrue(foreign_key);
  const not_null = is_mandatory ? iconSpan("mandatory-icon", "Mandatory") : "";
  const pk = is_pk ? iconSpan("pk-icon", "Primary Key") : "";
  const fk = is_fk ? iconSpan("fk-icon", "Foreign Key") : "";
  const name = escapeHtml(column);
  const label = is_pk  ? `<span class="pk-column">${name}</span>` : name;
  return `${pk}${fk}${not_null}${label}`;
}