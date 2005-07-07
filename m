From: Andi Kleen <ak@suse.de>
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Thu, 7 Jul 2005 23:15:05 +0200
Message-ID: <20050707211505.GM21330@wotan.suse.de>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507070912140.27066@graphe.net> <Pine.LNX.4.58.0507070937130.3293@g5.osdl.org> <Pine.LNX.4.62.0507071022480.7105@graphe.net> <Pine.LNX.4.58.0507071154440.3293@g5.osdl.org> <Pine.LNX.4.62.0507071208210.8200@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261439AbVGGVPJ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507071208210.8200@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Lameter <christoph@lameter.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andi Kleen <ak@suse.de>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Jul 07, 2005 at 12:09:00PM -0700, Christoph Lameter wrote:
> On Thu, 7 Jul 2005, Linus Torvalds wrote:
> 
> > Yes. Except that if hwif is NULL, we'll have other oopses since we access 
> > that in other places.
> > 
> > Why _is_ hwif NULL anyway? That's another, unrelated thing, and should 
> > probably have a separate check and an early return.
> 
> I was wondering about that one as well. Andi brought it up.

I don't know why hwif was NULL, but my kernel definitely crashed.
hwif was NULL in the first function (I first misread the oops
and thought it was pci_dev NULL, but it wasn't).  For the second
I didn't verify it was hwif or pci_dev NULL, but one of them
was too.

The setup was a Intel board with 1 PATA/4 SATA onboard and only a CD-ROM 
and a external Promise PATA controller with two PATA disks.

-Andi
