From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2] sgiioc4: fix error cleanup path
Date: Sun, 19 Oct 2008 22:13:57 +0400
Message-ID: <200810192213.57242.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:20993 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751518AbYJSSOQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Oct 2008 14:14:16 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, jeremy@sgi.com

The driver "forgot" to call iounmap() if request_mem_region() call failed in
sgiioc4_ide_setup_pci_device(). While fixing this, rename the 'err' label to
'alloc_err' and get rid of the 'err_free' label altogether...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the recent Linus' tree.
                                          
 drivers/ide/pci/sgiioc4.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

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
+		goto request_error;
 	}
 
 	/* Initialize the IO registers */
@@ -633,18 +634,17 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	host = ide_host_alloc(&d, hws);
 	if (host == NULL) {
 		rc = -ENOMEM;
-		goto err;
+		goto alloc_error;
 	}
 
 	rc = ide_host_register(host, &d, hws);
-	if (rc)
-		goto err_free;
+	if (!rc)
+		return 0;
 
-	return 0;
-err_free:
 	ide_host_free(host);
-err:
+ alloc_error:
 	release_mem_region(cmd_phys_base, IOC4_CMD_CTL_BLK_SIZE);
+ request_error:
 	iounmap(virt_base);
 	return rc;
 }

