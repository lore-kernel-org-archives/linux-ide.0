From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/15] ide: move wait_hwif_ready() documentation in the right place
Date: Fri, 04 Jan 2008 22:24:39 +0100
Message-ID: <20080104212439.6978.95269.sendpatchset@localhost.localdomain>
References: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:37216 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbYADVNC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 16:13:02 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2833655ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 13:13:02 -0800 (PST)
In-Reply-To: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Move wait_hwif_ready() documentation before this function.

* Fix trailing whitespaces.

* s/wait-for-busy/wait-for-non-busy/

* Remove no longer valid comment about the current code behavior.

* Docbook-ize it.

* Rename wait_hwif_ready() to ide_port_wait_ready().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   49 +++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -634,7 +634,33 @@ static void hwif_register (ide_hwif_t *h
 			__FUNCTION__, ret);
 }
 
-static int wait_hwif_ready(ide_hwif_t *hwif)
+/**
+ *	ide_port_wait_ready	-	wait for port to become ready
+ *	@hwif: IDE port
+ *
+ *	This is needed on some PPCs and a bunch of BIOS-less embedded
+ *	platforms.  Typical cases are:
+ *
+ *	- The firmware hard reset the disk before booting the kernel,
+ *	  the drive is still doing it's poweron-reset sequence, that
+ *	  can take up to 30 seconds.
+ *
+ *	- The firmware does nothing (or no firmware), the device is
+ *	  still in POST state (same as above actually).
+ *
+ *	- Some CD/DVD/Writer combo drives tend to drive the bus during
+ *	  their reset sequence even when they are non-selected slave
+ *	  devices, thus preventing discovery of the main HD.
+ *
+ *	Doing this wait-for-non-busy should not harm any existing
+ *	configuration and fix some issues like the above.
+ *
+ *	BenH.
+ *
+ *	Returns 0 on success, error code (< 0) otherwise.
+ */
+
+static int ide_port_wait_ready(ide_hwif_t *hwif)
 {
 	int unit, rc;
 
@@ -742,26 +768,7 @@ static void probe_hwif(ide_hwif_t *hwif)
 
 	local_irq_set(flags);
 
-	/* This is needed on some PPCs and a bunch of BIOS-less embedded
-	 * platforms. Typical cases are:
-	 * 
-	 *  - The firmware hard reset the disk before booting the kernel,
-	 *    the drive is still doing it's poweron-reset sequence, that
-	 *    can take up to 30 seconds
-	 *  - The firmware does nothing (or no firmware), the device is
-	 *    still in POST state (same as above actually).
-	 *  - Some CD/DVD/Writer combo drives tend to drive the bus during
-	 *    their reset sequence even when they are non-selected slave
-	 *    devices, thus preventing discovery of the main HD
-	 *    
-	 *  Doing this wait-for-busy should not harm any existing configuration
-	 *  (at least things won't be worse than what current code does, that
-	 *  is blindly go & talk to the drive) and fix some issues like the
-	 *  above.
-	 *  
-	 *  BenH.
-	 */
-	if (wait_hwif_ready(hwif) == -EBUSY)
+	if (ide_port_wait_ready(hwif) == -EBUSY)
 		printk(KERN_DEBUG "%s: Wait for ready failed before probe !\n", hwif->name);
 
 	/*
