Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDFDC433EF
	for <linux-ide@archiver.kernel.org>; Wed, 24 Nov 2021 04:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhKXE3h (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 23 Nov 2021 23:29:37 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:58667 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229622AbhKXE3h (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 Nov 2021 23:29:37 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 6A5832B0116A;
        Tue, 23 Nov 2021 23:26:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 23 Nov 2021 23:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=TNzYlAf8gHCMiOurGAolSHIotDBJRbmyQX+0b1N4zLI=; b=JtMlwNpN
        7hrAyKfH86TT9hxrN00MA5M4le+Pc9mj6gfg6f5+nsa1Eu9zRR9l1/ohlpcAYPhG
        LBX4i6oKoUNy0jWTYODXSwclNrPkGWmpkpoMtxaS/tgrrFpKpGZyqdDA4qlO3cH8
        GuUdM48poN08oc8vcsamORnlZzsFATjMxqEqpJjGAEaEX/kFJO2K6OMLibJXolwZ
        45mwy76E05pmP0u6Tdyhvq3TgOW2aqBNbbSQAVU9lSQZAWA3TMRMIv3Eb0YnOqvo
        /pnwp3SWjxurgQSC4l+2a0F+5/1pxkzGmL/m8Q8GUpYxwoDX75dTY6HRN81cRyqv
        EBQbvQhrwyqRZg==
X-ME-Sender: <xms:8r6dYVotRThxp5EMsTeHb7iEfh4jJafNvImaflWzKQlH3M5U1I6DAw>
    <xme:8r6dYXpHIT8X29Nr4kI4cp4KQRHPKtQagQq75MjOVTBBV3IdwUa3O9HDibaPXFw92
    v1BiZz_HcH7DPZzRBk>
X-ME-Received: <xmr:8r6dYSNjO2-tH6vBWTRassve_a2LFjF5xELl9QYxH9nIJMS7BatVwH41QxwHf6mxCrmZl89w3xwi7utqw_UTgK8h93ZsToe1_qs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeejgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fhohhrsghiugguvghnjfgurhculdehtddtmdenucfjughrpefvkffhufffsedttdertddt
    tdenucfhrhhomhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmie
    ekkhdrohhrgheqnecuhfhorhgsihguuggvnhfjughrpefvkffhufffsedttdertddttddp
    vffkhffuffestddtredttddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:8r6dYQ4UgroZ43RqlybT5_KrlEKpjcK_Pcs1ffXTg2DFhZ0QjLfcXA>
    <xmx:8r6dYU7ikiRIrEggWY2905-csZePO2vJfzwWJp5OI6h_BlEJ8SDR1g>
    <xmx:8r6dYYgLq07yICdGuf_WgnyORqySsjmsfk9LebEreXRUhh5_O2b6Hw>
    <xmx:876dYSlahmi4vCP_bAq3DSLzdwKVZLKNZutLArzdegcYXjDvn04iPd9lKsA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Nov 2021 23:26:23 -0500 (EST)
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     "Michael Schmitz" <schmitzmic@gmail.com>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        "Jens Axboe" <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <44e0213a681f3c8ee4c6ab2ef9d61ce3ac00e368.1637727935.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] pata_falcon: Add missing __iomem annotations
Date:   Wed, 24 Nov 2021 15:25:35 +1100
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The zero day bot reported some sparse complaints in pata_falcon.c. E.g.

drivers/ata/pata_falcon.c:58:41: warning: cast removes address space '__iomem' of expression
drivers/ata/pata_falcon.c:58:41: warning: incorrect type in argument 1 (different address spaces)
drivers/ata/pata_falcon.c:58:41:    expected unsigned short volatile [noderef] [usertype] __iomem *port
drivers/ata/pata_falcon.c:58:41:    got unsigned short [usertype] *

The same thing shows up in 8 places, all told. Avoid this by use of
__iomem type casts.

Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/ata/pata_falcon.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
index 121635aa8c00..e2a88edd9dbf 100644
--- a/drivers/ata/pata_falcon.c
+++ b/drivers/ata/pata_falcon.c
@@ -55,14 +55,14 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
 	/* Transfer multiple of 2 bytes */
 	if (rw == READ) {
 		if (swap)
-			raw_insw_swapw((u16 *)data_addr, (u16 *)buf, words);
+			raw_insw_swapw((u16 __iomem *)data_addr, (u16 *)buf, words);
 		else
-			raw_insw((u16 *)data_addr, (u16 *)buf, words);
+			raw_insw((u16 __iomem *)data_addr, (u16 *)buf, words);
 	} else {
 		if (swap)
-			raw_outsw_swapw((u16 *)data_addr, (u16 *)buf, words);
+			raw_outsw_swapw((u16 __iomem *)data_addr, (u16 *)buf, words);
 		else
-			raw_outsw((u16 *)data_addr, (u16 *)buf, words);
+			raw_outsw((u16 __iomem *)data_addr, (u16 *)buf, words);
 	}
 
 	/* Transfer trailing byte, if any. */
@@ -74,16 +74,16 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
 
 		if (rw == READ) {
 			if (swap)
-				raw_insw_swapw((u16 *)data_addr, (u16 *)pad, 1);
+				raw_insw_swapw((u16 __iomem *)data_addr, (u16 *)pad, 1);
 			else
-				raw_insw((u16 *)data_addr, (u16 *)pad, 1);
+				raw_insw((u16 __iomem *)data_addr, (u16 *)pad, 1);
 			*buf = pad[0];
 		} else {
 			pad[0] = *buf;
 			if (swap)
-				raw_outsw_swapw((u16 *)data_addr, (u16 *)pad, 1);
+				raw_outsw_swapw((u16 __iomem *)data_addr, (u16 *)pad, 1);
 			else
-				raw_outsw((u16 *)data_addr, (u16 *)pad, 1);
+				raw_outsw((u16 __iomem *)data_addr, (u16 *)pad, 1);
 		}
 		words++;
 	}
-- 
2.26.3

