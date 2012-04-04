From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: Re: [PATCH v2 1/3] PATA host controller driver for ep93xx
Date: Wed, 04 Apr 2012 09:47:56 +0200
Message-ID: <4F7BFCAC.2060300@metasoft.pl>
References: <4F7B0C54.8010804@metasoft.pl> <4F7B0CEF.2040307@metasoft.pl> <ADE657CA350FB648AAC2C43247A983F0020698409E51@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metasoft.pl ([195.149.224.191]:44005 "EHLO smtp.metasoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753265Ab2DDHsF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Apr 2012 03:48:05 -0400
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020698409E51@AUSP01VMBX24.collaborationhost.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, "rmallon@gmail.com" <rmallon@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, "bzolnier@gmail.com" <bzolnier@gmail.com>

On 2012-04-03 20:55, H Hartley Sweeten wrote:
> 
> If the dma init fails does the driver fall back to pio mode correctly?
> 

Yes, udma_mask of ata_port is set only if we successfully requested dma
channels. Otherwise, we are limited to PIO4.

>> +	.bmdma_setup		= ep93xx_pata_dma_setup,
>> +	.bmdma_start		= ep93xx_pata_dma_start,
>> +	.bmdma_stop		= ep93xx_pata_dma_stop,
>> +	.bmdma_status		= ep93xx_pata_dma_status,
> 
> The bmdma ops pointers are still set if the dma init failed. Should they
> be set to NULL?
> 

I think it's not needed. Libata will not call them if udma_mask = 0.

> There are only two m2m dma channels on the ep93xx. They could be already in
> use by the spi driver. I just want to make sure that the ide driver will fall back to
> pio mode if they are not available.
> 

I tested this by enabling ep93xx spi in dma mode. In this case, pata driver
works in PIO4 mode.

Thanks,
RP
