Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B584C43217
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbhLHQjD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:39:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37902 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbhLHQgp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 003A31FE25;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFFp3ytnKCErQSn43Ao0avNqrclZ93vUHiq4WdMeQVE=;
        b=Q59rOgQtsAu16ltwQ9uFKmTn5/kBBIU5/HuzEIQCL+UrJoWGpqp92L0Dw9ByzWXZb/oYeb
        XhATOOSG0DepH5+YmDG1em4NXWtg538JZ3XK0JlNc9d5CiVGOVc9EgyIMy6DihjS8NDfx5
        FBzg3ibcx4lM4jzWHWwvrnp3nkyda5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFFp3ytnKCErQSn43Ao0avNqrclZ93vUHiq4WdMeQVE=;
        b=EirFtsqIcOBkL5cHo4N5Pt195afZNP5qByHKTn6CaJubxzA8O0F8XUF3zlvNgorORdNWw6
        T6LEECuSS5PljkAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id F1AFFA3BC4;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id EE62B5191FBD; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 48/73] libata: drop ata_msg_warn()
Date:   Wed,  8 Dec 2021 17:32:30 +0100
Message-Id: <20211208163255.114660-49-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The WARN level was always enabled, so drop ata_msg_warn().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 19 ++++++++-----------
 include/linux/libata.h    |  2 --
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 00d3bb8c87af..363714fcb950 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1617,9 +1617,8 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 			else
 				ata_qc_complete(qc);
 
-			if (ata_msg_warn(ap))
-				ata_dev_warn(dev, "qc timeout (cmd 0x%x)\n",
-					     command);
+			ata_dev_warn(dev, "qc timeout (cmd 0x%x)\n",
+				     command);
 		}
 
 		spin_unlock_irqrestore(ap->lock, flags);
@@ -1978,9 +1977,8 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	return 0;
 
  err_out:
-	if (ata_msg_warn(ap))
-		ata_dev_warn(dev, "failed to IDENTIFY (%s, err_mask=0x%x)\n",
-			     reason, err_mask);
+	ata_dev_warn(dev, "failed to IDENTIFY (%s, err_mask=0x%x)\n",
+		     reason, err_mask);
 	return rc;
 }
 
@@ -2724,8 +2722,7 @@ int ata_dev_configure(struct ata_device *dev)
 
 		rc = atapi_cdb_len(id);
 		if ((rc < 12) || (rc > ATAPI_CDB_LEN)) {
-			if (ata_msg_warn(ap))
-				ata_dev_warn(dev, "unsupported CDB len\n");
+			ata_dev_warn(dev, "unsupported CDB len %d\n", rc);
 			rc = -EINVAL;
 			goto err_out_nosup;
 		}
@@ -5381,11 +5378,11 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 
 #if defined(ATA_VERBOSE_DEBUG)
 	/* turn on all debugging levels */
-	ap->msg_enable = 0x000F;
+	ap->msg_enable = 0x0007;
 #elif defined(ATA_DEBUG)
-	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_WARN;
+	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO;
 #else
-	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_WARN;
+	ap->msg_enable = ATA_MSG_DRV;
 #endif
 
 	mutex_init(&ap->scsi_scan_mutex);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8bde38e3debd..5a4a23d38c08 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -75,13 +75,11 @@ enum {
 	ATA_MSG_DRV	= 0x0001,
 	ATA_MSG_INFO	= 0x0002,
 	ATA_MSG_PROBE	= 0x0004,
-	ATA_MSG_WARN	= 0x0008,
 };
 
 #define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
 #define ata_msg_info(p)   ((p)->msg_enable & ATA_MSG_INFO)
 #define ata_msg_probe(p)  ((p)->msg_enable & ATA_MSG_PROBE)
-#define ata_msg_warn(p)   ((p)->msg_enable & ATA_MSG_WARN)
 
 static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
 {
-- 
2.29.2

