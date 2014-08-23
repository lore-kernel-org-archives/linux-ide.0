From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 4/4] pata_platform: Use 16-bit wide data transfer
Date: Sat, 23 Aug 2014 14:46:12 +0400
Message-ID: <1408790772-5305-3-git-send-email-shc_work@mail.ru>
References: <1408790772-5305-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fallback8.mail.ru ([94.100.181.110]:33186 "EHLO
	fallback8.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbaHWKsj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Aug 2014 06:48:39 -0400
In-Reply-To: <1408790772-5305-1-git-send-email-shc_work@mail.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexander Shiyan <shc_work@mail.ru>

In some cases, system bus can be configured for 16-bit mode, in this
case using of read/write functions for the 32 bit values causes two
cycles of 16 bits, which is incorrect.
The patch provides its own function to use the proper 16-bit mode.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/ata/pata_platform.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index ecbc3bf..79dd223 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -43,13 +43,28 @@ static int pata_platform_set_mode(struct ata_link *link, struct ata_device **unu
 	return 0;
 }
 
+static unsigned int pata_platform_xfer_noirq(struct ata_device *dev,
+					     unsigned char *buf,
+					     unsigned int buflen, int rw)
+{
+	unsigned long flags;
+	unsigned int consumed;
+
+	local_irq_save(flags);
+	/* Use 16-bit transfer */
+	consumed = ata_sff_data_xfer(dev, buf, buflen, rw);
+	local_irq_restore(flags);
+
+	return consumed;
+}
+
 static struct scsi_host_template pata_platform_sht = {
 	ATA_PIO_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations pata_platform_port_ops = {
 	.inherits		= &ata_sff_port_ops,
-	.sff_data_xfer		= ata_sff_data_xfer_noirq,
+	.sff_data_xfer		= pata_platform_xfer_noirq,
 	.cable_detect		= ata_cable_unknown,
 	.set_mode		= pata_platform_set_mode,
 };
-- 
1.8.5.5

