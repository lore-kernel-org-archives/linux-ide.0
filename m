From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/4] pata_of_platform: Remove "electra-ide" quirk
Date: Sat, 23 Aug 2014 14:46:10 +0400
Message-ID: <1408790772-5305-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fallback2.mail.ru ([94.100.179.22]:55759 "EHLO
	fallback2.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbaHWKxO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Aug 2014 06:53:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexander Shiyan <shc_work@mail.ru>

"electra-ide" is not used anywhere in the kernel and could be
represented in devicetree in a normal way.
This patch removes specific quirk for "electra-ide".

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/ata/pata_of_platform.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index a7e95a5..6af1c9b 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -35,20 +35,11 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 		return -EINVAL;
 	}
 
-	if (of_device_is_compatible(dn, "electra-ide")) {
-		/* Altstatus is really at offset 0x3f6 from the primary window
-		 * on electra-ide. Adjust ctl_res and io_res accordingly.
-		 */
-		ctl_res = io_res;
-		ctl_res.start = ctl_res.start+0x3f6;
-		io_res.end = ctl_res.start-1;
-	} else {
-		ret = of_address_to_resource(dn, 1, &ctl_res);
-		if (ret) {
-			dev_err(&ofdev->dev, "can't get CTL address from "
-				"device tree\n");
-			return -EINVAL;
-		}
+	ret = of_address_to_resource(dn, 1, &ctl_res);
+	if (ret) {
+		dev_err(&ofdev->dev, "can't get CTL address from "
+			"device tree\n");
+		return -EINVAL;
 	}
 
 	irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
@@ -79,8 +70,7 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 
 static struct of_device_id pata_of_platform_match[] = {
 	{ .compatible = "ata-generic", },
-	{ .compatible = "electra-ide", },
-	{},
+	{ },
 };
 MODULE_DEVICE_TABLE(of, pata_of_platform_match);
 
-- 
1.8.5.5

