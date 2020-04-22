Return-Path: <SRS0=fuJd=6G=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A7EC54FCB
	for <linux-ide@archiver.kernel.org>; Wed, 22 Apr 2020 17:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DCE820776
	for <linux-ide@archiver.kernel.org>; Wed, 22 Apr 2020 17:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDVRCu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:02:50 -0400
Received: from mailomta26-re.btinternet.com ([213.120.69.119]:10071 "EHLO
        re-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725980AbgDVRCu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Apr 2020 13:02:50 -0400
X-Greylist: delayed 10752 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Apr 2020 13:02:49 EDT
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20200422140336.CRWR20795.re-prd-fep-048.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 22 Apr 2020 15:03:36 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=j.oldman998@btinternet.com
X-Originating-IP: [31.51.225.56]
X-OWM-Source-IP: 31.51.225.56 (GB)
X-OWM-Env-Sender: j.oldman998@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrgeejgdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofestddtredtredttdenucfhrhhomheplfhohhhnucfqlhgumhgrnhcuoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqnecukfhppeefuddrhedurddvvdehrdehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehhvghnrhihrdhhohhmvgdpihhnvghtpeefuddrhedurddvvdehrdehiedpmhgrihhlfhhrohhmpeeojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqedprhgtphhtthhopeeorgigsghovgeskhgvrhhnvghlrdgukheqpdhrtghpthhtohepoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqpdhrtghpthhtohepoehlihhnuhigqdhiuggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeolhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from henry.home (31.51.225.56) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as j.oldman998@btinternet.com)
        id 5E3A16DE0C89880B; Wed, 22 Apr 2020 15:03:36 +0100
From:   John Oldman <john.oldman@polehill.co.uk>
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Oldman <john.oldman@polehill.co.uk>
Subject: [PATCH] Staging: ata: sata_inic162x fixed a spelling issue
Date:   Wed, 22 Apr 2020 15:03:32 +0100
Message-Id: <20200422140332.22923-1-john.oldman@polehill.co.uk>
X-Mailer: git-send-email 2.17.1
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixed a warning message spelling issue.

Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
---
 drivers/ata/sata_inic162x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index a6b76cc12a66..e517bd8822a5 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -145,7 +145,7 @@ enum {
 
 	/* PORT_IDMA_CTL bits */
 	IDMA_CTL_RST_ATA	= (1 << 2),  /* hardreset ATA bus */
-	IDMA_CTL_RST_IDMA	= (1 << 5),  /* reset IDMA machinary */
+	IDMA_CTL_RST_IDMA	= (1 << 5),  /* reset IDMA machinery */
 	IDMA_CTL_GO		= (1 << 7),  /* IDMA mode go */
 	IDMA_CTL_ATA_NIEN	= (1 << 8),  /* ATA IRQ disable */
 
-- 
2.17.1

