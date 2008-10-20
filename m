From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2] sgiioc4: fix error cleanup path (take 2)
Date: Mon, 20 Oct 2008 17:23:06 +0400
Message-ID: <200810201723.06653.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:23731 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751794AbYJTNXY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Oct 2008 09:23:24 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, jeremy@sgi.com

The driver "forgot" to call iounmap() iff request_mem_region() call failed in
sgiioc4_ide_setup_pci_device()...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
                                          
---
This patch is against the recent Linus' tree.

 drivers/ide/pci/sgiioc4.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/ide/pci/sgiioc4.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sgiioc4.c
+++ linux-2.6/drivers/ide/pci/sgiioc4.c
@@ -617,7 +617,8 @@ sgiioc4_ide_setup_pci_device(struct pci_
 		printk(KERN_ERR "%s %s -- ERROR: addresses 0x%08lx to 0x%08lx "
 		       "already in use\n", DRV_NAME, pci_name(dev),
 		       cmd_phys_base, cmd_phys_base + IOC4_CMD_CTL_BLK_SIZE);
-		return -EBUSY;
+		rc = -EBUSY;
+		goto req_mem_rgn_err;
 	}
 
 	/* Initialize the IO registers */
@@ -645,6 +646,7 @@ err_free:
 	ide_host_free(host);
 err:
 	release_mem_region(cmd_phys_base, IOC4_CMD_CTL_BLK_SIZE);
+req_mem_rgn_err:
 	iounmap(virt_base);
 	return rc;
 }

