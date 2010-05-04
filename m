From: timg@tpi.com (Tim Gardner)
Subject: ata: blacklist FUJITSU MHW2160BH PL
Date: Tue,  4 May 2010 10:32:57 -0600 (MDT)
Message-ID: <20100504163257.5DFE5F899A@sepang.rtg.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tpi.com ([70.99.223.143]:4064 "EHLO mail.tpi.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102Ab0EDREr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 May 2010 13:04:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

>From e21186c4fc02cdd1932365d39d1ba7b2e48417f3 Mon Sep 17 00:00:00 2001
From: Chuck Short <zulcss@ubuntu.com>
Date: Fri, 18 Jan 2008 13:21:16 -0500
Subject: [PATCH] ata: blacklist FUJITSU MHW2160BH PL

OriginalAuthor: Chuck Short <zulcss@ubuntu.com>
BugLink: http://bugs.launchpad.net/bugs/175834

Signed-off-by: Chuck Short <zulcss@ubuntu.com>
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>

Signed-off-by: Ben Collins <ben.collins@canonical.com>
---
 drivers/ata/libata-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 49cffb6..3100827 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4369,6 +4369,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_HORKAGE_NONCQ, },
 	{ "HTS541080G9SA00",    "MB4OC60D",     ATA_HORKAGE_NONCQ, },
 	{ "HTS541010G9SA00",    "MBZOC60D",     ATA_HORKAGE_NONCQ, },
+	{ "FUJITSU MHW2160BH PL", "0084001E",   ATA_HORKAGE_NONCQ, },
 
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=15573 */
 	{ "C300-CTFDDAC128MAG",	"0001",		ATA_HORKAGE_NONCQ, },
-- 
1.7.0.4

