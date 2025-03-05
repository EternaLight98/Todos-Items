import React from "react";
import { AppUI } from "./AppUI";
import { useLocalStorege } from "./useLocalStorage";

// const defaultTodos = [
//   { text: 'Cortar cebolla',
//     completed: true
//   },
//   { text: 'Tomar el curso de React.js',
//     completed: true
//   },
//   { text: 'lorar con la llorona',
//     completed: false
//   },
//   { text: 'Soy el mejor programador',
//     completed: false
//   },
//   { text: 'LALALALALA',
//     completed: false
//   },
//   { text: 'Juagando GEARS 5',
//     completed: true
//   }
// ];

// localStorage.setItem('TODOS_V1', JSON.stringify(defaultTodos));

// localStorage.removeItem('TODOS_V1');

function App() {
  const [todos, saveTodos] = useLocalStorege("TODOS_V1", []); // estados
  const [searchValue, setSearchValue] = React.useState("");

  const completedTodos = todos.filter((todo) => !!todo.completed).length;
  const totalTodos = todos.length;

  const searchedTodos = todos.filter((todo) => {
    const todoText = todo.text.toLowerCase();
    const searchText = searchValue.toLowerCase();

    return todoText.includes(searchText);
  });

  // completar Todos
  const completeTodo = (text) => {
    const newTodos = [...todos];
    const todoIndex = newTodos.findIndex((todo) => todo.text === text);
    newTodos[todoIndex].completed = true;
    saveTodos(newTodos);
  };

  // Eliminar Todos
  const deleteTodo = (text) => {
    const newTodos = [...todos];
    const todoIndex = newTodos.findIndex((todo) => todo.text === text);
    newTodos.splice(todoIndex, 1);
    saveTodos(newTodos);
  };

  return (
    <AppUI
      completedTodos={completedTodos}
      totalTodos={totalTodos}
      searchValue={searchValue}
      setSearchValue={setSearchValue}
      searchedTodos={searchedTodos}
      completeTodo={completeTodo}
      deleteTodo={deleteTodo}
    />
  );
}

export default App;
