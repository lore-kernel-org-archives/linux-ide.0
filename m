From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.0-rc3
Date: Mon, 9 Mar 2015 08:00:58 -0400
Message-ID: <20150309120058.GR13283@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:39230 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbbCIMBC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Mar 2015 08:01:02 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

Speed limiting fix for sata_fsl.

Thanks.

The following changes since commit a38ecbbd0be025a6ecbbfd22d2575a5b46317117:

  Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2015-03-01 12:22:44 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.0-fixes

for you to fetch changes up to 29200f12a1167076346415e18eee9065cb77a859:

  sata-fsl: Apply link speed limits (2015-03-02 12:08:43 -0500)

----------------------------------------------------------------
Martin Hicks (1):
      sata-fsl: Apply link speed limits

 drivers/ata/sata_fsl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index f9054cd..5389579 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -869,6 +869,8 @@ try_offline_again:
 	 */
 	ata_msleep(ap, 1);
 
+	sata_set_spd(link);
+
 	/*
 	 * Now, bring the host controller online again, this can take time
 	 * as PHY reset and communication establishment, 1st D2H FIS and
