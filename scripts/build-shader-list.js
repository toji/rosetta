// Run from the project root.
const fs = require('fs');

const shaderFolder = './shaders';

// Only files with the following extensions will be listed
const validExtensions = [
  'md', 'wgsl', 'glsl', 'hlsl', 'msl'
];

const ignore = ['node_modules'];

const shaderList = {};

function formatName(name) {
  const parts = name.split('-');
  for (let i = 0; i < parts.length; ++i) {
    if (!parts[i].length) { continue; }
    parts[i] = parts[i][0].toUpperCase() + parts[i].substr(1);
  }
  return parts.join(' ');
}

function matchFiles(baseFolder, extensions, recurse = true) {
  const matches = [];

  fs.readdirSync(baseFolder).forEach(file => {
    if (ignore.includes(file)) { return; }

    if (fs.statSync(`${baseFolder}/${file}`).isDirectory() && recurse) {
      matches.push(...matchFiles(`${baseFolder}/${file}`, extensions, recurse));
      return;
    }

    const filenameParts = file.split('.');
    if (!extensions.includes(filenameParts[filenameParts.length - 1])) {
      return;
    }

    matches.push({
      folder: baseFolder,
      name: file,
    });
  });

  return matches;
}

module.exports = function buildShaderList() {
  const folderFiles = {};
  const allFiles = [];
  function processFile(file) {
    const formattedFolder = formatName(
      file.folder
        .replace(shaderFolder, '')
        .replace('.', '')
        .replace('/', ' ')
        .trim()
    );

    if (!folderFiles[formattedFolder]) {
      folderFiles[formattedFolder] = {};
    }

    const files = folderFiles[formattedFolder];

    const filenameParts = file.name.split('.');
    const filename = filenameParts.shift();

    if (!files[filename]) {
      const newFile = {
        name: formatName(filename),
        url: `${file.folder}/${filename}`,
        extensions: []
      };
      files[filename] = newFile;
      allFiles.push(newFile);
    }
    files[filename].extensions.unshift(filenameParts.join('.'));
  }

  matchFiles('.', ['md'], false).forEach(processFile);
  matchFiles(shaderFolder, validExtensions).forEach(processFile);

  return JSON.stringify({
    categories: folderFiles,
    shaders: allFiles
  }, null, 2);
}

