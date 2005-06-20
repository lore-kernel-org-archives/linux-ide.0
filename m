From: domen@coderock.org
Subject: [patch 2/6] Replace pci_find_device with pci_dev_present
Date: Mon, 20 Jun 2005 23:52:18 +0200
Message-ID: <20050620215217.508725000@nd47.coderock.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coderock.org ([193.77.147.115]:32665 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261755AbVFTV4L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2005 17:56:11 -0400
Content-Disposition: inline; filename=pci_dev_present-drivers_ide_pci_alim15x3.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, Hanna Linder <hannal@us.ibm.com>, Maximilian Attems <janitor@sternwelten.at>, domen@coderock.org

From: Hanna Linder <hannal@us.ibm.com>



The dev returned from pci_find_device was not used so it can be replaced
with pci_dev_present. Has been compile tested.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 alim15x3.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: quilt/drivers/ide/pci/alim15x3.c
===================================================================
--- quilt.orig/drivers/ide/pci/alim15x3.c
+++ quilt/drivers/ide/pci/alim15x3.c
@@ -876,9 +876,14 @@ static ide_pci_device_t ali15x3_chipset 
  
 static int __devinit alim15x3_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	static struct pci_device_id ati_rs100[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS100) },
+		{ },
+	};
+
 	ide_pci_device_t *d = &ali15x3_chipset;
 
-	if(pci_find_device(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS100, NULL))
+	if(pci_dev_present(ati_rs100))
 		printk(KERN_ERR "Warning: ATI Radeon IGP Northbridge is not yet fully tested.\n");
 
 #if defined(CONFIG_SPARC64)

--
