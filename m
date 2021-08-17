Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F35C4338F
	for <linux-ide@archiver.kernel.org>; Tue, 17 Aug 2021 19:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F3060BD3
	for <linux-ide@archiver.kernel.org>; Tue, 17 Aug 2021 19:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhHQTDv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Aug 2021 15:03:51 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:37911 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhHQTDv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2021 15:03:51 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MMGZM-1mXBF429g6-00JIMw; Tue, 17 Aug 2021 21:03:08 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org
Subject: [PATCH] libata: fix setting and checking of DMA state.
Date:   Tue, 17 Aug 2021 21:03:07 +0200
Message-Id: <20210817190308.29065-1-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <YRv5cafgitLlfiCs@reimardoeffinger.de>
References: <YRv5cafgitLlfiCs@reimardoeffinger.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OBR85YcLyt7UFAQFar+p7ul4yKPVxzmFmeJ/xMcH+LWl+evQu+2
 qSPmu2PQOoFjRyBCsxbGvrSfVf2T11KO8MmvYa4xYQkg4VKguWm4YO+9Scxh4OC9xaohyi6
 rhz6PDBERb+wHPBWAIF/YFMDlFBCZP8KvQF3MbFpcrIdeDuBEklu1gmiDQMm4dv6snb0NJp
 NixEu7rkdEALSc5Z/DQ4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Rp5hyhoXGs=:bYxUMeV9VgAO4oTa0Lfh4c
 G1NLi+vUV09dCSLg2F9mZO0Y43p+N3tRwuPeDKMdpUR0PVvduYmHnX//gQf0CD45rVkESSw8/
 vH36kDRahNw07veMxTOg+8f7ppAxVbSrjrfNOe6oScPtdM32APwf17Gui7XR4aqoCg14A0+4l
 6eJ/FfqT7l+EaPS/qzOf0r79sC47IihGsRd8iyfCUtbivp/Nz47GcphqIKCyXcAp6cHzk0MwU
 zNxbSSY97fdqWQhailnR1wi06LjFXTTe0/M8mGyw8+GhMiuctQuZtJLuDCEqeJEiUsINmzCyT
 E6yIP4A/KLOGz2+o++HkiFRAGmeChFyL972FEkRK84A24YCBUgDr3Asj8Lr/SlI/1ocxKI7fl
 2aVwXdjA0m5Ps7BMp0M1RlrEy9rnOZ0VOkHxOoPhJ6esO8tbdA7gbylXAu/TxPTkH9I4GbvX8
 EHxg5F9hPz/XPeOOAEbYMWoprJZki7+oJ5Hp0cfPIuAG5UPZis4lL4Uf38OFqGrqUNH1VwKbi
 YI2qXUXrxAvkAAhFW+aG9VcJ6swEwld5wceB8NbPtem82HeMK7XqZWpzo+Ms8xoqsDhXfunVg
 HSVSuDK9DU90x8VTfmUoKb+k9xFb9LPmL88iYW0W+taAeqRayN6D8OZ0Z+2cKkJXPfoMHsU30
 o0hYnv6gf9hlKbPrvOdv68hltZMe3AOOGhfIE+D2V1ioxZbRSRBOpVAuQximZ5N8cMgEE1Uat
 aDQUG+ldLT1fEG+Uj5apJhrbuxaNWdhDoM3Q54Wh0ND4flLIytgpTPYMXBWXpolh8dGZ7Af1P
 wH+kVJ31HdCSvuK+XHYPnzF+ZybLeQtaQpX7DnMFDEjkv9tIDfSjQOOY1bKvQYBcoRuzCvUL2
 ZxUR0kPmf8Qi6ohNKtbg==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Checking if DMA is enabled should be done via the
ata_dma_enabled helper function.
Update dma_mode initialization so that SATA devices
are reported as DMA enabled.
---
 drivers/ata/libata-core.c | 4 ++--
 include/linux/ata.h       | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9934f6c465f4..a5fe20bb22d6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2004,7 +2004,7 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 
 retry:
 	ata_tf_init(dev, &tf);
-	if (dev->dma_mode && ata_id_has_read_log_dma_ext(dev->id) &&
+	if (ata_dma_enabled(dev) && ata_id_has_read_log_dma_ext(dev->id) &&
 	    !(dev->horkage & ATA_HORKAGE_NO_DMA_LOG)) {
 		tf.command = ATA_CMD_READ_LOG_DMA_EXT;
 		tf.protocol = ATA_PROT_DMA;
@@ -2824,7 +2824,7 @@ int ata_bus_probe(struct ata_port *ap)
 		 * bus as we may be talking too fast.
 		 */
 		dev->pio_mode = XFER_PIO_0;
-		dev->dma_mode = 0xff;
+		dev->dma_mode = ap->flags & ATA_FLAG_SATA ? XFER_SATA : 0xff;
 
 		/* If the controller has a pio mode setup function
 		 * then use it to set the chipset to rights. Don't
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 1b44f40c7700..7bb2c2acbc42 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -374,6 +374,7 @@ enum {
 
 	/* SETFEATURES stuff */
 	SETFEATURES_XFER	= 0x03,
+	XFER_SATA               = 0x48,
 	XFER_UDMA_7		= 0x47,
 	XFER_UDMA_6		= 0x46,
 	XFER_UDMA_5		= 0x45,
-- 
2.32.0

