From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 07/24] libata: Fix the host_set hacks and sort out
	simplex mode
Date: Fri, 07 Jul 2006 17:50:16 +0100
Message-ID: <1152291016.20883.32.camel@localhost.localdomain>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <44AE88B9.2080800@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58272 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932205AbWGGQdC
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Jul 2006 12:33:02 -0400
In-Reply-To: <44AE88B9.2080800@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>

Ar Gwe, 2006-07-07 am 12:15 -0400, ysgrifennodd Jeff Garzik:
> If nothing happens in a few days, please yell at me, and I'll apply this 
> patch and work on top of it.  As it stands, it does some things I don't 
> want (irq2) and wish to avoid.

If nothing happens in the next few days it'll be OLS so I'll beat you
[verbally] senseless in person ;)

I agree with your "push IRQ out of libata" direction so I'm more than
happy to see it go that way

> Such code is appropriate ONLY in libata-bmdma.c (PCI IDE-specific code).

I wish you'd rename that file, its got very little to do with BMDMA and
very much to do with ST506/SFF.

> > +#define ATA_SECONDARY_CMD	0x170
> > +#define ATA_SECONDARY_CTL	0x376
> > +#define ATA_SECONDARY_IRQ	15
> > +
> > +#endif
> 
> This is either silly, or obviously-preliminary code.
> 
> We don't want to duplicate this information, but instead do as your 
> __ASM_GENERIC_LIBATA_PORTMAP_H symbol implies:  put a single copy into 
> include/asm-generic.

Its the first cut. I need to rework it a little because it turns out
that for some platforms you can only answer the question "what port is
legacy IDE on" if you know the PCI root bridge. In fact some boxes may
have multiple legacy mode IDE devices each on "0x1F0" as far as the PCI
bus is concerned and elsewhere as far as the bridge to cpu mapping is
concerned. I'm still pondering that particular vomitous mess and I'd
prefer to shoot all the special cases here and do what I'm testing in
the patches which is to spot legacy mode IDE and "fix" the bars up when
reading the otherwise invalid PCI registers in that mode.

Alan

