import { QueryArgs } from './query-args.js';

function loadShader(shaderName, ext = undefined) {
  document.querySelector('nav').classList.add('collapsed');

  const shader = document.querySelector(`.shader[data-shader-name="${shaderName}"]`);
  const extensions = shader.querySelectorAll('li');

  const editors = document.querySelectorAll('.editor');

  for (let i = 0; i < editors.length; ++i) {
    if(i >= extensions.length) {
      editors[i].classList.add('hidden');
      continue;
    }

    let selectedExt = extensions[i].innerText;
    if (i == 0 && ext) {
      selectedExt = ext;
    } else if (selectedExt == ext) {
      // This is clunky, but whatever.
      selectedExt = extensions[(i+1)% extensions.length].innerText;
    }

    editors[i].classList.remove('hidden');
    editors[i].src = `shaders/${shaderName}.html?ext=${selectedExt}`;
  }
}

const shaders = document.querySelectorAll('.shader');

// Bind the click event for each shader in the nav menu.
shaders.forEach((shader) => {
  const shaderName = shader.getAttribute('data-shader-name');
  shader.addEventListener('click', () => loadShader(shaderName));

  const extensions = shader.querySelectorAll('li');
  extensions.forEach((extension) => {
    extension.addEventListener('click', (event) => {
      event.stopPropagation();
      loadShader(shaderName, extension.innerText)
    });
  });
});

// Set up the filter logic
document.getElementById('filter').addEventListener('input', (event) => {
  const text = event.target.value;
  for (const shader of shaders) {
    const label = shader.querySelector('label');
    if (!text || label.innerText.includes(text)) {
      shader.classList.remove('hidden');
    } else {
      shader.classList.add('hidden');
    }
  }
});

// Bind the click event for expanding/collapsing the nav menu.
document.getElementById('expand').addEventListener('click', () => {
  const nav = document.querySelector('nav');
  if(nav.classList.contains('collapsed')) {
    nav.classList.remove('collapsed');
  } else {
    nav.classList.add('collapsed');
  }
});
