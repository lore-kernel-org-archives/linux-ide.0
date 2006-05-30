From: Jeff Garzik <jeff@garzik.org>
Subject: Re: jgarzik and max-sectors: out of memory
Date: Tue, 30 May 2006 05:15:40 -0400
Message-ID: <20060530091540.GA18070@havoc.gtf.org>
References: <4478AA6C.5070305@garzik.org> <200605272243.41832.axboe@suse.de> <447BD0FD.1000200@garzik.org> <20060530083629.GA4199@suse.de> <20060530090258.GA17478@havoc.gtf.org> <20060530091002.GG4199@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:16072 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932206AbWE3JPm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 05:15:42 -0400
Content-Disposition: inline
In-Reply-To: <20060530091002.GG4199@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, Hannes Reinecke <hare@suse.de>

On Tue, May 30, 2006 at 11:10:02AM +0200, Jens Axboe wrote:
> And I'm sure some are even lower than that. Of course libata should be
> be imposing anything on the driver, the logic that drivers/ide uses for
> this is actually pretty sane:
> 
>         if (device_lba28)
>                 max_hw_sectors = 256;
>         if (device_lba48)
>                 max_hw_sectors = 65536;
>         if (max_sectors > more_than_controller_supports)
>                 max_sectors = more_than_controller_supports;
> 
> or something close to that.

libata has always done this, modulo the ATA_MAX_SECTORS issue.

	Jeff



