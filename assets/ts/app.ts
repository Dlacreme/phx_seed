import "./_phoenix"; // phoenix basic conf
import { Notif } from "./notif";
import { Props } from "./props";
import { Visibility } from "./visibility";
import { Dom } from "./dom";

(window as any).APP = {
  visibility: new Visibility(),
  props: new Props(),
  notif: new Notif(),
  dom: new Dom(),
};