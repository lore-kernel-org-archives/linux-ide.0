From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_artop: fix UDMA5 for AEC6280[R] and UDMA6 for
 AEC6880[R]
Date: Fri, 10 Aug 2007 18:33:43 +0100
Message-ID: <20070810183343.6f1ebed0@the-village.bc.nu>
References: <200708101438.l7AEcNna029762@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47827 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750866AbXHJR0e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 13:26:34 -0400
In-Reply-To: <200708101438.l7AEcNna029762@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> Tested on ATP865 (1191:0008 rev 07) in a DS101 box (an ARM-based NAS).
> Seems to work fine.

Its tested fairly hard on several NAS boxes (and still needs a fix for
one)

> However, I'm gettting consistently lower read throughput with pata_artop
> (13-19 MB/s) than with aec62xx (22 MB/s) on an oldish WD drive, and using
> pata_artop triggers a WARN_ON(irqs_disabled()) in arch/arm/mm/consistent.c:

It would be nice to know why - is the cable detet coming out right on
this ?

> WARNING: at arch/arm/mm/consistent.c:364 dma_free_coherent()

ARM has a problem with dma_free_coherent with IRQ disabled. Unfortunately
under high load ARM decides to use dma_free_coherent inside
dma_unmap_sg(). This as far as I can see is an ARM problem not a libata
problem and one you can duplicate with other drivers under high load.

If any ARM people can tell me what is going on and help fix it either in
ARM or libata that would be great.

Alan
