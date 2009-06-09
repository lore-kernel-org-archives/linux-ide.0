From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Subject: Re: [PATCH next] ide: fix PowerMac bootup oops
Date: Tue, 9 Jun 2009 14:02:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0906091357490.21803@sister.anvils>
References: <Pine.LNX.4.64.0906082137120.22183@sister.anvils>
 <200906082328.02729.bzolnier@gmail.com> <Pine.LNX.4.64.0906091237290.14065@sister.anvils>
 <200906091436.19710.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mk-filter-4-a-1.mail.uk.tiscali.com ([212.74.100.55]:8203 "EHLO
	mk-filter-4-a-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758244AbZFINNG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Jun 2009 09:13:06 -0400
In-Reply-To: <200906091436.19710.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Hugh Dickins <hugh.dickins@tiscali.co.uk>, Joao Ramos <joao.ramos@inov.pt>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, 9 Jun 2009, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 09 June 2009 13:44:25 Hugh Dickins wrote:
> > 
> > But memset id in probe_for_drive() when it might be being reused -
> > or would it be better to memset it wherever it used to be kfreed?
> 
> Please memset() it in ide_port_init_devices_data() -- this function
> is called before IDE device structure is going to be (re-)used.

That makes sense too, thanks, here we go...


[PATCH next] ide: fix PowerMac bootup oops

PowerMac bootup with CONFIG_IDE=y oopses in ide_pio_cycle_time():
because "ide: try to use PIO Mode 0 during probe if possible" causes
pmac_ide_set_pio_mode() to be called before drive->id has been set.

Bart points out other places which now need drive->id set earlier,
so follow his advice to allocate it in ide_port_alloc_devices()
(using kzalloc_node, without error message, as when allocating drive)
and memset it for reuse in ide_port_init_devices_data().

Fixed in passing: ide_host_alloc() was missing ide_port_free_devices()
from an error path.

Signed-off-by: Hugh Dickins <hugh.dickins@tiscali.co.uk>
---

 drivers/ide/ide-probe.c |   47 ++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

--- lnext/drivers/ide/ide-probe.c	2009-06-03 11:45:13.000000000 +0100
+++ linux/drivers/ide/ide-probe.c	2009-06-09 13:50:03.000000000 +0100
@@ -465,23 +465,8 @@ static u8 probe_for_drive(ide_drive_t *d
 	int rc;
 	u8 cmd;
 
-	/*
-	 *	In order to keep things simple we have an id
-	 *	block for all drives at all times. If the device
-	 *	is pre ATA or refuses ATA/ATAPI identify we
-	 *	will add faked data to this.
-	 *
-	 *	Also note that 0 everywhere means "can't do X"
-	 */
- 
 	drive->dev_flags &= ~IDE_DFLAG_ID_READ;
 
-	drive->id = kzalloc(SECTOR_SIZE, GFP_KERNEL);
-	if (drive->id == NULL) {
-		printk(KERN_ERR "ide: out of memory for id data.\n");
-		return 0;
-	}
-
 	m = (char *)&drive->id[ATA_ID_PROD];
 	strcpy(m, "UNKNOWN");
 
@@ -497,7 +482,7 @@ static u8 probe_for_drive(ide_drive_t *d
 		}
 
 		if ((drive->dev_flags & IDE_DFLAG_PRESENT) == 0)
-			goto out_free;
+			return 0;
 
 		/* identification failed? */
 		if ((drive->dev_flags & IDE_DFLAG_ID_READ) == 0) {
@@ -521,7 +506,7 @@ static u8 probe_for_drive(ide_drive_t *d
 	}
 
 	if ((drive->dev_flags & IDE_DFLAG_PRESENT) == 0)
-		goto out_free;
+		return 0;
 
 	/* The drive wasn't being helpful. Add generic info only */
 	if ((drive->dev_flags & IDE_DFLAG_ID_READ) == 0) {
@@ -535,9 +520,6 @@ static u8 probe_for_drive(ide_drive_t *d
 	}
 
 	return 1;
-out_free:
-	kfree(drive->id);
-	return 0;
 }
 
 static void hwif_release_dev(struct device *dev)
@@ -817,8 +799,6 @@ static int ide_port_setup_devices(ide_hw
 		if (ide_init_queue(drive)) {
 			printk(KERN_ERR "ide: failed to init %s\n",
 					drive->name);
-			kfree(drive->id);
-			drive->id = NULL;
 			drive->dev_flags &= ~IDE_DFLAG_PRESENT;
 			continue;
 		}
@@ -947,9 +927,6 @@ static void drive_release_dev (struct de
 	blk_cleanup_queue(drive->queue);
 	drive->queue = NULL;
 
-	kfree(drive->id);
-	drive->id = NULL;
-
 	drive->dev_flags &= ~IDE_DFLAG_PRESENT;
 
 	complete(&drive->gendev_rel_comp);
@@ -1132,8 +1109,11 @@ static void ide_port_init_devices_data(i
 
 	ide_port_for_each_dev(i, drive, hwif) {
 		u8 j = (hwif->index * MAX_DRIVES) + i;
+		u16 *saved_id = drive->id;
 
 		memset(drive, 0, sizeof(*drive));
+		memset(saved_id, 0, SECTOR_SIZE);
+		drive->id = saved_id;
 
 		drive->media			= ide_disk;
 		drive->select			= (i << 4) | ATA_DEVICE_OBS;
@@ -1240,8 +1220,10 @@ static void ide_port_free_devices(ide_hw
 	ide_drive_t *drive;
 	int i;
 
-	ide_port_for_each_dev(i, drive, hwif)
+	ide_port_for_each_dev(i, drive, hwif) {
+		kfree(drive->id);
 		kfree(drive);
+	}
 }
 
 static int ide_port_alloc_devices(ide_hwif_t *hwif, int node)
@@ -1255,6 +1237,18 @@ static int ide_port_alloc_devices(ide_hw
 		if (drive == NULL)
 			goto out_nomem;
 
+		/*
+		 * In order to keep things simple we have an id
+		 * block for all drives at all times. If the device
+		 * is pre ATA or refuses ATA/ATAPI identify we
+		 * will add faked data to this.
+		 *
+		 * Also note that 0 everywhere means "can't do X"
+		 */
+		drive->id = kzalloc_node(SECTOR_SIZE, GFP_KERNEL, node);
+		if (drive->id == NULL)
+			goto out_nomem;
+
 		hwif->devices[i] = drive;
 	}
 	return 0;
@@ -1296,6 +1290,7 @@ struct ide_host *ide_host_alloc(const st
 		if (idx < 0) {
 			printk(KERN_ERR "%s: no free slot for interface\n",
 					d ? d->name : "ide");
+			ide_port_free_devices(hwif);
 			kfree(hwif);
 			continue;
 		}
