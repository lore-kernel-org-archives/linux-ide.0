From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Issues with SIS 964 chipset on SATA
Date: Thu, 17 Feb 2005 13:38:35 -0500
Message-ID: <4214E4AB.2010507@pobox.com>
References: <E0854782-793A-11D9-A80A-000A95D2AC6A@iomega.com> <4214551C.8030109@pobox.com> <20050217083825.GA8695@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21931 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262318AbVBQSiw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Feb 2005 13:38:52 -0500
In-Reply-To: <20050217083825.GA8695@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Gary Poppitz <poppitzg@iomega.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> On Thu, Feb 17 2005, Jeff Garzik wrote:
>>It looks like I will need to do a workaround for all SATA ATAPI devices: 
>> if the transfer is not a multiple of 4 bytes, pad it with an DMA 1-3 
>>byte DMA segment.
> 
> 
> Yeah we definitely need something like that. The optimal solution is to
> make sure that all requests are fed through the bounce logic like fs
> requests.


Could you elaborate?  I'm not sure I follow.

I hope you're not suggesting leaking 1-3 bytes of random memory, past 
the end of the request, into the DMA stream?

	Jeff


