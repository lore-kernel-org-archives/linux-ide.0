From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: Remove debugging delay from CS5520 driver
Date: Fri, 05 Nov 2004 16:20:06 +0000
Message-ID: <1099671605.5567.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:5061 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261410AbUKERXC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 12:23:02 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.10rc1/drivers/ide/pci/cs5520.c linux-2.6.10rc1/drivers/ide/pci/cs5520.c
--- linux.vanilla-2.6.10rc1/drivers/ide/pci/cs5520.c	2004-11-05 15:34:47.000000000 +0000
+++ linux-2.6.10rc1/drivers/ide/pci/cs5520.c	2004-11-05 16:07:46.000000000 +0000
@@ -305,8 +305,6 @@
 
 	ide_pci_setup_ports(dev, d, 1, 14, &index);
 
-	printk("Index.b %d %d\n", index.b.low, index.b.high);
-	mdelay(2000);
 	if((index.b.low & 0xf0) != 0xf0)
 		probe_hwif_init(&ide_hwifs[index.b.low]);
 	if((index.b.high & 0xf0) != 0xf0)

