From: Keith Owens <kaos@ocs.com.au>
Subject: Re: [PATCH] ata_piix: ignore PCS on ICH5
Date: Wed, 23 Aug 2006 12:04:02 +1000
Message-ID: <28532.1156298642@kao2.melbourne.sgi.com>
References: <20060822120646.GA21866@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:47817 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932276AbWHWCFn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Aug 2006 22:05:43 -0400
In-reply-to: Your message of "Tue, 22 Aug 2006 21:06:46 +0900."
             <20060822120646.GA21866@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, stevenm@umd.edu, linux-ide@vger.kernel.org

Tejun Heo (on Tue, 22 Aug 2006 21:06:46 +0900) wrote:
>There have been a number of reports regarding some ICH5s failing to
>detect devices since the PCS handling update.  Analysis shows that
>these problems are caused by bogus PCS values from those controllers.
>
>Before the PCS update, the driver didn't honor PCS regs exactly and
>probed them in many cases PCS reports no device.  Now that PCS is
>honored exactly, these hardware problems are visible.
>
>This patch makes ICH5 ignore PCS.
>
>Signed-off-by: Tejun Heo <htejun@gmail.com>
>---
>
>Keith Owens, Steve and Andre, please test this patch and report how
>this works for you guys.  If possible, please test with several
>different setups.  Some ICHs (7 and 8) suffer from long boot delays
>due to ghost device if PCS is not honored and we want to make sure
>that ICH5 doesn't have that problem.
>
>ICH7 and 8's choke if the master device is ATAPI and the slave slot is
>empty, so testing this case on ICH5 would be especially helpful.
>e.g. If your ata_piix reports [P0 P1 IDE IDE], connect SATA ATAPI
>device to SATA port 0 and don't connect anything to P1, boot and see
>if things work okay.
>
>This patch is against libata-dev#upstream-fixes and should apply to
>2.6.18-rc4 and the current linus #master.
>
>Thanks.
>
>diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
>index 01b3530..3b98f18 100644
>--- a/drivers/scsi/ata_piix.c
>+++ b/drivers/scsi/ata_piix.c
>@@ -390,7 +390,8 @@ #endif
> 	/* ich5_sata */
> 	{
> 		.sht		= &piix_sht,
>-		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,
>+		.host_flags	= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR |
>+				  PIIX_FLAG_IGNORE_PCS,
> 		.pio_mask	= 0x1f,	/* pio0-4 */
> 		.mwdma_mask	= 0x07, /* mwdma0-2 */
> 		.udma_mask	= 0x7f,	/* udma0-6 */

I have already been running with ich5 locally patched to
PIIX_FLAG_IGNORE_PCS for several days, without any problems.  This
build also has Tejun Heo's patch index 19745a3..ad880b8.

ata_piix reports 'ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]'.  I
disconnected the drive on port 1 but the BIOS complained 'SATA Port 1
hard disk drive not found', so I had to disable P1 in the BIOS.  Linux
then complained, but it still booted.

[   11.494010] scsi1 : ata_piix
[   11.696977] ATA: abnormal status 0x7F on port 0xCCA7

It takes about 4 seconds from loading ata_piix to finishing its
processing, although some of that time is due to debug prints over a
9600 baud serial console.

