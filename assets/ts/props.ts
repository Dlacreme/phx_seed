
export class Props {
  constructor() { }

  public add(el_id, classname): void {
    const el = document.getElementById(el_id);
    if (!el) {
      console.debug(`${el_id} missing from DOM`);
      return;
    }
    el.classList.add(classname);
  }

  public remove(el_id, classname): void {
    const el = document.getElementById(el_id);
    if (!el) {
      console.debug(`${el_id} missing from DOM`);
      return;
    }
    el.classList.remove(classname);
  }

  public switch(el_id, classname): void {
    const el = document.getElementById(el_id);
    if (!el) {
      console.debug(`${el_id} missing from DOM`);
      return;
    }
    el.classList.contains(classname) ?
      el.classList.remove(classname) : el.classList.add(classname);
  }
}