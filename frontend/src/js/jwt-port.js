export function saveJwt (jwtString) {
  window.localStorage.setItem('jwt', jwtString)
}

export function restoreJwt () {
  return window.localStorage.getItem('jwt')
}
