From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 4/4] libata sata_qstor conversion to new error handling
 (EH).
Date: Wed, 07 Nov 2007 18:36:13 -0500
Message-ID: <47324BED.9010302@rtr.ca>
References: <4731DF06.3050202@rtr.ca> <4731DFA7.8010202@rtr.ca> <20071107232721.GB26706@havoc.gtf.org> <47324B0D.9060706@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3088 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbXKGXgO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Nov 2007 18:36:14 -0500
In-Reply-To: <47324B0D.9060706@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
..
> and SG_IO WRITEs don't work.  That's really no different from
> the existing 2.6.24 version.  Regular I/O looks fine.
...

I should qualify that:  SG_IO *PIO* WRITEs don't work.
SG_IO PIO READs do work, and SG_IO DMA R/W both work.

Cheers
