From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Add ata_piix's own resume function
Date: Sat, 27 May 2006 08:46:41 +0200
Message-ID: <20060527064641.GA24012@suse.de>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <20060526230534.GA3640@suse.de> <44778F2A.7070708@garzik.org> <20060527062159.GB23315@suse.de> <4477F24E.8080407@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:48942 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751034AbWE0GrB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 02:47:01 -0400
Content-Disposition: inline
In-Reply-To: <4477F24E.8080407@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Sat, May 27 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> >I thought about that, and I don't agree. Waiting for the BSY to clear is
> >not a pci property, at best I'd consider that even worse than defining a
> >scsi resume function in ata_piix.
> 
> It has nothing to do with PCI, and everything to do control flow.  This 
> is _how the hardware works_:

It does by the very nature of this being invoked by the pci device
resume function...

> First you resume the controller.
> Then you resume the bus.
> Then you resume the devices on the bus.
> 
> The original patch goes BACKWARDS, by trying to resume the bus from the 
> device resume method.  That's just dumb.

Since there's just the one device on the bus in this case, whether its
the device or bus posting BUSY seems pretty irrelevant. If anything, I'd
say that the act of iterating over possible devices hanging of the pci
device and resuming them from the pci handler is definitely the worst
approach. The pci driver resume function should do just one thing --
resume the device itself.

-- 
Jens Axboe

