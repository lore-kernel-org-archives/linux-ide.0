From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: revert "ide: fix drive side 80c cable check, take 2" for now
Date: Tue, 20 Mar 2007 21:54:13 +0100
Message-ID: <200703202154.13211.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:52867 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbXCTUqp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Mar 2007 16:46:45 -0400
Received: by ug-out-1314.google.com with SMTP id 44so7921uga
        for <linux-ide@vger.kernel.org>; Tue, 20 Mar 2007 13:46:44 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

[PATCH] ide: revert "ide: fix drive side 80c cable check, take 2" for now

"ide: fix drive side 80c cable check, take 2" patch from Tejun Heo (commit
fab59375b9543f84d1714f7dd00f5d11e531bd3e) fixed 80c bit test (bit13 of word93)
but we also need to fix master/slave IDENTIFY order (slave device should be
probed first in order to make it release PDIAG- signal) and we should also
check for pre-ATA3 slave devices (which may not release PDIAG- signal).

[ Unfortunately the fact that IDE driver doesn't reset devices itself helps
  only a bit as it seems that some BIOS-es reset ATA devices after programming
  the chipset, some BIOS-es can be set to not probe/configure selected devices,
  there may be no BIOS in case of add-on cards etc. ]

Since we are quite late in the release cycle and the required changes will
affect a lot of systems just revert the fix for now.

[ Please also see libata commit f31f0cc2f0b7527072d94d02da332d9bb8d7d94c. ]

Thanks goes out to Fernando Mitio Yamada for reporting the problem
and patiently testing patches.

Cc: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/ide-iops.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -583,8 +583,12 @@ u8 eighty_ninty_three (ide_drive_t *driv
 	if(!(drive->id->hw_config & 0x4000))
 		return 0;
 #endif /* CONFIG_IDEDMA_IVB */
-	if (!(drive->id->hw_config & 0x2000))
-		return 0;
+	/*
+	 * FIXME:
+	 * - change master/slave IDENTIFY order
+	 * - force bit13 (80c cable present) check
+	 *   (unless the slave device is pre-ATA3)
+	 */
 	return 1;
 }
 
