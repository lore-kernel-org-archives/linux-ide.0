From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Sun, 19 Mar 2006 16:14:51 -0500
Message-ID: <441DC9CB.7030203@pobox.com>
References: <441DC397.9040504@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:12197 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750920AbWCSVOz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Mar 2006 16:14:55 -0500
In-Reply-To: <441DC397.9040504@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Jens / Jeff,
> 
> Each libata driver registers a .dma_boundary field with SCSI.
> This field is used to prevent merging of bio segments across
> a hardware limitation boundary, usually 0xffff.
> 
> This looks like it works for regular block I/O,
> but I'm not so sure about SGIO originated requests.
> 
> Any thoughts, or code you can point me to?

Everything goes through the block layer, including SG_IO, so everyone 
agrees on the boundaries that must be respected.

scsi sets blk_queue_segment_boundary() then gets out of the way, for the 
most part.  BIOVEC_SEG_BOUNDARY() is the macro that accesses this. 
Trace back and forth from there.  You will probably run into a call to 
blk_recount_segments() in __bio_add_page(), or maybe you'll check the 
seg boundary from another path.

	Jeff


