From: akpm@linux-foundation.org
Subject: [patch 04/10] Ata: pata_marvell, use ioread* for iomap-ped memory
Date: Tue, 02 Oct 2007 13:53:01 -0700
Message-ID: <200710022053.l92Kr1GG021682@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35370 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753884AbXJBUxK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 16:53:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, jirislaby@gmail.com, alan@lxorguk.ukuu.org.uk

From: Jiri Slaby <jirislaby@gmail.com>

pata_marvell, use ioread* for iomap-ped memory

read* on pci_iomapped memory is incorrect, fix it

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_marvell.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/ata/pata_marvell.c~ata-pata_marvell-use-ioread-for-iomap-ped-memory drivers/ata/pata_marvell.c
--- a/drivers/ata/pata_marvell.c~ata-pata_marvell-use-ioread-for-iomap-ped-memory
+++ a/drivers/ata/pata_marvell.c
@@ -45,10 +45,10 @@ static int marvell_pre_reset(struct ata_
 		return -ENOMEM;
 	printk("BAR5:");
 	for(i = 0; i <= 0x0F; i++)
-		printk("%02X:%02X ", i, readb(barp + i));
+		printk("%02X:%02X ", i, ioread8(barp + i));
 	printk("\n");
 
-	devices = readl(barp + 0x0C);
+	devices = ioread32(barp + 0x0C);
 	pci_iounmap(pdev, barp);
 
 	if ((pdev->device == 0x6145) && (ap->port_no == 0) &&
_
