import { createElement } from 'lwc';
import HelloWorld from 'c/helloWorld';

describe('c-hello-world', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('should render a dafault value', () => {
        const element = createElement('c-hello-world', {
            is: HelloWorld
        });
        document.body.appendChild(element);

        const greetElem = element.shadowRoot.querySelector('p');
        expect(greetElem.textContent).toBe('Hello, World!');
    });
 
    it('should render a text as we type', async () => {
        const element = createElement('c-hello-world', {
            is: HelloWorld
        });
        document.body.appendChild(element);
        const greetElem = element.shadowRoot.querySelector('p');

        const inputElem = element.shadowRoot.querySelector('lightning-input');
        inputElem.value = 'Testing Change Event';
        inputElem.dispatchEvent(new CustomEvent('change'));

        return Promise.resolve().then(() => {
            expect(greetElem.textContent).toBe('Hello, Testing Change Event!');
        });
    });
});