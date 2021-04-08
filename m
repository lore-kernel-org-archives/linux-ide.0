Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDD0C433B4
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 01:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E66461181
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 01:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhDHBzT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 21:55:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15168 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhDHBzT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Apr 2021 21:55:19 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FG45J6QZnzpWBP;
        Thu,  8 Apr 2021 09:52:20 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 09:54:58 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        linux-ide <linux-ide@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] ide: remove unused local variable 'sitre'
Date:   Thu, 8 Apr 2021 09:54:51 +0800
Message-ID: <20210408015451.2983-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning:

drivers/ide/piix.c: In function ‘piix_set_dma_mode’:
drivers/ide/piix.c:146:8: warning: variable ‘sitre’ set but not used [-Wunused-but-set-variable]

Fixes: 2bfba3c444fe ("ide: remove useless subdirs from drivers/ide/")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/ide/piix.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ide/piix.c b/drivers/ide/piix.c
index a671cead6ae72b7..b512d2dc9108cf6 100644
--- a/drivers/ide/piix.c
+++ b/drivers/ide/piix.c
@@ -143,13 +143,11 @@ static void piix_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 	int v_flag		= 0x01 << drive->dn;
 	int w_flag		= 0x10 << drive->dn;
 	int u_speed		= 0;
-	int			sitre;
 	u16			reg4042, reg4a;
 	u8			reg48, reg54, reg55;
 	const u8 speed		= drive->dma_mode;
 
 	pci_read_config_word(dev, maslave, &reg4042);
-	sitre = (reg4042 & 0x4000) ? 1 : 0;
 	pci_read_config_byte(dev, 0x48, &reg48);
 	pci_read_config_word(dev, 0x4a, &reg4a);
 	pci_read_config_byte(dev, 0x54, &reg54);
-- 
1.8.3


