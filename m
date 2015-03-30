From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.0-rc6
Date: Mon, 30 Mar 2015 13:23:49 -0400
Message-ID: <20150330172349.GB9974@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36828 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbbC3RXx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Mar 2015 13:23:53 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

Nothing exciting.  Two patches to update queued trim blacklist.

Thanks.

The following changes since commit 5067c0469c643512f24786990e315f9c15cc7d24:

  ata: Add a new flag to destinguish sas controller (2015-03-19 14:14:43 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.0-fixes

for you to fetch changes up to 6fc4d97a4987c5d247655a157a9377996626221a:

  libata: Blacklist queued TRIM on Samsung SSD 850 Pro (2015-03-27 15:22:46 -0400)

----------------------------------------------------------------
Martin K. Petersen (2):
      libata: Update Crucial/Micron blacklist
      libata: Blacklist queued TRIM on Samsung SSD 850 Pro

 drivers/ata/libata-core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ef150eb..23dac3b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4204,9 +4204,18 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
 	/* devices that don't properly handle queued TRIM commands */
-	{ "Micron_M[56]*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+	{ "Micron_M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Crucial_CT*M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Micron_M5[15]0*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Crucial_CT*M550*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Crucial_CT*MX100*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Samsung SSD 850 PRO*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-	{ "Crucial_CT*SSD*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
 
 	/*
 	 * As defined, the DRAT (Deterministic Read After Trim) and RZAT
@@ -4226,6 +4235,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	 */
 	{ "INTEL*SSDSC2MH*",		NULL,	0, },
 
+	{ "Micron*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Crucial*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "INTEL*SSD*", 		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "SSD*INTEL*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Samsung*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
