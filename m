From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] remove dead drivers/ide/ppc/swarm.c
Date: Tue, 4 May 2004 14:43:49 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040504124349.GA15664@linux-mips.org>
References: <200405040134.22092.bzolnier@elka.pw.edu.pl> <20040504111902.GA14240@linux-mips.org> <200405041428.50592.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from p508B626F.dip.t-dialin.net ([80.139.98.111]:60786 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S264354AbUEDMo3
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 May 2004 08:44:29 -0400
Content-Disposition: inline
In-Reply-To: <200405041428.50592.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl

On Tue, May 04, 2004 at 02:28:50PM +0200, Bartlomiej Zolnierkiewicz wrote:

> It is not integrated into -mm (2.6.6-rc3-mm1) yet so I couldn't see it.
> [ Please cc: me on IDE patches. ]

Will do.

> If it looks the same as in linux-mips CVS it won't work because I've killed
> ide_init_default_hwifs() recently (except ARM but patch is pending).
> 
> Sorry, this is what you get when using hacks. 8)
> 
> While at swarm.c ...
> 
> > * Boards with SiByte processors so far have supported IDE devices via
> > * the Generic Bus, PCI bus, and built-in PCMCIA interface.  In all
> > * cases, byte-swapping must be avoided for these devices (whereas
> > * other PCI devices, for example, will require swapping).
> 
> Why does byte-swapping must be avoided for PCI IDE
> but not for other PCI devices?

Simply a result of the way the IDE bus is hooked up to the generic bus of
the Sibyte chip.  I'd have to research details if you're interested ...

  Ralf
