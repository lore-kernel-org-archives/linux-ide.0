From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata-core.c: ata_fill_sg() ... sanity check on arithmentic ?
Date: Wed, 8 Aug 2007 11:02:18 +0100
Message-ID: <20070808110218.601fbda3@the-village.bc.nu>
References: <loom.20070807T172323-813@post.gmane.org>
	<20070807180714.25b1a8c1@the-village.bc.nu>
	<loom.20070808T110804-590@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57103 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754016AbXHHJyr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 05:54:47 -0400
In-Reply-To: <loom.20070808T110804-590@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MikeW <mw_phil@yahoo.co.uk>
Cc: linux-ide@vger.kernel.org

> > The specification says that 0x0000 means 64K. A couple of controllers do
> > get this wrong and we did recently add a second sg list builder for those.
> > 
> > Perhaps a comment or two is in order ?
> > -
> 
> Thanks - but which specification is this ?
> 
> As far as I am aware there is no spec for DMA controllers running ATA.

SFF 8038i covers the standard taskfile IDE class PCI device interface for
PIO and DMA. It also covers the alternate ADMA interface.

> Since DMA controller details may vary according to hardware, I
> would have expected that ata_fill_sg() would be one of the overloadable
> function entries with a driver-specific function that knew about
> the DMA controller niceties, and how to stuff a sg entry.

It is -n ot directly however but by overloading qc_prep. That makes more
sense than overloading fill_sg as not all controllers fit a simple
SFF like scatter/gather list model in the first place.

Alan
