From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH] fix sata_sil compilation on non-DMI platforms
Date: Mon, 11 May 2009 20:23:44 +0200
Message-ID: <20090511182344.GX24429@mail.wantstofly.org>
References: <200905062009.28087.markos@codex.gr> <4A086A76.3090008@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xi.wantstofly.org ([80.101.37.227]:59468 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755462AbZEKSPA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 May 2009 14:15:00 -0400
Content-Disposition: inline
In-Reply-To: <4A086A76.3090008@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Konstantinos Margaritis <markos@codex.gr>, linux-ide@vger.kernel.org, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>

On Mon, May 11, 2009 at 02:12:06PM -0400, Jeff Garzik wrote:

> > I tried to compile sata_sil on a 2.6.27 kernel on powerpc32 and I found 
> > that it failed to compile -lots of dmi related errors. I found that I had 
> > to include the broken_systems handling code in #ifdef CONFIG_DMI (DMI is 
> > not supported on platforms other than i386/x86_64). 
> >
> > Lennert on #mklinux told me that this commit broke the non-dmi support, 
> > and that a similar patch to mine is used on ARM systems :
> >
> > commit e57db7bde7bff95ae812736ca00c73bd5271455b
> > SATA Sil: Blacklist system that spins off disks during ACPI power off
> >
> > With this patch, sata_sil compiles on ppc (and I guess on other 
> > platforms). I'm using it for a while with no problems with a Delock 4-port 
> > SATA PCI card.
> 
> (CC'ing various Lennerts)

That was moi.


> What is the breakage?
> 
> Ideally the DMI subsystem should be provided wrappers for platforms 
> without DMI, rendering patches like this unnecessary.

It seems that the commit below should fix it.  Since that only went
into 2.6.29, that would explain why 2.6.27 is broken.


	commit d8204ee2ad1c9babd7e33d4c118ec99a78a8442e
	Author: Kumar Gala <galak@kernel.crashing.org>
	Date:   Wed Jan 28 00:07:20 2009 -0600

	    dmi: Fix build breakage

	    [...]
