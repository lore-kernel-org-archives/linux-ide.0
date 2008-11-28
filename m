From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH] pata-rb532-cf: read/write data in 4-byte blocks
Date: Fri, 28 Nov 2008 20:48:43 +0100
Message-ID: <20081128194607.93677386B1A7@mail.ifyouseekate.net>
References: <20081128193322.D103C386DBBE@mail.ifyouseekate.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:52464 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbYK1TqJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Nov 2008 14:46:09 -0500
In-Reply-To: <20081128193322.D103C386DBBE@mail.ifyouseekate.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

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
 drivers/ata/pata_rb532_cf.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index c2e6fb9..362af11 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -79,18 +79,14 @@ static unsigned int rb532_pata_data_xfer(struct ata_device *adev, unsigned char
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
-- 
1.5.6.4

