Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C55C3F68F
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF372087E
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBDQ4J (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:34820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbgBDQ4J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F335CB116;
        Tue,  4 Feb 2020 16:56:04 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/46] libata: move ata_dump_id() to dynamic debugging
Date:   Tue,  4 Feb 2020 17:55:10 +0100
Message-Id: <20200204165547.115220-10-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204165547.115220-1-hare@suse.de>
References: <20200204165547.115220-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use ata_port_dbg() to print out the information in ata_dump_id()
and remove the ata_msg_probe() conditional.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b2b96420a2f2..8a18047f9bcb 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1449,32 +1449,14 @@ static int ata_hpa_resize(struct ata_device *dev)
  *	caller.
  */
 
-static inline void ata_dump_id(const u16 *id)
-{
-	DPRINTK("49==0x%04x  "
-		"53==0x%04x  "
-		"63==0x%04x  "
-		"64==0x%04x  "
-		"75==0x%04x  \n",
-		id[49],
-		id[53],
-		id[63],
-		id[64],
-		id[75]);
-	DPRINTK("80==0x%04x  "
-		"81==0x%04x  "
-		"82==0x%04x  "
-		"83==0x%04x  "
-		"84==0x%04x  \n",
-		id[80],
-		id[81],
-		id[82],
-		id[83],
-		id[84]);
-	DPRINTK("88==0x%04x  "
-		"93==0x%04x\n",
-		id[88],
-		id[93]);
+static inline void ata_dump_id(struct ata_port *ap, const u16 *id)
+{
+	ata_port_dbg(ap,
+		"49==0x%04x  53==0x%04x  63==0x%04x  64==0x%04x  75==0x%04x\n"
+		"80==0x%04x  81==0x%04x  82==0x%04x  83==0x%04x  84==0x%04x\n"
+		"88==0x%04x  93==0x%04x\n",
+		id[49], id[53], id[63], id[64], id[75], id[80],
+		id[81], id[82], id[83], id[84], id[88], id[93]);
 }
 
 /**
@@ -2552,8 +2534,7 @@ int ata_dev_configure(struct ata_device *dev)
 	/* find max transfer mode; for printk only */
 	xfer_mask = ata_id_xfermask(id);
 
-	if (ata_msg_probe(ap))
-		ata_dump_id(id);
+	ata_dump_id(ap, id);
 
 	/* SCSI only uses 4-char revisions, dump full 8 chars from ATA */
 	ata_id_c_string(dev->id, fwrevbuf, ATA_ID_FW_REV,
-- 
2.16.4

