Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC98C433FE
	for <linux-ide@archiver.kernel.org>; Mon, 21 Mar 2022 21:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiCUV1H (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 21 Mar 2022 17:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiCUV1G (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Mar 2022 17:27:06 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2913E3458FA;
        Mon, 21 Mar 2022 14:25:27 -0700 (PDT)
Received: from handsomejack.molgen.mpg.de (handsomejack.molgen.mpg.de [141.14.17.248])
        by mx.molgen.mpg.de (Postfix) with ESMTP id 869DC61E6478B;
        Mon, 21 Mar 2022 22:25:21 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ata: ahci: Add new board low_power_no_debounce_delay
Date:   Mon, 21 Mar 2022 22:24:30 +0100
Message-Id: <20220321212431.13717-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Some adapters do not require the default 200 ms debounce delay in
`sata_link_resume()`. So, create the new board
`board_ahci_low_power_no_debounce_delay` with the link flag
`ATA_LFLAG_NO_DEBOUNCE_DELAY`.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
---
v2: Resend

 drivers/ata/ahci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 84456c05e8452..0fc09b86a5590 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -51,6 +51,7 @@ enum board_ids {
 	board_ahci,
 	board_ahci_ign_iferr,
 	board_ahci_low_power,
+	board_ahci_low_power_no_debounce_delay,
 	board_ahci_no_debounce_delay,
 	board_ahci_nomsi,
 	board_ahci_noncq,
@@ -142,6 +143,14 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_low_power_no_debounce_delay] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_USE_LPM_POLICY),
+		.flags		= AHCI_FLAG_COMMON,
+		.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_no_debounce_delay] = {
 		.flags		= AHCI_FLAG_COMMON,
 		.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
-- 
2.30.2

