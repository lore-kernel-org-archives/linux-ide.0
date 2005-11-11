From: Jens Axboe <axboe@suse.de>
Subject: Re: Marvell MV88SX6041 SATA Driver PIO4 Mode Not DMA
Date: Fri, 11 Nov 2005 13:14:47 +0100
Message-ID: <20051111121447.GQ3699@suse.de>
References: <1131648518.26701.247242836@webmail.messagingengine.com> <437471D0.3090404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:42353 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750703AbVKKMNn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2005 07:13:43 -0500
Content-Disposition: inline
In-Reply-To: <437471D0.3090404@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Spencer Tuttle <rodeojones@fastmail.fm>, linux-ide@vger.kernel.org

On Fri, Nov 11 2005, Jeff Garzik wrote:
> Spencer Tuttle wrote:
> >I have just compiled the new 2.6.14 kernel from the gentoo-sources tree.
> >
> >I can access the drives just fine, but it seems really slow.  Here is
> >the dmesg output when I load the kernel module
> 
> That's expected, since the driver in 2.6.14 only does PIO mode.
> 
> Try 2.6.14-gitN which supports EDMA.

Did you see these as well:

blk_queue_max_hw_segments: set to minimum 1

Could it be forgetting to set ->sg_tablesize as well?

-- 
Jens Axboe

