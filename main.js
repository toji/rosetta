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
      selectedExtension: 'md',
      code: '',
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
    async displayShader(shaderFile, extension) {
      this.selectedFile = shaderFile;
      this.selectedExtension = extension;

      loadShader(shaderFile.url, extension);
    }
  }
});
app.mount('#rosetta');

// Initialize monaco editors
const containers = document.querySelectorAll('.editor');
if (containers.length > 1) {
  containers[1].classList.add('hidden');
}

const editors = [];

async function fetchForEditor(index, fileUrl, extension) {
  const result = await fetch(`${fileUrl}.${extension}`);
  const text = await result.text();

  const model = editors[index].getModel();
  monaco.editor.setModelLanguage(model, EXTENSION_LANGUAGES[extension] ?? 'javascript');
  editors[index].setValue(text);
}

async function loadShader(fileUrl, extension = undefined) {
  fetchForEditor(0, fileUrl, extension);

  /*if (extensions.length > 1) {
    containers[1].classList.remove('hidden');
    fetchForEditor(1, shaderName, extensions[1]);
  } else {
    containers[1].classList.add('hidden');
    editors[1].setValue('// No second language set');
  }*/
}

for (const container of containers) {
  const editor = monaco.editor.create(container, {
    value: 'Editor content',
    language: 'markdown',
    readOnly: true,
    theme: 'vs-dark',
    minimap: {
      enabled: false
    },
    automaticLayout: true,
  });
  editors.push(editor);
}

loadShader('./categories/about/welcome', 'md');
