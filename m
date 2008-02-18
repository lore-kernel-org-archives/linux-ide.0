From: Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl>
Subject: Re: DMA on ht6560b?
Date: Mon, 18 Feb 2008 16:17:10 +0100
Message-ID: <47B9A176.9020808@caiway.nl>
References: <47B992A1.2030008@caiway.nl> <20080218143003.39f22ca3@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cardassian.kabelfoon.nl ([62.45.45.18]:53939 "EHLO
	cardassian.kabelfoon.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbYBRPRM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 10:17:12 -0500
In-Reply-To: <20080218143003.39f22ca3@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Alan Cox wrote:
>> I think the ht6560b controller supports DMA. 
>>     
>
> The data sheet doesn't. It's a PIO controller capable of PIO4 with 32bit
> host to cpu transfers are best.
>   

Hmm. But what do you then think that 2.2 did?
I mean it now does 1.15M/s and in 2.2 it would do ~4M/s with DMA on. 
Were those perhaps ISA style DMA transfers (as opposed to BM-DMA)?
I really should compile a 2.2 with ht6560b support...

Thanks for answering, though, I don't know that much about ATA.
Jan Evert

