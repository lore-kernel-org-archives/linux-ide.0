From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: lengthen interval between SRST set and clear
Date: Thu, 28 Sep 2006 17:04:42 +0900
Message-ID: <20060928080442.GJ25800@htj.dyndns.org>
References: <20060927082005.GA14569@jim.sh> <20060928051415.GG25800@htj.dyndns.org> <20060928062357.GA12266@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:31085 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751760AbWI1IEs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Sep 2006 04:04:48 -0400
Received: by py-out-1112.google.com with SMTP id n25so646082pyg
        for <linux-ide@vger.kernel.org>; Thu, 28 Sep 2006 01:04:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060928062357.GA12266@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: mail@philipp-wagner.com, linux-ide@vger.kernel.org, jeff@garzik.org, justin@jmicron.com

On Thu, Sep 28, 2006 at 02:23:57AM -0400, Jim Paris wrote:
> Hi Tejun,
> 
> > 20us isn't enough for some SATA controllers (sata_nv) ending up not
> > sending the second FIS27 to clear SRST.  This usually results in SRST
> > timeout causing excessive delays during hotplug.
> >
> > This patch lengthens the delay from 20us to 1ms and also converts it
> > to msleep() instead of busy wait.
> 
> Thanks for the patch.  Unfortunately it doesn't seem to help on 2.6.18:

I see.

Justing, the solution doesn't seem to work.  Have you guys verified
that the controller doesn't send the second H2D regsiter FIS clearing
SRST w/ 20us delay?  If you guys did, the patch needs to make into
tree whether it helps this particular case or not.  If not, I think
it's best to leave it alone.

Jim, can you please test the following patch?  It only adds
ATA_FLAG_HRST_TO_RESUME.

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 8cd730f..647e7b8 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -257,7 +257,8 @@ static struct ata_port_info nv_port_info
 	/* generic */
 	{
 		.sht		= &nv_sht,
-		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_HRST_TO_RESUME,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
@@ -266,7 +267,8 @@ static struct ata_port_info nv_port_info
 	/* nforce2/3 */
 	{
 		.sht		= &nv_sht,
-		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_HRST_TO_RESUME,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
@@ -275,7 +277,8 @@ static struct ata_port_info nv_port_info
 	/* ck804 */
 	{
 		.sht		= &nv_sht,
-		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_HRST_TO_RESUME,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
