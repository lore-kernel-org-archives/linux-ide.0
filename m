From: Mark Lord <liml@rtr.ca>
Subject: Re: Issues with SIS 964 chipset on SATA
Date: Thu, 17 Feb 2005 08:26:07 -0500
Message-ID: <42149B6F.1000502@rtr.ca>
References: <E0854782-793A-11D9-A80A-000A95D2AC6A@iomega.com> <4214551C.8030109@pobox.com> <20050217083825.GA8695@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:21677 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S262146AbVBQN0W
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Feb 2005 08:26:22 -0500
In-Reply-To: <20050217083825.GA8695@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Gary Poppitz <poppitzg@iomega.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
>
>>It looks like I will need to do a workaround for all SATA ATAPI devices: 
>> if the transfer is not a multiple of 4 bytes, pad it with an DMA 1-3 
>>byte DMA segment.

Yup, that requirement has existed on most of the hardware
I've done drivers for, both SATA and a lot of PATA chips too.

Cheers
