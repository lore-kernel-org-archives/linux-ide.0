From: Jens Axboe <axboe@suse.de>
Subject: Re: jgarzik and max-sectors: out of memory
Date: Tue, 30 May 2006 11:10:02 +0200
Message-ID: <20060530091002.GG4199@suse.de>
References: <4478AA6C.5070305@garzik.org> <200605272243.41832.axboe@suse.de> <447BD0FD.1000200@garzik.org> <20060530083629.GA4199@suse.de> <20060530090258.GA17478@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:12592 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932197AbWE3JIB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 05:08:01 -0400
Content-Disposition: inline
In-Reply-To: <20060530090258.GA17478@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, Hannes Reinecke <hare@suse.de>

On Tue, May 30 2006, Jeff Garzik wrote:
> On Tue, May 30, 2006 at 10:36:29AM +0200, Jens Axboe wrote:
> > On Tue, May 30 2006, Jeff Garzik wrote:
> > > Jens Axboe wrote:
> > > >Yep lets please do that, I don't think libata ever had any problems with 
> > > >256 sectors other than perhaps a worry that it would break "something" :-)
> > > 
> > > There were definite bugs in the past with 256 (versus <= 255) sectors...
> > 
> > Hardware or software? IIRC, the hardware ones were largely an urban
> > legend.
> 
> Software.
> 
> Alan is submitting a couple PATA drivers limited to 255 though...

And I'm sure some are even lower than that. Of course libata should be
be imposing anything on the driver, the logic that drivers/ide uses for
this is actually pretty sane:

        if (device_lba28)
                max_hw_sectors = 256;
        if (device_lba48)
                max_hw_sectors = 65536;
        if (max_sectors > more_than_controller_supports)
                max_sectors = more_than_controller_supports;

or something close to that.

-- 
Jens Axboe

