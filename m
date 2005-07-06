From: Andi Kleen <ak@suse.de>
Subject: [PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Wed, 6 Jul 2005 15:30:53 +0200
Message-ID: <20050706133052.GF21330@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42452 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262227AbVGFNa7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jul 2005 09:30:59 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, christoph@lameter.com


Without this patch a dual Xeon EM64T machine would oops on boot
because the hwif pointer here was NULL. I also added a check for
pci_dev because it's doubtful that all IDE devices have pci_devs.

Signed-off-by: Andi Kleen <ak@suse.de>


Index: linux/drivers/ide/ide-probe.c
===================================================================
--- linux.orig/drivers/ide/ide-probe.c
+++ linux/drivers/ide/ide-probe.c
@@ -978,8 +978,10 @@ static int ide_init_queue(ide_drive_t *d
 	 *	do not.
 	 */
 
-	q = blk_init_queue_node(do_ide_request, &ide_lock,
-				pcibus_to_node(drive->hwif->pci_dev->bus));
+	int node = 0; /* Should be -1 */
+	if (drive->hwif && drive->hwif->pci_dev)
+		node = pcibus_to_node(drive->hwif->pci_dev->bus); 
+	q = blk_init_queue_node(do_ide_request, &ide_lock, node);
 	if (!q)
 		return 1;
 
@@ -1096,8 +1098,13 @@ static int init_irq (ide_hwif_t *hwif)
 		hwgroup->hwif->next = hwif;
 		spin_unlock_irq(&ide_lock);
 	} else {
-		hwgroup = kmalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,
-			pcibus_to_node(hwif->drives[0].hwif->pci_dev->bus));
+		int node = 0; 
+		if (hwif->drives[0].hwif) { 
+			struct pci_dev *pdev = hwif->drives[0].hwif->pci_dev;  
+			if (pdev)
+				node = pcibus_to_node(pdev->bus);
+		}
+		hwgroup = kmalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,node);
 		if (!hwgroup)
 	       		goto out_up;
 


