From: Prarit Bhargava <prarit@sgi.com>
Subject: [PATCH]: Suppress output of error messages for non-existant interfaces
Date: Wed, 12 Jan 2005 09:04:52 -0500
Message-ID: <41E52E84.9040609@sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090700030804090308050200"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:20455 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261190AbVALOFH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Jan 2005 09:05:07 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j0CE56Fe028705
	for <linux-ide@vger.kernel.org>; Wed, 12 Jan 2005 09:05:07 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j0CE51r28561
	for <linux-ide@vger.kernel.org>; Wed, 12 Jan 2005 09:05:01 -0500
Received: from [172.16.80.158] (prarit.boston.redhat.com [172.16.80.158])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j0CE4xQd026955
	for <linux-ide@vger.kernel.org>; Wed, 12 Jan 2005 09:04:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090700030804090308050200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Suppress output of "Wait for ready failed before probe !" messages for 
non-existant interfaces.

Please see 
http://marc.theaimsgroup.com/?l=linux-ide&m=110553792013649&w=2 for 
further context on this patch.



--------------090700030804090308050200
Content-Type: text/plain;
 name="ide-probe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-probe.patch"

--- linux-2.5.orig/drivers/ide/ide-probe.c	2005-01-12 09:00:49.000000000 -0500
+++ linux-2.5/drivers/ide/ide-probe.c	2005-01-12 09:01:25.000000000 -0500
@@ -742,21 +742,21 @@
 	 *    their reset sequence even when they are non-selected slave
 	 *    devices, thus preventing discovery of the main HD
 	 *    
 	 *  Doing this wait-for-busy should not harm any existing configuration
 	 *  (at least things won't be worse than what current code does, that
 	 *  is blindly go & talk to the drive) and fix some issues like the
 	 *  above.
 	 *  
 	 *  BenH.
 	 */
-	if (wait_hwif_ready(hwif))
+	if (wait_hwif_ready(hwif) == -EBUSY)
 		printk(KERN_DEBUG "%s: Wait for ready failed before probe !\n", hwif->name);
 
 	/*
 	 * Second drive should only exist if first drive was found,
 	 * but a lot of cdrom drives are configured as single slaves.
 	 */
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
 		drive->dn = (hwif->channel ? 2 : 0) + unit;
 		(void) probe_for_drive(drive);

--------------090700030804090308050200--
