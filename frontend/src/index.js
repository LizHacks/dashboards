import './styles/main.css';
import { Elm } from './elm/Main.elm';
import '@fortawesome/fontawesome-free/css/all.min.css'
import registerServiceWorker from './registerServiceWorker';

Elm.Main.init({
  flags: localStorage.getItem('token')
});

registerServiceWorker();
