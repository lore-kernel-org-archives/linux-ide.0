From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Fix a large collection of DMA mode mismatches
Date: Sun, 03 Aug 2008 23:02:55 +0900
Message-ID: <4895BA8F.4090603@kernel.org>
References: <20080801091834.5ca39334@lxorguk.ukuu.org.uk>	<489537FF.7050106@kernel.org> <20080803140826.761c2582@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47006 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755197AbYHCODi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Aug 2008 10:03:38 -0400
In-Reply-To: <20080803140826.761c2582@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: =?ISO-8859-1?Q?David_M=FCller?= <dave.mueller@gmx.ch>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Alan Cox wrote:
>>> +/* Don't open code these in drivers as there are traps. Firstly the range may
>>> +   change in future hardware and specs, secondly 0xFF means 'no DMA' but is
>>> +   > UDMA_0. Dyma ddreigiau */
>> I suppose "Dyma ddreigiau" is just contamination?  Also, can you please
>> use similar patch formatting as other comments for consistency?
> 
> No.. its essetially 'Here by Dragons', and to see if people actually read
> patch comments 8)

Ah.. Okay.  English word games and Latin phrases scare me.  :-)

>>> +static inline int ata_dma_enabled(struct ata_device *adev)
>>> +{
>>> +	return (adev->dma_mode == 0xFF ? 0 : 1);
>>> +}
>> Wouldn't it be better to use ata_using_dma() instead like the other two?
> 
> Not really fussed either way. Up to Jeff I guess.

The thing is ata_dma_enabled(dev) looks like it's testing whether the
device is capable of doing DMA while 'using' explicitly indicates the
current configuration.  Well, no biggie either way.

-- 
tejun
