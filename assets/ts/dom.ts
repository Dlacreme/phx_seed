export class Dom {
  constructor() { }

  public remove(ev: HTMLElement): void {
    console.log('ev ?>', ev);
    ev.remove();
  }
}