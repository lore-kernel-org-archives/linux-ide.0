Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4A1C433DB
	for <linux-ide@archiver.kernel.org>; Wed, 23 Dec 2020 10:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49755207F7
	for <linux-ide@archiver.kernel.org>; Wed, 23 Dec 2020 10:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgLWKtu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Dec 2020 05:49:50 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:26528 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbgLWKtu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 23 Dec 2020 05:49:50 -0500
Received: from localhost.localdomain (unknown [10.192.85.18])
        by mail-app3 (Coremail) with SMTP id cC_KCgCHj6eIIONfGi8AAA--.223S4;
        Wed, 23 Dec 2020 18:48:44 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ide: pci: Fix memleak in ide_pci_init_two
Date:   Wed, 23 Dec 2020 18:48:42 +0800
Message-Id: <20201223104843.28251-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgCHj6eIIONfGi8AAA--.223S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyUCry5tF48GF1fGFWkCrg_yoWkArcEk3
        95Zrs8X3y8uFyUGr47Cr4fZryFkFZ0qr48uwsFkrsxAasxZ3yDCrn7AF43CF4UWw4UZFy8
        Ar4DWr4rAryjyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgkDBlZdtRp0WwAPsK
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When do_ide_setup_pci_device() fails, host allocated
by ide_host_alloc() may not have been freed, which
leads to memleak.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: - Refine the error handling on failure of
      ide_host_register().
---
 drivers/ide/setup-pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
index fdc8e813170c..14b8a514b51a 100644
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -586,7 +586,7 @@ int ide_pci_init_two(struct pci_dev *dev1, struct pci_dev *dev2,
 		 * do_ide_setup_pci_device() on the first device!
 		 */
 		if (ret < 0)
-			goto out_free_bars;
+			goto out_free_host;
 
 		/* fixup IRQ */
 		if (ide_pci_is_in_compatibility_mode(pdev[i])) {
@@ -598,10 +598,12 @@ int ide_pci_init_two(struct pci_dev *dev1, struct pci_dev *dev2,
 
 	ret = ide_host_register(host, d, hws);
 	if (ret)
-		ide_host_free(host);
-	else
-		goto out;
+		goto out_free_host;
+
+	return 0;
 
+out_free_host:
+	ide_host_free(host);
 out_free_bars:
 	i = n_ports / 2;
 	while (i--)
-- 
2.17.1

