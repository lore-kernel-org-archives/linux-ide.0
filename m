From: Jarno Paananen <jpaana@s2.org>
Subject: Re: Promise 579 with current(?) libata in libata-dev-2.6 queue
Date: Tue, 19 Oct 2004 03:40:51 +0300
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <m36557k0a4.fsf@kalahari.s2.org>
References: <m3sm8ljkco.fsf@kalahari.s2.org> <417023B6.9070900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s2.org ([195.197.64.39]:59089 "EHLO kalahari.s2.org")
	by vger.kernel.org with ESMTP id S268179AbUJSAkz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Oct 2004 20:40:55 -0400
In-Reply-To: <417023B6.9070900@pobox.com> (Jeff Garzik's message of "Fri, 15
 Oct 2004 15:23:34 -0400")
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> There are additional interrupt events on the new cards that
> sata_promise doesn't know about.  Ack or disable those events, and
> things should work.
>
> 	Jeff

Thanks, 

it seems the comment:

/* reading should also clear interrupts */

doesn't hold for the 579, but some reading of the Promise driver
and adding a simple

writel(mask, mmio_base + PDC_INT_SEQMASK);

after the spin_lock (didn't know which side it should be, the but
the Promise driver does it after checking the 0xffff, and after the
spinlock seemed safe :) makes the driver work nicely for me. Dunno
if this is safe for other controllers than the 579 though, so it
might be useful to define a new card type for it.

// Jarno

--- sata_promise.c.old	2004-10-19 03:38:55.000000000 +0300
+++ sata_promise.c	2004-10-19 03:32:33.000000000 +0300
@@ -158,6 +158,8 @@
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3574, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
@@ -438,6 +440,8 @@
 
         spin_lock(&host_set->lock);
 
+        writel(mask, mmio_base + PDC_INT_SEQMASK);
+   
         for (i = 0; i < host_set->n_ports; i++) {
 		VPRINTK("port %u\n", i);
 		ap = host_set->ports[i];
