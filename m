From: Stephan Linz <linz@li-pro.net>
Subject: [PATCH v6] leds: documentation: 'ide-disk' to 'disk-activity'
Date: Fri, 24 Jun 2016 19:16:53 +0200
Message-ID: <20160624171704.13399-1-linz@li-pro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
Sender: linux-leds-owner@vger.kernel.org
To: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Stephan Linz <linz@li-pro.net>, Joseph Jezak <josejx@gentoo.org>, =?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>, Mark Rutland <mark.rutland@arm.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, Richard Purdie <rpurdie@rpsys.net>, Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Cc: Joseph Jezak <josejx@gentoo.org>
Cc: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Stephan Linz <linz@li-pro.net>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
---
Changes in v6:
  - Reorganize v5.

Changes in v5:
  - Keep documentation for the old 'ide-disk' device tree
    binding, but mark as deprecated and refer to the new
    trigger 'disk-activity'.

Changes in v4:
  - Keep the 'ide-disk' trigger and add a second one
    for 'disk-activity'.

Changes in v3:
  - Port to kernel 4.x
  - Split into platform independent and dependent parts.

v2: https://patchwork.ozlabs.org/patch/117485/
v1: http://dev.gentoo.org/~josejx/ata.patch
---
 Documentation/devicetree/bindings/leds/common.txt    | 4 +++-
 Documentation/devicetree/bindings/leds/leds-gpio.txt | 4 ++--
 Documentation/laptops/asus-laptop.txt                | 2 +-
 Documentation/leds/leds-class.txt                    | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Docume=
ntation/devicetree/bindings/leds/common.txt
index af10678..93ef6e6 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -26,7 +26,9 @@ Optional properties for child nodes:
      "default-on" - LED will turn on (but for leds-gpio see "default-s=
tate"
 		    property in Documentation/devicetree/bindings/gpio/led.txt)
      "heartbeat" - LED "double" flashes at a load average based rate
-     "ide-disk" - LED indicates disk activity
+     "disk-activity" - LED indicates disk activity
+     "ide-disk" - LED indicates IDE disk activity (deprecated),
+                  in new implementations use "disk-activity"
      "timer" - LED flashes at a fixed, configurable rate
=20
 - led-max-microamp : Maximum LED supply current in microamperes. This =
property
diff --git a/Documentation/devicetree/bindings/leds/leds-gpio.txt b/Doc=
umentation/devicetree/bindings/leds/leds-gpio.txt
index cbbeb18..5b1b43a 100644
--- a/Documentation/devicetree/bindings/leds/leds-gpio.txt
+++ b/Documentation/devicetree/bindings/leds/leds-gpio.txt
@@ -33,9 +33,9 @@ Examples:
 leds {
 	compatible =3D "gpio-leds";
 	hdd {
-		label =3D "IDE Activity";
+		label =3D "Disk Activity";
 		gpios =3D <&mcu_pio 0 GPIO_ACTIVE_LOW>;
-		linux,default-trigger =3D "ide-disk";
+		linux,default-trigger =3D "disk-activity";
 	};
=20
 	fault {
diff --git a/Documentation/laptops/asus-laptop.txt b/Documentation/lapt=
ops/asus-laptop.txt
index 79a1bc6..5f28587 100644
--- a/Documentation/laptops/asus-laptop.txt
+++ b/Documentation/laptops/asus-laptop.txt
@@ -72,7 +72,7 @@ LEDs
     echo 1 >  /sys/class/leds/asus::mail/brightness
   will switch the mail LED on.
   You can also know if they are on/off by reading their content and us=
e
-  kernel triggers like ide-disk or heartbeat.
+  kernel triggers like disk-activity or heartbeat.
=20
 Backlight
 ---------
diff --git a/Documentation/leds/leds-class.txt b/Documentation/leds/led=
s-class.txt
index 44f5e6b..f1f7ec9 100644
--- a/Documentation/leds/leds-class.txt
+++ b/Documentation/leds/leds-class.txt
@@ -11,7 +11,7 @@ brightness support so will just be turned on for non-=
zero brightness settings.
 The class also introduces the optional concept of an LED trigger. A tr=
igger
 is a kernel based source of led events. Triggers can either be simple =
or
 complex. A simple trigger isn't configurable and is designed to slot i=
nto
-existing subsystems with minimal additional code. Examples are the ide=
-disk,
+existing subsystems with minimal additional code. Examples are the dis=
k-activity,
 nand-disk and sharpsl-charge triggers. With led triggers disabled, the=
 code
 optimises away.
=20
--=20
2.9.0
