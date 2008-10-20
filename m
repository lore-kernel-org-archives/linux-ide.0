From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2] sgiioc4: use ide_host_add() (take 2)
Date: Mon, 20 Oct 2008 17:24:57 +0400
Message-ID: <200810201724.57267.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:23751 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751830AbYJTNZO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Oct 2008 09:25:14 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, jeremy@sgi.com

Convert the driver to use ide_host_add() -- this seems to be a straightforward
change which I'm not sure why hasn't been done yet...

While doing this at last, get rid of:

- useless local copy of the 'sgiioc4_port_info' variable;

- unnecessary 'goto' and label...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
                                          
---
This patch is against the recent pata-2.6 series...
                                         
 drivers/ide/pci/sgiioc4.c |   18 +++---------------
 1 files changed, 3 insertions(+), 15 deletions(-)

Index: linux-2.6/drivers/ide/pci/sgiioc4.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sgiioc4.c
+++ linux-2.6/drivers/ide/pci/sgiioc4.c
@@ -567,9 +567,7 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	unsigned long cmd_base, irqport;
 	unsigned long bar0, cmd_phys_base, ctl;
 	void __iomem *virt_base;
-	struct ide_host *host;
 	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
-	struct ide_port_info d = sgiioc4_port_info;
 	int rc;
 
 	/*  Get the CmdBlk and CtrlBlk Base Registers */
@@ -604,20 +602,10 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	/* Initializing chipset IRQ Registers */
 	writel(0x03, (void __iomem *)(irqport + IOC4_INTR_SET * 4));
 
-	host = ide_host_alloc(&d, hws);
-	if (host == NULL) {
-		rc = -ENOMEM;
-		goto err;
-	}
+	rc = ide_host_add(&sgiioc4_port_info, hws, NULL);
+	if (!rc)
+		return 0;
 
-	rc = ide_host_register(host, &d, hws);
-	if (rc)
-		goto err_free;
-
-	return 0;
-err_free:
-	ide_host_free(host);
-err:
 	release_mem_region(cmd_phys_base, IOC4_CMD_CTL_BLK_SIZE);
 req_mem_rgn_err:
 	iounmap(virt_base);

