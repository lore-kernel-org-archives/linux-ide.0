From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH] ST340823A, HPA and libata
Date: Sun, 5 Aug 2007 22:06:16 +0300
Message-ID: <20070805190616.GA1932@nalle>
References: <20070801092903.GA1199@nalle> <200708030034.13193.bzolnier@gmail.com> <20070802231100.GA1861@nalle> <200708030135.16910.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:55724 "EHLO
	gw03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760366AbXHETGX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Aug 2007 15:06:23 -0400
Content-Disposition: inline
In-Reply-To: <200708030135.16910.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello again,

Had some time to play with libata and this ST340823A drive. I had some
problems with 2.6.23-rc2 setup failing at early boot so I kept on
going with 2.6.22.1.

First, vanilla 2.6.22.1 which works as HPA is not disabled by default:

http://bugzilla.kernel.org/attachment.cgi?id=12251&action=view

$ egrep "Host Prote|current size|native size|sdb" dmesg_ide_bug_26221_pata.txt
ata2.01: Host Protected Area detected:
        current size: 78165360 sectors
        native size: 78165361 sectors
ata2.01: Host Protected Area detected:
        current size: 78165360 sectors
        native size: 78165361 sectors
sd 1:0:1:0: [sdb] 78165360 512-byte hardware sectors (40021 MB)
sd 1:0:1:0: [sdb] Write Protect is off
sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:0:1:0: [sdb] 78165360 512-byte hardware sectors (40021 MB)
sd 1:0:1:0: [sdb] Write Protect is off
sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdb: sdb1 sdb2 sdb3
sd 1:0:1:0: [sdb] Attached SCSI disk

Then I went to disabled HPA by default. Actually the
drive and filesystem work altough boot looks nasty:

http://bugzilla.kernel.org/attachment.cgi?id=12252&action=view 

$ egrep "Host Prote|current size|native size|sdb" 
dmesg_ide_bug_26221_pata_hpa.txt
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
sd 1:0:1:0: [sdb] 78165361 512-byte hardware sectors (40021 MB)
sd 1:0:1:0: [sdb] Write Protect is off
sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:1:0: [sdb] 78165361 512-byte hardware sectors (40021 MB)
sd 1:0:1:0: [sdb] Write Protect is off
sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2 sdb3
sd 1:0:1:0: [sdb] Attached SCSI disk
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
sd 1:0:1:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 1:0:1:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
sd 1:0:1:0: [sdb] Add. Sense: Recorded entity not found
end_request: I/O error, dev sdb, sector 78165360
Buffer I/O error on device sdb, logical block 78165360
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
sd 1:0:1:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 1:0:1:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
sd 1:0:1:0: [sdb] Add. Sense: Recorded entity not found
end_request: I/O error, dev sdb, sector 78165360
Buffer I/O error on device sdb, logical block 78165360
sd 1:0:1:0: [sdb] 78165361 512-byte hardware sectors (40021 MB)
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
sd 1:0:1:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 1:0:1:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
sd 1:0:1:0: [sdb] Add. Sense: Recorded entity not found
end_request: I/O error, dev sdb, sector 78165360
Buffer I/O error on device sdb, logical block 78165360
sd 1:0:1:0: [sdb] Write Protect is off
sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
sd 1:0:1:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 1:0:1:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
sd 1:0:1:0: [sdb] Add. Sense: Recorded entity not found
end_request: I/O error, dev sdb, sector 78165360
Buffer I/O error on device sdb, logical block 78165360
sd 1:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:1:0: [sdb] 78165361 512-byte hardware sectors (40021 MB)
sd 1:0:1:0: [sdb] Write Protect is off
sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
sd 1:0:1:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 1:0:1:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
sd 1:0:1:0: [sdb] Add. Sense: Recorded entity not found
end_request: I/O error, dev sdb, sector 78165360
Buffer I/O error on device sdb, logical block 78165360
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
sd 1:0:1:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 1:0:1:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
sd 1:0:1:0: [sdb] Add. Sense: Recorded entity not found
end_request: I/O error, dev sdb, sector 78165360
Buffer I/O error on device sdb, logical block 78165360
sd 1:0:1:0: [sdb] 78165361 512-byte hardware sectors (40021 MB)
sd 1:0:1:0: [sdb] Write Protect is off
sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:1:0: [sdb] 78165361 512-byte hardware sectors (40021 MB)
sd 1:0:1:0: [sdb] Write Protect is off
sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
sd 1:0:1:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 1:0:1:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
sd 1:0:1:0: [sdb] Add. Sense: Recorded entity not found
end_request: I/O error, dev sdb, sector 78165360
Buffer I/O error on device sdb, logical block 78165360
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
sd 1:0:1:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 1:0:1:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
sd 1:0:1:0: [sdb] Add. Sense: Recorded entity not found
end_request: I/O error, dev sdb, sector 78165360
Buffer I/O error on device sdb, logical block 78165360
sd 1:0:1:0: [sdb] 78165361 512-byte hardware sectors (40021 MB)
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
sd 1:0:1:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 1:0:1:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
sd 1:0:1:0: [sdb] Add. Sense: Recorded entity not found
end_request: I/O error, dev sdb, sector 78165360
Buffer I/O error on device sdb, logical block 78165360
sd 1:0:1:0: [sdb] Write Protect is off
sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
sd 1:0:1:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 1:0:1:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
sd 1:0:1:0: [sdb] Add. Sense: Recorded entity not found
end_request: I/O error, dev sdb, sector 78165360
Buffer I/O error on device sdb, logical block 78165360
sd 1:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:1:0: [sdb] 78165361 512-byte hardware sectors (40021 MB)
sd 1:0:1:0: [sdb] Write Protect is off
sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
sd 1:0:1:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 1:0:1:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
sd 1:0:1:0: [sdb] Add. Sense: Recorded entity not found
end_request: I/O error, dev sdb, sector 78165360
Buffer I/O error on device sdb, logical block 78165360
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
ata2.01: Host Protected Area detected:
	current size: 78165360 sectors
	native size: 78165361 sectors
ata2.01: native size increased to 78165361 sectors
sd 1:0:1:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 1:0:1:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
sd 1:0:1:0: [sdb] Add. Sense: Recorded entity not found
end_request: I/O error, dev sdb, sector 78165360
sd 1:0:1:0: [sdb] 78165361 512-byte hardware sectors (40021 MB)
sd 1:0:1:0: [sdb] Write Protect is off
sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:1:0: [sdb] 78165361 512-byte hardware sectors (40021 MB)
sd 1:0:1:0: [sdb] Write Protect is off
sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

Tried to hack a blacklist, which gives the log:

http://bugzilla.kernel.org/attachment.cgi?id=12254&action=view 

$ egrep "Host Prote|current size|native size|sdb"
dmesg_ide_bug_26221_pata_hpa_fix.txt
ata2.01: Host Protected Area detected:
        current size: 78165360 sectors
        native size: 78165361 sectors
ata2.01: Host Protected Area detected:
        current size: 78165360 sectors
        native size: 78165361 sectors
sd 1:0:1:0: [sdb] 78165360 512-byte hardware sectors (40021 MB)
sd 1:0:1:0: [sdb] Write Protect is off
sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:0:1:0: [sdb] 78165360 512-byte hardware sectors (40021 MB)
sd 1:0:1:0: [sdb] Write Protect is off
sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdb: sdb1 sdb2 sdb3
sd 1:0:1:0: [sdb] Attached SCSI disk

The patch is simply:

diff -X linux-2.6.22.1/Documentation/exception.txt -rup linux-2.6.22.1.orig/drivers/ata/libata-core.c linux-2.6.22.1/drivers/ata/libata-core.c
--- linux-2.6.22.1.orig/drivers/ata/libata-core.c	2007-07-10 21:56:30.000000000 +0300
+++ linux-2.6.22.1/drivers/ata/libata-core.c	2007-08-05 11:38:29.000000000 +0300
@@ -991,7 +991,10 @@ static u64 ata_hpa_resize(struct ata_dev
 			"\tnative size: %lld sectors\n",
 			(long long)sectors, (long long)hpa_sectors);
 
-		if (ata_ignore_hpa) {
+		if (ata_device_blacklisted(dev) & ATA_HORKAGE_HPA) {
+			ata_dev_printk(dev, KERN_INFO,
+				"Device blacklisted, ignoring HPA.\n");
+		} else if (ata_ignore_hpa) {
 			if (ata_id_has_lba48(dev->id))
 				hpa_sectors = ata_set_native_max_address_ext(dev, hpa_sectors);
 			else
@@ -3803,6 +3806,10 @@ static const struct ata_blacklist_entry 
 
 	/* Devices with NCQ limits */
 
+	/* Devices which fail when HPA is disable, e.g. READ_NATIVE_MAX_ADDRESS
+	   returns maximum size instead of maximum addressable sector. */
+	{ "ST340823A",	NULL,	ATA_HORKAGE_HPA },
+
 	/* End Marker */
 	{ }
 };
diff -X linux-2.6.22.1/Documentation/exception.txt -rup linux-2.6.22.1.orig/include/linux/libata.h linux-2.6.22.1/include/linux/libata.h
--- linux-2.6.22.1.orig/include/linux/libata.h	2007-07-10 21:56:30.000000000 +0300
+++ linux-2.6.22.1/include/linux/libata.h	2007-08-05 00:43:59.000000000 +0300
@@ -298,6 +298,7 @@ enum {
 	ATA_HORKAGE_NODMA	= (1 << 1),	/* DMA problems */
 	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
 	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
+	ATA_HORKAGE_HPA         = (1 << 4),     /* Don't disable HPA */
 };
 
 enum hsm_task_states {
