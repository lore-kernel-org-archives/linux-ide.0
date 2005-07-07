From: Andi Kleen <ak@suse.de>
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Thu, 7 Jul 2005 23:25:18 +0200
Message-ID: <20050707212518.GO21330@wotan.suse.de>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507070912140.27066@graphe.net> <Pine.LNX.4.58.0507070937130.3293@g5.osdl.org> <Pine.LNX.4.62.0507071022480.7105@graphe.net> <Pine.LNX.4.58.0507071154440.3293@g5.osdl.org> <Pine.LNX.4.62.0507071208210.8200@graphe.net> <20050707211505.GM21330@wotan.suse.de> <58cb370e050707141913e87371@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:15536 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261601AbVGGVZV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 17:25:21 -0400
Content-Disposition: inline
In-Reply-To: <58cb370e050707141913e87371@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Christoph Lameter <christoph@lameter.com>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

> > The setup was a Intel board with 1 PATA/4 SATA onboard and only a CD-ROM
> > and a external Promise PATA controller with two PATA disks.
> 
> actual OOPS would be very useful

It's difficult because I don't have serial on that machine.

-Andi
