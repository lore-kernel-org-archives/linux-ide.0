From: Jens Axboe <axboe@suse.de>
Subject: Re: Issues with SIS 964 chipset on SATA
Date: Thu, 17 Feb 2005 09:38:30 +0100
Message-ID: <20050217083825.GA8695@suse.de>
References: <E0854782-793A-11D9-A80A-000A95D2AC6A@iomega.com> <4214551C.8030109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from ns.virtualhost.dk ([195.184.98.160]:17559 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262273AbVBQIik (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Feb 2005 03:38:40 -0500
Content-Disposition: inline
In-Reply-To: <4214551C.8030109@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Gary Poppitz <poppitzg@iomega.com>, linux-ide@vger.kernel.org

On Thu, Feb 17 2005, Jeff Garzik wrote:
> Gary Poppitz wrote:
> >We tracked down a problem with the 964 chipset with a 0x180 ID code that 
> >may save someone on the list some time.
> >
> >The chip will only transfer multiples of 4 bytes. Anything else will 
> >cause it to hang.
> 
> 
> After further research, this is popping up on a number of chips (and 
> worked around in several vendor drivers).
> 
> It looks like I will need to do a workaround for all SATA ATAPI devices: 
>  if the transfer is not a multiple of 4 bytes, pad it with an DMA 1-3 
> byte DMA segment.

Yeah we definitely need something like that. The optimal solution is to
make sure that all requests are fed through the bounce logic like fs
requests.

-- 
Jens Axboe

