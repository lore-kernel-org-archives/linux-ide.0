From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH] read and write data in 4-byte blocks
Date: Sat,  1 Nov 2008 19:11:38 +0100
Message-ID: <1225563098-11447-1-git-send-email-n0-1@freewrt.org>
References: <1225562973-8843-1-git-send-email-n0-1@freewrt.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:57182 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbYKASLn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Nov 2008 14:11:43 -0400
Received: from base (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id 6F835386DBBE
	for <linux-ide@vger.kernel.org>; Sat,  1 Nov 2008 19:11:42 +0100 (CET)
In-Reply-To: <1225562973-8843-1-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

* rename the offset definition to avoid abiguity with the standard ATA
  IO address
* read and write four bytes at once
* use writesl() and readsl() which implicitly iterate over the data

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 drivers/ata/pata_rb532_cf.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 7b11f40..0ae377f 100644
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
@@ -80,15 +81,13 @@ static void rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
 	struct ata_port *ap = adev->link->ap;
 	void __iomem *ioaddr = ap->ioaddr.data_addr;
 
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
+	return buflen;
 }
 
 static void rb532_pata_freeze(struct ata_port *ap)
@@ -156,7 +155,7 @@ static void rb532_pata_setup_ports(struct ata_host *ah)
 
 	ata_sff_std_ports(&ap->ioaddr);
 
-	ap->ioaddr.data_addr	= info->iobase + RB500_CF_REG_DATA;
+	ap->ioaddr.data_addr	= info->iobase + RB500_CF_REG_DBUF32;
 	ap->ioaddr.error_addr	= info->iobase + RB500_CF_REG_ERR;
 }
 
-- 
1.5.6.4

