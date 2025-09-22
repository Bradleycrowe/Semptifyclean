// Semptify One-Click Builder — 9/20/2025
// Creates Vault, GUIL, RightsNavigator, LetterGenerator modules and wires App.js

const fs = require('fs');
const path = require('path');

const modules = {
  Vault: `export function Vault() {
    return <div><h2>Vault</h2><p>Upload and view files</p></div>;
  }`,
  GUIL: `export function GUIL() {
    return <div><h2>GUIL Interface</h2><p>Upload + Indexed Lookup</p></div>;
  }`,
  RightsNavigator: `export function RightsNavigator() {
    return (
      <div>
        <h2>Rights Navigator</h2>
        <input placeholder="Search protections…" />
        <select><option value="MN">Minnesota</option></select>
      </div>
    );
  }`,
  LetterGenerator: `export function LetterGenerator() {
    return (
      <div>
        <h2>Letter Generator</h2>
        <form>
          <input placeholder="Your name" />
          <input placeholder="Landlord name" />
          <select><option value="repair">Repair Request</option></select>
          <button>Generate Letter</button>
        </form>
      </div>
    );
  }`,
};

const srcPath = path.join(__dirname, 'client', 'src');

for (const [name, content] of Object.entries(modules)) {
  const filePath = path.join(srcPath, `${name}.js`);
  fs.writeFileSync(filePath, content);
  console.log(`✅ Created ${name}.js`);
}

// Wire App.js
const appPath = path.join(srcPath, 'App.js');
let appContent = fs.readFileSync(appPath, 'utf8');

for (const name of Object.keys(modules)) {
  if (!appContent.includes(`import { ${name} }`)) {
    appContent = `import { ${name} } from './${name}';\n` + appContent;
  }
}

const routeBlock = `
<Route path="/vault" element={<Vault />} />
<Route path="/guil" element={<GUIL />} />
<Route path="/rights" element={<RightsNavigator />} />
<Route path="/letters" element={<LetterGenerator />} />
`;

if (!appContent.includes('/vault')) {
  appContent = appContent.replace('<Routes>', `<Routes>${routeBlock}`);
  fs.writeFileSync(appPath, appContent);
  console.log(`🔗 App.js wired with all routes`);
}

console.log(`🎉 Semptify scaffold complete — Vault, GUIL, Rights, Letters ready`);
