From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 1/5] libata: using ata_tag_internal() instead of open-coding
Date: Thu,  3 Jul 2014 20:09:38 +0800
Message-ID: <1404389382-27298-2-git-send-email-haokexin@gmail.com>
References: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:38606 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbaGCMKf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jul 2014 08:10:35 -0400
Received: by mail-pa0-f44.google.com with SMTP id rd3so131022pab.3
        for <linux-ide@vger.kernel.org>; Thu, 03 Jul 2014 05:10:35 -0700 (PDT)
In-Reply-To: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8f3043165048..2895254d8388 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -752,7 +752,7 @@ int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->flags |= tf_flags;
 
-	if (ata_ncq_enabled(dev) && likely(tag != ATA_TAG_INTERNAL)) {
+	if (ata_ncq_enabled(dev) && likely(!ata_tag_internal(tag))) {
 		/* yay, NCQ */
 		if (!lba_48_ok(block, n_block))
 			return -ERANGE;
@@ -4738,7 +4738,7 @@ static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 		tag = (i + ap->last_tag + 1) % ATA_MAX_QUEUE;
 
 		/* the last tag is reserved for internal command. */
-		if (tag == ATA_TAG_INTERNAL)
+		if (ata_tag_internal(tag))
 			continue;
 
 		if (!test_and_set_bit(tag, &ap->qc_allocated)) {
-- 
1.9.3

