From: Pawel Moll <pawel.moll@arm.com>
Subject: [PATCH] ata: Make pata_of_platform.c compile again and work on non-PPC platforms
Date: Wed,  7 Sep 2011 13:36:26 +0100
Message-ID: <1315398986-10078-1-git-send-email-pawel.moll@arm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:39961 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756067Ab1IGQHM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Sep 2011 12:07:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>

This patch adds missing #includes, makes the driver selectable on
non-PPC OF-enabled platforms and fixes property value accesses to
be correct in Little Endian system.

Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/ata/Kconfig            |    2 +-
 drivers/ata/pata_of_platform.c |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 5987e0b..c6ef9d0 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -820,7 +820,7 @@ config PATA_PLATFORM
 
 config PATA_OF_PLATFORM
 	tristate "OpenFirmware platform device PATA support"
-	depends on PATA_PLATFORM && PPC_OF
+	depends on PATA_PLATFORM && OF
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems with OpenFirmware
diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index f305400..a72ab0d 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -11,6 +11,8 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/ata_platform.h>
 
@@ -57,11 +59,11 @@ static int __devinit pata_of_platform_probe(struct platform_device *ofdev)
 
 	prop = of_get_property(dn, "reg-shift", NULL);
 	if (prop)
-		reg_shift = *prop;
+		reg_shift = be32_to_cpup(prop);
 
 	prop = of_get_property(dn, "pio-mode", NULL);
 	if (prop) {
-		pio_mode = *prop;
+		pio_mode = be32_to_cpup(prop);
 		if (pio_mode > 6) {
 			dev_err(&ofdev->dev, "invalid pio-mode\n");
 			return -EINVAL;
-- 
1.6.3.3

