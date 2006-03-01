From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_sil: remove unneeded ATA_FLAG_SRST from 3512 port info
Date: Wed, 1 Mar 2006 19:07:27 +0900
Message-ID: <20060301100727.GA23124@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.182]:57567 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932163AbWCAKHe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 05:07:34 -0500
Received: by pproxy.gmail.com with SMTP id o67so41373pye
        for <linux-ide@vger.kernel.org>; Wed, 01 Mar 2006 02:07:32 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Now unneeded ATA_FLAG_SRST sneaked into sil_3512 port info while
merging upstream-fixes.  Kill it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 91ecf52..cdf800e 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -202,7 +202,7 @@ static const struct ata_port_info sil_po
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
+				  ATA_FLAG_MMIO |
 				  SIL_FLAG_RERR_ON_DMA_ACT,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
