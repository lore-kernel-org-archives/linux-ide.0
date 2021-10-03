Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D8BC433F5
	for <linux-ide@archiver.kernel.org>; Sun,  3 Oct 2021 11:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C51461AFB
	for <linux-ide@archiver.kernel.org>; Sun,  3 Oct 2021 11:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhJCLbI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 3 Oct 2021 07:31:08 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:35883 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhJCLbH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 3 Oct 2021 07:31:07 -0400
Received: from localhost ([217.85.124.89]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mi2aH-1n1MPk262D-00e4IK; Sun, 03 Oct 2021 13:28:45 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 1/6] libata: fix checking of DMA state
Date:   Sun,  3 Oct 2021 15:28:46 +0200
Message-Id: <20211003132851.12574-2-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003132851.12574-1-Reimar.Doeffinger@gmx.de>
References: <11506f71-80ea-a40f-1d5a-50c8005fcc42@opensource.wdc.com>
 <20211003132851.12574-1-Reimar.Doeffinger@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:O7yTA9e00AxU3u534R4Qebp4rrjTcnukCBwEsHL8cNtrKoPoDMN
 50EJ/7OtqJvDo/VP49bPQt/H17nWGOh6ECDu7GYG73ArSBSgEEecvFSOwdl4iOa6FWAhAvl
 KnHoKt3DWDROR/B9OEUgxTCSYCDB76ekoHWYWxLuxL6idgYhend4choSUlFFyFqoLbYuYgP
 k7gtMeTzy2Qn0Qp+9Y+KA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hrfTpGU2YKs=:o6Ffoy2wuVJXxQUEt2wXZo
 ZVqzoWPCE6aE9poEgaCyOgLKm3VP68IV9QNn4ZuM77Xg56wYj/wqDH2sAp2lKFnTN+b6ZSQ3O
 9ktXcB4tgAr8g1THUrsfUaihPM64l4HiLKumDECfmg+YJSoNeFS4yHNjltK4lMX4QTmNsJpH0
 dDUnQ3YfaewV1VKWfs4WoT1ldE1PMJOe9Fh2qjJNkq4kp/GVi4QFmeSarAR8DrvEBEGc1hs/R
 ijvfUJx2ioxaJFmUfq2SBjLP8GUssnD/mJbD0LGsRgOkFuWDe5Eaf79Kb6AKjhJXBH3zrX4OY
 7++B+LWfpr8iQZcw6pasZkMDX1ctzrEXuMVInZZjomzGPRP/mPiolTCqLt+c84YptsUeaaVji
 3vDozLS2wGYfF/erBhAfdKXT5xWVWKmx2JPdmnsnrE07J13kketYsrdycf5fo08sqSf4HehX+
 MRzruEhZN6+Ai+gF+o7pMx8yPJuAF/mvyJ0le0SbMN5jTLetCUoT3NkCqxSSiJPkWAPWxhCl8
 TTECVljzU9J8IfrUN+pKNaW9aUDL9RBUn0bHIaibYcyH85q0VGRMCs2U3eDIv1wqvS7vaV9+i
 3Ic42TT83/VxzD2DS6K89WFoXkY5vu3jnhGJP9blAMbkLluX7kREeijhJDW/jh5npkIVq8RqZ
 o0GNpUqWDARgfU0LMhnBCsnMbfsf/pfBnwMSd9diCEJhCX0pyWay8aQNEWnEuKyZVbpWxN16c
 SRpnYY4rEiQm8mFXd9+sOaPGqiDsHOBCvxG12IjxJjVryUdIMyXhbp2cGV8=
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Checking if DMA is enabled should be done via the
ata_dma_enabled helper function, since the init state
0xff indicates disabled.
This meant that ATA_CMD_READ_LOG_DMA_EXT was used and probed
for before DMA was enabled, which caused hangs for some combinations
of controllers and devices.
It might also have caused it to be incorrectly disabled as broken,
but there have been no reports of that.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=195895
Signed-off-by: Reimar Döffinger <Reimar.Doeffinger@gmx.de>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index eed65311b5d1..046faf0dbdd3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2007,7 +2007,7 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 
 retry:
 	ata_tf_init(dev, &tf);
-	if (dev->dma_mode && ata_id_has_read_log_dma_ext(dev->id) &&
+	if (ata_dma_enabled(dev) && ata_id_has_read_log_dma_ext(dev->id) &&
 	    !(dev->horkage & ATA_HORKAGE_NO_DMA_LOG)) {
 		tf.command = ATA_CMD_READ_LOG_DMA_EXT;
 		tf.protocol = ATA_PROT_DMA;
-- 
2.33.0

