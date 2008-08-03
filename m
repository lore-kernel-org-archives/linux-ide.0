From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Fix a large collection of DMA mode mismatches
Date: Sun, 3 Aug 2008 14:08:26 +0100
Message-ID: <20080803140826.761c2582@lxorguk.ukuu.org.uk>
References: <20080801091834.5ca39334@lxorguk.ukuu.org.uk>
	<489537FF.7050106@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51113 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754755AbYHCNZm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 09:25:42 -0400
In-Reply-To: <489537FF.7050106@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: David =?UTF-8?B?TcO8bGxlcg==?= <dave.mueller@gmx.ch>, jgarzik@pobox.com, linux-ide@vger.kernel.org

> > +/* Don't open code these in drivers as there are traps. Firstly the range may
> > +   change in future hardware and specs, secondly 0xFF means 'no DMA' but is
> > +   > UDMA_0. Dyma ddreigiau */
> 
> I suppose "Dyma ddreigiau" is just contamination?  Also, can you please
> use similar patch formatting as other comments for consistency?

No.. its essetially 'Here by Dragons', and to see if people actually read
patch comments 8)
 
> > +static inline int ata_dma_enabled(struct ata_device *adev)
> > +{
> > +	return (adev->dma_mode == 0xFF ? 0 : 1);
> > +}
> 
> Wouldn't it be better to use ata_using_dma() instead like the other two?

Not really fussed either way. Up to Jeff I guess.

