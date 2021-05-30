import Component from "@ember/component";

export default Component.extend({
  actions: {
    userChanged(selectedUsername) {
      this.set("value", selectedUsername[0]);

      this.valueChanged &&
        this.valueChanged({
          target: {
            value: selectedUsername[0],
          },
        });
    },
  },
});
