From: Christoph Lameter <christoph@lameter.com>
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Thu, 7 Jul 2005 10:23:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0507071022480.7105@graphe.net>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507070912140.27066@graphe.net>
 <Pine.LNX.4.58.0507070937130.3293@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from graphe.net ([209.204.138.32]:34515 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261471AbVGGRXd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 13:23:33 -0400
In-Reply-To: <Pine.LNX.4.58.0507070937130.3293@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, Linus Torvalds wrote:

> If you make it use a trivial inline function for the thing, I think that 
> would be ok, though.

Like this?

Index: linux-2.6.git/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.git.orig/drivers/ide/ide-probe.c	2005-06-23 11:38:02.000000000 -0700
+++ linux-2.6.git/drivers/ide/ide-probe.c	2005-07-07 10:22:02.000000000 -0700
@@ -960,6 +960,15 @@
 }
 #endif /* MAX_HWIFS > 1 */
 
+static inline int hwif_to_node(ide_hwif_t *hwif)
+{
+	if (hwif && hwif->pci_dev)
+		return pcibus_to_node(hwif->pci_dev->bus);
+	else
+		/* Add ways to determine the node of other busses here */
+		return -1;
+}
+
 /*
  * init request queue
  */
@@ -978,8 +987,7 @@
 	 *	do not.
 	 */
 
-	q = blk_init_queue_node(do_ide_request, &ide_lock,
-				pcibus_to_node(drive->hwif->pci_dev->bus));
+	q = blk_init_queue_node(do_ide_request, &ide_lock, hwif_to_node(hwif));
 	if (!q)
 		return 1;
 
@@ -1097,7 +1105,7 @@
 		spin_unlock_irq(&ide_lock);
 	} else {
 		hwgroup = kmalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,
-			pcibus_to_node(hwif->drives[0].hwif->pci_dev->bus));
+					hwif_to_node(hwif->drives[0].hwif));
 		if (!hwgroup)
 	       		goto out_up;
 
