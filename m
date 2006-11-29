From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] pata_cs5535: add missing comma in pci_driver initializer
Date: Wed, 29 Nov 2006 15:22:47 +0900
Message-ID: <20061129062247.GD11250@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:26191 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S934493AbWK2GXI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Nov 2006 01:23:08 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2811359nfa
        for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 22:23:05 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

PATA PM update introduced intialization line without comma.  Add it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index 73b9b54..e3efec4 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -269,7 +269,7 @@ static struct pci_driver cs5535_pci_driv
 	.name		= DRV_NAME,
 	.id_table	= cs5535,
 	.probe 		= cs5535_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
 	.suspend	= ata_pci_device_suspend,
 	.resume		= ata_pci_device_resume,
 };
