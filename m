From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: [BUG + FIX]xfermode setting fails with PIONEER DVD-RW  DVRTD08A
Date: Wed, 24 Aug 2011 15:09:25 +0200
Message-ID: <1462587.9v6Adyj5AV@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41984 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab1HXNJ3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Aug 2011 09:09:29 -0400
Received: by bke11 with SMTP id 11so872212bke.19
        for <linux-ide@vger.kernel.org>; Wed, 24 Aug 2011 06:09:28 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Since kernel 3.0.3 I've been getting "ata5.00: failed to set xfermode (err_mask=0x4)" error message during boot. This also rendered my DVD drive inoperable. I've never had this issue before. I attached a trivial patch that 
seems to have fixed the issue for me.

---
 drivers/ata/libata-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4a3a5ae..0705038 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4124,6 +4124,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	 * device and controller are SATA.
 	 */
 	{ "PIONEER DVD-RW  DVRTD08",	NULL,	ATA_HORKAGE_NOSETXFER },
+	{ "PIONEER DVD-RW  DVRTD08A",	NULL,	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
-- 
1.7.6


