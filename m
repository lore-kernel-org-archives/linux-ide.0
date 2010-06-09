From: Dan Carpenter <error27@gmail.com>
Subject: [patch] sata_sil24: memset() overflow
Date: Wed, 9 Jun 2010 14:01:54 +0200
Message-ID: <20100609120153.GF5483@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61376 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754848Ab0FIMCQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2010 08:02:16 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, Robert Hancock <hancockrwd@gmail.com>, Vivek Mahajan <vivek.mahajan@freescale.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

cb->atapi.cdb is an array of 16 u8 elements.  The call too memset() 
would set the first part of the sge array to zero as well.  It's not
a packed struct. 

This one has been around for five years.  I found it with Smatch.  I
think the reason no one has seen it before is because we normally call
sil24_fill_sg() and that overwrites sge with proper information?

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
I don't have this hardware myself so I can't test it.  Sorry. :(

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index e925051..9e459eb 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -865,7 +865,7 @@ static void sil24_qc_prep(struct ata_queued_cmd *qc)
 	} else {
 		prb = &cb->atapi.prb;
 		sge = cb->atapi.sge;
-		memset(cb->atapi.cdb, 0, 32);
+		memset(cb->atapi.cdb, 0, sizeof(cb->atapi.cdb));
 		memcpy(cb->atapi.cdb, qc->cdb, qc->dev->cdb_len);
 
 		if (ata_is_data(qc->tf.protocol)) {
