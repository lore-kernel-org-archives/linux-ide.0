From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: do not ignore PIO-only devices
Date: Wed, 22 Mar 2006 20:48:18 +0900
Message-ID: <20060322114818.GA23515@htj.dyndns.org>
References: <4420B439.6000608@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:20658 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750781AbWCVLsY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Mar 2006 06:48:24 -0500
Received: by zproxy.gmail.com with SMTP id o37so151453nzf
        for <linux-ide@vger.kernel.org>; Wed, 22 Mar 2006 03:48:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4420B439.6000608@comcast.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ed Sweetman <safemode@comcast.net>, jgarzik@pobox.com
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

As libata now can do PIO, don't ignore PIO-only devices.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

I'm currently away from my machines due to idiotic/useless national
reserve military training :-(, so I only compile tested it.  Ed, can
you please try the following patch and report the result?  Jeff,
please don't apply until Ed confirms.

 libata-core.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 714b42b..c4e528c 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1219,13 +1219,6 @@ static int ata_dev_configure(struct ata_
 	 * common ATA, ATAPI feature tests
 	 */
 
-	/* we require DMA support (bits 8 of word 49) */
-	if (!ata_id_has_dma(id)) {
-		printk(KERN_DEBUG "ata%u: no dma\n", ap->id);
-		rc = -EINVAL;
-		goto err_out_nosup;
-	}
-
 	/* find max transfer mode; for printk only */
 	xfer_mask = ata_id_xfermask(id);
 
