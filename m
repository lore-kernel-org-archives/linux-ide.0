From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 4/4] libata sata_qstor conversion to new error handling
	(EH).
Date: Wed, 7 Nov 2007 18:45:14 -0500
Message-ID: <20071107234514.GC26706@havoc.gtf.org>
References: <4731DF06.3050202@rtr.ca> <4731DFA7.8010202@rtr.ca> <20071107232721.GB26706@havoc.gtf.org> <47324B0D.9060706@rtr.ca> <47324BED.9010302@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:36433 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603AbXKGXpP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Nov 2007 18:45:15 -0500
Content-Disposition: inline
In-Reply-To: <47324BED.9010302@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wed, Nov 07, 2007 at 06:36:13PM -0500, Mark Lord wrote:
> Mark Lord wrote:
> ..
> >and SG_IO WRITEs don't work.  That's really no different from
> >the existing 2.6.24 version.  Regular I/O looks fine.
> ...
> 
> I should qualify that:  SG_IO *PIO* WRITEs don't work.
> SG_IO PIO READs do work, and SG_IO DMA R/W both work.

multi-sector or single-sector PIO?

	Jeff



