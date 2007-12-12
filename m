From: Will Trives <will@trivescon.com.au>
Subject: Re: [PATCH #upstream-fixes] libata: update
	atapi_eh_request_sense() such that lbam/lbah contains buffer size
Date: Wed, 12 Dec 2007 19:05:39 +1100
Message-ID: <1197446739.3467.4.camel@Athas>
References: <475F51AE.1010305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out8.tpgi.com.au ([220.244.226.118]:57386 "EHLO
	mail8.tpgi.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757641AbXLLIe6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Dec 2007 03:34:58 -0500
In-Reply-To: <475F51AE.1010305@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, yannick.dirou@axetic.com, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello guys,

Yannick does it work ok for you when you try to blank a dvd+rw disc ?
Mine no longer jams up the drive now but it does say that the media or
drive does not support blanking. I'm thinking its either because these
discs just do multisession so this is what was meant to happen all along
or there's still something going on. 


wodim -blank=fast dev=/dev/sr0
wodim: Operation not permitted. Warning: Cannot raise RLIMIT_MEMLOCK
limits.Device type    : Removable CD-ROM
Version        : 5
Response Format: 2
Capabilities   :
Vendor_info    : 'BENQ    '
Identification : 'DVD DD DW1640   '
Revision       : 'BSRB'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Using generic SCSI-3/mmc DVD-R(W) driver (mmc_mdvd).
Driver flags   : SWABAUDIO BURNFREE
Supported modes: PACKET SAO
HINT: use dvd+rw-mediainfo from dvd+rw-tools for information extraction.
Speed set to 5540 KB/s
Starting to write CD/DVD at speed   4.0 in real BLANK mode for single
session.
Last chance to quit, starting real write i   0 seconds. Operation
starts.
Error: this media does not support blanking, ignoring.
This drive or media does not support the 'BLANK media' command
wodim: Cannot blank disk, aborting.
wodim: Some drives do not support all blank types.
wodim: Try again with wodim blank=all.


Regards,

Will Trives

On Wed, 2007-12-12 at 12:12 +0900, Tejun Heo wrote:
> While updating lbam/h for ATAPI commands, atapi_eh_request_sense() was
> left out.  Update it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This patch is from improve-ATAPI-data-xfer patchset pending for
> #upstream.
> 
>  drivers/ata/libata-eh.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: work/drivers/ata/libata-eh.c
> ===================================================================
> --- work.orig/drivers/ata/libata-eh.c
> +++ work/drivers/ata/libata-eh.c
> @@ -1264,8 +1264,8 @@ static unsigned int atapi_eh_request_sen
>  		tf.feature |= ATAPI_PKT_DMA;
>  	} else {
>  		tf.protocol = ATA_PROT_ATAPI;
> -		tf.lbam = (8 * 1024) & 0xff;
> -		tf.lbah = (8 * 1024) >> 8;
> +		tf.lbam = SCSI_SENSE_BUFFERSIZE;
> +		tf.lbah = 0;
>  	}
>  
>  	return ata_exec_internal(dev, &tf, cdb, DMA_FROM_DEVICE,

