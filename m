From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] ide: ide-generic, add another device exception
Date: Fri, 8 Jun 2007 23:35:12 +0100
Message-ID: <20070608233512.69988f57@the-village.bc.nu>
References: <20601315171560711667@wsc.cz>
	<200706081418.56217.bzolnier@gmail.com>
	<20070608223505.3ff1a662@the-village.bc.nu>
	<200706090042.50287.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41354 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1032315AbXFHWag (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 18:30:36 -0400
In-Reply-To: <200706090042.50287.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Ingo Korb <ml@akana.de>, linux-ide@vger.kernel.org

On Sat, 9 Jun 2007 00:42:50 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Friday 08 June 2007, Alan Cox wrote:
> > On Fri, 8 Jun 2007 14:18:55 +0200
> > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > 
> > > On Monday 04 June 2007, Jiri Slaby wrote:
> > > > ide-generic, add another device exception
> > > 
> > > ide-generic is a generic ISA IDE driver, this one is drivers/ide/pci/generic
> > > (a generic IDE PCI driver) - fixed patch description to avoid confusion.
> > 
> > Nope ide-generic is a generic I/O based ST506 interface. It covers a bit
> > more than just ISA bus.
> 
> If so then can we finally get rid of hd.c?

Ok ST-506 register set. ST-506 MFM command set is a bit different and
does need hd.c (SFF only deals with PCI controllers)

> > > [ Yes, both drivers need a rename - patches are welcomed. ]
> > 
> > Good way to break everyones module settings
> 
> MODULE_ALIAS() should cover this up nicely.

No problem with that. Just need to be sure it gets done.

