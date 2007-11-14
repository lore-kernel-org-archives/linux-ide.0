From: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.24-rc & SB600 AHCI no go on >=4GB of RAM
Date: Wed, 14 Nov 2007 13:17:35 +0100
Message-ID: <200711141317.35746.ak@suse.de>
References: <198606.73895.qm@web52608.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:33614 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbXKNMVb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Nov 2007 07:21:31 -0500
In-Reply-To: <198606.73895.qm@web52608.mail.re2.yahoo.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Wednesday 14 November 2007 12:55, Srihari Vijayaraghavan wrote:
> [Sorry to reply to my own email thread]
>
> Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au> wrote:
> ...
>
> > No problems. Here's the log of unworking kernel with IOMMU turned on.
> > Basically it goes on reseting the SATA ports throwing many errors (none
> > are present in 2.6.23 or on 2.6.24-rc with mem=3500M) for many minutes at
> > which point I do a power reset :-(.
> >
> > Also the log of the working kernel with IOMMU but with mem=3500M is also
> > attached for the record. It's basically the same above kernel just with
> > the added parameter.
>
> Gentlemen,
>
> This changeset has introduced a regression in 2.6.24-rc, such that my
> machine boots no more:

Hmm, you got an AHCI controller that does not do 64bit DMA masks?
Or do you have CONFIG_IOMMU_DEBUG enabled? 

Anyways, not being able to deal with merged SG lists must be some
driver or hardware bug. I would stick some printks into gart_map_sg()
and try to find out where the failing DMA is initiatiated and then
split it into multiple IO submissions at the caller level.

-Andi
