From: Stephan Linz <linz@li-pro.net>
Subject: [PATCH v3 2/7] leds: documentation: 'ide-disk' to 'disk-activity'
Date: Thu,  9 Jun 2016 00:29:37 +0200
Message-ID: <20160608223000.433-2-linz@li-pro.net>
References: <20160608223000.433-1-linz@li-pro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608223000.433-1-linz@li-pro.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Stephan Linz <linz@li-pro.net>, Joseph Jezak <josejx@gentoo.org>, Nico Macrionitis <acrux@cruxppc.org>, =?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Cc: Joseph Jezak <josejx@gentoo.org>
Cc: Nico Macrionitis <acrux@cruxppc.org>
Cc: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
Signed-off-by: Stephan Linz <linz@li-pro.net>
---
 Documentation/devicetree/bindings/leds/common.txt    | 2 +-
 Documentation/devicetree/bindings/leds/leds-gpio.txt | 2 +-
 Documentation/laptops/asus-laptop.txt                | 2 +-
 Documentation/leds/leds-class.txt                    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Docume=
ntation/devicetree/bindings/leds/common.txt
index af10678..1e97169 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -26,7 +26,7 @@ Optional properties for child nodes:
      "default-on" - LED will turn on (but for leds-gpio see "default-s=
tate"
 		    property in Documentation/devicetree/bindings/gpio/led.txt)
      "heartbeat" - LED "double" flashes at a load average based rate
-     "ide-disk" - LED indicates disk activity
+     "disk-activity" - LED indicates disk activity
      "timer" - LED flashes at a fixed, configurable rate
=20
 - led-max-microamp : Maximum LED supply current in microamperes. This =
property
diff --git a/Documentation/devicetree/bindings/leds/leds-gpio.txt b/Doc=
umentation/devicetree/bindings/leds/leds-gpio.txt
index cbbeb18..e166053 100644
--- a/Documentation/devicetree/bindings/leds/leds-gpio.txt
+++ b/Documentation/devicetree/bindings/leds/leds-gpio.txt
@@ -35,7 +35,7 @@ leds {
 	hdd {
 		label =3D "IDE Activity";
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
index d406d98..44c1bcf 100644
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
2.8.4
