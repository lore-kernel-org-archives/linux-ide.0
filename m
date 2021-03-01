Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E835C433E9
	for <linux-ide@archiver.kernel.org>; Mon,  1 Mar 2021 07:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B4264D8F
	for <linux-ide@archiver.kernel.org>; Mon,  1 Mar 2021 07:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhCAHjc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Mar 2021 02:39:32 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:23376 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232539AbhCAHj3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 1 Mar 2021 02:39:29 -0500
Received: from localhost.localdomain (unknown [10.192.85.18])
        by mail-app4 (Coremail) with SMTP id cS_KCgAnoWCrlzxgsYPkAQ--.52399S4;
        Mon, 01 Mar 2021 15:28:46 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sata_dwc_460ex: Fix missing check in sata_dwc_isr
Date:   Mon,  1 Mar 2021 15:28:42 +0800
Message-Id: <20210301072842.7410-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgAnoWCrlzxgsYPkAQ--.52399S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XF4DXFykGw1UXw45Gw4xtFb_yoWfXrb_Ga
        1xZFn7Wry8Kr1rGr17Ww1rZryIkw48urs3Za4xt3W3X343WF4FqrWDXwn8JwnxWa1FyFnI
        v3y7C345Cr97GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2kFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
        6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0LBlZdtSi7-wACsS
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ata_qc_from_tag() may return a null pointer and further lead to
null-pointer-dereference. Add a return value check to avoid such case.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/ata/sata_dwc_460ex.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 9dcef6ac643b..0068247ffc06 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -548,8 +548,10 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 		 * active tag.  It is the tag that matches the command about to
 		 * be completed.
 		 */
-		qc->ap->link.active_tag = tag;
-		sata_dwc_bmdma_start_by_tag(qc, tag);
+		if (qc) {
+			qc->ap->link.active_tag = tag;
+			sata_dwc_bmdma_start_by_tag(qc, tag);
+		}
 
 		handled = 1;
 		goto DONE;
-- 
2.17.1

