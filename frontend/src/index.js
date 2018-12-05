import './styles/main.css';
import { Elm } from './elm/Main.elm';
import '@fortawesome/fontawesome-free/css/all.min.css'
import registerServiceWorker from './registerServiceWorker';
import {saveJwt, restoreJwt} from './js/jwt-port';


const app = Elm.Main.init({
  flags: restoreJwt()
});

app.ports.saveJwt.subscribe(saveJwt)

registerServiceWorker();
