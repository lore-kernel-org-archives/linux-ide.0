From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.24-rc & SB600 AHCI no go on >=4GB of RAM
Date: Wed, 14 Nov 2007 17:43:22 +0100 (CET)
Message-ID: <alpine.LFD.0.9999.0711141633400.3265@localhost.localdomain>
References: <198606.73895.qm@web52608.mail.re2.yahoo.com> <200711141317.35746.ak@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:58370 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753766AbXKNQni (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Nov 2007 11:43:38 -0500
In-Reply-To: <200711141317.35746.ak@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Wed, 14 Nov 2007, Andi Kleen wrote:
> On Wednesday 14 November 2007 12:55, Srihari Vijayaraghavan wrote:
> > [Sorry to reply to my own email thread]
> >
> > Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au> wrote:
> > ...
> >
> > > No problems. Here's the log of unworking kernel with IOMMU turned on.
> > > Basically it goes on reseting the SATA ports throwing many errors (none
> > > are present in 2.6.23 or on 2.6.24-rc with mem=3500M) for many minutes at
> > > which point I do a power reset :-(.
> > >
> > > Also the log of the working kernel with IOMMU but with mem=3500M is also
> > > attached for the record. It's basically the same above kernel just with
> > > the added parameter.
> >
> > Gentlemen,
> >
> > This changeset has introduced a regression in 2.6.24-rc, such that my
> > machine boots no more:
> 
> Hmm, you got an AHCI controller that does not do 64bit DMA masks?
> Or do you have CONFIG_IOMMU_DEBUG enabled? 
> 
> Anyways, not being able to deal with merged SG lists must be some
> driver or hardware bug. I would stick some printks into gart_map_sg()
> and try to find out where the failing DMA is initiatiated and then
> split it into multiple IO submissions at the caller level.

64bit DMA on SB600 was disabled in May/07 due to a chip bug:
http://www.mail-archive.com/linux-ide@vger.kernel.org/msg06694.html

The AHCI code falls back to 32bit DMA in that case. Which in turn
causes the problem seen by Srihari. There is not much printk sticking
necessary, the code is simply not handling this. So the main option
right now seems to revert the iommu_merge patch.

Thanks,

	tglx
