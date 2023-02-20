function loadShader(shaderUrl) {
  document.querySelector('nav').classList.add('collapsed');

  const editors = document.querySelectorAll('.editor');
  for (let i = 0; i < editors.length; ++i) {
    editors[i].src = `${shaderUrl}.html`;

    /*if (i > 0) {
      const radios = editors[i].querySelectorAll(`.tab input[type=radio]`);
      radios[i % radios.length].checked = true;
    }*/
  }
}

function toggleNav(event) {
  const nav = document.querySelector('nav');
  if(nav.classList.contains('collapsed')) {
    nav.classList.remove('collapsed');
  } else {
    nav.classList.add('collapsed');
  }
}

document.getElementById('filter').addEventListener('input', (event) => {
  const text = event.target.value;
  const shaders = document.querySelectorAll('.shader');
  for (const shader of shaders) {
    const label = shader.querySelector('label');
    if (!text || label.innerText.includes(text)) {
      shader.classList.remove('hidden');
    } else {
      shader.classList.add('hidden');
    }
  }
});