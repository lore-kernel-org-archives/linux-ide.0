From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [RFC][PATCH 0/3] OF-platform PATA driver
Date: Sat, 24 Nov 2007 16:26:13 +0900
Message-ID: <20071124072613.GA7303@linux-sh.org>
References: <20071123175229.GA27143@localhost.localdomain> <4747751D.4060802@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pip15.gyao.ne.jp ([61.122.117.253]:1643 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752154AbXKXH0V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Nov 2007 02:26:21 -0500
Content-Disposition: inline
In-Reply-To: <4747751D.4060802@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: avorontsov@ru.mvista.com, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Fri, Nov 23, 2007 at 07:49:33PM -0500, Jeff Garzik wrote:
> Anton Vorontsov wrote:
> >Here is the PATA Platform driver using OF infrastructure.
> >
> >Mostly it's just a wrapper around a bit modified pata_platform
> >driver.
> >
> >Patches are well split for the easier review:
> >
> >First one factors out platform_device specific bits and modifies
> >pata_platform to be a library-alike driver (with platform_device
> >default binding).
> >
The only issue I have here is that this library-like version has subtle
semantic changes that will break existing drivers.

irq_flags exists in struct pata_platform_info precisely for the IRQ
resource IRQ flags (as opposed to the IORESOURCE flags, which are what
the IRQ resource flags refer to instead). This change takes that for
granted and just assumes we're going to be using the res->flags, which is
both an invalid assumption, and will utterly break blackfin and others
that depend on it.

Incidentally, we already have an include/linux/pata_platform.h. If this
is going to be library-like, through the prototypes in there, rather than
splitting them up betewen include/linux and drivers/ata. We don't need
two headers.

These patches basically look fine to me otherwise, though it would be
nice if the semantic-changing bits had been abstracted. So as long as the
old irq_flags behaviour is maintained and that irq_res->flags stuff is
ripped out, I'll add my Acked-by as well.
