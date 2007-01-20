From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_promise: kill qc->nsect
Date: Sat, 20 Jan 2007 13:12:46 +0900
Message-ID: <20070120041246.GT10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [221.139.199.108] ([221.139.199.108]:45319 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S965133AbXATEMt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Jan 2007 23:12:49 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Merge order left qc->nsect usage in sata_promise dangling.  Kill it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 551644a..32ae03e 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -502,8 +502,6 @@ static void pdc_atapi_pkt(struct ata_queued_cmd *qc)
 		feature = PDC_FEATURE_ATAPI_PIO;
 		/* set byte counter register to real transfer byte count */
 		nbytes = qc->nbytes;
-		if (!nbytes)
-			nbytes = qc->nsect << 9;
 		if (nbytes > 0xffff)
 			nbytes = 0xffff;
 	} else {
