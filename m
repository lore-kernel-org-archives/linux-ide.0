From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] remove dead ATAPI multi-lun support (used for ide-scsi)
Date: Fri, 20 Feb 2004 22:47:02 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200402202247.02345.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28371 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261415AbUBTVk4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Feb 2004 16:40:56 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Willem Riede <wrlk@riede.org>
Cc: linux-ide@vger.kernel.org


Hi,

Not a big issue but maybe you know something more...

Cheers.


[IDE] remove dead ATAPI multi-lun support (used for ide-scsi)

ChangeSet@1.889.69.2 03-01-23 14:51:03-05:00  adam@yggdrasil.com
|  The following changes to ide-scsi.c are a recovery of the
| changes that I had in ide-scsi.c in the stock kernel's before
| Martin Dalecki's IDE tree was reverted and a few other changes.
...

broke it.

Before this change drive->id->last_id & 0x7 was used as shost->max_lun
and "hdXlun=" kernel parameter could be used to override it.

It was needed probably only for some rare ATAPI PD-CD drives
(http://www.geocrawler.com/archives/3/58/1999/11/50/2877161/).

However it was far from optimal:
- people played with "hdXlun=" and then complained about multiple instances
  of the same device (most ATAPI drives respond to each LUN)
- probably some devices return 7 not 0 in id->last_id (=> 7 x same device)

This patch cleans things up, multi-lun will be fixed if needed in ide-scsi.
I think that this may work but can't verify it:

	if (id->last_lun && id->last_lun != 7)
		shost->max_lun = id->last_lun + 1;
	else
		shost->max_lun = 1;

 linux-2.6.3-root/Documentation/ide.txt   |    2 --
 linux-2.6.3-root/drivers/ide/ide-probe.c |    3 ---
 linux-2.6.3-root/drivers/ide/ide.c       |   17 +----------------
 linux-2.6.3-root/drivers/scsi/ide-scsi.c |    5 +++++
 linux-2.6.3-root/include/linux/ide.h     |    2 --
 5 files changed, 6 insertions(+), 23 deletions(-)

diff -puN Documentation/ide.txt~ide_hdxlun Documentation/ide.txt
--- linux-2.6.3/Documentation/ide.txt~ide_hdxlun	2004-02-20 19:12:53.000000000 +0100
+++ linux-2.6.3-root/Documentation/ide.txt	2004-02-20 19:13:27.000000000 +0100
@@ -250,8 +250,6 @@ Summary of ide driver parameters for ker
  "hdx=scsi"		: the return of the ide-scsi flag, this is useful for
  			  allowing ide-floppy, ide-tape, and ide-cdrom|writers
  			  to use ide-scsi emulation on a device specific option.
-				
- "hdxlun=xx"		: set the drive last logical unit
 
  "idebus=xx"		: inform IDE driver of VESA/PCI bus speed in MHz,
 			  where "xx" is between 20 and 66 inclusive,
diff -puN drivers/ide/ide.c~ide_hdxlun drivers/ide/ide.c
--- linux-2.6.3/drivers/ide/ide.c~ide_hdxlun	2004-02-20 19:13:01.000000000 +0100
+++ linux-2.6.3-root/drivers/ide/ide.c	2004-02-20 19:15:17.000000000 +0100
@@ -1803,9 +1803,7 @@ int __init ide_setup (char *s)
 	if (strncmp(s,"hd",2) == 0 && s[2] == '=')	/* hd= is for hd.c   */
 		return 0;				/* driver and not us */
 
-	if (strncmp(s,"ide",3) &&
-	    strncmp(s,"idebus",6) &&
-	    strncmp(s,"hd",2))		/* hdx= & hdxlun= */
+	if (strncmp(s,"ide",3) && strncmp(s,"idebus",6) && strncmp(s,"hd",2))
 		return 0;
 
 	printk(KERN_INFO "ide_setup: %s", s);
@@ -1852,19 +1850,6 @@ int __init ide_setup (char *s)
 			strlcpy(drive->driver_req, s + 4, sizeof(drive->driver_req));
 			goto done;
 		}
-		/*
-		 * Look for last lun option:  "hdxlun="
-		 */
-		if (s[3] == 'l' && s[4] == 'u' && s[5] == 'n') {
-			if (match_parm(&s[6], NULL, vals, 1) != 1)
-				goto bad_option;
-			if (vals[0] >= 0 && vals[0] <= 7) {
-				drive->last_lun = vals[0];
-				drive->forced_lun = 1;
-			} else
-				printk(" -- BAD LAST LUN! Expected value from 0 to 7");
-			goto done;
-		}
 		switch (match_parm(&s[3], hd_words, vals, 3)) {
 			case -1: /* "none" */
 			case -2: /* "noprobe" */
diff -puN drivers/ide/ide-probe.c~ide_hdxlun drivers/ide/ide-probe.c
--- linux-2.6.3/drivers/ide/ide-probe.c~ide_hdxlun	2004-02-20 19:17:22.000000000 +0100
+++ linux-2.6.3-root/drivers/ide/ide-probe.c	2004-02-20 19:17:44.000000000 +0100
@@ -137,9 +137,6 @@ static inline void do_identify (ide_driv
 	local_irq_enable();
 	ide_fix_driveid(id);
 
-	if (!drive->forced_lun)
-		drive->last_lun = id->last_lun & 0x7;
-
 #if defined (CONFIG_SCSI_EATA_DMA) || defined (CONFIG_SCSI_EATA_PIO) || defined (CONFIG_SCSI_EATA)
 	/*
 	 * EATA SCSI controllers do a hardware ATA emulation:
diff -puN drivers/scsi/ide-scsi.c~ide_hdxlun drivers/scsi/ide-scsi.c
--- linux-2.6.3/drivers/scsi/ide-scsi.c~ide_hdxlun	2004-02-20 19:19:16.091124320 +0100
+++ linux-2.6.3-root/drivers/scsi/ide-scsi.c	2004-02-20 22:04:16.001109240 +0100
@@ -967,6 +967,11 @@ static int idescsi_attach(ide_drive_t *d
 		return 1;
 
 	host->max_id = 1;
+	/* FIXME: multi-lun support */
+#if 0
+	printk(KERN_DEBUG "%s: id->last_lun=%u\n", drive->name,
+						   drive->id->last_lun & 0x7);
+#endif
 	host->max_lun = 1;
 	drive->driver_data = host;
 	idescsi = scsihost_to_idescsi(host);
diff -puN include/linux/ide.h~ide_hdxlun include/linux/ide.h
--- linux-2.6.3/include/linux/ide.h~ide_hdxlun	2004-02-20 19:25:05.000000000 +0100
+++ linux-2.6.3-root/include/linux/ide.h	2004-02-20 19:25:43.000000000 +0100
@@ -761,8 +761,6 @@ typedef struct ide_drive_s {
 
 	u64		capacity64;	/* total number of sectors */
 
-	int		last_lun;	/* last logical unit */
-	int		forced_lun;	/* if hdxlun was given at boot */
 	int		lun;		/* logical unit */
 	int		crc_count;	/* crc counter to reduce drive speed */
 	struct list_head list;

_

