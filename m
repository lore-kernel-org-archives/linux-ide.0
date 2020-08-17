Return-Path: <SRS0=rcVg=B3=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BD4C433DF
	for <linux-ide@archiver.kernel.org>; Mon, 17 Aug 2020 01:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C6B2075D
	for <linux-ide@archiver.kernel.org>; Mon, 17 Aug 2020 01:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgHQBbV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 16 Aug 2020 21:31:21 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:50142 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726221AbgHQBbV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 16 Aug 2020 21:31:21 -0400
Received: from localhost (unknown [159.226.5.99])
        by APP-01 (Coremail) with SMTP id qwCowABH50QO2zlfcVw9AQ--.9269S2;
        Mon, 17 Aug 2020 09:19:10 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     axboe@kernel.dk, linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Xu Wang <vulab@iscas.ac.cn>
Subject: [PATCH] ata: ahci: use ata_link_info() instead of ata_link_printk()
Date:   Mon, 17 Aug 2020 01:18:54 +0000
Message-Id: <20200817011854.9668-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: qwCowABH50QO2zlfcVw9AQ--.9269S2
X-Coremail-Antispam: 1UD129KBjvdXoWrWF15tF1kZFW5ZrWkGrW7urg_yoWxWrb_uF
        y8Aw47Wr1FyF98Zr17Ja13ZF9Yy3Wvvr1kXFyIganxur1Uuw4fJrW0q3W5X34qqw4IkF98
        t3yUJFy5Crn8XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
        WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6w4l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbb_-PUUUUU==
X-Originating-IP: [159.226.5.99]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiAwsLA13qZTas9gAAs+
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Using ata_link_info() instead of ata_link_printk().

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/ata/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0c0a736eb861..9d72d907b4ee 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -807,7 +807,7 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
 				(sstatus & 0xf) != 1)
 			break;
 
-		ata_link_printk(link, KERN_INFO, "avn bounce port%d\n",
+		ata_link_info(link,  "avn bounce port%d\n",
 				port);
 
 		pci_read_config_word(pdev, 0x92, &val);
-- 
2.17.1

