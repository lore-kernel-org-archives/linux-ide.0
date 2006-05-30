From: Jens Axboe <axboe@suse.de>
Subject: Re: jgarzik and max-sectors: out of memory
Date: Tue, 30 May 2006 10:36:29 +0200
Message-ID: <20060530083629.GA4199@suse.de>
References: <4478AA6C.5070305@garzik.org> <200605272243.41832.axboe@suse.de> <447BD0FD.1000200@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:7440 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932187AbWE3IfA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 04:35:00 -0400
Content-Disposition: inline
In-Reply-To: <447BD0FD.1000200@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, Hannes Reinecke <hare@suse.de>

On Tue, May 30 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> >Yep lets please do that, I don't think libata ever had any problems with 
> >256 sectors other than perhaps a worry that it would break "something" :-)
> 
> There were definite bugs in the past with 256 (versus <= 255) sectors...

Hardware or software? IIRC, the hardware ones were largely an urban
legend.

-- 
Jens Axboe

