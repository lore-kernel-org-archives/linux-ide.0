Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D323C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  9 Feb 2022 21:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiBIVqi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Feb 2022 16:46:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiBIVqf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2022 16:46:35 -0500
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E32CC0F8692
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 13:46:38 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 7254A20C0956
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 2/3] ata: pata_samsung_cf: make pata_s3c_devchk() return 'bool'
Date:   Thu, 10 Feb 2022 00:46:29 +0300
Message-ID: <20220209214630.13340-3-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220209214630.13340-1-s.shtylyov@omp.ru>
References: <20220209214630.13340-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

pata_s3c_devchk() returns 1 if a device is present, 0 if not -- the 'bool'
type clearly fits better here than 'unsigned int'...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/pata_samsung_cf.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index 377cd6bd87ac..bdd2178c4a61 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -308,8 +308,7 @@ static void pata_s3c_dev_select(struct ata_port *ap, unsigned int device)
 /*
  * pata_s3c_devchk - PATA device presence detection
  */
-static unsigned int pata_s3c_devchk(struct ata_port *ap,
-				unsigned int device)
+static bool pata_s3c_devchk(struct ata_port *ap, unsigned int device)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	u8 nsect, lbal;
@@ -329,9 +328,9 @@ static unsigned int pata_s3c_devchk(struct ata_port *ap,
 	lbal = ata_inb(ap->host, ioaddr->lbal_addr);
 
 	if ((nsect == 0x55) && (lbal == 0xaa))
-		return 1;	/* we found a device */
+		return true;	/* we found a device */
 
-	return 0;		/* nothing found */
+	return false;		/* nothing found */
 }
 
 /*
-- 
2.26.3

