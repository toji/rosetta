import { QueryArgs } from './query-args.js';

const selectedTab = QueryArgs.getString('ext');
if (selectedTab) {
  const tab = document.getElementById(selectedTab);
  if (tab) { tab.checked = true; }
}