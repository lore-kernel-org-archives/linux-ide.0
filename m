From: Rob Hughes <rob@robhughes.com>
Subject: Re: sata_sil performance
Date: Thu, 02 Dec 2004 05:50:53 -0600
Message-ID: <1101988253.32379.10.camel@kahuna-ws.robhughes.com>
References: <1101680376.5337.5.camel@kahuna-ws.robhughes.com>
	 <41AEFCB7.9030108@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sccrmhc11.comcast.net ([204.127.202.55]:11760 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261584AbULBL5l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Dec 2004 06:57:41 -0500
In-Reply-To: <41AEFCB7.9030108@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Thu, 2004-12-02 at 06:29 -0500, Jeff Garzik wrote:
> Rob Hughes wrote:
> > Jeff,
> > 
> > I can understand why you did what you did looking through the code, but
> > my drive, a Seagate ST3120026AS, does not need this fix. Further,
> > performance has gone from 50-60 Mbit transfers to 14-15 Mbit transfers
> > between the 2.6.8 and 2.6.9 kernels. And as a side not, hdparm is
> > reporting "HDIO_GET_MULTCOUNT failed: Inappropriate ioctl for device"
> > when doing either -I or -i as of this kernel version.
> 
> multcount is for PIO transfers, don't worry about it.  If you are doing 
> PIO you are already slower than 15Mbit.
> 

I wasn't actually clear there. hdparm  fails entirely to get any
information from the drive. That's just the error that's thrown to the
console. This worked before SATA drives were treated as SCSI devices (<
2.6.8 or thereabouts).

> 
> > If you're already working on a patch for this, I'd be happy to test it.
> > Also, it should be noted that I'm running FC3, so I'm not sure how much
> > that will play into this.
> 
> Unfortunately at this time we must judge the situation as "you just 
> haven't hit the problem yet".  Yeah, the performance hit sucks, but the 
> kernel _must_ be conservative and err on the side of caution.

I will, of course, bow to your judgment, but I've done my own patch to
remove my drive from the blacklist. Performance is back up and nothing
is reporting any errors, nor have I experienced any data corruption,
even under very heavy IO loads. And the big compiles I do are again
completing in reasonable time. But since I at least know about this now,
I can, in the future, purchase drives that aren't blacklisted.

I wonder if Seagate would replace it with a drive not affected by the
mod15write bug? ;)

Regards,
Rob
