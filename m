From: Marin Mitov <mitov@issp.bas.bg>
Subject: [PATCH] pci_try_set_mwi() in sata_promise
Date: Tue, 22 Apr 2008 21:26:56 +0300
Message-ID: <200804222126.56321.mitov@issp.bas.bg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762156AbYDVS04@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi all,

The BIOS (Asus A8V Deluxe) is setting incorrectly PCI
Cache Line Size Register (as seen in lspci -vvv output), 
so try to correct it by pci_try_set_mwi(pdev).

Marin Mitov
----------------------------------------------------------
Enable Memory-Write-and-Invalidate in sata_promise driver and 
get rid of strange BIOS-set value for cache line size register.

According to Documentation/pci.txt:  "This enables...
...and also ensures that the cache line size register
is set correctly".

Signed-off-by: Marin Mitov <mitov@issp.bas.bg>
----------------------------------------------------------
--- a/drivers/ata/sata_promise.c	2008-04-22 13:09:15.000000000 +0300
+++ b/drivers/ata/sata_promise.c	2008-04-22 13:11:01.000000000 +0300
@@ -1114,6 +1114,7 @@ static int pdc_ata_init_one(struct pci_d

 	/* start host, request IRQ and attach */
 	pci_set_master(pdev);
+	pci_try_set_mwi(pdev);
 	return ata_host_activate(host, pdev->irq, pdc_interrupt, IRQF_SHARED,
 				 &pdc_ata_sht);
 }
