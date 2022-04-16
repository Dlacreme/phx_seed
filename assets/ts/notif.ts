enum Type {
  Info = 'info',
  Warning = 'warning',
  Error = 'error',
}

interface Notification {
  type: Type
  content: string;
  timeout?: number;
  element: HTMLDivElement;
}

export class Notif {

  private readonly notifContainerId = 'cc-notif-container';

  constructor() { }

  public info(content: string, timeout = 5000): Notification {
    return this.push(content, Type.Info, timeout);
  }

  public warning(content: string, timeout = 5000): Notification {
    return this.push(content, Type.Warning, timeout);
  }

  public error(content: string, timeout = 5000): Notification {
    return this.push(content, Type.Error, timeout);
  }

  private push(content: string, type: Type, timeout): Notification {
    const el = document.createElement('div');
    const notification: Notification = {
      type: type,
      content: content,
      timeout: timeout,
      element: el,
    }
    el.classList.add('cc-notif');
    el.classList.add(type.toString());
    const pContent = document.createElement('p');
    pContent.innerText = content;
    const closeBtn = document.createElement('button');
    const closeIcon = document.createElement('icon');
    closeIcon.classList.add('material-icons');
    closeIcon.innerText = 'close';
    closeBtn.onclick = () => {
      this.clear(notification);
    };
    closeBtn.appendChild(closeIcon);
    el.appendChild(pContent);
    el.appendChild(closeBtn);
    this.addToDOM(notification);
    if (notification.timeout) {
      window.setTimeout(() => {
        this.clear(notification);
      }, notification.timeout);
    }

    return notification;
  }

  public clear(notif: Notification): void {
    // TODO: should free Notification to avoid memory lock
    this.getContainer().removeChild(notif.element);
  }

  private addToDOM(notif: Notification): void {
    this.getContainer().appendChild(notif.element);
  }

  private getContainer(): HTMLElement {
    return document.getElementById(this.notifContainerId);
  }
}