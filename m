From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: Re: ST340823A disk size issue
Date: Fri, 3 Aug 2007 02:11:00 +0300
Message-ID: <20070802231100.GA1861@nalle>
References: <20070801092903.GA1199@nalle> <20070802200357.GA1178@nalle> <20070802214246.63a54fe6@the-village.bc.nu> <200708030034.13193.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:55697 "EHLO
	gw02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757177AbXHBXLG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 19:11:06 -0400
Content-Disposition: inline
In-Reply-To: <200708030034.13193.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Fri, Aug 03, 2007 at 12:34:13AM +0200, Bartlomiej Zolnierkiewicz wrote:
> Mikko, please verify that the following patch fixes the issue.

A few oopses later and this actually works with vanilla 2.6.22.1 and Debian
2.6.18 (2.6.18.dfsg.1-12etch2), latter without EXPORT_SYMBOL_GPL since
it's there already.

diff -X linux-2.6.22.1/Documentation/dontdiff -upr linux-2.6.22.1.orig/drivers/ide/ide-disk.c linux-2.6.22.1/drivers/ide/ide-disk.c
--- linux-2.6.22.1.orig/drivers/ide/ide-disk.c	2007-07-10 21:56:30.000000000 +0300
+++ linux-2.6.22.1/drivers/ide/ide-disk.c	2007-08-03 00:22:46.000000000 +0300
@@ -481,6 +481,15 @@ static inline int idedisk_supports_lba48
 	       && id->lba_capacity_2;
 }
 
+/*
+ * Some disks report total number of sectors instead of
+ * maximum sector address.  We list them here.
+ */
+static const struct drive_list_entry hpa_list[] = {
+	{ "ST340823A",	"ALL" },
+	{ NULL       ,  NULL  }
+};
+
 static void idedisk_check_hpa(ide_drive_t *drive)
 {
 	unsigned long long capacity, set_max;
@@ -492,6 +501,15 @@ static void idedisk_check_hpa(ide_drive_
 	else
 		set_max = idedisk_read_native_max_address(drive);
 
+	if (ide_in_drive_list(drive->id, hpa_list)) {
+		/*
+		 * Since we are inclusive wrt to firmware revisions do this
+		 * extra check and apply the workaround only when needed.
+		 */
+		if (set_max == capacity + 1)
+			set_max--;
+	}
+
 	if (set_max <= capacity)
 		return;
 
diff -X linux-2.6.22.1/Documentation/dontdiff -upr linux-2.6.22.1.orig/drivers/ide/ide-dma.c linux-2.6.22.1/drivers/ide/ide-dma.c
--- linux-2.6.22.1.orig/drivers/ide/ide-dma.c	2007-07-10 21:56:30.000000000 +0300
+++ linux-2.6.22.1/drivers/ide/ide-dma.c	2007-08-03 01:10:25.000000000 +0300
@@ -152,6 +152,7 @@ int ide_in_drive_list(struct hd_driveid 
 			return 1;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ide_in_drive_list);
 
 /**
  *	ide_dma_intr	-	IDE DMA interrupt handler
