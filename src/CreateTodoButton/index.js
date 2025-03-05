import './CreateTodoButton.css'

function CreateTodoButtonutton(){
    return (
    <button className="CreateTodoButton"
    onClick={
        (event) => {
            console.log('Haz dado clic');
            console.log(event);
            console.log(event.target);
        }
    }
    >+</button>
    )
}

export {CreateTodoButtonutton}