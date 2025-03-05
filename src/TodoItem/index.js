import "./TodoItem.css";
import { CompletedIcon } from "../TodoIcon/CompleteIcon";
import { DeleteIcon } from "../TodoIcon/DeleteIcon";

function TodoItem(props) {
  return (
    <li className="TodoItem">
      <CompletedIcon
        completed={props.completed}
        onComplete={props.onComplete}
      />
      <p className={`TodoItem-p ${props.completed && "TodoItem-p--complete"}`}>
        {props.text}
      </p>
      <DeleteIcon onDelete={props.onDelete} />
    </li>
  );
}

export { TodoItem };
