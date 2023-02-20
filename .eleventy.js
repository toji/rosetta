const syntaxHighlight = require("@11ty/eleventy-plugin-syntaxhighlight");
const buildShaderList = require("./scripts/build-shader-list");
const fs = require('fs');

const shaderListOutPath = './page/_data/shaderList.json';

function updateShaderList() {
  console.log('Rebuilding shader list...');
  fs.writeFileSync(shaderListOutPath, buildShaderList());
}
updateShaderList();

module.exports = function(eleventyConfig) {
  eleventyConfig.addPlugin(syntaxHighlight);
  eleventyConfig.addPassthroughCopy('./page/assets');
  //eleventyConfig.addPassthroughCopy('./shaders');

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