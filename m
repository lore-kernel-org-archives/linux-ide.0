From: Christoph Lameter <christoph@lameter.com>
Subject: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Thu, 7 Jul 2005 09:21:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0507070912140.27066@graphe.net>
References: <20050706133052.GF21330@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from graphe.net ([209.204.138.32]:44206 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261360AbVGGQWA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 12:22:00 -0400
In-Reply-To: <20050706133052.GF21330@wotan.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Andi Kleen wrote:

> Without this patch a dual Xeon EM64T machine would oops on boot
> because the hwif pointer here was NULL. I also added a check for
> pci_dev because it's doubtful that all IDE devices have pci_devs.

Here is IMHO the right way to fix this. Test for the hwif != NULL and
test for pci_dev != NULL before determining the node number of the pci 
bus that the device is connected to. Maybe we need a hwif_to_node for ide 
drivers that is also able to determine the locality of other hardware?

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.git/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.git.orig/drivers/ide/ide-probe.c	2005-06-23 11:38:02.000000000 -0700
+++ linux-2.6.git/drivers/ide/ide-probe.c	2005-07-07 09:15:04.000000000 -0700
@@ -979,7 +979,8 @@
 	 */
 
 	q = blk_init_queue_node(do_ide_request, &ide_lock,
-				pcibus_to_node(drive->hwif->pci_dev->bus));
+				(drive->hwif && drive->hwif->pci_dev) ?
+				pcibus_to_node(drive->hwif->pci_dev->bus): -1);
 	if (!q)
 		return 1;
 
@@ -1097,7 +1098,8 @@
 		spin_unlock_irq(&ide_lock);
 	} else {
 		hwgroup = kmalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,
-			pcibus_to_node(hwif->drives[0].hwif->pci_dev->bus));
+			(hwif->drives[0].hwif && hwif->drives[0].hwif->pci_dev) ?
+			pcibus_to_node(hwif->drives[0].hwif->pci_dev->bus) : -1);
 		if (!hwgroup)
 	       		goto out_up;
 
