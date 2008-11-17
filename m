From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH] pata-rb532-cf: read/write data in 4-byte blocks
Date: Mon, 17 Nov 2008 21:04:07 +0100
Message-ID: <1226952247-1328-3-git-send-email-n0-1@freewrt.org>
References: <1226952247-1328-1-git-send-email-n0-1@freewrt.org>
 <1226952247-1328-2-git-send-email-n0-1@freewrt.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:40270 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbYKQUTS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Nov 2008 15:19:18 -0500
In-Reply-To: <1226952247-1328-2-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

* rename the offset definition to avoid abiguity with the standard ATA
  IO address
* read and write four bytes at once like the original driver does
* use writesl() and readsl() which implicitly iterate over the data

This patch assumes buflen to be a multiple of four, which is true for
ATA devices. ATAPI support is not known, though unlikely, as the
original driver always transfers 512 Bytes at once. In doubt, do the
right thing and return the number of bytes actually consumed.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
Acked-by: Sergei Shtyltov <sshtylyov@ru.mvista.com>
Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Acked-by: Florian Fainelli <florian@openwrt.org>
---
 drivers/ata/pata_rb532_cf.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 576fc99..4479b04 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -43,7 +43,8 @@
 #define RB500_CF_REG_BASE	0x0800
 #define RB500_CF_REG_ERR	0x080D
 #define RB500_CF_REG_CTRL	0x080E
-#define RB500_CF_REG_DATA	0x0C00
+/* 32bit buffered data register offset */
+#define RB500_CF_REG_DBUF32	0x0C00
 
 struct rb532_cf_info {
 	void __iomem	*iobase;
@@ -79,18 +80,14 @@ static unsigned int rb532_pata_data_xfer(struct ata_device *adev, unsigned char
 {
 	struct ata_port *ap = adev->link->ap;
 	void __iomem *ioaddr = ap->ioaddr.data_addr;
-	int retlen = buflen;
 
-	if (write_data) {
-		for (; buflen > 0; buflen--, buf++)
-			writeb(*buf, ioaddr);
-	} else {
-		for (; buflen > 0; buflen--, buf++)
-			*buf = readb(ioaddr);
-	}
+	if (write_data)
+		writesl(ioaddr, buf, buflen / sizeof(u32));
+	else
+		readsl(ioaddr, buf, buflen / sizeof(u32));
 
 	rb532_pata_finish_io(adev->link->ap);
-	return retlen;
+	return buflen - buflen % sizeof(u32);
 }
 
 static void rb532_pata_freeze(struct ata_port *ap)
@@ -158,7 +155,7 @@ static void rb532_pata_setup_ports(struct ata_host *ah)
 
 	ata_sff_std_ports(&ap->ioaddr);
 
-	ap->ioaddr.data_addr	= info->iobase + RB500_CF_REG_DATA;
+	ap->ioaddr.data_addr	= info->iobase + RB500_CF_REG_DBUF32;
 	ap->ioaddr.error_addr	= info->iobase + RB500_CF_REG_ERR;
 }
 
-- 
1.5.6.4

