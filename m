Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C08C3F2C6
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6FC205ED
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgCCJjp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:47718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbgCCJjp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AFE44B1FF;
        Tue,  3 Mar 2020 09:39:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/40] libata: move ata_dump_id() to dynamic debugging
Date:   Tue,  3 Mar 2020 10:37:43 +0100
Message-Id: <20200303093813.18523-11-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use ata_dev_dbg() to print out the information in ata_dump_id()
and remove the ata_msg_probe() conditional.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 17abc52ce41e..1987886140b6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1440,6 +1440,7 @@ static int ata_hpa_resize(struct ata_device *dev)
 
 /**
  *	ata_dump_id - IDENTIFY DEVICE info debugging output
+ *	@dev: device from which the information is fetched
  *	@id: IDENTIFY DEVICE page to dump
  *
  *	Dump selected 16-bit words from the given IDENTIFY DEVICE
@@ -1449,32 +1450,14 @@ static int ata_hpa_resize(struct ata_device *dev)
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
+static inline void ata_dump_id(struct ata_device *dev, const u16 *id)
+{
+	ata_dev_dbg(dev,
+		"49==0x%04x  53==0x%04x  63==0x%04x  64==0x%04x  75==0x%04x\n"
+		"80==0x%04x  81==0x%04x  82==0x%04x  83==0x%04x  84==0x%04x\n"
+		"88==0x%04x  93==0x%04x\n",
+		id[49], id[53], id[63], id[64], id[75], id[80],
+		id[81], id[82], id[83], id[84], id[88], id[93]);
 }
 
 /**
@@ -2551,8 +2534,7 @@ int ata_dev_configure(struct ata_device *dev)
 	/* find max transfer mode; for printk only */
 	xfer_mask = ata_id_xfermask(id);
 
-	if (ata_msg_probe(ap))
-		ata_dump_id(id);
+	ata_dump_id(dev, id);
 
 	/* SCSI only uses 4-char revisions, dump full 8 chars from ATA */
 	ata_id_c_string(dev->id, fwrevbuf, ATA_ID_FW_REV,
-- 
2.16.4

