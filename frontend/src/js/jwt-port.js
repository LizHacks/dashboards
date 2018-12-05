const jwtKey = 'jwt';

export function saveJwt (jwtString) {
  window.localStorage.setItem(jwtKey, jwtString);
}

export function restoreJwt () {
  return window.localStorage.getItem(jwtKey);
}

export function deleteJwt () {
  return window.localStorage.removeItem(jwtKey);
}
