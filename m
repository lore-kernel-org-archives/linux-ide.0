Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF0AC433F5
	for <linux-ide@archiver.kernel.org>; Wed,  9 Feb 2022 21:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiBIVqg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Feb 2022 16:46:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiBIVqf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2022 16:46:35 -0500
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F91C0DE7C1
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 13:46:37 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru B7D8E20A4C16
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 1/3] ata: libata-sff: make ata_devchk() return 'bool'
Date:   Thu, 10 Feb 2022 00:46:28 +0300
Message-ID: <20220209214630.13340-2-s.shtylyov@omp.ru>
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

ata_devchk() returns 1 if a device is present, 0 if not -- the 'bool' type
clearly fits better here than 'unsigned int'...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/libata-sff.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index c9dbfb3641fc..546b1f73ede5 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1751,10 +1751,13 @@ EXPORT_SYMBOL_GPL(ata_sff_prereset);
  *	correctly storing and echoing back the
  *	ATA shadow register contents.
  *
+ *	RETURN:
+ *	true if device is present, false if not.
+ *
  *	LOCKING:
  *	caller.
  */
-static unsigned int ata_devchk(struct ata_port *ap, unsigned int device)
+static bool ata_devchk(struct ata_port *ap, unsigned int device)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	u8 nsect, lbal;
@@ -1774,9 +1777,9 @@ static unsigned int ata_devchk(struct ata_port *ap, unsigned int device)
 	lbal = ioread8(ioaddr->lbal_addr);
 
 	if ((nsect == 0x55) && (lbal == 0xaa))
-		return 1;	/* we found a device */
+		return true;	/* we found a device */
 
-	return 0;		/* nothing found */
+	return false;		/* nothing found */
 }
 
 /**
-- 
2.26.3

