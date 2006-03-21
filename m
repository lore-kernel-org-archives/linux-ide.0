From: Sander <sander@humilis.net>
Subject: Re: Some sata_mv error messages
Date: Tue, 21 Mar 2006 08:26:03 +0100
Message-ID: <20060321072603.GA4089@favonius>
References: <20060318044056.350a2931.akpm@osdl.org> <20060320133318.GB32762@favonius> <441F508E.1030008@pobox.com>
Reply-To: sander@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ookhoi.xs4all.nl ([213.84.114.66]:59882 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932289AbWCUH0F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Mar 2006 02:26:05 -0500
Content-Disposition: inline
In-Reply-To: <441F508E.1030008@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: sander@humilis.net, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, lkml@rtr.ca

Jeff Garzik wrote (ao):
> Sander wrote:
> >While sata_mv in 2.6.16-rc6-mm2 seems stable (yah!) compared to
> >2.6.16-rc6 (no crashes, no data corruption), I still get these messages:
> >
> >[ 3962.139906] ata5: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
> >0xb/47/00
> >[ 3962.139959] ata5: status=0xd0 { Busy }

> >I'm not entirely sure this is only happens on sata_mv (Marvell
> >MV88SX6081) as out of eight disks only one is connected to the onboard
> >sata_nv (nVidia) and the error doesn't happen very often. But I'll keep
> >an eye on it.
> >
> >Are these messages somehow dangerous or otherwise indicating a
> >potentional serious problem? A google search came up with a few links,
> >but none of them helped me understand the messages.
> 
> Without answering your specific question, just remember that sata_mv is 
> considerly "highly experimental" right now, and still needs some 
> workarounds for hardware errata.
> 
> For now, the goal is a system that doesn't crash and doesn't corrupt 
> data. If its occasionally slow or spits out a few errors, but
> otherwise still works, that's pretty darned good :)

I fully agree!

I am aware that sata_mv is early beta, and kernel 2.6.16-rc6-mm2 is
actually the first kernel which lets me really use my Marvell
controller (users should give feedback on that right ;-). Kudos to you
all!  (I don't know what happened between -rc6 and -rc6-mm2).

I know quite some people have their Marvell controller on a shelf
because they could not get it to work reliably. Now they can give it
another try..

Btw, without the hardware errata workarounds implemented yet, will it
eventually corrupt data for a fact? Are there any tests which will
trigger bugs, other than my simple dd-over-raid5?

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
