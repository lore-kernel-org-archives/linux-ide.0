Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F993C43219
	for <linux-ide@archiver.kernel.org>; Sun,  3 Oct 2021 11:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052A661AF0
	for <linux-ide@archiver.kernel.org>; Sun,  3 Oct 2021 11:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhJCLbM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 3 Oct 2021 07:31:12 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:51071 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhJCLbI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 3 Oct 2021 07:31:08 -0400
Received: from localhost ([217.85.124.89]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1McH1Q-1n4xyU3uaC-00clox; Sun, 03 Oct 2021 13:28:47 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 3/6] pata_ali: fix checking of DMA state
Date:   Sun,  3 Oct 2021 15:28:48 +0200
Message-Id: <20211003132851.12574-4-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003132851.12574-1-Reimar.Doeffinger@gmx.de>
References: <11506f71-80ea-a40f-1d5a-50c8005fcc42@opensource.wdc.com>
 <20211003132851.12574-1-Reimar.Doeffinger@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Cu3/hAxSJSAsso4OJfXMFLa889YsaldVd3cvQsDSDVnkB/Hbha3
 z5+74gqwub9GfZpABVonUr6z/n7WVZ0S8cNC5kI5pjUl155wyKTKdLny1dBCwI7TY4bWG12
 U7FyudjDTX4WjH4ELw3X2dzTKf+pq7jF0dWE5nyYj+mVHGbkE7kTPtgbGWlzoYc2FVsCm0V
 C3B5rsrJiYjjPtFj6QFxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ds33yXKUQyI=:BdO4wxRkxcPSqPqI2BkShH
 7m3lusXdSohZoZdVA2l0Mg+suZgX/diuAnVfX4mpHRZHlsPGbMXQMJjOQ183agSGlLFyHu1bR
 PbzX3tIUVJQ89NKHN5T2jL7QUVcTgoQolCSsMxo7u7vLnCgPBmKXg9q2Y7AO25p9bXfzYQG8i
 6cmtcvpo6wiSmv+r0Yrpe7e3glk2Sn3SJhqMIZBO/A5dMFxxa5TBS2QThLTIKlq2yMY1NQVPb
 ydAGvr4TQ3ypCRS2Uhb1Lbwjn87+PNZAUgxs3Oa9d78n70JvE38alwahSWFAhAE1CLep+Mj6v
 6fMovi9KdqE+WvUbMA9tP9Pr8kUcHHMb9TGCA6FAgWM/d9u8LwW2yW7zyzb48YI7hrtt+40NI
 6IB+ZxVNhTnRj8jsgLID4FiiKg+RMtB7g03tg6ODQeoun/+/CMC2VDuH7hJMo4wwfksROScXC
 GSm7gQHUlOD590mt26F4/EOKzMhs+2LVINNgxjypHtvd0WuunmUIzXfffU9lt3O7M8EYtgEir
 ZCrFyildn3ytuB9VemrPGAZUcTRYTrF//TvvAP2i7zBFbonitFHYZgyQKwNKlXkq6XPzT7ZCh
 mRDDztVPB9Vs6qCBPrDHL7oDCsMIzazMqK4rLz4UqVjYA1r6YUgAn0A2e3x4pvjxNf+E0F2wa
 AXZDPZEmhAViCJ3ilDcqR8ZgjFsPsfyiEGtSqndrC1OHYZk55oAZSx0bnzZ9daAwq4+YM5mqr
 qzwKcyt3lb2p9AOGdjBwC9gjInBX4WvS6KejpT7+y0huK8eMv6QJ8ggHTKI=
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Checking if DMA is enabled should be done via the
ata_dma_enabled helper function, since the init state
0xff indicates disabled.
Change based on code review, not tested due to lack of hardware.

Signed-off-by: Reimar Döffinger <Reimar.Doeffinger@gmx.de>
---
 drivers/ata/pata_ali.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 557ecf466102..b7ff63ed3bbb 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -215,7 +215,7 @@ static void ali_set_piomode(struct ata_port *ap, struct ata_device *adev)
 		struct ata_timing p;
 		ata_timing_compute(pair, pair->pio_mode, &p, T, 1);
 		ata_timing_merge(&p, &t, &t, ATA_TIMING_SETUP|ATA_TIMING_8BIT);
-		if (pair->dma_mode) {
+		if (ata_dma_enabled(pair)) {
 			ata_timing_compute(pair, pair->dma_mode, &p, T, 1);
 			ata_timing_merge(&p, &t, &t, ATA_TIMING_SETUP|ATA_TIMING_8BIT);
 		}
@@ -264,7 +264,7 @@ static void ali_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 			struct ata_timing p;
 			ata_timing_compute(pair, pair->pio_mode, &p, T, 1);
 			ata_timing_merge(&p, &t, &t, ATA_TIMING_SETUP|ATA_TIMING_8BIT);
-			if (pair->dma_mode) {
+			if (ata_dma_enabled(pair)) {
 				ata_timing_compute(pair, pair->dma_mode, &p, T, 1);
 				ata_timing_merge(&p, &t, &t, ATA_TIMING_SETUP|ATA_TIMING_8BIT);
 			}
-- 
2.33.0

