From: Stephan Linz <linz-LlUBiLVY8XKsTnJN9+BGXg@public.gmane.org>
Subject: [PATCH v4 3/7] powerpc: use the new LED disk activity trigger
Date: Fri, 10 Jun 2016 07:59:58 +0200
Message-ID: <20160610060021.12382-3-linz@li-pro.net>
References: <20160610060021.12382-1-linz@li-pro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160610060021.12382-1-linz-LlUBiLVY8XKsTnJN9+BGXg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Stephan Linz <linz-LlUBiLVY8XKsTnJN9+BGXg@public.gmane.org>, Joseph Jezak <josejx-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, =?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg-au2b9oQwubsjnolme5KbmQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

- dts: rename 'ide-disk' to 'disk-activity'
- defconfig: rename 'ADB_PMU_LED_IDE' to 'ADB_PMU_LED_DISK'

Cc: Joseph Jezak <josejx-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: J=C3=B6rg Sommer <joerg-au2b9oQwubsjnolme5KbmQ@public.gmane.org>
Signed-off-by: Stephan Linz <linz-LlUBiLVY8XKsTnJN9+BGXg@public.gmane.org>
---
 arch/powerpc/boot/dts/mpc8315erdb.dts |  2 +-
 arch/powerpc/boot/dts/mpc8377_rdb.dts |  2 +-
 arch/powerpc/boot/dts/mpc8378_rdb.dts |  2 +-
 arch/powerpc/boot/dts/mpc8379_rdb.dts |  2 +-
 arch/powerpc/configs/pmac32_defconfig |  2 +-
 arch/powerpc/configs/ppc6xx_defconfig |  2 +-
 drivers/macintosh/Kconfig             | 13 ++++++-------
 drivers/macintosh/via-pmu-led.c       |  4 ++--
 8 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/=
dts/mpc8315erdb.dts
index 4354684..ca5139e 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -472,7 +472,7 @@
=20
 		hdd {
 			gpios =3D <&mcu_pio 1 0>;
-			linux,default-trigger =3D "ide-disk";
+			linux,default-trigger =3D "disk-activity";
 		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/=
dts/mpc8377_rdb.dts
index 2b4b653..e326139 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -496,7 +496,7 @@
=20
 		hdd {
 			gpios =3D <&mcu_pio 1 0>;
-			linux,default-trigger =3D "ide-disk";
+			linux,default-trigger =3D "disk-activity";
 		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/=
dts/mpc8378_rdb.dts
index 74b6a53..71842fc 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -480,7 +480,7 @@
=20
 		hdd {
 			gpios =3D <&mcu_pio 1 0>;
-			linux,default-trigger =3D "ide-disk";
+			linux,default-trigger =3D "disk-activity";
 		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/=
dts/mpc8379_rdb.dts
index 3b5cbac..e442a29 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -446,7 +446,7 @@
=20
 		hdd {
 			gpios =3D <&mcu_pio 1 0>;
-			linux,default-trigger =3D "ide-disk";
+			linux,default-trigger =3D "disk-activity";
 		};
 	};
 };
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/confi=
gs/pmac32_defconfig
index ea8705f..3f6c9a6 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -158,7 +158,7 @@ CONFIG_ADB=3Dy
 CONFIG_ADB_CUDA=3Dy
 CONFIG_ADB_PMU=3Dy
 CONFIG_ADB_PMU_LED=3Dy
-CONFIG_ADB_PMU_LED_IDE=3Dy
+CONFIG_ADB_PMU_LED_DISK=3Dy
 CONFIG_PMAC_APM_EMU=3Dm
 CONFIG_PMAC_MEDIABAY=3Dy
 CONFIG_PMAC_BACKLIGHT=3Dy
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/confi=
gs/ppc6xx_defconfig
index 99ccbeba..1dde0be 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -442,7 +442,7 @@ CONFIG_ADB=3Dy
 CONFIG_ADB_CUDA=3Dy
 CONFIG_ADB_PMU=3Dy
 CONFIG_ADB_PMU_LED=3Dy
-CONFIG_ADB_PMU_LED_IDE=3Dy
+CONFIG_ADB_PMU_LED_DISK=3Dy
 CONFIG_PMAC_APM_EMU=3Dy
 CONFIG_PMAC_MEDIABAY=3Dy
 CONFIG_PMAC_BACKLIGHT=3Dy
diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 3e8b29e..d28690f 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -96,19 +96,18 @@ config ADB_PMU_LED
 	  Support the front LED on Power/iBooks as a generic LED that can
 	  be triggered by any of the supported triggers. To get the
 	  behaviour of the old CONFIG_BLK_DEV_IDE_PMAC_BLINK, select this
-	  and the ide-disk LED trigger and configure appropriately through
-	  sysfs.
+	  and the disk LED trigger and configure appropriately through sysfs.
=20
-config ADB_PMU_LED_IDE
-	bool "Use front LED as IDE LED by default"
+config ADB_PMU_LED_DISK
+	bool "Use front LED as DISK LED by default"
 	depends on ADB_PMU_LED
 	depends on LEDS_CLASS
 	depends on IDE_GD_ATA
 	select LEDS_TRIGGERS
-	select LEDS_TRIGGER_IDE_DISK
+	select LEDS_TRIGGER_DISK
 	help
-	  This option makes the front LED default to the IDE trigger
-	  so that it blinks on IDE activity.
+	  This option makes the front LED default to the disk trigger
+	  so that it blinks on disk activity.
=20
 config PMAC_SMU
 	bool "Support for SMU  based PowerMacs"
diff --git a/drivers/macintosh/via-pmu-led.c b/drivers/macintosh/via-pm=
u-led.c
index 19c3718..ae067ab 100644
--- a/drivers/macintosh/via-pmu-led.c
+++ b/drivers/macintosh/via-pmu-led.c
@@ -73,8 +73,8 @@ static void pmu_led_set(struct led_classdev *led_cdev=
,
=20
 static struct led_classdev pmu_led =3D {
 	.name =3D "pmu-led::front",
-#ifdef CONFIG_ADB_PMU_LED_IDE
-	.default_trigger =3D "ide-disk",
+#ifdef CONFIG_ADB_PMU_LED_DISK
+	.default_trigger =3D "disk-activity",
 #endif
 	.brightness_set =3D pmu_led_set,
 };
--=20
2.8.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
