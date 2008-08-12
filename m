From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] sgiioc4: fixup message on resource allocation failure
Date: Tue, 12 Aug 2008 11:27:23 +0200
Message-ID: <200808121127.23512.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753599AbYHLJcH@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>
List-Id: linux-ide@vger.kernel.org

There can be more than one sgiioc4 card in the system so print
also PCI device name on resource allocation failure (so we know
which one is the problematic one).

Reported-by: Jeremy Higdon <jeremy@sgi.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sgiioc4.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -621,9 +621,9 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	if (!request_mem_region(cmd_phys_base, IOC4_CMD_CTL_BLK_SIZE,
 	    DRV_NAME)) {
 		printk(KERN_ERR
-			"%s : %s -- ERROR, Addresses "
+			"%s %s: -- ERROR, Addresses "
 			"0x%p to 0x%p ALREADY in use\n",
-		       __func__, DRV_NAME, (void *) cmd_phys_base,
+		       DRV_NAME, pci_name(dev), (void *)cmd_phys_base,
 		       (void *) cmd_phys_base + IOC4_CMD_CTL_BLK_SIZE);
 		return -ENOMEM;
 	}
