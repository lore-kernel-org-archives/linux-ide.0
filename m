From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.15-rc8
Date: Fri, 19 Jan 2018 09:15:40 -0800
Message-ID: <20180119171540.GD3460072@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44471 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932152AbeASRPo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Jan 2018 12:15:44 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

This just adds one more entry for liteon optical drives to the device
blacklist for large IOs.  The change is very low risk.

Thanks.

The following changes since commit 2dc0b46b5ea30f169b0b272253ea846a5a281731:

  libata: sata_down_spd_limit should return if driver has not recorded sstatus speed (2017-12-04 13:57:03 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.15-fixes

for you to fetch changes up to db5ff909798ef0099004ad50a0ff5fde92426fd1:

  libata: apply MAX_SEC_1024 to all LITEON EP1 series devices (2017-12-19 05:30:38 -0800)

----------------------------------------------------------------
Xinyu Lin (1):
      libata: apply MAX_SEC_1024 to all LITEON EP1 series devices

 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8193b38..3c09122 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4449,6 +4449,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=121671
 	 */
 	{ "LITEON CX1-JB*-HP",	NULL,		ATA_HORKAGE_MAX_SEC_1024 },
+	{ "LITEON EP1-*",	NULL,		ATA_HORKAGE_MAX_SEC_1024 },
 
 	/* Devices we expect to fail diagnostics */

-- 
tejun
