From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 02/02] sata_mv: workaround for multi_count errata sata24
Date: Mon, 13 Apr 2009 11:36:24 -0400
Message-ID: <49E35BF8.1070402@rtr.ca>
References: <49E359D6.1090309@rtr.ca> <49E35A5E.4020204@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:56581 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbZDMPg0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Apr 2009 11:36:26 -0400
In-Reply-To: <49E35A5E.4020204@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Mark Lord wrote:
> Workaround for errata SATA#24 in sata_mv.
> This errata affects WRITE_MULTI* commands when
> the device multi_count produces a DRQ block size >= 4Kbytes.
> 
> We work around it here by converting such operations
> into ordinary PIO_WRITEs instead.
> 
> Note that this might result in a PIO FUA write unavoidably being converted
> into a non-FUA write.  In practice, any system using FUA is also going to be
> using DMA rather than PIO, so this shouldn't affect anyone in the real world.
..

Testing this was a real bear.

The drives I have here are among those which cannot do R/W MULTI
prior to having a SET_MULTIPLE command issued to them by libata.

Which libata currently does not do.

This means that libata is unable to cope with non-DMA devices
that report a non-zero multi_count value at startup.

I simulated this scenario in sata_mv by changing the .udma_mask field
to zero for the card under test.  System sat there retrying the
partition table read over and over and over and over..  :)

Someday I'll fix that, if you guys don't beat me to it.
I suppose we just need to issue the SET_MULTIPLE command from
the drive revalidation code.  

Cheers
