Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573ADC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 27 Dec 2021 16:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhL0Q1L (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 27 Dec 2021 11:27:11 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:43897 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229596AbhL0Q1K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 27 Dec 2021 11:27:10 -0500
Received: from handsomejack.molgen.mpg.de (handsomejack.molgen.mpg.de [141.14.17.248])
        by mx.molgen.mpg.de (Postfix) with ESMTP id 3B42E61EA1922;
        Mon, 27 Dec 2021 17:27:09 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] ahci: Use macro PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE
Date:   Mon, 27 Dec 2021 17:26:57 +0100
Message-Id: <20211227162658.11314-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211227162658.11314-1-pmenzel@molgen.mpg.de>
References: <20211227162658.11314-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use the defined macro from `include/linux/pci_ids.h`.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/ata/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1e1167e725a4..6a2432e4adda 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -436,7 +436,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 		.class_mask = 0xffffff,
 		board_ahci_al },
 	/* AMD */
-	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE), board_ahci },
 	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
 	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
 	/* AMD is using RAID class only for ahci controllers */
-- 
2.30.2

