From: Christoph Lameter <christoph@lameter.com>
Subject: Re: [PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Wed, 6 Jul 2005 10:07:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0507061006190.20554@graphe.net>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507060933330.20107@graphe.net>
 <20050706164533.GK21330@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from graphe.net ([209.204.138.32]:22736 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262378AbVGFRHP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jul 2005 13:07:15 -0400
In-Reply-To: <20050706164533.GK21330@wotan.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Andi Kleen wrote:

> On Wed, Jul 06, 2005 at 09:34:28AM -0700, Christoph Lameter wrote:
> > On Wed, 6 Jul 2005, Andi Kleen wrote:
> > 
> > > -	q = blk_init_queue_node(do_ide_request, &ide_lock,
> > > -				pcibus_to_node(drive->hwif->pci_dev->bus));
> > > +	int node = 0; /* Should be -1 */
> > 
> > Why is this not -1?
> 
> Because there is no code in rc3 that handles -1 in kmalloc_node.
> 
> If you add a patch that handles it then feel free to change.
> But fixing the bootup has the highest priority.
> 
> > 
> > > +		int node = 0; 
> > > +		if (hwif->drives[0].hwif) { 
> > 
> > Also needs to be -1.
> 
> Then it would crash again.

The patch follows. Maybe add that and include a signoff by me?:

Index: linux-2.6.git/mm/slab.c
===================================================================
--- linux-2.6.git.orig/mm/slab.c	2005-07-05 17:03:30.000000000 -0700
+++ linux-2.6.git/mm/slab.c	2005-07-05 18:25:20.000000000 -0700
@@ -2372,6 +2372,9 @@
 	struct slab *slabp;
 	kmem_bufctl_t next;
 
+	if (nodeid == -1)
+		return kmem_cache_alloc_node(cachep, flags);
+
 	for (loop = 0;;loop++) {
 		struct list_head *q;
 
