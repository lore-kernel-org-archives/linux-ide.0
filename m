From: MikeW <mw_phil@yahoo.co.uk>
Subject: Re: libata-core.c: =?utf-8?b?YXRhX2ZpbGxfc2coKQ==?= ... sanity check on arithmentic ?
Date: Wed, 8 Aug 2007 09:15:40 +0000 (UTC)
Message-ID: <loom.20070808T110804-590@post.gmane.org>
References: <loom.20070807T172323-813@post.gmane.org> <20070807180714.25b1a8c1@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:55138 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754119AbXHHJQA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Aug 2007 05:16:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIhe0-0005wF-1Z
	for linux-ide@vger.kernel.org; Wed, 08 Aug 2007 11:15:56 +0200
Received: from 57.66.65.38 ([57.66.65.38])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 08 Aug 2007 11:15:56 +0200
Received: from mw_phil by 57.66.65.38 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 08 Aug 2007 11:15:56 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Alan Cox <alan <at> lxorguk.ukuu.org.uk> writes:

> 
> > So then ap->prd[idx].flags_len gets set to (0x10000 & 0xFFFF) = 0 !
> > So this sg element ends up with a zero length, even though the
> > transfer size should be 64k.
> > 
> > Is this correct behaviour, if not, should it be corrected ?
> 
> The specification says that 0x0000 means 64K. A couple of controllers do
> get this wrong and we did recently add a second sg list builder for those.
> 
> Perhaps a comment or two is in order ?
> -

Thanks - but which specification is this ?

As far as I am aware there is no spec for DMA controllers running ATA.

Since DMA controller details may vary according to hardware, I
would have expected that ata_fill_sg() would be one of the overloadable
function entries with a driver-specific function that knew about
the DMA controller niceties, and how to stuff a sg entry.

Cheers,
MikeW




