From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH] pata-rb532-cf: fix signature of the xfer function
Date: Mon, 17 Nov 2008 21:04:06 +0100
Message-ID: <1226952247-1328-2-git-send-email-n0-1@freewrt.org>
References: <1226952247-1328-1-git-send-email-n0-1@freewrt.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:52034 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbYKQUCI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Nov 2008 15:02:08 -0500
In-Reply-To: <1226952247-1328-1-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Per definition, this function should return the number of bytes
consumed. As the original parameter "buflen" is being decremented inside
the read/write loop, save it in "retlen" at the beginning.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
Acked-by: Sergei Shtyltov <sshtylyov@ru.mvista.com>
Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Acked-by: Florian Fainelli <florian@openwrt.org>
---
 drivers/ata/pata_rb532_cf.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 7b11f40..576fc99 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -74,11 +74,12 @@ static void rb532_pata_exec_command(struct ata_port *ap,
 	rb532_pata_finish_io(ap);
 }
 
-static void rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
+static unsigned int rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
 				unsigned int buflen, int write_data)
 {
 	struct ata_port *ap = adev->link->ap;
 	void __iomem *ioaddr = ap->ioaddr.data_addr;
+	int retlen = buflen;
 
 	if (write_data) {
 		for (; buflen > 0; buflen--, buf++)
@@ -89,6 +90,7 @@ static void rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
 	}
 
 	rb532_pata_finish_io(adev->link->ap);
+	return retlen;
 }
 
 static void rb532_pata_freeze(struct ata_port *ap)
-- 
1.5.6.4

