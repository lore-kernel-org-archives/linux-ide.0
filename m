Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A38C433FE
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C1960C4D
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhJLGak (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Oct 2021 02:30:40 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:42009 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhJLGaj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2021 02:30:39 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MeTwa-1n8Q5j0Nk4-00aV5n; Tue, 12 Oct 2021 08:28:15 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 3/6] pata_ali: fix checking of DMA state
Date:   Tue, 12 Oct 2021 08:27:46 +0200
Message-Id: <20211012062749.4728-4-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012062749.4728-1-Reimar.Doeffinger@gmx.de>
References: <20211012062749.4728-1-Reimar.Doeffinger@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AM4ZEqWrHmdnkTONhwF2ah2KZjmwINAe9w+U3HsdcQXGxbWsvlp
 eJoP5Jcvi0HnCMe+sJYl255OCmCkPE3BMwqE7v5Pa5QElidpu+NieDE2bMMelPFuRmWucy4
 YhSIrEOp4yr4w78R+NppIzpsIuJ3rCWgF3XNOHp8nQ/FL3Hyhhf4KCTGUkO2UvUlBqOmB+t
 g8s1oFHyiWBP/VGLLGsmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Eu+qvYesbI=:loWJ303ds0B30fSydmPxog
 jqR21JErVujlJp66vWz7O4HOJWoOkJIJ1WLDcU7duaGdYsvMCQ8kfntwZY0h9+CpW5VC4l/gl
 +Os2n89WB2pfugjPXp/tpQBKBPLd+BP9rQIJTAnuA/6TTUXZdAxNvRUc8LS7RvAIk1n9yClwy
 orlYX0pYseo7zIWNHyUuhhdWC788irV3qd8Fhty1HSaWnqPQdtWY8wERO6HFFbbVnF0vmrAeP
 Bs23cRuuEAwC9ERVsaaqBK8g7C5kcF8jSlx7BB1Cjt2KxpmsogwxpHWGbGzrQupB17CVBFfoT
 DWehGaCInglJmqN8pa1BiYecphT/K0Mzh5Em8n9NRHUyIj/Mya/Wpx+zpS0bXjhc4KwuyHZaM
 puNceQJ5gLbJoWo0BpiO+FiBQQIwzEwu4+bFnNbcq7WT/XZPql2Ag0W94xG6H8mH028VRPbko
 fJrXETq8aXJQlnOBCOjSHGsb1416dPDzIi7wWZ+kQmvadK57LMimUsuztgrwFYn4XwmZRitiN
 wBiwVqyt4KBc1moCqb9pBfcfNA3KM6Qw6fMR6yNAkaTVNk4Xv/jJRPD/iMRA8ydenvI/cJSO6
 4yOWt4uarpuSBIydysvIIuvuX7HkeTW+LTVEv6pUzAuTZ6vjCydKlRfMx8t1FusIiSe5edkF8
 UYEIXR82Fh7LsoQL4NUq3gFArEiqxuUyS3kfE65DnMXsP+3RlWwSv1VPCYyfm/2x+bfShOEhC
 jQ55t5OZN8zWnYg5Ajh9YoUFr+k1g09k/YtTVLwG6hvgmn7bKNU3YIg/QjU=
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

