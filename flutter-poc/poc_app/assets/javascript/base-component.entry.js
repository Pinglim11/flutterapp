import { r as registerInstance, h } from './index-62e99a85.js';

const baseComponentCss = ".sample.sc-base-component{color:red}.group.sc-base-component{display:flex;flex-direction:row;align-items:center}.group.sc-base-component label.sc-base-component{margin-right:1em;min-width:100px}";

const BaseComponent = class {
  constructor(hostRef) {
    registerInstance(this, hostRef);
  }
  render() {
    return (h("div", { class: "parent" }, h("form", null, h("div", { class: "group" }, h("label", null, "Name: "), h("input", { type: "text", name: "name", id: "name" })), h("div", { class: "group" }, h("label", null, "Email: "), h("input", { type: "text", name: "name", id: "name" })), h("div", { class: "group" }, h("label", null, "City: "), h("input", { type: "text", name: "name", id: "name" })), h("div", { class: "group" }, h("label", null, "Province: "), h("input", { type: "text", name: "name", id: "name" })), h("div", { class: "group" }, h("label", null, "Country: "), h("input", { type: "text", name: "name", id: "name" })))));
  }
};
BaseComponent.style = baseComponentCss;

export { BaseComponent as base_component };
