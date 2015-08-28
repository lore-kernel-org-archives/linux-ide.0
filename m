From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.2-rc8
Date: Fri, 28 Aug 2015 10:13:44 -0400
Message-ID: <20150828141344.GK26785@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33154 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbbH1ONq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Aug 2015 10:13:46 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

Simple blacklist entry addition.

Thanks.

The following changes since commit f9114d357858c1429dcde022706db7443918f49f:

  ata: ahci_brcmstb: Fix misuse of IS_ENABLED (2015-08-06 14:30:07 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.2-fixes

for you to fetch changes up to 7a7184b01aa9deb86df661c6f7cbcf69a95b728c:

  Add factory recertified Crucial M500s to blacklist (2015-08-26 11:30:47 -0400)

----------------------------------------------------------------
Guillermo A. Amaral (1):
      Add factory recertified Crucial M500s to blacklist

 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 19bcb80..790e0de 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4230,6 +4230,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Samsung SSD 8*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 
 	/* devices that don't properly handle TRIM commands */
 	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },

-- 
tejun
