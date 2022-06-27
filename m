Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05AAC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 27 Jun 2022 13:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbiF0NSf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 27 Jun 2022 09:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiF0NS2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jun 2022 09:18:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5E7C6F;
        Mon, 27 Jun 2022 06:18:24 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LWp8t22bkz6H8NV;
        Mon, 27 Jun 2022 21:14:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 15:18:22 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 14:18:19 +0100
From:   John Garry <john.garry@huawei.com>
To:     <s.shtylyov@omp.ru>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] ata: pata_cs5535: Fix W=1 warnings
Date:   Mon, 27 Jun 2022 21:12:20 +0800
Message-ID: <1656335540-50293-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

x86_64 allmodconfig build with W=1 gives these warnings:

drivers/ata/pata_cs5535.c: In function ‘cs5535_set_piomode’:
drivers/ata/pata_cs5535.c:93:11: error: variable ‘dummy’ set but not used [-Werror=unused-but-set-variable]
  u32 reg, dummy;
           ^~~~~
drivers/ata/pata_cs5535.c: In function ‘cs5535_set_dmamode’:
drivers/ata/pata_cs5535.c:132:11: error: variable ‘dummy’ set but not used [-Werror=unused-but-set-variable]
  u32 reg, dummy;
           ^~~~~
cc1: all warnings being treated as errors

Mark variables 'dummy' as "maybe unused" to satisfy when rdmsr() is
stubbed, which is the same as what we already do in pata_cs5536.c .

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index 6725931f3c35..c2c3238ff84b 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -90,7 +90,7 @@ static void cs5535_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	static const u16 pio_cmd_timings[5] = {
 		0xF7F4, 0x53F3, 0x13F1, 0x5131, 0x1131
 	};
-	u32 reg, dummy;
+	u32 reg, __maybe_unused dummy;
 	struct ata_device *pair = ata_dev_pair(adev);
 
 	int mode = adev->pio_mode - XFER_PIO_0;
@@ -129,7 +129,7 @@ static void cs5535_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 	static const u32 mwdma_timings[3] = {
 		0x7F0FFFF3, 0x7F035352, 0x7F024241
 	};
-	u32 reg, dummy;
+	u32 reg, __maybe_unused dummy;
 	int mode = adev->dma_mode;
 
 	rdmsr(ATAC_CH0D0_DMA + 2 * adev->devno, reg, dummy);
-- 
2.35.3

