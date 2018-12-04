import './main.css';
import { Elm } from './elm/Main.elm';
import registerServiceWorker from './registerServiceWorker';

Elm.Main.init();

registerServiceWorker();
