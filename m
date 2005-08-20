From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: AHCI_MAX_SG
Date: Sat, 20 Aug 2005 02:45:21 -0400
Message-ID: <4306D181.5050205@pobox.com>
References: <20050609090859.GO5140@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:10721 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751078AbVHTGp1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Aug 2005 02:45:27 -0400
In-Reply-To: <20050609090859.GO5140@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jens Axboe wrote:
> Been wondering about this weird value for a while - why does it default
> to 168 segments? As clustering is disabled, that makes 672KiB the
> largest supported request. So currently the dma mapped controller
> command area is about 91KiB in size, I guess the limit is meant to limit
> the size of that area because 256 would be nicer. So how about making it
> 160 which makes the resulting command at least a multiple of 128, or
> even just 128 which gives us a nice clean 512KiB?

(I hope you don't mind me making a private message public -- several 
people have asked this, and even you have brought this up in public)

168 is the number that guarantees that AHCI_PORT_PRIV_DMA_SZ is 4K.

No other reason, and, it can (and probably will) be increased in the future.

	Jeff


