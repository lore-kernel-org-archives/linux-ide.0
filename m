From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: fix Seagate NCQ+FLUSH blacklist
Date: Thu, 11 Dec 2008 13:42:42 +0900
Message-ID: <49409A42.7090305@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41353 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753023AbYLKEmy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Dec 2008 23:42:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: stable@kernel.org

Due to miscommunication, P/N was mistaken as firmware revision
strings.  Update it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
This is ugly but the fixed revision is SD1A, so we either need to
write custom match for these drives or make our pattern matching
smarter to make the list shorter.  For #upstream-fixes and -stable
go with the dumb approach.  :-(

 drivers/ata/libata-core.c |   65 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5e2eb74..bc6695e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4050,17 +4050,70 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "ST3160023AS",	"3.42",		ATA_HORKAGE_NONCQ },
 
 	/* Seagate NCQ + FLUSH CACHE firmware bug */
-	{ "ST31500341AS",	"9JU138",	ATA_HORKAGE_NONCQ |
+	{ "ST31500341AS",	"SD15",		ATA_HORKAGE_NONCQ |
 						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST31000333AS",	"9FZ136",	ATA_HORKAGE_NONCQ |
+	{ "ST31500341AS",	"SD16",		ATA_HORKAGE_NONCQ |
 						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3640623AS",	"9FZ164",	ATA_HORKAGE_NONCQ |
+	{ "ST31500341AS",	"SD17",		ATA_HORKAGE_NONCQ |
 						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3640323AS",	"9FZ134",	ATA_HORKAGE_NONCQ |
+	{ "ST31500341AS",	"SD18",		ATA_HORKAGE_NONCQ |
 						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3320813AS",	"9FZ182",	ATA_HORKAGE_NONCQ |
+	{ "ST31500341AS",	"SD19",		ATA_HORKAGE_NONCQ |
 						ATA_HORKAGE_FIRMWARE_WARN },
-	{ "ST3320613AS",	"9FZ162",	ATA_HORKAGE_NONCQ |
+
+	{ "ST31000333AS",	"SD15",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST31000333AS",	"SD16",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST31000333AS",	"SD17",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST31000333AS",	"SD18",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST31000333AS",	"SD19",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+
+	{ "ST3640623AS",	"SD15",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3640623AS",	"SD16",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3640623AS",	"SD17",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3640623AS",	"SD18",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3640623AS",	"SD19",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+
+	{ "ST3640323AS",	"SD15",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3640323AS",	"SD16",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3640323AS",	"SD17",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3640323AS",	"SD18",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3640323AS",	"SD19",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+
+	{ "ST3320813AS",	"SD15",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3320813AS",	"SD16",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3320813AS",	"SD17",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3320813AS",	"SD18",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3320813AS",	"SD19",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+
+	{ "ST3320613AS",	"SD15",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3320613AS",	"SD16",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3320613AS",	"SD17",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3320613AS",	"SD18",		ATA_HORKAGE_NONCQ |
+						ATA_HORKAGE_FIRMWARE_WARN },
+	{ "ST3320613AS",	"SD19",		ATA_HORKAGE_NONCQ |
 						ATA_HORKAGE_FIRMWARE_WARN },
 
 	/* Blacklist entries taken from Silicon Image 3124/3132
