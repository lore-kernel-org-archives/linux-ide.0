From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH linux-2.6.13-rc3] Mod15Write quirk against v2.6.13
Date: Sun, 21 Aug 2005 15:19:44 -0400
Message-ID: <4308D3D0.50504@pobox.com>
References: <1121894035.4885.15.camel@drevil.aslab.com> <20050728141242.GA10010@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:39883 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751128AbVHUV0M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Aug 2005 17:26:12 -0400
Received: from mail.dvmed.net (mail.dvmed.net [216.237.124.58])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7LJN4Zg021905
	for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 12:23:05 -0700
In-Reply-To: <20050728141242.GA10010@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Michael Madore <Michael.Madore@aslab.com>, linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> Also, Jeff, I know you're very busy, but what do you think about
> taking m15w workaround into ata tree?  It's been around for a while
> now and I haven't received any complaints (except for this one) yet.
> The workaround is ugly but it surely helps and I'm willing to maintain
> it.

I think your mod15write solution is too messy to deal with long-term. 
Maintenance burden is much lower on us without it.  It's not too 
difficult to simply avoid certain combinations of hardware.

Note!  As Carlos @ Silicon Image points out, the blacklist should only 
apply to SiI 3112, not 3512/3114/etc.  That's an open FIXME that would 
benefit users.


>  One thing that bothers me is how Albert's commit and the original
> ata_host_intr tell IRQ subsystem that an interrupt isn't ours when we
> know that we have generated a spurious interrupt.  IMHO, we always
> should enter ata_host_intr and always tell IRQ subsystem that it's our
> interrupt if bmdma_status tells us so, regardless of ata status value.
> The current code is likely to cause "nobody cared" error which can be
> avoided.

If there is a mismatch between BMDMA's IRQ bit and ATA device indicating 
an interrupt, that's a host state machine[1] violation that should be 
addressed elsewhere.

I wouldn't mind using BMDMA IRQ bit as an indicator of the ATA intrq 
status, though.

(for others) As linked on

	http://www.t13.org/project/d1510r1-Host-Adapter.pdf
		via
	http://linux.yyz.us/sata/devel.html

you can find documentation on the BMDMA IRQ bit.

The main problem with using BMDMA IRQ bit is that it is likely never set 
unless the commands are READ/WRITE DMA commands, which means we must 
have separate host state machine tracking for PIO and non-data commands, 
increasing complexity.

	Jeff



[1] "host state machine"  These are illustrated by the state machine 
diagrams in ATA/ATAPI-7 Volume 3, under the chapter headings "Bus idle 
protocol", "Non-data command protocol", "DMA command protocol", "Ultra 
DMA data-{in,out} command protocol".  STUDY THESE.
