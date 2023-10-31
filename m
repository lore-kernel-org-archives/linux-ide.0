Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A51C4332F
	for <linux-ide@archiver.kernel.org>; Tue, 31 Oct 2023 04:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjJaEG6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 31 Oct 2023 00:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJaEG5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2023 00:06:57 -0400
X-Greylist: delayed 373 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Oct 2023 21:06:54 PDT
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB49B4
        for <linux-ide@vger.kernel.org>; Mon, 30 Oct 2023 21:06:54 -0700 (PDT)
Received: from localhost (unknown [124.16.138.129])
        by APP-01 (Coremail) with SMTP id qwCowAAHDx8ke0BldmfOAQ--.28967S2;
        Tue, 31 Oct 2023 11:57:24 +0800 (CST)
From:   Chen Ni <nichen@iscas.ac.cn>
To:     s.shtylyov@omp.ru, dlemoal@kernel.org, jeff@garzik.org,
        htejun@gmail.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] pata_isapnp: Add check for devm_ioport_map
Date:   Tue, 31 Oct 2023 04:00:07 +0000
Message-Id: <20231031040007.2498659-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAHDx8ke0BldmfOAQ--.28967S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4xWw1UKrW5XF1rZF15twb_yoWfJFX_Aa
        yUZF4fW3yvyry5Gw13XF1fZFySgws5ursxXrZYgF93Jry5Zw47WFWYvwnxZayDZ3WrWFn8
        AF1Ut3s8uF15JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUUEfO7UUUUU==
X-Originating-IP: [124.16.138.129]
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add check for devm_ioport_map() and return the error if it fails in
order to guarantee the success of devm_ioport_map().

Fixes: 0d5ff566779f ("libata: convert to iomap")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/ata/pata_isapnp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 25a63d043c8e..0f77e0424066 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -82,6 +82,9 @@ static int isapnp_init_one(struct pnp_dev *idev, const struct pnp_device_id *dev
 	if (pnp_port_valid(idev, 1)) {
 		ctl_addr = devm_ioport_map(&idev->dev,
 					   pnp_port_start(idev, 1), 1);
+		if (!ctl_addr)
+			return -ENOMEM;
+
 		ap->ioaddr.altstatus_addr = ctl_addr;
 		ap->ioaddr.ctl_addr = ctl_addr;
 		ap->ops = &isapnp_port_ops;
-- 
2.25.1

