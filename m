From: Christoph Lameter <christoph@lameter.com>
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Thu, 7 Jul 2005 21:44:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0507072141390.14256@graphe.net>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507070912140.27066@graphe.net>
 <Pine.LNX.4.58.0507070937130.3293@g5.osdl.org> <Pine.LNX.4.62.0507071022480.7105@graphe.net>
 <Pine.LNX.4.58.0507071154440.3293@g5.osdl.org> <Pine.LNX.4.62.0507071208210.8200@graphe.net>
 <20050707211505.GM21330@wotan.suse.de> <58cb370e050707141913e87371@mail.gmail.com>
 <20050707212518.GO21330@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from graphe.net ([209.204.138.32]:6349 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262607AbVGHEo1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jul 2005 00:44:27 -0400
In-Reply-To: <20050707212518.GO21330@wotan.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 7 Jul 2005, Andi Kleen wrote:

> > > The setup was a Intel board with 1 PATA/4 SATA onboard and only a CD-ROM
> > > and a external Promise PATA controller with two PATA disks.
> > 
> > actual OOPS would be very useful
> 
> It's difficult because I don't have serial on that machine.

Maybe we can settle on this patch until we know for sure that the hwif 
is also a problem. In that case we can simply patch hwif_to_node:


Index: linux-2.6.git/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.git.orig/drivers/ide/ide-probe.c	2005-06-23 11:38:02.000000000 -0700
+++ linux-2.6.git/drivers/ide/ide-probe.c	2005-07-07 20:18:22.000000000 -0700
@@ -960,6 +960,15 @@
 }
 #endif /* MAX_HWIFS > 1 */
 
+static inline int hwif_to_node(ide_hwif_t *hwif)
+{
+	if (hwif->pci_dev)
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
 
