From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: Impact of no_lba48{_dma} = 1 ?
Date: Wed, 07 Feb 2007 14:25:34 +0100
Message-ID: <45C9D34E.1060007@imc-berlin.de>
References: <45C9A23E.3030201@imc-berlin.de> <20070207115826.2e3609e3@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:59780 "EHLO
	mx1.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030303AbXBGNZg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Feb 2007 08:25:36 -0500
In-Reply-To: <20070207115826.2e3609e3@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan,

>> How about performance impact of
>>
>> 		if (hwif->no_lba48 || hwif->no_lba48_dma)
>> 			hwif->rqsize = 256;
>> 		else
>> 			hwif->rqsize = 65536;
>>
>> in ide-probe.c ?
> 
> Only relevant for DMA really

So rqsize is only needed for DMA accesses?
