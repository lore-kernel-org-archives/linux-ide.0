From: Alan Cox <alan@redhat.com>
Subject: PATCH: identify non decoded master/slave by serial and model
Date: Sun, 15 Aug 2004 10:50:05 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040815145005.GA8565@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:31706 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266739AbUHOOu5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Aug 2004 10:50:57 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

Some interfaces (notably PCMCIA ones) don't decode the master/slave select so
you get two copies of a device appearing and bad things happening if a user
accidentally uses both. 

This checks for the model/serial matching but also knows about non ATA drives
ide=noprobe and a Maxtor problem that was found in Andrew's testing of an
earlier patch. Although M00000.. drives should be RMA'd to Maxtor (and with
info on where they were obtained...) we don't want to break anyone who has
them.


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/ide-probe.c linux-2.6.8-rc3/drivers/ide/ide-probe.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide-probe.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide-probe.c	2004-08-14 21:03:03.000000000 +0100
@@ -749,6 +790,20 @@
 		ide_drive_t *drive = &hwif->drives[unit];
 		drive->dn = (hwif->channel ? 2 : 0) + unit;
 		(void) probe_for_drive(drive);
+		if (drive->present && hwif->present && unit == 1)
+		{
+			if(strcmp(hwif->drives[0].id->model, drive->id->model) == 0 &&
+			   /* Don't do this for noprobe or non ATA */
+			   strcmp(drive->id->model, "UNKNOWN") &&
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

Signed-off-by: Alan Cox <alan@redhat.com>

