From: Alan Cox <alan@redhat.com>
Subject: PATCH: ide probe
Date: Mon, 6 Sep 2004 11:33:04 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040906153304.GA6067@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:27351 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268153AbUIFPdI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Sep 2004 11:33:08 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

This is a revised version of the IDE probe undecoded slave detection patch. It
replaces the one in the -mm tree. It contains just the probe code so none of
the other IDE stuff thats pending Bartlomiej deciding which little bits to
merge first, and stands alone.


--- ../linux.vanilla-2.6.8.1/drivers/ide/ide-probe.c	2004-08-16 17:57:02.000000000 +0100
+++ drivers/ide/ide-probe.c	2004-08-30 14:46:17.000000000 +0100
@@ -749,6 +776,22 @@
 		ide_drive_t *drive = &hwif->drives[unit];
 		drive->dn = (hwif->channel ? 2 : 0) + unit;
 		(void) probe_for_drive(drive);
+		if (drive->present && hwif->present && unit == 1)
+		{
+			if(strcmp(hwif->drives[0].id->model, drive->id->model) == 0 &&
+			   /* Don't do this for noprobe or non ATA */
+			   strcmp(drive->id->model, "UNKNOWN") &&
+			   /* ITE haven't got this figured out either (see the quirk code too) */
+			   !strstr(drive->id->model, "Integrated Technology Express") &&
+			   /* And beware of confused Maxtor drives that go "M0000000000" 
+			      "The SN# is garbage in the ID block..." [Eric] */
+			   strncmp(drive->id->serial_no, "M0000000000000000000", 20) && 
+			   strncmp(hwif->drives[0].id->serial_no, drive->id->serial_no, 20) == 0)
+			{
+				printk(KERN_WARNING "ide-probe: ignoring undecoded slave\n");
+				drive->present = 0;
+			}
+		}
 		if (drive->present && !hwif->present) {
 			hwif->present = 1;
 			if (hwif->chipset != ide_4drives ||
