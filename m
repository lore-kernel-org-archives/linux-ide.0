From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] sis5513: Switch to pci refcounting
Date: Fri, 15 Sep 2006 15:18:07 +0100
Message-ID: <1158329887.29932.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44196 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751480AbWIONyY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Sep 2006 09:54:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Mirrors the drivers/ata version, hold a reference to the host bridge
while we are doing setup.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/ide/pci/sis5513.c linux-2.6.18-rc6-mm1/drivers/ide/pci/sis5513.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/ide/pci/sis5513.c	2006-09-11 17:00:09.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/ide/pci/sis5513.c	2006-09-14 17:19:58.000000000 +0100
@@ -739,7 +739,7 @@
 
 	for (i = 0; i < ARRAY_SIZE(SiSHostChipInfo) && !chipset_family; i++) {
 
-		host = pci_find_device(PCI_VENDOR_ID_SI, SiSHostChipInfo[i].host_id, NULL);
+		host = pci_get_device(PCI_VENDOR_ID_SI, SiSHostChipInfo[i].host_id, NULL);
 
 		if (!host)
 			continue;
@@ -753,6 +753,7 @@
 			if (hostrev >= 0x30)
 				chipset_family = ATA_100a;
 		}
+		pci_dev_put(host);
 	
 		printk(KERN_INFO "SIS5513: %s %s controller\n",
 			 SiSHostChipInfo[i].name, chipset_capability[chipset_family]);

