From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Date: Tue, 21 Mar 2006 16:37:20 -0500
Message-ID: <44207210.9080903@garzik.org>
References: <441F4F95.4070203@garzik.org> <200603210000.36552.lkml@rtr.ca> <20060321121354.GB24977@favonius> <442004E4.7010002@rtr.ca> <20060321153708.GA11703@favonius> <Pine.LNX.4.64.0603211028380.3622@g5.osdl.org> <20060321191547.GC20426@favonius> <Pine.LNX.4.64.0603211132340.3622@g5.osdl.org> <20060321204435.GE25066@favonius> <Pine.LNX.4.64.0603211249270.3622@g5.osdl.org> <44206B81.1030309@garzik.org> <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:178 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932312AbWCUVhZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 16:37:25 -0500
In-Reply-To: <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sander <sander@humilis.net>, Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>, Andrew Morton <akpm@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Linus Torvalds wrote:
> Maybe back-porting any critical sata_mv fixes to 2.6.16.x is appropriate, 
> considering that I don't think RH or SuSE will necessarily want to pull 
> the whole thing.

Agreed -- in theory -- but I'll let Mark Lord or somebody else do that, 
if they are motivated.  sata_mv is labelled "HIGHLY EXPERIMENTAL" for a 
reason :)  Its a known bug report generator, with bugs far outpacing 
fixes at present.

Key patches to backport or test, in priority order, would be:

[libata sata_mv] do not enable PCI MSI by default
[libata sata_mv] add 6042 support, fix 60xx/50xx EDMA configuration
[PATCH] Add missing FUA write to sata_mv dma command list

After that, you're at the mercy of not-yet-worked-around hardware bugs, 
and (as Mark Lord appears to be finding) some driver bugs as well.

sata_mv development slowed to a trickle for a long time, after the 
original developer disappeared, and I didn't have time to dig deep into 
the hardware details.  Mark Lord recently started picking up the pieces, 
so things are looking much better already.  I have another patch from 
Mark to forward to you and 2.6.16.x (stable@), coming to you today.

	Jeff


