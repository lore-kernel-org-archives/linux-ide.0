From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH #upstream-fixes] pata_cmd64x: revert commit d62f5576
Date: Tue, 17 Aug 2010 14:56:43 +0200
Message-ID: <201008171456.43648.bzolnier@gmail.com>
References: <4C6A7CF6.5090706@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61221 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab0HQM5d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2010 08:57:33 -0400
Received: by fxm13 with SMTP id 13so3437368fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 17 Aug 2010 05:57:32 -0700 (PDT)
In-Reply-To: <4C6A7CF6.5090706@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, "\"linux-ide@vger.kernel.org\" st" <linux-ide@vger.kernel.org>, stable <stable@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Milan Kocian <milan.kocian@wq.cz>


On Tuesday 17 August 2010 02:13:42 pm Tejun Heo wrote:
> Commit d62f5576 (pata_cmd64x: fix handling of address setup timings)
> incorrectly called ata_timing_compute() on UDMA mode on 0 @UT leading
> to devide by zero fault.  Revert it until better fix is available.
> This is reported in bko#16607 by Milan Kocian who also root caused it.
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=16607

How's about giving the ATA maintainer some time to resolve the issue
properly?

The revert should be a last resort action (+ the issue was reported
only yesterday) as it introduces another regression (it just replaces
new bug with the old bug while adding noise in the process)..

> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-and-root-caused-by: Milan Kocian <milan.kocian@wq.cz>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Cc: stable@kernel.org
> ---
>  drivers/ata/pata_cmd64x.c |    6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
> index 9f5da1c..905ff76 100644
> --- a/drivers/ata/pata_cmd64x.c
> +++ b/drivers/ata/pata_cmd64x.c
> @@ -121,14 +121,8 @@ static void cmd64x_set_timing(struct ata_port *ap, struct ata_device *adev, u8 m
> 
>  		if (pair) {
>  			struct ata_timing tp;
> -
>  			ata_timing_compute(pair, pair->pio_mode, &tp, T, 0);
>  			ata_timing_merge(&t, &tp, &t, ATA_TIMING_SETUP);
> -			if (pair->dma_mode) {
> -				ata_timing_compute(pair, pair->dma_mode,
> -						&tp, T, 0);
> -				ata_timing_merge(&tp, &t, &t, ATA_TIMING_SETUP);
> -			}
>  		}
>  	}
