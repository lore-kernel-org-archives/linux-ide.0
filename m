From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: Set latency when resetting it821x out of firmware mode
Date: Tue, 17 Jan 2006 20:46:18 +0000
Message-ID: <1137530778.14135.91.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63917 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932439AbWAQUqv
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jan 2006 15:46:51 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/drivers/ide/pci/it821x.c linux-2.6.16-rc1/drivers/ide/pci/it821x.c
--- linux.vanilla-2.6.16-rc1/drivers/ide/pci/it821x.c	2006-01-17 15:36:23.000000000 +0000
+++ linux-2.6.16-rc1/drivers/ide/pci/it821x.c	2006-01-17 16:36:38.000000000 +0000
@@ -733,7 +733,7 @@
 
 	pci_write_config_dword(dev,0x4C, 0x02040204);
 	pci_write_config_byte(dev, 0x42, 0x36);
-	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0);
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x20);
 }
 
 static unsigned int __devinit init_chipset_it821x(struct pci_dev *dev, const char *name)

