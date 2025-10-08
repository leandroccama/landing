export interface NavItem {
  title: string;
  href: string;
}

export const mainNav: NavItem[] = [
  { title: 'Servicios', href: '#servicios' },
  { title: 'Portafolio', href: '#portafolio' },
  { title: 'Precios', href: '#precios' },
  { title: 'Contacto', href: '#contacto' },
];

export const WHATSAPP_LINK =
  'https://wa.me/51928229965?text=Hola%2C%20quiero%20saber%20m%C3%A1s%20sobre%20tus%20servicios.';
