Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BD8C4338F
	for <linux-ide@archiver.kernel.org>; Thu, 19 Aug 2021 12:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16C36023B
	for <linux-ide@archiver.kernel.org>; Thu, 19 Aug 2021 12:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhHSM5J (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 19 Aug 2021 08:57:09 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57697 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhHSM5J (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 19 Aug 2021 08:57:09 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MGi6k-1mKZSn4BTW-00Dr8B; Thu, 19 Aug 2021 14:56:24 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org
Subject: [PATCH] libata: fix checking of DMA state
Date:   Thu, 19 Aug 2021 14:56:23 +0200
Message-Id: <20210819125623.22059-1-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819081340.4362-1-Reimar.Doeffinger@gmx.de>
References: <20210819081340.4362-1-Reimar.Doeffinger@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:raIt20G29od/WIa2awOwv6xo90JFrXiAICAiqZrvI2f5OoCPuai
 dBsdnCo71IEuZtrETc23Lrdx5H6+kr+DC4kktMRruEWn2u/qFsGpIEEvaB3dxMHukM1XIKQ
 4ZkkgQ4y0dQFg5Y7HAH3hMLmlyZdkZONYHjruvkZpDPWunlLYxYl9/b7R2Lg3LVaxWFXMtp
 AJ5TOMRGNY6+YfYz+r2oQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FE0Cvb6R3RU=:EmyFDd3HdxoQp0iD77glAf
 ib5+8icPreENQyxNF8AxOOWQg+Dfk8mmwpCgCXhYJtEW/1gWzFEPY2Nt0uuCNGU2zwEoc/0ge
 yjnHXG9XQNJmB47pB6BaSQsXfEdGL6TqA+2jn86P4FQFs8eDXPg1gEJghTO7XZq9d0H09r9cJ
 7aYRBGN8l00AcEZKbldkCEv3Ot613yTDYB4fzUZefs2oFQCbniCeg2OoHsL0ntHJlKVCPx164
 3Zzm+mT+gt6RPHRT314m9dM+XZJ9TX6Gq3klEmKBsdSPH6Ct02ziBCzvACK7nz3o0GQ1DIUS1
 RMtKNDqs7JLLqkpLu1f6AC1Pky3DgIRxH/hUze+64ywV6iuUeFuP/GFNzDKvHKyuph+iPaYEe
 BX84o+U5JMZwb1bzxW4MZVJUiGH87qMx+3SVFiVkpaEGfoEs+qyk/PLKOhxDfQYlgWm+bnjvx
 IbCyt4xC3KA78XhGgYjfHVr4cD+t3AvfjMkJ5Kzjn6pDf+6KLIdbodwl4tfUqN8NPHCaQW0PK
 JXJJOkvScZ0Z1vGsJ/iPE3wC5kssWoBE1H82agtomQcw5ut23W32uPx5CtBVacUm+Y1yQlbOv
 RLMFGQetI1J5WqqAVeSPA2YSukoy/NTTAvPLYABQLBbfcxLf5ZLKjakITcQLFh41xAe0EMn7H
 ULbK+QUB1zNkWHj9Xw6ajKqSbqXwEyS8wG/VHBYJDcTQ0fJhlLUowTyivjx6XFipWpHyuHL3H
 fMwaV9LH/jdhH/Ck9fs2yUKxcBMw0IiHfqGl3m78SmbdC4y+Mxs0Phz+1eOyGGoWS9zuvYJRu
 +YCbcNvqqRFYRBWDs9ErToBaxqaR04nJlEAJFJg36HttBmXcmVPAFJwdgLAzWKYECQishRD1y
 LVshRq8a3gWkH7nlcs8A==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Checking if DMA is enabled should be done via the
ata_dma_enabled helper function, since the init state
0xff indicates disabled.
Only the libata-core logic is tested on actual devices,
the other changes are based on code review only.
---
Changes v3:
- found and updated more cases in pata_ali, pata_amd and pata_radisys.
Changes v2:
- removed initialization change for SATA. I got confused by the
  ping-pong between libata-eh and libata-core and thought SATA did not
  set up xfermode
- reviewed other cases that used dma_mode in boolean context and those
  seemed to need changing as well, so added them to patch.
  I did not see any places that would set dma_mode to 0 ever, so I
  do think they were all indeed wrong.

 drivers/ata/libata-core.c  | 2 +-
 drivers/ata/libata-scsi.c  | 4 ++--
 drivers/ata/pata_ali.c     | 4 ++--
 drivers/ata/pata_amd.c     | 2 +-
 drivers/ata/pata_optidma.c | 4 ++--
 drivers/ata/pata_radisys.c | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

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
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index c8acba162d02..154748cfcc79 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -66,7 +66,7 @@ static void timing_setup(struct ata_port *ap, struct ata_device *adev, int offse
 
 	if (peer) {
 		/* This may be over conservative */
-		if (peer->dma_mode) {
+		if (ata_dma_enabled(peer)) {
 			ata_timing_compute(peer, peer->dma_mode, &apeer, T, UT);
 			ata_timing_merge(&apeer, &at, &at, ATA_TIMING_8BIT);
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
index 8fde4a86401b..3aca8fe3fdb6 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -172,8 +172,8 @@ static unsigned int radisys_qc_issue(struct ata_queued_cmd *qc)
 
 	if (adev != ap->private_data) {
 		/* UDMA timing is not shared */
-		if (adev->dma_mode < XFER_UDMA_0) {
-			if (adev->dma_mode)
+		if (adev->dma_mode < XFER_UDMA_0 || !ata_dma_enabled(adev)) {
+			if (ata_dma_enabled(adev))
 				radisys_set_dmamode(ap, adev);
 			else if (adev->pio_mode)
 				radisys_set_piomode(ap, adev);
-- 
2.32.0

