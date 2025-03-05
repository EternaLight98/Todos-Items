import React from "react";

function useLocalStorege(itenName, initialValue) {
  const localStoregeItem = localStorage.getItem(itenName);

  let parsedItem;

  if (!localStoregeItem) {
    localStorage.setItem(itenName, JSON.stringify(initialValue));
    parsedItem = [];
  } else {
    parsedItem = JSON.parse(localStoregeItem);
  }
  const [item, setItem] = React.useState(parsedItem);

  // modificar localstorege
  const saveItem = (newItem) => {
    localStorage.setItem(itenName, JSON.stringify(newItem));
    setItem(newItem);
  };

  return [item, saveItem];
}

export { useLocalStorege };
