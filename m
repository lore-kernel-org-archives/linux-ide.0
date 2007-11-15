From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 10/13] ide-cris: fix DMA methods
Date: Thu, 15 Nov 2007 21:51:13 +0100
Message-ID: <200711152151.13500.bzolnier@gmail.com>
References: <200711130002.06806.bzolnier@gmail.com> <473B2556.4090605@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:18511 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762091AbXKOUxB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Nov 2007 15:53:01 -0500
Received: by nf-out-0910.google.com with SMTP id g13so610004nfb
        for <linux-ide@vger.kernel.org>; Thu, 15 Nov 2007 12:53:00 -0800 (PST)
In-Reply-To: <473B2556.4090605@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Mikael Starvik <starvik@axis.com>

On Wednesday 14 November 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Rename cris_dma_{on,off}() to cris_dma_host_{on,off}().
> 
>     Haven't you killed dma_on/dma_off_quietly() methods in the previosu patch?

Yes, I did.

I left fixing ide-cris after "kill dma_on/dma_off_quietly() methods"
patch because:

* Currently this driver is broken: cris_dma_on() (returns 'int')
  is assigned to hwif->dma_host_on (returns 'void') so the driver
  won't build.

* ->ide_dma_on method was missing so the driver OOPS-es on attempt
  to enable DMA.

* drive->using_dma was never set/cleared so DMA wouldn't be used anyway.

Unfortunately it seems that ide-cris stays broken even after this patch:

* V10: <asm/arch-v10/ide.h> needs fixing
  - ide_init_default_hwifs() should be removed
    (IDE core no longer uses it)
  - same for ide_init_hwif_ports() and ide_default_{irq,io_base}()
    (they shouldn't be needed for ide-cris host driver)

* V32: I'm unable to find a place which defines ETRAX_ARCH_V32

but I'm leaving fixing this to CRIS gurus. :)

[ I added the above explanation to the patch description. ]

> > * Remove no longer needed ->dma_off_quietly
> >   (IDE core has the needed code now).
> 
> > * Make cris_dma_host_on() void.
> 
> > Cc: Mikael Starvik <starvik@axis.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
