From: Milan Kocian <milon@wq.cz>
Subject: Re: [PATCH #upstream-fixes] pata_cmd64x: revert commit d62f5576
Date: Thu, 19 Aug 2010 12:30:43 +0200
Message-ID: <20100819103043.GB21017@ntm.vs.lam.cz>
References: <4C6A7CF6.5090706@kernel.org>
 <4C6AFF5F.50403@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srw1.wq.cz ([212.71.155.176]:34238 "EHLO srw1.wq.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187Ab0HSKvv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Aug 2010 06:51:51 -0400
Content-Disposition: inline
In-Reply-To: <4C6AFF5F.50403@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org st" <linux-ide@vger.kernel.org>, stable <stable@kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Milan Kocian <milan.kocian@wq.cz>

On Tue, Aug 17, 2010 at 05:30:07PM -0400, Jeff Garzik wrote:
> On 08/17/2010 08:13 AM, Tejun Heo wrote:
> >Commit d62f5576 (pata_cmd64x: fix handling of address setup timings)
> >incorrectly called ata_timing_compute() on UDMA mode on 0 @UT leading
> >to devide by zero fault.  Revert it until better fix is available.
> >This is reported in bko#16607 by Milan Kocian who also root caused it.
> >
> >   https://bugzilla.kernel.org/show_bug.cgi?id=16607
> >
> >Signed-off-by: Tejun Heo<tj@kernel.org>
> >Reported-and-root-caused-by: Milan Kocian<milan.kocian@wq.cz>
> >Cc: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> >Cc: stable@kernel.org
> >---
> >  drivers/ata/pata_cmd64x.c |    6 ------
> >  1 file changed, 6 deletions(-)
> >
> >diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
> >index 9f5da1c..905ff76 100644
> >--- a/drivers/ata/pata_cmd64x.c
> >+++ b/drivers/ata/pata_cmd64x.c
> >@@ -121,14 +121,8 @@ static void cmd64x_set_timing(struct ata_port *ap, struct ata_device *adev, u8 m
> >
> >  		if (pair) {
> >  			struct ata_timing tp;
> >-
> >  			ata_timing_compute(pair, pair->pio_mode,&tp, T, 0);
> >  			ata_timing_merge(&t,&tp,&t, ATA_TIMING_SETUP);
> >-			if (pair->dma_mode) {
> >-				ata_timing_compute(pair, pair->dma_mode,
> >-						&tp, T, 0);
> >-				ata_timing_merge(&tp,&t,&t, ATA_TIMING_SETUP);
> 
> applied; even if not perfect, this gets us into a better state.
> 
> 

Thank all for solving this. Should I close the bug now ?

regards

-- 
Milan Kocian
