From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH] pata-generic/of: Make probing via device tree non-powerpc-specific
Date: Fri, 16 Sep 2011 15:38:10 +0100
Message-ID: <1316183890-13677-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f180.google.com ([74.125.82.180]:64213 "EHLO
	mail-wy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849Ab1IPOi1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Sep 2011 10:38:27 -0400
Received: by wyj26 with SMTP id 26so4835481wyj.11
        for <linux-ide@vger.kernel.org>; Fri, 16 Sep 2011 07:38:26 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, linux-ide@vger.kernel.org
Cc: patches@linaro.org, Jeff Garzik <jgarzik@pobox.com>, linux-arm-kernel@lists.infradead.org, Dave Martin <dave.martin@linaro.org>

This patch enables device-tree-based probing of the pata-generic
platform driver across all architectures:

  * make the pata_of_generic module depend on OF instead of PPC_OF;
  * supply some missing inclues;
  * replace endianness-sensitive raw access to device tree data
    with of_property_read_u32() calls.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---

Tested on ARM Versatile Express, with my soon-to-be-posted device
tree support patches.

I'm not in a position to build/test this for powerpc easily --
if anyone is able to do that, it would be appreciated.

Grant, does this require similar cleanup to the isp1760 USB hcd driver?

Cheers
---Dave

 drivers/ata/Kconfig            |    2 +-
 drivers/ata/pata_of_platform.c |   16 +++++++---------
 2 files changed, 8 insertions(+), 10 deletions(-)

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
index f305400..ac7c9f7 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -11,6 +11,9 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/ata_platform.h>
 
@@ -21,10 +24,9 @@ static int __devinit pata_of_platform_probe(struct platform_device *ofdev)
 	struct resource io_res;
 	struct resource ctl_res;
 	struct resource irq_res;
-	unsigned int reg_shift = 0;
-	int pio_mode = 0;
+	u32 reg_shift = 0;
+	u32 pio_mode = 0;
 	int pio_mask;
-	const u32 *prop;
 
 	ret = of_address_to_resource(dn, 0, &io_res);
 	if (ret) {
@@ -55,13 +57,9 @@ static int __devinit pata_of_platform_probe(struct platform_device *ofdev)
 	else
 		irq_res.flags = 0;
 
-	prop = of_get_property(dn, "reg-shift", NULL);
-	if (prop)
-		reg_shift = *prop;
+	of_property_read_u32(dn, "reg-shift", &reg_shift);
 
-	prop = of_get_property(dn, "pio-mode", NULL);
-	if (prop) {
-		pio_mode = *prop;
+	if (of_property_read_u32(dn, "pio-mode", &pio_mode)) {
 		if (pio_mode > 6) {
 			dev_err(&ofdev->dev, "invalid pio-mode\n");
 			return -EINVAL;
-- 
1.7.4.1

