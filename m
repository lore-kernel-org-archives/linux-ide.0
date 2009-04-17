From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/02] sata_mv: workaround for multi_count errata sata24
Date: Fri, 17 Apr 2009 19:03:53 -0400
Message-ID: <49E90AD9.7070706@pobox.com>
References: <49E359D6.1090309@rtr.ca> <49E35A5E.4020204@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36900 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762009AbZDQXD4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 19:03:56 -0400
In-Reply-To: <49E35A5E.4020204@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Workaround for errata SATA#24 in sata_mv.
> This errata affects WRITE_MULTI* commands when
> the device multi_count produces a DRQ block size >= 4Kbytes.
> 
> We work around it here by converting such operations
> into ordinary PIO_WRITEs instead.
> 
> Note that this might result in a PIO FUA write unavoidably being converted
> into a non-FUA write.  In practice, any system using FUA is also going 
> to be
> using DMA rather than PIO, so this shouldn't affect anyone in the real 
> world.

I'm applying this, but I think a follow-up patch would be nice:  it 
seems like a one-time printk, indicating the FUA conversion is active, 
could be a help in case someone does care.

	Jeff




