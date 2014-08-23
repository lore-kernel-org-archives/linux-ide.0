From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 3/4] pata_platform: Use devm_ioremap_resource()
Date: Sat, 23 Aug 2014 14:46:11 +0400
Message-ID: <1408790772-5305-2-git-send-email-shc_work@mail.ru>
References: <1408790772-5305-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fallback8.mail.ru ([94.100.181.110]:33183 "EHLO
	fallback8.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbaHWKsj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Aug 2014 06:48:39 -0400
In-Reply-To: <1408790772-5305-1-git-send-email-shc_work@mail.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexander Shiyan <shc_work@mail.ru>

Use devm_ioremap_resource() calls.
This will provide a more reasonable exit codes in case of errors.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/ata/pata_platform.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index f8cff3e..ecbc3bf 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -145,19 +145,21 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
 	 * Handle the MMIO case
 	 */
 	if (mmio) {
-		ap->ioaddr.cmd_addr = devm_ioremap(dev, io_res->start,
-				resource_size(io_res));
-		ap->ioaddr.ctl_addr = devm_ioremap(dev, ctl_res->start,
-				resource_size(ctl_res));
+		ap->ioaddr.cmd_addr = devm_ioremap_resource(dev, io_res);
+		if (IS_ERR(ap->ioaddr.cmd_addr))
+			return PTR_ERR(ap->ioaddr.cmd_addr);
+		ap->ioaddr.ctl_addr = devm_ioremap_resource(dev, ctl_res);
+		if (IS_ERR(ap->ioaddr.ctl_addr))
+			return PTR_ERR(ap->ioaddr.ctl_addr);
 	} else {
 		ap->ioaddr.cmd_addr = devm_ioport_map(dev, io_res->start,
 				resource_size(io_res));
 		ap->ioaddr.ctl_addr = devm_ioport_map(dev, ctl_res->start,
 				resource_size(ctl_res));
-	}
-	if (!ap->ioaddr.cmd_addr || !ap->ioaddr.ctl_addr) {
-		dev_err(dev, "failed to map IO/CTL base\n");
-		return -ENOMEM;
+		if (!ap->ioaddr.cmd_addr || !ap->ioaddr.ctl_addr) {
+			dev_err(dev, "failed to map IO/CTL base\n");
+			return -ENOMEM;
+		}
 	}
 
 	ap->ioaddr.altstatus_addr = ap->ioaddr.ctl_addr;
-- 
1.8.5.5

