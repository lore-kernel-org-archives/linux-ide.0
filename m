From: Tejun Heo <htejun@gmail.com>
Subject: Re: Random libata notes
Date: Mon, 13 Mar 2006 20:40:18 +0900
Message-ID: <20060313114018.GB25706@htj.dyndns.org>
References: <4409CF74.7030808@garzik.org> <44118B3D.9040103@gmail.com> <44118E4B.9050401@gmail.com> <44137B69.2080107@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:55406 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751825AbWCMLk0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 06:40:26 -0500
Received: by wproxy.gmail.com with SMTP id 57so577885wri
        for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 03:40:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <44137B69.2080107@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jens Axboe <axboe@suse.de>, Mark Lord <liml@rtr.ca>

On Sat, Mar 11, 2006 at 08:37:45PM -0500, Jeff Garzik wrote:
> >>>
> >>>2) ata_scsi_slave_config() hardcodes a call to
> >>>blk_queue_max_phys_segments(, LIBATA_MAX_PRD), when the value passed
> >>>should not be so limited on nice hardware like AHCI.
> >
> >
> >And, AFAICS, we can increase max_phys_segments all we want. This limits 
> >the number of segments before IOMMU mapping. The only part that's 
> >affected is the driver (software) and I don't see any limitation in 
> >libata PIO implementation that puts limitation on the number of sg 
> >entries. Simply changing LIBATA_MAX_PRD to 65535 should do it.
> 
> We really want to accurately export the correct value for each piece of 
> hardware.  It IMO isn't wise to tempt fate with a wide disparity between 
> max_phys_segments, max_hw_segments, and real life...  :)
> 

Okay, I may have misunderstood, but max_phys_segments has *nothing* to
do with hardware limits.  max_phys_segments tells the block layer how
many segments the device driver (software) can handle while
max_hw_segments tells the block layer how many segments the hardware
can handle.

So, on machines without an IOMMU, unless max_phys_segments is smaller
than max_hw_segments, it is ignored.  And on machine with an IOMMU,
the number of sg entries may exceed max_hw_segments iff it's still
under max_phys_segments and the number of sg entries hardware sees is
under than max_hw_segments after IOMMU merging.

AFAICS, there is no limit in the current libata code which limits the
number of sg entries libata software can handle.  The only affected
codes would be sg mapping and PIO codes, both of which don't put any
limits on the number of segments they can handle.  So, there is no
reason to limit max_phys_segments to any number lower than its
maximum.  Limiting max_hw_segments is enough.

Hmmm.. Or is it that you are worried about block layer and/or IOMMU
acting weirdly?

Thanks.

-- 
tejun
