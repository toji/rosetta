const markdownIt = require("markdown-it");
const syntaxHighlight = require("@11ty/eleventy-plugin-syntaxhighlight");
const buildShaderList = require("./scripts/build-shader-list");
const fs = require('fs');

const shaderListOutPath = './page/_data/shaderList.json';

const highlightLanguage = {
  "es3.glsl": "glsl",
  "msl": "cpp",
}

function updateShaderList() {
  console.log('Rebuilding shader list...');
  fs.writeFileSync(shaderListOutPath, buildShaderList());
}
updateShaderList();

const fileRegex = /\/\/\s*@file\s*:\s*([a-zA-Z0-9\s]*)/g;

module.exports = function(eleventyConfig) {
  eleventyConfig.addPlugin(syntaxHighlight);
  eleventyConfig.addPassthroughCopy('./page/assets');

  const md = new markdownIt({ html: true });

  eleventyConfig.addPairedShortcode("shader", (content, ext) => {
    if (ext == 'md') {
      return md.render(content);
    }
    output = syntaxHighlight.pairedShortcode(content, highlightLanguage[ext] ?? ext);
    return output.replaceAll(fileRegex, '<h4>$1</h4>');
  });

  eleventyConfig.addWatchTarget("./shaders");

  eleventyConfig.on('eleventy.beforeWatch', async (changedFiles) => {
    for (file of changedFiles) {
      console.log(file);
      if (file.includes('./shaders/')) {
        updateShaderList();
        return;
      }
    }
  });

  return {
    dir: {
      input: "page",
      output: "_site",
    }
  }
};