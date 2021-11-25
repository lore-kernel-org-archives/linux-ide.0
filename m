Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4389CC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 25 Nov 2021 22:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhKYWl7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:41:59 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:34829 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238253AbhKYWj6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Nov 2021 17:39:58 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9BB8658043F;
        Thu, 25 Nov 2021 17:36:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 25 Nov 2021 17:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Ba2WyiN6647MB61mpmqIykEYTj6KVGUq5LS7QOD/UcE=; b=WTBHISQS
        4uwAgJLcHkqzfyw5Uno4ikYUSIrRTm5iTuJb1F4L1VFGy8PmJHiCHzl+gt/FzU65
        kYNn/q/K3eu5IwK5GFSslUBuimsU28lR14fRrwFKUBrrm5d9EbJekLctdwijDHP+
        DPEFkBXU5ETrHODepsQeIxUwsXvpsUxF4+icusoLvVcMYNTlO/p7UgU2pfyRWVs0
        IB6TxVsB1Fs+X3o1b9UwFRgIZRu98U9v3Zw03pxGXfLxAr1akHv86CuypuX/JND/
        v3qmHC7fgYfgpeeWfYJbhVNM8S9z+Hh1YcVHg6lNfvXmHLazOJAMmgpOO9d2R53y
        C9n6i/u2ovSaQg==
X-ME-Sender: <xms:_g-gYWfvwmNjV8NmNu6J_vbCnDCVR3mfgXw7H__8n-KeuEID-bww3A>
    <xme:_g-gYQOVAOpvsKjYQtEJsEgc-qs7SCdrAvWrn7u1mh8XENy0yjKzF0Gc42ZOKL26J
    eEEqdambyD3pt0GzIY>
X-ME-Received: <xmr:_g-gYXh8RBiMnyyJcF1kqha1MKLPzcYv57KgmSvYbIAXcCIOfEaPt8t5f9ftwT_BEpngXPIM5g8k_yQAA5CIBxiiaijB4-OxEek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrhedtgdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gohfhorhgsihguuggvnhfjughrucdlhedttddmnecujfgurhepvffkhffuffestddtredt
    tddtnecuhfhrohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmh
    eikehkrdhorhhgqeenucfhohhrsghiugguvghnjfgurhepvffkhffuffestddtredttddt
    pdfvkffhufffsedttdertddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:_g-gYT87gPDf8dUhjILy5POt5l8WjSYFiYFWVW_-5NMD3LweSKP5rQ>
    <xmx:_g-gYSuYKxg5XOsGtl8tOQezDkHBypuJVF5Ks-9hqwp1rnGqEBvoeQ>
    <xmx:_g-gYaEI0YfMaKyU9XLpwRv5frllwnwDD5WBmHUIhsg8jq4wvPJ6VQ>
    <xmx:_g-gYWKBO3r0DXOHgnp3I_lHSH_OoG7pRDeEH6xGy1WvIWGR2RVTNA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Nov 2021 17:36:43 -0500 (EST)
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Michael Schmitz" <schmitzmic@gmail.com>,
        "Jens Axboe" <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <8f6a78cf7b60160ef3d22445ee1b8f2c0678f74b.1637879659.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2] pata_falcon: Avoid type warnings from sparse
Date:   Fri, 26 Nov 2021 09:34:19 +1100
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The zero day bot reported some sparse complaints in pata_falcon.c. E.g.

drivers/ata/pata_falcon.c:58:41: warning: cast removes address space '__iomem' of expression
drivers/ata/pata_falcon.c:58:41: warning: incorrect type in argument 1 (different address spaces)
drivers/ata/pata_falcon.c:58:41:    expected unsigned short volatile [noderef] [usertype] __iomem *port
drivers/ata/pata_falcon.c:58:41:    got unsigned short [usertype] *

The same thing shows up in 8 places, all told. Avoid this by removing
unnecessary type casts.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/ata/pata_falcon.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
index 121635aa8c00..823c88622e34 100644
--- a/drivers/ata/pata_falcon.c
+++ b/drivers/ata/pata_falcon.c
@@ -55,14 +55,14 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
 	/* Transfer multiple of 2 bytes */
 	if (rw == READ) {
 		if (swap)
-			raw_insw_swapw((u16 *)data_addr, (u16 *)buf, words);
+			raw_insw_swapw(data_addr, (u16 *)buf, words);
 		else
-			raw_insw((u16 *)data_addr, (u16 *)buf, words);
+			raw_insw(data_addr, (u16 *)buf, words);
 	} else {
 		if (swap)
-			raw_outsw_swapw((u16 *)data_addr, (u16 *)buf, words);
+			raw_outsw_swapw(data_addr, (u16 *)buf, words);
 		else
-			raw_outsw((u16 *)data_addr, (u16 *)buf, words);
+			raw_outsw(data_addr, (u16 *)buf, words);
 	}
 
 	/* Transfer trailing byte, if any. */
@@ -74,16 +74,16 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
 
 		if (rw == READ) {
 			if (swap)
-				raw_insw_swapw((u16 *)data_addr, (u16 *)pad, 1);
+				raw_insw_swapw(data_addr, (u16 *)pad, 1);
 			else
-				raw_insw((u16 *)data_addr, (u16 *)pad, 1);
+				raw_insw(data_addr, (u16 *)pad, 1);
 			*buf = pad[0];
 		} else {
 			pad[0] = *buf;
 			if (swap)
-				raw_outsw_swapw((u16 *)data_addr, (u16 *)pad, 1);
+				raw_outsw_swapw(data_addr, (u16 *)pad, 1);
 			else
-				raw_outsw((u16 *)data_addr, (u16 *)pad, 1);
+				raw_outsw(data_addr, (u16 *)pad, 1);
 		}
 		words++;
 	}
-- 
2.26.3

