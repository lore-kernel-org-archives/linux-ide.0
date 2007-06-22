From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata: Add pata_dma option so users can disable pata_dma as they can with old-ide
Date: Fri, 22 Jun 2007 21:04:25 +0200
Message-ID: <200706222104.25482.bzolnier@gmail.com>
References: <20070622144939.026ed6ac@the-village.bc.nu> <20070622165221.2ce648f6@the-village.bc.nu> <467BFE6F.7050300@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:12859 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758945AbXFVSu0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jun 2007 14:50:26 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1169572mue
        for <linux-ide@vger.kernel.org>; Fri, 22 Jun 2007 11:50:24 -0700 (PDT)
In-Reply-To: <467BFE6F.7050300@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, davej@redhat.com, linux-ide@vger.kernel.org

On Friday 22 June 2007, Mark Lord wrote:
> Alan Cox wrote:
> > On Fri, 22 Jun 2007 11:01:09 -0400
> > Mark Lord <liml@rtr.ca> wrote:
> > 
> >> Alan Cox wrote:
> >>> Allow
> >>>
> >>> 	libata.pata_dma=0
> >>>
> >>> to disable DMA (default is 1)
> >>>
> >>> SATA is unaffected as disabling DMA for SATA makes no sense at all.
> >>>
> >>> Signed-off-by: Alan Cox <alan@redhat.com>
> >> Alan,
> >>
> >> Should we really be piling up like this on global boot/module options
> >> rather than run-time flags on individual channels/devices ?
> >>
> >> I can imagine systems with internal notebook drives that want dma=1,
> >> plus Cardbus CF devices that require dma=0.
> >>
> >> With a single global flag, how does one do that?
> > 
> > We need proper tuning as well but there is huge value (with distro hat
> > on especially) in a single "try this to get it installed and then we can
> > debug it" button. Same with the old IDE. Trying to guide users through
> > selecting specific channels/devices is going to be painful. I want
> > something that I can tell people to get them 'off the ground' and work
> > with them to sort the rest.
> 
> Oh for sure.  I'm just thinking that some form of on-the-fly tunable
> would be of even greater value here, in addition to the boot/load default flag.
> 
> I think a /sys/ "dma" attribute (pick a name) might be most appropriate,
> or we just just implement HDIO_[GS]ET_DMA as a simpler/lazier mechanism.

The problem is that libata lacks any locking needed for having this
(and other useful) settings tunable on per device basis.

IDE has a needed locking although it sucks a lot (but is being reworked).

Bart
