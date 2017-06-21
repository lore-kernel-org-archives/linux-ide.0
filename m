From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ata: ftide010: fix resource printing
Date: Thu, 22 Jun 2017 00:00:55 +0200
Message-ID: <20170621220115.4100076-1-arnd@arndb.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:64708 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdFUWBa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jun 2017 18:01:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

The new driver uses an incorrect format string for resource_size_t:

drivers/ata/pata_ftide010.c: In function 'pata_ftide010_probe':
drivers/ata/pata_ftide010.c:520:17: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]

The nicest way to print the address is to pretty-print the resource
using %pR.

Fixes: be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ata/pata_ftide010.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index 7b7e417ba8ba..5d4b72e21161 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -517,8 +517,8 @@ static int pata_ftide010_probe(struct platform_device *pdev)
 		ata_sff_std_ports(ioaddr);
 	}
 
-	dev_info(dev, "device ID %08x, irq %d, io base 0x%08x\n",
-		 readl(ftide->base + FTIDE010_IDE_DEVICE_ID), irq, res->start);
+	dev_info(dev, "device ID %08x, irq %d, reg %pR\n",
+		 readl(ftide->base + FTIDE010_IDE_DEVICE_ID), irq, res);
 
 	ret = ata_host_activate(ftide->host, irq, ata_bmdma_interrupt,
 				0, &pata_ftide010_sht);
-- 
2.9.0

