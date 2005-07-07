From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Thu, 7 Jul 2005 11:57:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507071154440.3293@g5.osdl.org>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507070912140.27066@graphe.net>
 <Pine.LNX.4.58.0507070937130.3293@g5.osdl.org> <Pine.LNX.4.62.0507071022480.7105@graphe.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261874AbVGGTA5@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0507071022480.7105@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Lameter <christoph@lameter.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andi Kleen <ak@suse.de>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org



On Thu, 7 Jul 2005, Christoph Lameter wrote:
>
> On Thu, 7 Jul 2005, Linus Torvalds wrote:
> 
> > If you make it use a trivial inline function for the thing, I think that 
> > would be ok, though.
> 
> Like this?

Yes. Except that if hwif is NULL, we'll have other oopses since we access 
that in other places.

Why _is_ hwif NULL anyway? That's another, unrelated thing, and should 
probably have a separate check and an early return.

So there's two unrelated issues: hwif being NULL is a serious error
regardless of any node issues, and pci_dev being NULL just means we aren't
a PCI device.

Bartlomiej?

		Linus
