Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4BFC433FE
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A27E460EDF
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhJLGap (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Oct 2021 02:30:45 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57247 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbhJLGak (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2021 02:30:40 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N4yJ8-1mi3VC2ege-010xrn; Tue, 12 Oct 2021 08:28:14 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 2/6] libata-scsi: fix checking of DMA state
Date:   Tue, 12 Oct 2021 08:27:45 +0200
Message-Id: <20211012062749.4728-3-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012062749.4728-1-Reimar.Doeffinger@gmx.de>
References: <20211012062749.4728-1-Reimar.Doeffinger@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RSnP8zlmmnaBu8nZ+XGo7DvwB1A21nRNpfl8Qq4TsV/C+LUJCd7
 ajnZpHjcvi1GBNAsaS4ZnpxsymOEFhp3rELPhvtfnixvOcfoxmhd9YXW3sTcWjhX5xD3SjR
 hVSsE7u8mIUyeLgVvZfg+jyF4/KyGBRou5XZm3r/FoT8cOgJsjBPqA12I3wKRhv/OWDRi10
 nggtt76P8MPp+IM1u52Mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jMxoRwc92RA=://izxjmlgROGCq5LSTN0n2
 uZD5UFXd74Uu8dwbmO94b1VCimF+tZBXwa1wcfj7+fp5mKT+I+3nKcawOUHoz95SPBRWWuncb
 dNMEJ72MidKann0gBdj3wZASNsi5EMklDwY9EGpXPxVO4MdKHNdZnAG+GpGp/FtEG6wvze0NZ
 FzJXNxYQPluhxyr4zHVJC1fUuL8eYAkMZIGxVPrsqCLLQl4i0o5z190ZpHXK1NKtIqWkuiPma
 V+3mgjeT0tpVboZ/CPZvi1dOFFEMaL8OdKNS4DxphI/yx0U1vdA+He9xwS57Q40mdCqQOrzoq
 MU4tmvjRkf82csOl8kt3fUNqNax4e9E7UkB8pnSfcJbZHDI+cIQCOEw1Dwzlkf4/YkZeWCRZA
 1HDPHouF1Em9eKFDsge5Y7DxkwPDB1elNZOBK8U8coEn7Au4nw99cXPu4oZj2VoypbEbfS7xr
 PN+63gY0voANmz/M7uRDksg9bXek9qpBeWiu1UP2enrmvjDOpbu7qlpjAyitsJF2BKrh+F9Kj
 ZCGRfmdJnTOZst0oZzrMx9nLxyDPC6Xs8RbtinUzgMBfaRBWazYmFuiXs//CfkHZueHQ5khOj
 UQbFbX4vpAcj6GniJVYOBqK9aGcgT44Eyg2tWVpRcLIBkDlSuY45jPEeE1vpB5psxal38OjrM
 0vX8ADp1rtwqSqUTTbo896tCwib3oEL7/gqayF48UzazTJk/rtLvEdXWxQKh9fPlc0MnhzYMv
 ps67/5Lk3UTVXGBm5hjTHOeXtn5g1Lte/+fz+yXjD82gWsvHR7lu3rAHq1k=
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Checking if DMA is enabled should be done via the
ata_dma_enabled helper function, since the init state
0xff indicates disabled.
Change based on code review, not tested due to lack of hardware.

Signed-off-by: Reimar Döffinger <Reimar.Doeffinger@gmx.de>
---
 drivers/ata/libata-scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 1fb4611f7eeb..0adea33f2137 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2981,7 +2981,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	ata_qc_set_pc_nbytes(qc);
 
 	/* We may not issue DMA commands if no DMA mode is set */
-	if (tf->protocol == ATA_PROT_DMA && dev->dma_mode == 0) {
+	if (tf->protocol == ATA_PROT_DMA && !ata_dma_enabled(dev)) {
 		fp = 1;
 		goto invalid_fld;
 	}
@@ -3131,7 +3131,7 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	u8 unmap = cdb[1] & 0x8;
 
 	/* we may not issue DMA commands if no DMA mode is set */
-	if (unlikely(!dev->dma_mode))
+	if (unlikely(!ata_dma_enabled(dev)))
 		goto invalid_opcode;
 
 	/*
-- 
2.33.0

