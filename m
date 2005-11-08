From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 2/2] drivers/ide/pci/alim15x3.c: use KERN_WARNING
Date: Tue, 8 Nov 2005 20:57:57 +0300
Message-ID: <20051108175756.GE7631@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.192]:1815 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030219AbVKHRog (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2005 12:44:36 -0500
Received: by nproxy.gmail.com with SMTP id q29so181594nfc
        for <linux-ide@vger.kernel.org>; Tue, 08 Nov 2005 09:44:35 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>

From: Alexey Dobriyan <adobriyan@gmail.com>

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Index: linux-kj/drivers/ide/pci/alim15x3.c
===================================================================
--- linux-kj.orig/drivers/ide/pci/alim15x3.c	2005-11-08 20:47:34.000000000 +0300
+++ linux-kj/drivers/ide/pci/alim15x3.c	2005-11-08 20:47:35.000000000 +0300
@@ -884,7 +884,7 @@ static int __devinit alim15x3_init_one(s
 	ide_pci_device_t *d = &ali15x3_chipset;
 
 	if(pci_dev_present(ati_rs100))
-		printk(KERN_ERR "Warning: ATI Radeon IGP Northbridge is not yet fully tested.\n");
+		printk(KERN_WARNING "ATI Radeon IGP Northbridge is not yet fully tested.\n");
 
 #if defined(CONFIG_SPARC64)
 	d->init_hwif = init_hwif_common_ali15x3;

