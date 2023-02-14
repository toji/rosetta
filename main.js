import { createApp } from './node_modules/vue/dist/vue.esm-browser.js'
import { shaderList } from './shader-list.js'

const EXTENSION_LANGUAGES = {
  md: 'markdown',
  wgsl: 'rust',
  glsl: 'cpp',
  hlsl: 'cpp',
  msl: 'cpp',
}

const app = createApp({
  data() {
    return {
      filter: '',
      shaderList,
      selectedFile: shaderList.About.Welcome,
      selectedExtension0: 'md',
      selectedExtension1: 'md',
      code: '',
      navCollapsed: true,
    }
  },
  computed: {
    filteredShaderList() {
      if (!this.filter) { return shaderList; }

      const filterText = this.filter.toLowerCase();

      const filteredList = {};
      for (const category in shaderList) {
        if (category.toLowerCase().includes(filterText)) {
          filteredList[category] = shaderList[category];
          continue;
        }

        const filteredFiles = {};
        for (const name in shaderList[category]) {
          const file = shaderList[category][name];
          if (name.toLowerCase().includes(filterText) || file.extensions.includes(filterText)) {
            filteredFiles[name] = shaderList[category][name];
            continue;
          }
        }

        if (Object.keys(filteredFiles).length) {
          filteredList[category] = filteredFiles;
        }
      }
      return filteredList;
    }
  },
  methods: {
    async displayShader(shaderFile, extension, editorIndex) {
      this.selectedFile = shaderFile;

      if (extension === undefined) {
        extension = shaderFile.extensions[0];
      }

      if (editorIndex === undefined) {
        const extensionIndex = shaderFile.extensions.indexOf(extension);
        for (let i = 0; i < editors.length; ++i) {
          const ext = shaderFile.extensions[(extensionIndex + i) % shaderFile.extensions.length];
          this[`selectedExtension${i}`] = ext;
          loadShader(shaderFile.url, ext, i);
        }
      } else {
        this[`selectedExtension${editorIndex}`] = extension;
        loadShader(shaderFile.url, extension, editorIndex);
      }
      this.navCollapsed = true;
    }
  }
});
app.mount('#rosetta');

// Initialize monaco editors
const containers = document.querySelectorAll('.text-area');
/*if (containers.length > 1) {
  containers[1].classList.add('hidden');
}*/

const editors = [];

async function fetchShader(fileUrl, extension) {
  const result = await fetch(`${fileUrl}.${extension}`);
  return result.text();
}

async function loadShader(fileUrl, extension, editorIndex) {
  const text = await fetchShader(fileUrl, extension);

  const model = editors[editorIndex].getModel();
  monaco.editor.setModelLanguage(model, EXTENSION_LANGUAGES[extension] ?? 'javascript');
  editors[editorIndex].setValue(text);
}

for (const container of containers) {
  const editor = monaco.editor.create(container, {
    value: 'No selection',
    language: 'markdown',
    readOnly: true,
    theme: 'vs-dark',
    minimap: {
      enabled: false
    },
    automaticLayout: true,
    //lineNumbers: false,
  });
  editors.push(editor);
}

loadShader('./categories/about/welcome', 'md', 0);
