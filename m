From: domen@coderock.org
Subject: [patch 3/3] Replace pci_find_device with pci_dev_present
Date: Wed, 12 Jan 2005 00:17:43 +0100
Message-ID: <20050111231743.A07031F225@trashy.coderock.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coderock.org ([193.77.147.115]:15045 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262899AbVAKXRw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Jan 2005 18:17:52 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, domen@coderock.org, hannal@us.ibm.com, janitor@sternwelten.at




The dev returned from pci_find_device was not used so it can be replaced
with pci_dev_present. Has been compile tested.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/ide/pci/alim15x3.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -puN drivers/ide/pci/alim15x3.c~pci_dev_present-drivers_ide_pci_alim15x3 drivers/ide/pci/alim15x3.c
--- kj/drivers/ide/pci/alim15x3.c~pci_dev_present-drivers_ide_pci_alim15x3	2005-01-10 18:00:15.000000000 +0100
+++ kj-domen/drivers/ide/pci/alim15x3.c	2005-01-10 18:00:15.000000000 +0100
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
_
