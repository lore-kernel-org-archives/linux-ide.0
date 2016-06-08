From: Stephan Linz <linz@li-pro.net>
Subject: [PATCH v3 3/7] powerpc: use the new LED disk activity trigger
Date: Thu,  9 Jun 2016 00:29:38 +0200
Message-ID: <20160608223000.433-3-linz@li-pro.net>
References: <20160608223000.433-1-linz@li-pro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608223000.433-1-linz@li-pro.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Stephan Linz <linz@li-pro.net>, Joseph Jezak <josejx@gentoo.org>, Nico Macrionitis <acrux@cruxppc.org>, =?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

- dts: rename 'ide-disk' to 'disk-activity'
- defconfig: rename 'ADB_PMU_LED_IDE' to 'ADB_PMU_LED_DISK'

Cc: Joseph Jezak <josejx@gentoo.org>
Cc: Nico Macrionitis <acrux@cruxppc.org>
Cc: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
Signed-off-by: Stephan Linz <linz@li-pro.net>
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
