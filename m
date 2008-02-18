From: Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl>
Subject: [PATCH ht6560b] Force prefetch for some devices
Date: Mon, 18 Feb 2008 13:50:02 +0100
Message-ID: <47B97EFA.2040805@caiway.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080602080508000001080006"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pelian.kabelfoon.nl ([62.45.45.43]:56461 "EHLO
	pelian.kabelfoon.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbYBRNZG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 08:25:06 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, bzolnier@gmail.com

This is a multi-part message in MIME format.
--------------080602080508000001080006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Prefetch needs to be set for some ide devices to work when connected to
a ht6560b interface. This was not always done properly, causing a system
with a HD and CD on the primary interface to not work properly. Or, in
effect, hang hard.

This patch forces prefetch on devices before checking whether it
is necessary to change the settings in the interface

This patch should also be applied to 2.4. I don't currently have a
2.4 tree around.

(also change my email address)

Signed-off-by: Jan Evert van Grootheest <janevert@caiway.nl>



--------------080602080508000001080006
Content-Type: text/x-patch;
 name="ht65.oldide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ht65.oldide.patch"

--- linux-2.6.git/drivers/ide/legacy/ht6560b.c	2008-02-01 18:50:31.000000000 +0100
+++ linux-2.6.24/drivers/ide/legacy/ht6560b.c	2008-02-18 13:48:59.000000000 +0100
@@ -23,18 +23,21 @@
  *                      "Prefetch" mode bit OFF for ide disks and
  *                      ON for anything else.
  *
+ *  Version 0.08        Need to force prefetch for CDs and other non-disk
+ *                      devices. (not sure which devices exactly need
+ *                      prefetch)
  *
  *  HT-6560B EIDE-controller support
  *  To activate controller support use kernel parameter "ide0=ht6560b".
  *  Use hdparm utility to enable PIO mode support.
  *
  *  Author:    Mikko Ala-Fossi            <maf@iki.fi>
- *             Jan Evert van Grootheest   <janevert@iae.nl>
+ *             Jan Evert van Grootheest   <janevert@caiway.nl>
  *
  *  Try:  http://www.maf.iki.fi/~maf/ht6560b/
  */
 
-#define HT6560B_VERSION "v0.07"
+#define HT6560B_VERSION "v0.08"
 
 #include <linux/module.h>
 #include <linux/types.h>
@@ -132,15 +135,20 @@
 	u8 select, timing;
 	
 	local_irq_save(flags);
-	
+
 	select = HT_CONFIG(drive);
 	timing = HT_TIMING(drive);
-	
+
+	/*
+	 * Need to enforce prefetch sometimes because otherwise
+	 * it'll hang (hard).
+	 */
+	if (drive->media != ide_disk || !drive->present)
+		select |= HT_PREFETCH_MODE;
+
 	if (select != current_select || timing != current_timing) {
 		current_select = select;
 		current_timing = timing;
-		if (drive->media != ide_disk || !drive->present)
-			select |= HT_PREFETCH_MODE;
 		(void)inb(HT_CONFIG_PORT);
 		(void)inb(HT_CONFIG_PORT);
 		(void)inb(HT_CONFIG_PORT);
@@ -190,11 +198,12 @@
 	outb(HT_TIMING_DEFAULT, 0x1f6);  /* IDE_SELECT_REG */
 	(void) inb(0x1f7);               /* IDE_STATUS_REG */
 	
-	printk("\nht6560b " HT6560B_VERSION
+	printk("ht6560b " HT6560B_VERSION
 	       ": chipset detected and initialized"
 #ifdef DEBUG
 	       " with debug enabled"
 #endif
+	       "\n"
 		);
 	return 1;
 }

--------------080602080508000001080006--
