From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/6] SATA: Blacklisting of systems that spin off disks during ACPI power off
Date: Mon, 19 Jan 2009 20:56:43 +0100
Message-ID: <200901192056.44529.rjw@sisk.pl>
References: <20081104062734.GA4420@havoc.gtf.org> <49739371.5030107@garzik.org> <200901192053.50831.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39384 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859AbZASUAx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jan 2009 15:00:53 -0500
In-Reply-To: <200901192053.50831.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Frans Pop <elendil@planet.nl>, tj@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce new libata flags ATA_FLAG_NO_POWEROFF_SPINDOWN and
ATA_FLAG_NO_HIBERNATE_SPINDOWN that, if set, will prevent disks from
being spun off during system power off and hibernation, respectively
(to handle the hibernation case we need the new system state
SYSTEM_HIBERNATE_ENTER that can be checked against by libata, in
analogy with SYSTEM_POWER_OFF).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/ata/libata-scsi.c |   20 +++++++++++++++++---
 include/linux/libata.h    |    2 ++
 2 files changed, 19 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/ata/libata-scsi.c
===================================================================
--- linux-2.6.orig/drivers/ata/libata-scsi.c
+++ linux-2.6/drivers/ata/libata-scsi.c
@@ -46,6 +46,7 @@
 #include <linux/libata.h>
 #include <linux/hdreg.h>
 #include <linux/uaccess.h>
+#include <linux/suspend.h>
 
 #include "libata.h"
 
@@ -1303,6 +1304,17 @@ static unsigned int ata_scsi_start_stop_
 
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
@@ -1326,8 +1338,7 @@ static unsigned int ata_scsi_start_stop_
 				scmd->scsi_done = qc->scsidone;
 				qc->scsidone = ata_delayed_done;
 			}
-			scmd->result = SAM_STAT_GOOD;
-			return 1;
+			goto skip;
 		}
 
 		/* Issue ATA STANDBY IMMEDIATE command */
@@ -1343,10 +1354,13 @@ static unsigned int ata_scsi_start_stop_
 
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
 
 
Index: linux-2.6/include/linux/libata.h
===================================================================
--- linux-2.6.orig/include/linux/libata.h
+++ linux-2.6/include/linux/libata.h
@@ -187,6 +187,8 @@ enum {
 	ATA_FLAG_PIO_POLLING	= (1 << 9), /* use polling PIO if LLD
 					     * doesn't handle PIO interrupts */
 	ATA_FLAG_NCQ		= (1 << 10), /* host supports NCQ */
+	ATA_FLAG_NO_POWEROFF_SPINDOWN = (1 << 11), /* don't spindown before poweroff */
+	ATA_FLAG_NO_HIBERNATE_SPINDOWN = (1 << 12), /* don't spindown before hibernation */
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
 	ATA_FLAG_IGN_SIMPLEX	= (1 << 15), /* ignore SIMPLEX */
 	ATA_FLAG_NO_IORDY	= (1 << 16), /* controller lacks iordy */

