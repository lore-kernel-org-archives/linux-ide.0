From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [patch 4/4] kill ide_driver_t->pre_reset
Date: Sun, 16 Jan 2005 02:14:31 +0100 (CET)
Message-ID: <Pine.GSO.4.58.0501160214030.29887@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:37521 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262378AbVAPBVD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Jan 2005 20:21:03 -0500
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:35840 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S198804AbVAPBPi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Jan 2005 02:15:38 +0100
Received: from higgs.elka.pw.edu.pl ([194.29.160.5])
 by localhost (hadron [194.29.160.13]) (amavisd-new, port 251) with ESMTP
 id 12366-01-9 for <linux-ide@vger.kernel.org>;
 Sun, 16 Jan 2005 02:15:36 +0100 (CET)
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:33140 "EHLO
	mion.elka.pw.edu.pl") by higgs.elka.pw.edu.pl with ESMTP
	id S198664AbVAPBOc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Jan 2005 02:14:32 +0100
Received: (from localhost user: 'bzolnier', uid#10472) by mion.elka.pw.edu.pl
	with ESMTP id S366819AbVAPBOc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Jan 2005 02:14:32 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Add ide_drive_t->post_reset flag and use it to signal post reset
condition to the ide-tape driver (only user of ide_driver_t->pre_reset).

diff -Nru a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
--- a/drivers/ide/ide-iops.c	2005-01-15 14:17:55 +01:00
+++ b/drivers/ide/ide-iops.c	2005-01-15 14:17:55 +01:00
@@ -1132,7 +1132,7 @@
 	if (drive->media == ide_disk)
 		ide_disk_pre_reset(drive);
 	else
-		drive->driver->pre_reset(drive);
+		drive->post_reset = 1;

 	if (!drive->keep_settings) {
 		if (drive->using_dma) {
diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	2005-01-15 14:17:55 +01:00
+++ b/drivers/ide/ide-tape.c	2005-01-15 14:17:55 +01:00
@@ -2428,6 +2428,11 @@
 	if (!drive->dsc_overlap && !(rq->cmd[0] & REQ_IDETAPE_PC2))
 		set_bit(IDETAPE_IGNORE_DSC, &tape->flags);

+	if (drive->post_reset == 1) {
+		set_bit(IDETAPE_IGNORE_DSC, &tape->flags);
+		drive->post_reset = 0;
+	}
+
 	if (tape->tape_still_time > 100 && tape->tape_still_time < 200)
 		tape->measure_insert_time = 1;
 	if (time_after(jiffies, tape->insert_time))
@@ -3558,16 +3563,6 @@
 }

 /*
- *	idetape_pre_reset is called before an ATAPI/ATA software reset.
- */
-static void idetape_pre_reset (ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	if (tape != NULL)
-		set_bit(IDETAPE_IGNORE_DSC, &tape->flags);
-}
-
-/*
  *	idetape_space_over_filemarks is now a bit more complicated than just
  *	passing the command to the tape since we may have crossed some
  *	filemarks during our pipelined read-ahead mode.
@@ -4690,7 +4685,6 @@
 	.cleanup		= idetape_cleanup,
 	.do_request		= idetape_do_request,
 	.end_request		= idetape_end_request,
-	.pre_reset		= idetape_pre_reset,
 	.proc			= idetape_proc,
 	.attach			= idetape_attach,
 	.drives			= LIST_HEAD_INIT(idetape_driver.drives),
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-01-15 14:17:55 +01:00
+++ b/drivers/ide/ide.c	2005-01-15 14:17:55 +01:00
@@ -2037,10 +2037,6 @@
 	return __ide_error(drive, rq, stat, err);
 }

-static void default_pre_reset (ide_drive_t *drive)
-{
-}
-
 static sector_t default_capacity (ide_drive_t *drive)
 {
 	return 0x7fffffff;
@@ -2059,7 +2055,6 @@
 	if (d->end_request == NULL)	d->end_request = default_end_request;
 	if (d->error == NULL)		d->error = default_error;
 	if (d->abort == NULL)		d->abort = default_abort;
-	if (d->pre_reset == NULL)	d->pre_reset = default_pre_reset;
 	if (d->capacity == NULL)	d->capacity = default_capacity;
 }

diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2005-01-15 14:17:55 +01:00
+++ b/include/linux/ide.h	2005-01-15 14:17:55 +01:00
@@ -721,6 +721,7 @@
 					 *  3=64-bit
 					 */
 	unsigned scsi		: 1;	/* 0=default, 1=ide-scsi emulation */
+	unsigned post_reset	: 1;

         u8	quirk_list;	/* considered quirky, set for a specific host */
         u8	init_speed;	/* transfer rate set at boot */
@@ -1099,7 +1100,6 @@
 	ide_startstop_t	(*error)(ide_drive_t *, struct request *rq, u8, u8);
 	ide_startstop_t	(*abort)(ide_drive_t *, struct request *rq);
 	int		(*ioctl)(ide_drive_t *, struct inode *, struct file *, unsigned int, unsigned long);
-	void		(*pre_reset)(ide_drive_t *);
 	sector_t	(*capacity)(ide_drive_t *);
 	ide_proc_entry_t	*proc;
 	int		(*attach)(ide_drive_t *);
