From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] sata_nv: use ata_pci_sff_activate_host()
 instead of ata_host_activate()
Date: Fri, 14 May 2010 11:48:50 +0200
Message-ID: <4BED1C82.10102@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49433 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753870Ab0ENJtB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2010 05:49:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, stable <stable@kernel.org>, Robert Hancock <hancockrwd@gmail.com>

sata_nv was incorrectly using ata_host_activate() instead of
ata_pci_sff_activate_host() leading to IRQ assignment failure in
legacy mode.  Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockr@shaw.ca>
Cc: stable@kernel.org
---
 drivers/ata/sata_nv.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: ata/drivers/ata/sata_nv.c
===================================================================
--- ata.orig/drivers/ata/sata_nv.c
+++ ata/drivers/ata/sata_nv.c
@@ -2479,8 +2479,7 @@ static int nv_init_one(struct pci_dev *p
 	}

 	pci_set_master(pdev);
-	return ata_host_activate(host, pdev->irq, ipriv->irq_handler,
-				 IRQF_SHARED, ipriv->sht);
+	return ata_pci_sff_activate_host(host, ipriv->irq_handler, ipriv->sht);
 }

 #ifdef CONFIG_PM
