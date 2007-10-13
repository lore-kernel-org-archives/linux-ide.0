From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-2.6.git] IDE/ATA fighting over driver name?
Date: Sat, 13 Oct 2007 13:02:19 +0100
Message-ID: <20071013130219.1f020d49@the-village.bc.nu>
References: <1192254081.29452.13.camel@Homer.simpson.net>
	<4710A31A.7020204@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50820 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753314AbXJMMAO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Oct 2007 08:00:14 -0400
In-Reply-To: <4710A31A.7020204@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mike Galbraith <efault@gmx.de>, Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Sat, 13 Oct 2007 06:51:06 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Mike Galbraith wrote:
> > Greetings,
> > 
> > Perhaps my .config is dainbramaged.  When make oldconfig asked me if I
> > wanted CONFIG_PATA_PLATFORM, I said "Damned if I know, go for it".
> > 
> > drivers/ide/legacy/ide_platform.c:		.name = "pata_platform",
> > drivers/ata/pata_platform.c:#define DRV_NAME "pata_platform"
> 
> That's a clear bug..  IDE's should be called ide_platform.

No its intentional and was discussed. Both of them provide an identical
platform driver interface, so they both use the same name. This means an
embedded platform developer doesn't have to choose which driver each of
their downstream users gets.

Probably just needs a bit of ifdef twiddling, if its even a bug (which is
not clear).

Alan
