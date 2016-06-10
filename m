From: Stephan Linz <linz@li-pro.net>
Subject: [PATCH v4 5/7] mips: use the new LED disk activity trigger
Date: Fri, 10 Jun 2016 08:00:00 +0200
Message-ID: <20160610060021.12382-5-linz@li-pro.net>
References: <20160610060021.12382-1-linz@li-pro.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:51843 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbcFJGCM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2016 02:02:12 -0400
In-Reply-To: <20160610060021.12382-1-linz@li-pro.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Stephan Linz <linz@li-pro.net>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org

- platform: rename 'ide-disk' to 'disk-activity'
- defconfig: rename 'LEDS_TRIGGER_IDE_DISK' to 'LEDS_TRIGGER_DISK'

Signed-off-by: Stephan Linz <linz@li-pro.net>
---
 arch/mips/configs/malta_qemu_32r6_defconfig | 2 +-
 arch/mips/configs/maltaaprp_defconfig       | 2 +-
 arch/mips/configs/maltasmvp_eva_defconfig   | 2 +-
 arch/mips/configs/maltaup_defconfig         | 2 +-
 arch/mips/configs/rbtx49xx_defconfig        | 2 +-
 arch/mips/txx9/generic/setup.c              | 2 +-
 arch/mips/txx9/rbtx4939/setup.c             | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/configs/malta_qemu_32r6_defconfig b/arch/mips/configs/malta_qemu_32r6_defconfig
index 7f50dd6..65f140e 100644
--- a/arch/mips/configs/malta_qemu_32r6_defconfig
+++ b/arch/mips/configs/malta_qemu_32r6_defconfig
@@ -146,7 +146,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_IDE_DISK=y
+CONFIG_LEDS_TRIGGER_DISK=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
diff --git a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
index a9d433a..799c433 100644
--- a/arch/mips/configs/maltaaprp_defconfig
+++ b/arch/mips/configs/maltaaprp_defconfig
@@ -147,7 +147,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_IDE_DISK=y
+CONFIG_LEDS_TRIGGER_DISK=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
diff --git a/arch/mips/configs/maltasmvp_eva_defconfig b/arch/mips/configs/maltasmvp_eva_defconfig
index 2774ef0..3184600 100644
--- a/arch/mips/configs/maltasmvp_eva_defconfig
+++ b/arch/mips/configs/maltasmvp_eva_defconfig
@@ -152,7 +152,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_IDE_DISK=y
+CONFIG_LEDS_TRIGGER_DISK=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
diff --git a/arch/mips/configs/maltaup_defconfig b/arch/mips/configs/maltaup_defconfig
index 9bbd221..a79107d 100644
--- a/arch/mips/configs/maltaup_defconfig
+++ b/arch/mips/configs/maltaup_defconfig
@@ -146,7 +146,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_IDE_DISK=y
+CONFIG_LEDS_TRIGGER_DISK=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
diff --git a/arch/mips/configs/rbtx49xx_defconfig b/arch/mips/configs/rbtx49xx_defconfig
index f8bf9b4..43d55e5 100644
--- a/arch/mips/configs/rbtx49xx_defconfig
+++ b/arch/mips/configs/rbtx49xx_defconfig
@@ -90,7 +90,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_IDE_DISK=y
+CONFIG_LEDS_TRIGGER_DISK=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 108f8a8..ada92db 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -727,7 +727,7 @@ void __init txx9_iocled_init(unsigned long baseaddr,
 	int i;
 	static char *default_triggers[] __initdata = {
 		"heartbeat",
-		"ide-disk",
+		"disk-activity",
 		"nand-disk",
 		NULL,
 	};
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index 3703040..8b93730 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -215,7 +215,7 @@ static int __init rbtx4939_led_probe(struct platform_device *pdev)
 	int i;
 	static char *default_triggers[] __initdata = {
 		"heartbeat",
-		"ide-disk",
+		"disk-activity",
 		"nand-disk",
 	};
 
-- 
2.8.4

