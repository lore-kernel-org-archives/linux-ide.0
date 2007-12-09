From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: add ST3160023AS / 3.42 to NCQ blacklist
Date: Sun, 09 Dec 2007 19:45:39 +0900
Message-ID: <475BC753.7090108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:30400 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbXLIKpu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 05:45:50 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2635957wah
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 02:45:50 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Matheus Izvekov <mizvekov@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>Matheus Izvekov <mizvekov@gmail.com>, "Eric D. Mudama" <edm>


Like ST380817AS / 3.42, ST3160023AS / 3.42 times out commands if NCQ
is used.  Blacklist it.  This is reported by Matheus Izvekov in the
following thread.

  http://thread.gmane.org/gmane.linux.ide/24202

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Matheus Izvekov <mizvekov@gmail.com>
---
It could be that all devices with 3.42 firmware have this problem.
I'll ask around.  Thanks.

 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e4dea86..e080b07 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4149,6 +4149,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "HITACHI HDS7250SASUN500G*", NULL,    ATA_HORKAGE_NONCQ },
 	{ "HITACHI HDS7225SBSUN250G*", NULL,    ATA_HORKAGE_NONCQ },
 	{ "ST380817AS",		"3.42",		ATA_HORKAGE_NONCQ },
+	{ "ST3160023AS",	"3.42",		ATA_HORKAGE_NONCQ },
 
 	/* Blacklist entries taken from Silicon Image 3124/3132
 	   Windows driver .inf file - also several Linux problem reports */
