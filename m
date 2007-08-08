From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-core: Document some limits/assumptions about ID_ATA
Date: Wed, 8 Aug 2007 14:27:00 +0100
Message-ID: <20070808142700.0ca41ceb@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53505 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753190AbXHHNT3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 09:19:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/drivers/ata/libata-core.c linux-2.6.23rc1-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.23rc1-mm1/drivers/ata/libata-core.c	2007-07-26 15:02:57.000000000 +0100
+++ linux-2.6.23rc1-mm1/drivers/ata/libata-core.c	2007-08-08 13:38:39.257549616 +0100
@@ -1614,6 +1622,9 @@
  *	devices.  This function also issues ATA_CMD_INIT_DEV_PARAMS
  *	for pre-ATA4 drives.
  *
+ *	FIXME: ATA_CMD_ID_ATA is optional for early drives and right
+ *	now we abort if we hit that case. 
+ *
  *	LOCKING:
  *	Kernel thread context (may sleep)
  *
@@ -1741,10 +1752,13 @@
 		/*
 		 * The exact sequence expected by certain pre-ATA4 drives is:
 		 * SRST RESET
-		 * IDENTIFY
-		 * INITIALIZE DEVICE PARAMETERS
+		 * IDENTIFY (optional in early ATA)
+		 * INITIALIZE DEVICE PARAMETERS (later IDE and ATA)
 		 * anything else..
 		 * Some drives were very specific about that exact sequence.
+		 *
+		 * Note that ATA4 says lba is mandatory so the second check
+		 * shoud never trigger.
 		 */
 		if (ata_id_major_version(id) < 4 || !ata_id_has_lba(id)) {
 			err_mask = ata_dev_init_params(dev, id[3], id[6]);
