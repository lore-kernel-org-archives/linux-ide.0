From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 1/1] Ata: pata_marvell, use ioread* for iomap-ped memory
Date: Sat, 25 Aug 2007 04:00:48 -0400
Message-ID: <14077223792606026025@pripojeni.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from general-networks3.cust.sloane.cz ([88.146.176.14]:33591 "EHLO
	server.generalnetworks.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932997AbXHYIAs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Aug 2007 04:00:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, jgarzik@pobox.com

pata_marvell, use ioread* for iomap-ped memory

read* on pci_iomapped memory is incorrect, fix it

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

---
commit 5a28a23f3c53993aaf6e7ef6c392e5f4c20d4a3b
tree 4b3387d330556da54d61d989f2dc75d5258af4ea
parent f5f10b061961546a77300f3ebe92abd9cb5b9b48
author Jiri Slaby <jirislaby@gmail.com> Sat, 25 Aug 2007 09:41:44 +0200
committer Jiri Slaby <jirislaby@gmail.com> Sat, 25 Aug 2007 09:41:44 +0200

 drivers/ata/pata_marvell.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index f8db900..a657754 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -45,10 +45,10 @@ static int marvell_pre_reset(struct ata_link *link, unsigned long deadline)
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
