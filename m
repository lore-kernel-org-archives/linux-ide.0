From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Issues with SIS 964 chipset on SATA
Date: Thu, 17 Feb 2005 03:26:04 -0500
Message-ID: <4214551C.8030109@pobox.com>
References: <E0854782-793A-11D9-A80A-000A95D2AC6A@iomega.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52971 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262182AbVBQI0Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Feb 2005 03:26:24 -0500
In-Reply-To: <E0854782-793A-11D9-A80A-000A95D2AC6A@iomega.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gary Poppitz <poppitzg@iomega.com>
Cc: linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>

Gary Poppitz wrote:
> We tracked down a problem with the 964 chipset with a 0x180 ID code that 
> may save someone on the list some time.
> 
> The chip will only transfer multiples of 4 bytes. Anything else will 
> cause it to hang.


After further research, this is popping up on a number of chips (and 
worked around in several vendor drivers).

It looks like I will need to do a workaround for all SATA ATAPI devices: 
  if the transfer is not a multiple of 4 bytes, pad it with an DMA 1-3 
byte DMA segment.

	Jeff


