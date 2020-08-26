Return-Path: <SRS0=cafq=CE=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A39BC433E1
	for <linux-ide@archiver.kernel.org>; Wed, 26 Aug 2020 09:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E210F206FA
	for <linux-ide@archiver.kernel.org>; Wed, 26 Aug 2020 09:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgHZJRq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:17:46 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:36032 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727793AbgHZJRp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 26 Aug 2020 05:17:45 -0400
Received: from localhost.localdomain (unknown [210.32.144.184])
        by mail-app3 (Coremail) with SMTP id cC_KCgCXP6iuKEZfbc49Aw--.38158S4;
        Wed, 26 Aug 2020 17:17:40 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ide: pci: Fix memleak in ide_pci_init_two
Date:   Wed, 26 Aug 2020 17:17:33 +0800
Message-Id: <20200826091733.924-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgCXP6iuKEZfbc49Aw--.38158S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKF4kKr1fuFy7tryfXFW3trb_yoW3CwbEk3
        9rursrWrWj9FyUJr12kr4xZry09a90vr1kWr42kr1xZa9xZa4kursxZF17CF48Wr17Cry2
        yF4DJr4rA342kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbI8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
        JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48J
        MxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        fUOOzVUUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0EBlZdtPrBDAADsG
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When do_ide_setup_pci_device() fails, host should be
freed just like when ide_host_register() fails.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/ide/setup-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
index fdc8e813170c..e6cba7e24c39 100644
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -585,8 +585,10 @@ int ide_pci_init_two(struct pci_dev *dev1, struct pci_dev *dev2,
 		 * FIXME: Mom, mom, they stole me the helper function to undo
 		 * do_ide_setup_pci_device() on the first device!
 		 */
-		if (ret < 0)
+		if (ret < 0) {
+			ide_host_free(host);
 			goto out_free_bars;
+		}
 
 		/* fixup IRQ */
 		if (ide_pci_is_in_compatibility_mode(pdev[i])) {
-- 
2.17.1

