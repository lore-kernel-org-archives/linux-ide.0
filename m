From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_nv: SRST sometimes fails after hotplug, use HRST_TO_RESUME
Date: Thu, 28 Sep 2006 17:49:22 +0900
Message-ID: <20060928084922.GL25800@htj.dyndns.org>
References: <20060927082005.GA14569@jim.sh> <20060928051415.GG25800@htj.dyndns.org> <20060928062357.GA12266@jim.sh> <20060928080442.GJ25800@htj.dyndns.org> <20060928083430.GA18596@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:2514 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751795AbWI1Itb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Sep 2006 04:49:31 -0400
Received: by nf-out-0910.google.com with SMTP id o25so676795nfa
        for <linux-ide@vger.kernel.org>; Thu, 28 Sep 2006 01:49:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060928083430.GA18596@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: mail@philipp-wagner.com, linux-ide@vger.kernel.org, jeff@garzik.org, justin@jmicron.com

NV controllers sometimes fail to perform softreset after hotplug.
Make it use hardreset to resume link.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
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
