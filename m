From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 1/2] drivers/ide/pci/alim15x3.c: replace pci_find_device() with pci_dev_present()
Date: Tue, 8 Nov 2005 20:56:19 +0300
Message-ID: <20051108175619.GD7631@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.207]:12295 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965150AbVKHRm4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2005 12:42:56 -0500
Received: by nproxy.gmail.com with SMTP id r45so199108nfc
        for <linux-ide@vger.kernel.org>; Tue, 08 Nov 2005 09:42:55 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Hanna Linder <hannal@us.ibm.com>, Andrew Morton <akpm@osdl.org>

From: Hanna Linder <hannal@us.ibm.com>

The dev returned from pci_find_device() was not used so it can be
replaced with pci_dev_present(). Compile tested.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Index: linux-kj/drivers/ide/pci/alim15x3.c
===================================================================
--- linux-kj.orig/drivers/ide/pci/alim15x3.c	2005-11-08 20:46:36.000000000 +0300
+++ linux-kj/drivers/ide/pci/alim15x3.c	2005-11-08 20:47:34.000000000 +0300
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

