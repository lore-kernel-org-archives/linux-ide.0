Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E17C4338F
	for <linux-ide@archiver.kernel.org>; Thu, 19 Aug 2021 08:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DA861131
	for <linux-ide@archiver.kernel.org>; Thu, 19 Aug 2021 08:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhHSIOh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 19 Aug 2021 04:14:37 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:53467 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237066AbhHSIOh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 19 Aug 2021 04:14:37 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MwQKp-1n6oWe0GhR-00sMBf; Thu, 19 Aug 2021 10:13:41 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org
Subject: [PATCH] libata: fix checking of DMA state
Date:   Thu, 19 Aug 2021 10:13:40 +0200
Message-Id: <20210819081340.4362-1-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <DM6PR04MB7081AB7034F116CDFBA43890E7FF9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <DM6PR04MB7081AB7034F116CDFBA43890E7FF9@DM6PR04MB7081.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1pDJWK5G3G9ngjeOkHnmO78eqPbrPTPMWWOAurayj/og85Eg0/g
 Zt+RYqhYDPGwahkcZpX05pecLfZGTyWlePz8GmQrC7UseHr3nUScAXnQCdzOewLStyGvy0d
 FDrH7v6kjRSJPzhj7RccQ3c2+bDtWeClXaNRQdXHQHO74Mb+hp1h+TzKUYRDzzaEa2Prwy1
 FjWAMLr71jJ2giXlahCDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2RwgNoBXxAU=:U6zEFSZKWrs4QwVQzd7qMr
 edKINq1UVqVfqKCO9IBVm7U2zthg0kSZj2GHmVj0D5exntRN7hVzvrY0M7oNCngfVa9CnUiEV
 xtXIZumB4RSlMxfyoELNwKH2RoaNapYfTeIiy0D4sf4pnRMAiW5FckhXncHyicWmdxmn9hd3B
 1K6vkrmaUTzaFYnv/PQc04VGulpT0+2R2reEfPQ0sfmly+rVcBsnAqP3/A96QDQvB4j4ibfM6
 OAb07N4j2n8iAS+cEJB47HBpdNjtvJz88sIgrEwzWBvrNi8VUimjjiuAQuCOi2wp5B9J1zUsH
 C7/tIym4wv523U0lCNyfmNipyZYfQNd1OV3FBdXiWiYf5EaWbQrcE8ZB5+uinqNkjk8dDZUUW
 KdbCc/Hm/HfY1fni4OuH6XIK29xCAJI06YLFzXkrN7Twbg8Yy6Dhkd/kDNze1R276X358E603
 bKfiUJI6Nc+YiXi3RCEq0jfFo+k9/5Tr1W3VA7AuDcklVP6LORW6DHXBC/61fJJfgUXB/+l+0
 +80mI6Fu3OEXXIU96BRPNPi+OEjYIvU/zr4ZMsUgSctuEqlji2ZhETV4hOg59r7bM4iXbSVhJ
 /54bM+0jpkzuEUMmAKade0FQUxZo4jE2w3LBPw03bK/52CrhRsiZ36s08VqaZnOmWWMviF/9z
 ie+iAp4JJ5oh9H9a5A9fwBZ4FY851wJN0rkz4WkPKxd+CsKGrzdpQxgA8+PKaMjuCl+DWh5y1
 NeBYKBnwq29DYI9bOu2753RzLUDSBcI9DNOO/0B0vx5UWQx2i7XPaiLYbL/rpt5zJKcs3ehg3
 Hsmc5LSGM8TB3SRxshw7FiU0FukbGzkZtEGSaJAYAxM46FFJa0WIB4mn/iAttE4Aks+45lbyp
 yNOZfOA4XRckPz7GaWaA==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Checking if DMA is enabled should be done via the
ata_dma_enabled helper function, since the init state
0xff indicates disabled.
Only the libata-core logic is tested on actual devices,
the other changes are based on code review only.
---
Changes to previous version:
- removed initialization change for SATA. I got confused by the
  ping-pong between libata-eh and libata-core and thought SATA did not
  set up xfermode
- reviewed other cases that used dma_mode in boolean context and those
  seemed to need changing as well, so added them to patch.
  I did not see any places that would set dma_mode to 0 ever, so I
  do think they were all indeed wrong.

 drivers/ata/libata-core.c  | 2 +-
 drivers/ata/libata-scsi.c  | 4 ++--
 drivers/ata/pata_ali.c     | 2 +-
 drivers/ata/pata_optidma.c | 4 ++--
 drivers/ata/pata_radisys.c | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9934f6c465f4..52469b39d424 100644
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
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b9588c52815d..9e51251161e9 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3023,7 +3023,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	ata_qc_set_pc_nbytes(qc);
 
 	/* We may not issue DMA commands if no DMA mode is set */
-	if (tf->protocol == ATA_PROT_DMA && dev->dma_mode == 0) {
+	if (tf->protocol == ATA_PROT_DMA && !ata_dma_enabled(dev)) {
 		fp = 1;
 		goto invalid_fld;
 	}
@@ -3173,7 +3173,7 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	u8 unmap = cdb[1] & 0x8;
 
 	/* we may not issue DMA commands if no DMA mode is set */
-	if (unlikely(!dev->dma_mode))
+	if (unlikely(!ata_dma_enabled(dev)))
 		goto invalid_opcode;
 
 	/*
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 557ecf466102..28b56811306f 100644
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
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index f6278d9de348..ad1090b90e52 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -153,7 +153,7 @@ static void optidma_mode_setup(struct ata_port *ap, struct ata_device *adev, u8
 	if (pair) {
 		u8 pair_addr;
 		/* Hardware constraint */
-		if (pair->dma_mode)
+		if (ata_dma_enabled(pair))
 			pair_addr = 0;
 		else
 			pair_addr = addr_timing[pci_clock][pair->pio_mode - XFER_PIO_0];
@@ -301,7 +301,7 @@ static u8 optidma_make_bits43(struct ata_device *adev)
 	};
 	if (!ata_dev_enabled(adev))
 		return 0;
-	if (adev->dma_mode)
+	if (ata_dma_enabled(adev))
 		return adev->dma_mode - XFER_MW_DMA_0;
 	return bits43[adev->pio_mode - XFER_PIO_0];
 }
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 8fde4a86401b..626b14f0f2ea 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -173,7 +173,7 @@ static unsigned int radisys_qc_issue(struct ata_queued_cmd *qc)
 	if (adev != ap->private_data) {
 		/* UDMA timing is not shared */
 		if (adev->dma_mode < XFER_UDMA_0) {
-			if (adev->dma_mode)
+			if (ata_dma_enabled(adev))
 				radisys_set_dmamode(ap, adev);
 			else if (adev->pio_mode)
 				radisys_set_piomode(ap, adev);
-- 
2.32.0

