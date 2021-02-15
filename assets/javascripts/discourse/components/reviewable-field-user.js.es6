import Component from "@ember/component";

export default Component.extend({
  actions: {
    userChanged(previouslySelected, selected) {
      this.valueChanged &&
        this.valueChanged({
          target: {
            value: selected[0],
          },
        });
    },
  },
});
