From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.7-rc7
Date: Thu, 21 Jul 2016 13:36:31 -0400
Message-ID: <20160721173631.GC23759@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33200 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbcGURgf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jul 2016 13:36:35 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

Another fallout from max_sectors bump a couple years ago.  The lite-on
optical drive times out on large requests.

Thanks.

The following changes since commit 76bf3441ad6584ddc3aea1501927f21b21ba3a3a:

  ata: sata_mv: fix mis-conversion in mv_write_cached_reg() (2016-06-17 12:15:17 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.7-fixes

for you to fetch changes up to 1488a1e3828d60d74c9b802a05e24c0487babe4e:

  libata: LITE-ON CX1-JB256-HP needs lower max_sectors (2016-07-18 18:40:00 -0400)

----------------------------------------------------------------
Tejun Heo (1):
      libata: LITE-ON CX1-JB256-HP needs lower max_sectors

 drivers/ata/libata-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6be7770..31c183a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4314,6 +4314,12 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	 */
 	{ "ST380013AS",		"3.20",		ATA_HORKAGE_MAX_SEC_1024 },
 
+	/*
+	 * Device times out with higher max sects.
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=121671
+	 */
+	{ "LITEON CX1-JB256-HP", NULL,		ATA_HORKAGE_MAX_SEC_1024 },
+
 	/* Devices we expect to fail diagnostics */
 
 	/* Devices where NCQ should be avoided */
