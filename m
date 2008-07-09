From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ide: disable drive interrupts in ide_driveid_update()
Date: Wed, 9 Jul 2008 20:48:48 +0400
Message-ID: <200807092048.48078.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:3067 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751353AbYGIQso (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jul 2008 12:48:44 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, mcherkashin@ru.mvista.com

From: Mikhail Cherkashin <mcherkashin@ru.mvista.com>

Since ide_driveid_update() uses polling to execute the IDENTIFY DEVICE command
but clears nIEN bit in the control register and doesn't mask the IDE interrupt,
the latter does happen and lead to the corresponding message to appear:

ide0: unexpected interrupt, status=0x58, count=1

when e.g. running hdparm with option -X with a non-PCI IDE driver...

Signed-off-by: Mikhail Cherkashin <mcherkashin@ru.mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
No attempt is made to respect the drive's quirkiness which is probably not
correct but the 'drive->quirk_list' matter is somewhat confusing...

 drivers/ide/ide-iops.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index 0daf923..c2dd20a 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -689,7 +689,7 @@ int ide_driveid_update(ide_drive_t *drive)
 	 */
 
 	SELECT_MASK(drive, 1);
-	ide_set_irq(drive, 1);
+	ide_set_irq(drive, 0);
 	msleep(50);
 	hwif->OUTBSYNC(drive, WIN_IDENTIFY, hwif->io_ports.command_addr);
 	timeout = jiffies + WAIT_WORSTCASE;

