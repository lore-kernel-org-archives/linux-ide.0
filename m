Return-Path: <SRS0=KxJU=CD=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6F1C433DF
	for <linux-ide@archiver.kernel.org>; Tue, 25 Aug 2020 05:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46BB2071E
	for <linux-ide@archiver.kernel.org>; Tue, 25 Aug 2020 05:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgHYFFu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Aug 2020 01:05:50 -0400
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:44744 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728246AbgHYFFu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Aug 2020 01:05:50 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 2B93118010D99
        for <linux-ide@vger.kernel.org>; Tue, 25 Aug 2020 04:56:54 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 0B8231E04;
        Tue, 25 Aug 2020 04:56:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fan66_0f1652527059
X-Filterd-Recvd-Size: 2259
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:56:49 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/29] ata: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:02 -0700
Message-Id: <2a3979b0eab31224e53553ca01759eb072790a65.1598331148.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/ata/pata_icside.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
index 08543aeb0093..498383cb6e29 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -202,14 +202,19 @@ static void pata_icside_set_dmamode(struct ata_port *ap, struct ata_device *adev
 	 * Choose the IOMD cycle timing which ensure that the interface
 	 * satisfies the measured active, recovery and cycle times.
 	 */
-	if (t.active <= 50 && t.recover <= 375 && t.cycle <= 425)
-		iomd_type = 'D', cycle = 187;
-	else if (t.active <= 125 && t.recover <= 375 && t.cycle <= 500)
-		iomd_type = 'C', cycle = 250;
-	else if (t.active <= 200 && t.recover <= 550 && t.cycle <= 750)
-		iomd_type = 'B', cycle = 437;
-	else
-		iomd_type = 'A', cycle = 562;
+	if (t.active <= 50 && t.recover <= 375 && t.cycle <= 425) {
+		iomd_type = 'D';
+		cycle = 187;
+	} else if (t.active <= 125 && t.recover <= 375 && t.cycle <= 500) {
+		iomd_type = 'C';
+		cycle = 250;
+	} else if (t.active <= 200 && t.recover <= 550 && t.cycle <= 750) {
+		iomd_type = 'B';
+		cycle = 437;
+	} else {
+		iomd_type = 'A';
+		cycle = 562;
+	}
 
 	ata_dev_info(adev, "timings: act %dns rec %dns cyc %dns (%c)\n",
 		     t.active, t.recover, t.cycle, iomd_type);
-- 
2.26.0

