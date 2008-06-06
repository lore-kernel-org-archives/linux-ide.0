From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/4] sgiioc4: use driver name for resource allocation
Date: Fri, 6 Jun 2008 23:34:23 +0200
Message-ID: <200806062334.23364.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:8718 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760814AbYFFVkq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jun 2008 17:40:46 -0400
Received: by mu-out-0910.google.com with SMTP id w8so726772mue.1
        for <linux-ide@vger.kernel.org>; Fri, 06 Jun 2008 14:40:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>

Cc: Jeremy Higdon <jeremy@sgi.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sgiioc4.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -608,11 +608,11 @@ sgiioc4_ide_setup_pci_device(struct pci_
 
 	cmd_phys_base = bar0 + IOC4_CMD_OFFSET;
 	if (!request_mem_region(cmd_phys_base, IOC4_CMD_CTL_BLK_SIZE,
-	    hwif->name)) {
+	    DRV_NAME)) {
 		printk(KERN_ERR
 			"%s : %s -- ERROR, Addresses "
 			"0x%p to 0x%p ALREADY in use\n",
-		       __func__, hwif->name, (void *) cmd_phys_base,
+		       __func__, DRV_NAME, (void *) cmd_phys_base,
 		       (void *) cmd_phys_base + IOC4_CMD_CTL_BLK_SIZE);
 		return -ENOMEM;
 	}
