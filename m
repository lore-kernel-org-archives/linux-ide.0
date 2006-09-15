From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] piix: Use refcounted interface when searching for a 450NX
Date: Fri, 15 Sep 2006 15:14:38 +0100
Message-ID: <1158329678.29932.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45769 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751450AbWIONuy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Sep 2006 09:50:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Simple conversion

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/ide/pci/piix.c linux-2.6.18-rc6-mm1/drivers/ide/pci/piix.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/ide/pci/piix.c	2006-09-11 17:00:09.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/ide/pci/piix.c	2006-09-14 17:19:12.000000000 +0100
@@ -602,7 +602,7 @@
 	struct pci_dev *pdev = NULL;
 	u16 cfg;
 	u8 rev;
-	while((pdev=pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454NX, pdev))!=NULL)
+	while((pdev=pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454NX, pdev))!=NULL)
 	{
 		/* Look for 450NX PXB. Check for problem configurations
 		   A PCI quirk checks bit 6 already */

