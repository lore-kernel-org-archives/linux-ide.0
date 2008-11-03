From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/8] SATA: Blacklisting of systems that spin off disks during ACPI power off (rev. 2)
Date: Mon,  3 Nov 2008 19:01:04 +0900
Message-ID: <1225706469-27870-4-git-send-email-tj@kernel.org>
References: <1225706469-27870-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60509 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754755AbYKCKBe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Nov 2008 05:01:34 -0500
In-Reply-To: <1225706469-27870-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Tejun Heo <tj@kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce new libata flags ATA_FLAG_NO_POWEROFF_SPINDOWN and
ATA_FLAG_NO_HIBERNATE_SPINDOWN that, if set, will prevent disks from
being spun off during system power off and hibernation, respectively
(to handle the hibernation case we need the new system state
SYSTEM_HIBERNATE_ENTER that can be checked against by libata, in
analogy with SYSTEM_POWER_OFF).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-scsi.c |   20 +++++++++++++++++---
 include/linux/libata.h    |    2 ++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index bbb30d8..0a0aa95 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -46,6 +46,7 @@
 #include <linux/libata.h>
 #include <linux/hdreg.h>
 #include <linux/uaccess.h>
+#include <linux/suspend.h>
 
 #include "libata.h"
 
@@ -1307,6 +1308,17 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 
 		tf->command = ATA_CMD_VERIFY;	/* READ VERIFY */
 	} else {
+		/* Some odd clown BIOSen issue spindown on power off (ACPI S4
+		 * or S5) causing some drives to spin up and down again.
+		 */
+		if ((qc->ap->flags & ATA_FLAG_NO_POWEROFF_SPINDOWN) &&
+		    system_state == SYSTEM_POWER_OFF)
+			goto skip;
+
+		if ((qc->ap->flags & ATA_FLAG_NO_HIBERNATE_SPINDOWN) &&
+		     system_entering_hibernation())
+			goto skip;
+
 		/* XXX: This is for backward compatibility, will be
 		 * removed.  Read Documentation/feature-removal-schedule.txt
 		 * for more info.
@@ -1330,8 +1342,7 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 				scmd->scsi_done = qc->scsidone;
 				qc->scsidone = ata_delayed_done;
 			}
-			scmd->result = SAM_STAT_GOOD;
-			return 1;
+			goto skip;
 		}
 
 		/* Issue ATA STANDBY IMMEDIATE command */
@@ -1347,10 +1358,13 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 
 	return 0;
 
-invalid_fld:
+ invalid_fld:
 	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x24, 0x0);
 	/* "Invalid field in cbd" */
 	return 1;
+ skip:
+	scmd->result = SAM_STAT_GOOD;
+	return 1;
 }
 
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f5441ed..cc0ceaf 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -187,6 +187,8 @@ enum {
 	ATA_FLAG_PIO_POLLING	= (1 << 9), /* use polling PIO if LLD
 					     * doesn't handle PIO interrupts */
 	ATA_FLAG_NCQ		= (1 << 10), /* host supports NCQ */
+	ATA_FLAG_NO_POWEROFF_SPINDOWN = (1 << 11), /* don't spindown before poweroff */
+	ATA_FLAG_NO_HIBERNATE_SPINDOWN = (1 << 12), /* don't spindown before hibernation */
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
 	ATA_FLAG_IGN_SIMPLEX	= (1 << 15), /* ignore SIMPLEX */
 	ATA_FLAG_NO_IORDY	= (1 << 16), /* controller lacks iordy */
-- 
1.5.4.5

