Return-Path: <SRS0=rcVg=B3=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A96C433DF
	for <linux-ide@archiver.kernel.org>; Mon, 17 Aug 2020 03:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C7120674
	for <linux-ide@archiver.kernel.org>; Mon, 17 Aug 2020 03:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgHQD3b (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 16 Aug 2020 23:29:31 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:42702 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726235AbgHQD3a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 16 Aug 2020 23:29:30 -0400
Received: from localhost (unknown [159.226.5.99])
        by APP-01 (Coremail) with SMTP id qwCowADHz2+P+TlfauNCAQ--.38977S2;
        Mon, 17 Aug 2020 11:29:19 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     axboe@kernel.dk, linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Xu Wang <vulab@iscas.ac.cn>
Subject: [PATCH] ata: ahci: use ata_link_info() instead of ata_link_printk()
Date:   Mon, 17 Aug 2020 03:29:13 +0000
Message-Id: <20200817032913.10173-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: qwCowADHz2+P+TlfauNCAQ--.38977S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw13Gr1fCr18JFWxuw4rKrg_yoWxCFc_uF
        y8Zw47WrWjyF15Zr17Ja13ZF90k3Wvvw1kXFyIganxury5Ww4fJrW0q3W5X34DXw4IkF98
        ArWUAFy5CrnIgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK
        6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjoKZJ
        UUUUU==
X-Originating-IP: [159.226.5.99]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiAw4LA13qZTb7pwAAs9
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Using ata_link_info() instead of ata_link_printk().

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/ata/ahci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0c0a736eb861..fbd8eaa32d32 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -807,8 +807,7 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
 				(sstatus & 0xf) != 1)
 			break;
 
-		ata_link_printk(link, KERN_INFO, "avn bounce port%d\n",
-				port);
+		ata_link_info(link,  "avn bounce port%d\n", port);
 
 		pci_read_config_word(pdev, 0x92, &val);
 		val &= ~(1 << port);
-- 
2.17.1

