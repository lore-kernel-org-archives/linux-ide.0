Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB73C4332D
	for <linux-ide@archiver.kernel.org>; Wed,  3 Mar 2021 22:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F0561494
	for <linux-ide@archiver.kernel.org>; Wed,  3 Mar 2021 22:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390009AbhCCV6O (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 3 Mar 2021 16:58:14 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:23646 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1582095AbhCCHfN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 3 Mar 2021 02:35:13 -0500
Received: from localhost.localdomain (unknown [222.205.72.8])
        by mail-app4 (Coremail) with SMTP id cS_KCgD38WDwOz9gkrD4AQ--.3768S4;
        Wed, 03 Mar 2021 15:34:12 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] sata_dwc_460ex: Fix missing check in sata_dwc_isr
Date:   Wed,  3 Mar 2021 15:34:08 +0800
Message-Id: <20210303073408.461-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgD38WDwOz9gkrD4AQ--.3768S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4xGry7Xw4fKrW3KFWxWFg_yoW8GrWfpr
        s3ZFyj9rZ3GFWUWrnrZw1kury5C3ykKFWrtFnxAa4IvryYq3s3WFW5K34aqrn8tFWkJ3W2
        vas8JFZ09F4jyr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48J
        MxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
        fUYMKZDUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgENBlZdtSlmQQAAs4
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The return value of ata_qc_from_tag() is checked in the whole
kernel except for two calls in sata_dwc_isr(), which may lead
to null-pointer-dereference. Add return value checks to avoid
such case.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: - Refine commit message.
      Add return value check for another ata_qc_from_tag() call.
---
 drivers/ata/sata_dwc_460ex.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 9dcef6ac643b..f0ef844428bb 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -543,6 +543,11 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 		hsdev->sactive_issued |= qcmd_tag_to_mask(tag);
 
 		qc = ata_qc_from_tag(ap, tag);
+		if (unlikely(!qc)) {
+			dev_err(ap->dev, "failed to get qc");
+			handled = 1;
+			goto DONE;
+		}
 		/*
 		 * Start FP DMA for NCQ command.  At this point the tag is the
 		 * active tag.  It is the tag that matches the command about to
@@ -658,6 +663,11 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 
 		tag_mask &= (~0x00000001);
 		qc = ata_qc_from_tag(ap, tag);
+		if (unlikely(!qc)) {
+			dev_err(ap->dev, "failed to get qc");
+			handled = 1;
+			goto DONE;
+		}
 
 		/* To be picked up by completion functions */
 		qc->ap->link.active_tag = tag;
-- 
2.17.1

