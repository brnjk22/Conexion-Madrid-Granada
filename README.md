# Proyecto Red LaLiga Santander
Esto es un proyecto para montar y configurar la red de uno de los departamentos de **LaLiga Santander**. Esta entidad quiso contar con la ayuda de NetNinjas, una empresa formada por dos miembros cuyas ambiciones son infinitas, para llevar a cabo un **plan estratégico de digitalización y análisis avanzado de datos**. En este contexto, se proyecta la apertura de un nuevo **Centro de Investigación Digital y Auditoría Financiera** en la ciudad de Madrid. Los encargados de este trabajo seran David López <daaviidlopezz13@gmail.com> y Bruno Nicolas <brunoocampoperez@gmail.com>

## 1. Objetivo

Este centro tiene como objetivo dotarse de infraestructura tecnológica avanzada para analizar operaciones financieras, patrones de comportamiento y comunicaciones relacionadas con **casos bajo investigación dentro del fútbol profesional español**, entre ellos, asuntos vinculados a **posibles irregularidades en pagos o influencias en el colectivo arbitral por parte del Real Madrid Club de Fútbol**.
La propuesta contempla la creación de una red eficiente, escalable y segmentada, que permita a nuestros equipos:

- Trabajar de forma segura y estable en entornos diferenciados (investigación, administración, sistemas).


- Acceder a recursos internos y externos bajo políticas de seguridad estrictas.


- Asegurar una gestión sencilla del entorno por parte de nuestros equipos técnicos.


>LaLiga: "La estructura que proponemos se basa en un modelo de red moderno que combina conectividad eficiente entre puestos de trabajo, servidores internos, impresoras, y salida controlada a Internet, todo ello bajo medidas de protección adecuadas.
Solicitamos que se nos presente una propuesta de ejecución, incluyendo plazos estimados, fases de implementación y recursos necesarios. La implantación de esta red es clave para avanzar en uno de los proyectos estratégicos del presente año."

## 2. Planificacion del Proyecto

Queremos llevar a cabo un diseño, despliegue y configuración de una infraestructura de red segura, escalable y segmentada, basada en topología Leaf-Spine, que permita:
El aislamiento lógico de entornos de análisis, servidores y personal.


- La conexión segura a Internet y servicios cloud.


- La captura y auditoría de tráfico interno.


- Alta disponibilidad para la operación continua del centro.

## 3. Alcance y Correspondencias con la Topologia Propuesta

* ### Spine y Leaf – Núcleo de Conmutación Redundante

    - **Switches Spine (S1 y S2):** *192.168.10.20 y 192.168.10.30* \
 Proporcionarán el núcleo de alta disponibilidad y baja latencia, garantizando conectividad este-oeste entre todos los dispositivos del centro.
 __*(Debidoa a la carencia de Switches de Layer3 hemos optado por usar Routers)*__

    - **Switches Leaf (L1–L5):** *192.168.10.40 a 192.168.10.80* \
 Encargados de interconectar a usuarios, equipos de análisis, impresoras, servidores y puntos de acceso físico.
 
---
* ### Usuarios e Investigación

    - **CORP:** Usuarios de administración e investigación – VLAN 30

    - **IT-USERS:** Técnicos de red, analistas forenses y personal de campo – VLAN 50

    - **PRINTER:** Impresoras de uso interno – VLAN 40

    - **WEB y SRI:** Servidores internos con acceso a bases de datos de LaLiga y fuentes de datos externas – VLAN 20

*Todos estos dispositivios estarán conectados a través de los Leaf L3, L4 y L5*

* ### Seguridad Perimetral y Control de Tráfico

    - **R1 y R2:** Encargados de enrutar el tráfico interno hacia la red perimetral.


    - **Firewall:** Punto de inspección donde se aplicarán reglas de acceso, logging y detección de intrusiones.


    - **R3:** Enlace controlado a Internet (192.168.10.3) para servicios externos y sincronización con plataformas en la nube de LaLiga.
---
* ### Segmentación Lógica por VLANs

La red estará segmentada con las siguientes VLANs, con el fin de aislar funciones críticas y garantizar la seguridad de las investigaciones:

| VLAN | Propósito | Red |
| :----: | :---------: | :---: |
| 10 | Gestion de red y dispositivos | 192.168.10.0/24 |
| 20 | Servidores de datos y aplicaciones | 192.168.20.0/24 |
| 30 | Personal administrativo e interno | 192.168.30.0/24 |
| 40 | Impresoras y dispositivos pasivos | 192.168.40.0/24 |
| 50 | Usuarios técnicos e investigadores | 192.168.50.0/24 |
| 60 | Gestion remota y mantenimiento | 192.168.60.0/24 |

## 4. Diseño de la Topología

![Topologia que se utilizara](Diagram/Topologia_Spine-Leaf_LaLiga.drawio.svg)