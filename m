From: Rob Herring <robherring2@gmail.com>
Subject: [PATCH] pata_of_platform: remove direct dependency on OF_IRQ
Date: Wed, 21 Dec 2011 17:23:50 -0600
Message-ID: <1324509830-4689-1-git-send-email-robherring2@gmail.com>
References: <20111221.173810.971054965060472866.davem@davemloft.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34791 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611Ab1LUXYH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Dec 2011 18:24:07 -0500
Received: by ggdk6 with SMTP id k6so5918281ggd.19
        for <linux-ide@vger.kernel.org>; Wed, 21 Dec 2011 15:24:06 -0800 (PST)
In-Reply-To: <20111221.173810.971054965060472866.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: pawel.moll@arm.com, David Miller <davem@davemloft.net>
Cc: Rob Herring <rob.herring@calxeda.com>, linux-ide@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Rob Herring <rob.herring@calxeda.com>

CONFIG_OF_IRQ is not available on some platforms and using of_irq_*
breaks the build. Since resources are already populated in the platform
device, get the irq from there instead.

Reported-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/ata/pata_of_platform.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 2a472c5..ece899d 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -12,8 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/ata_platform.h>
 
 static int __devinit pata_of_platform_probe(struct platform_device *ofdev)
@@ -22,7 +21,7 @@ static int __devinit pata_of_platform_probe(struct platform_device *ofdev)
 	struct device_node *dn = ofdev->dev.of_node;
 	struct resource io_res;
 	struct resource ctl_res;
-	struct resource irq_res;
+	struct resource *irq_res;
 	unsigned int reg_shift = 0;
 	int pio_mode = 0;
 	int pio_mask;
@@ -51,11 +50,9 @@ static int __devinit pata_of_platform_probe(struct platform_device *ofdev)
 		}
 	}
 
-	ret = of_irq_to_resource(dn, 0, &irq_res);
-	if (!ret)
-		irq_res.start = irq_res.end = 0;
-	else
-		irq_res.flags = 0;
+	irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
+	if (irq_res)
+		irq_res->flags = 0;
 
 	prop = of_get_property(dn, "reg-shift", NULL);
 	if (prop)
@@ -75,7 +72,7 @@ static int __devinit pata_of_platform_probe(struct platform_device *ofdev)
 	pio_mask = 1 << pio_mode;
 	pio_mask |= (1 << pio_mode) - 1;
 
-	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res, &irq_res,
+	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res, irq_res,
 				     reg_shift, pio_mask);
 }
 
-- 
1.7.5.4

