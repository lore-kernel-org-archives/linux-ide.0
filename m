From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Issues with SIS 964 chipset on SATA
Date: Thu, 17 Feb 2005 13:36:41 -0500
Message-ID: <4214E439.6040201@pobox.com>
References: <E0854782-793A-11D9-A80A-000A95D2AC6A@iomega.com> <4214551C.8030109@pobox.com> <20050217083825.GA8695@suse.de> <42149B6F.1000502@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9387 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261177AbVBQSg4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Feb 2005 13:36:56 -0500
In-Reply-To: <42149B6F.1000502@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, Gary Poppitz <poppitzg@iomega.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Jens Axboe wrote:
> 
>>
>>> It looks like I will need to do a workaround for all SATA ATAPI 
>>> devices: if the transfer is not a multiple of 4 bytes, pad it with an 
>>> DMA 1-3 byte DMA segment.
> 
> 
> Yup, that requirement has existed on most of the hardware
> I've done drivers for, both SATA and a lot of PATA chips too.

PATA too?  Interesting...

	Jeff



