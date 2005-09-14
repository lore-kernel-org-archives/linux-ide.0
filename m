From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] alim15x3: replace pci_find_device() with pci_dev_present()
Date: Wed, 14 Sep 2005 22:38:22 +0400
Message-ID: <20050914183822.GD19491@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:31105 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932255AbVINS2N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Sep 2005 14:28:13 -0400
Received: by zproxy.gmail.com with SMTP id i11so9636nzi
        for <linux-ide@vger.kernel.org>; Wed, 14 Sep 2005 11:28:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkiewicz@elka.pw.edu.pl>
Cc: Hanna Linder <hannal@us.ibm.com>, linux-ide@vger.kernel.org

From: Hanna Linder <hannal@us.ibm.com>

The dev returned from pci_find_device() was not used so it can be
replaced with pci_dev_present(). Compile tested.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/ide/pci/alim15x3.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
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

