From: Graeme Russ <graeme.russ@gmail.com>
Subject: [PATCH] Add hook for custom xfer function in PATA Platform driver
Date: Sun,  9 May 2010 15:21:33 +1000
Message-ID: <1273382493-5859-1-git-send-email-graeme.russ@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:38404 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab0EIFVj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 May 2010 01:21:39 -0400
Received: by pzk42 with SMTP id 42so1139716pzk.4
        for <linux-ide@vger.kernel.org>; Sat, 08 May 2010 22:21:38 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Graeme Russ <graeme.russ@gmail.com>

Allows the existing 16-bit data transfer function used by the PATA Platform
driver to be overriden by a vendor specific fuction. This is useful if,
for example, the PATA device is only capable of 8-bit data transfers

Signed-off-by: Graeme Russ <graeme.russ@gmail.com>
---
 drivers/ata/pata_platform.c  |    7 +++++++
 include/linux/ata_platform.h |    5 +++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 3f6ebc6..dc516b4 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -238,6 +238,13 @@ static int __devinit pata_platform_probe(struct platform_device *pdev)
 	if (irq_res)
 		irq_res->flags = pp_info ? pp_info->irq_flags : 0;
 
+	/*
+	 * Assign custom data transfer function (if defined)
+	 */
+	if (pp_info)
+		if (unlikely(pp_info->data_xfer))
+			pata_platform_port_ops.sff_data_xfer = pp_info->data_xfer;
+
 	return __pata_platform_probe(&pdev->dev, io_res, ctl_res, irq_res,
 				     pp_info ? pp_info->ioport_shift : 0,
 				     pio_mask);
diff --git a/include/linux/ata_platform.h b/include/linux/ata_platform.h
index 9a26c83..0913633 100644
--- a/include/linux/ata_platform.h
+++ b/include/linux/ata_platform.h
@@ -13,6 +13,11 @@ struct pata_platform_info {
 	 * IRQ flags when call request_irq()
 	 */
 	unsigned int irq_flags;
+	/*
+	 * Custom data transfer function
+	 */
+	unsigned int (*data_xfer)(struct ata_device *dev,
+			unsigned char *buf, unsigned int buflen, int rw);
 };
 
 extern int __devinit __pata_platform_probe(struct device *dev,
-- 
1.7.1.rc1.12.ga601

