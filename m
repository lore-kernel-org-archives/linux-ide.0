From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: Basics of per controller fixup
Date: Fri, 05 Nov 2004 16:29:33 +0000
Message-ID: <1099672171.5630.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:8901 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261410AbUKERc0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 12:32:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

We add probe_hwif_init_with_fixup (seperate naming as requested by
Bartlomiej). This runs a fixup on present interfaces before attaching
the drives. The existing API is maintained as a call to the new API.

The sometimes troublesome undecoded slave detector is moved to its own
function and exported so that ide-cs and the upcoming delkin_cb can both
use it (along with any arch specific cf/pcmcia drivers I don't know
about).

The non-relevant checks for this scenario (M00000 and ITE RAID) are
removed.

diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.10rc1/drivers/ide/ide-probe.c linux-2.6.10rc1/drivers/ide/ide-probe.c
--- linux.vanilla-2.6.10rc1/drivers/ide/ide-probe.c	2004-11-05 15:42:15.000000000 +0000
+++ linux-2.6.10rc1/drivers/ide/ide-probe.c	2004-11-05 16:26:39.000000000 +0000
@@ -652,6 +652,39 @@
 	return rc;
 }
 
+/**
+ *	ide_undecoded_slave	-	look for bad CF adapters
+ *	@hwif: interface
+ *
+ *	Analyse the drives on the interface and attempt to decide if we
+ *	have the same drive viewed twice. This occurs with crap CF adapters
+ *	and PCMCIA sometimes.
+ */
+
+void ide_undecoded_slave(ide_hwif_t *hwif) 
+{
+	ide_drive_t *drive0 = &hwif->drives[0];
+	ide_drive_t *drive1 = &hwif->drives[1];
+	
+	if (drive0->present == 0 || drive1->present == 0)
+			return;
+		
+	/* If the models don't match they are not the same product */	
+	if (strcmp(drive0->id->model, drive1->id->model))
+		return;
+	/* Serial numbers do not match */
+	if(strncmp(drive0->id->serial_no, drive1->id->serial_no, 20))
+		return;
+	/* No serial number, thankfully very rare for CF */
+	if (drive0->id->serial_no[0] == 0)
+		return;
+	/* Appears to be an IDE flash adapter with decode bugs */
+	printk(KERN_WARNING "ide-probe: ignoring undecoded slave\n");
+	drive1->present = 0;
+}
+
+EXPORT_SYMBOL(ide_undecoded_slave);
+
 /*
  * This routine only knows how to look for drive units 0 and 1
  * on an interface, so any setting of MAX_DRIVES > 2 won't work here.
@@ -723,18 +756,6 @@
 		ide_drive_t *drive = &hwif->drives[unit];
 		drive->dn = (hwif->channel ? 2 : 0) + unit;
 		(void) probe_for_drive(drive);
-		if (drive->present && hwif->present && unit == 1) {
-			if (strcmp(hwif->drives[0].id->model, drive->id->model) == 0 &&
-			    /* Don't do this for noprobe or non ATA */
-			    strcmp(drive->id->model, "UNKNOWN") &&
-			    /* And beware of confused Maxtor drives that go "M0000000000"
-			      "The SN# is garbage in the ID block..." [Eric] */
-			    strncmp(drive->id->serial_no, "M0000000000000000000", 20) &&
-			    strncmp(hwif->drives[0].id->serial_no, drive->id->serial_no, 20) == 0) {
-				printk(KERN_WARNING "ide-probe: ignoring undecoded slave\n");
-				drive->present = 0;
-			}
-		}
 		if (drive->present && !hwif->present) {
 			hwif->present = 1;
 			if (hwif->chipset != ide_4drives ||
@@ -808,13 +829,18 @@
 }
 
 static int hwif_init(ide_hwif_t *hwif);
-int probe_hwif_init (ide_hwif_t *hwif)
+
+int probe_hwif_init_with_fixup(ide_hwif_t *hwif, void (*fixup)(ide_hwif_t *hwif))
 {
 	probe_hwif(hwif);
 	hwif_init(hwif);
 
 	if (hwif->present) {
 		u16 unit = 0;
+
+		if(fixup != NULL)
+			fixup(hwif);
+			
 		for (unit = 0; unit < MAX_DRIVES; ++unit) {
 			ide_drive_t *drive = &hwif->drives[unit];
 			/* For now don't attach absent drives, we may
@@ -828,6 +854,13 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(probe_hwif_init_with_fixup);
+
+int probe_hwif_init(ide_hwif_t *hwif)
+{
+	return probe_hwif_init_with_fixup(hwif, NULL);
+}
+
 EXPORT_SYMBOL(probe_hwif_init);
 
 #if MAX_HWIFS > 1

