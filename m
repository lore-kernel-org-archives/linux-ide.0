From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH] updates to Vitesse SATA driver
Date: Wed, 29 Sep 2004 19:34:28 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040930023428.GA200873@sgi.com>
References: <8746466a04092114163b3c0618@mail.gmail.com> <415B34FC.8060908@pobox.com> <8746466a0409291532471417b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx3-ext.sgi.com ([192.48.171.20]:20418 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268470AbUI3Cet (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Sep 2004 22:34:49 -0400
Content-Disposition: inline
In-Reply-To: <8746466a0409291532471417b8@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Dave <dave.jiang@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, jeremy.higdon@sgi.com, linux-ide@vger.kernel.org

On Wed, Sep 29, 2004 at 03:32:34PM -0700, Dave wrote:
> On Wed, 29 Sep 2004 18:19:40 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> > So where did the discussion on this patch land?

The only part that made sense to me was the LED patch, which should
just be a single line of code.

> Jeff,
> 
> I believe waiting for you to comment on whether to put in a hook for
> controllers that do not support ATA_NIEN so it can mask/unmask IRQ
> with a fixup.  Even though the spec for this particular SATA
> controller says the bit is reserved, it seems to work just fine. From
> my understanding, the registers are actually on the drives, and the
> ones we write to the HBAs are just shadow registers right? I suppose
> either we can use the "undocumented" reserved bit for ATA_NIEN, or
> provide some sort of special hook in lib_ata core to clear the
> interrupt bit....

I don't think we need this.  In vsc_sata_tf_load(), we see if the
ATA_NIEN bit has changed and call vsc_intr_mask_update() as
necessary.

> Obviosly if it is working on IA32 or IA64, this code must be only
> scanning device 0 per port and not device 1. Not sure why it is only
> scanning 1 device on IA platforms, but both on XScale. Either way we
> have a corner case here that should be addressed....

Jeff, I don't remember how libata knows how many devices a port
can have.  Which field is it?

jeremy
