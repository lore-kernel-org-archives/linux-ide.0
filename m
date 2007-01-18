From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH] ide: Fix ATAPI DMA lost irq problem with CDB intr devices
Date: Thu, 18 Jan 2007 19:19:26 +0800
Message-ID: <45AF57BE.7060505@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:37556 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbXARLTn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jan 2007 06:19:43 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0IBJgYX030077
	for <linux-ide@vger.kernel.org>; Thu, 18 Jan 2007 06:19:42 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0IBJfIm536352
	for <linux-ide@vger.kernel.org>; Thu, 18 Jan 2007 04:19:41 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0IBJfFK020752
	for <linux-ide@vger.kernel.org>; Thu, 18 Jan 2007 04:19:41 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>
Cc: "Adam W. Hawks" <awhawks@us.ibm.com>

Problem: IDE ATAPI DMA lost irq with CDB intr devices on Intel ICHx machines.

This patch clears the INTR and ERROR bits of DMA status before starting BMDMA
to fix the problem.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
ATAPI DMA irq lost when testing Intel ICHx with CDB-intr CD-ROM drives:

Jan 18 18:08:48 p4ht-s kernel: ide-cd: cmd 0x28 timed out
Jan 18 18:08:48 p4ht-s kernel: hdc: DMA interrupt recovery
Jan 18 18:08:48 p4ht-s kernel: hdc: lost interrupt
Jan 18 18:08:48 p4ht-s kernel: hdc: status timeout: status=0xd0 { Busy }
Jan 18 18:08:48 p4ht-s kernel: ide: failed opcode was: unknown
Jan 18 18:08:48 p4ht-s kernel: hdc: DMA disabled
Jan 18 18:08:48 p4ht-s kernel: hdc: drive not ready for command
Jan 18 18:08:48 p4ht-s kernel: hdc: ATAPI reset complete

The problem is reported by Adam Hawks.
It seems the the INTR bit was set to 1 by the CDB-intr before the DMA is started.
ICHx doesn't like it and causes the DMA irq lost later.

The patch is against 2.6.20-rc5. Tested ok on ICH4.
====================================================================

--- ide-dma.ori/drivers/ide/ide-dma.c	2006-11-30 05:57:37.000000000 +0800
+++ ide-dma/drivers/ide/ide-dma.c	2007-01-18 18:40:18.000000000 +0800
@@ -591,6 +591,12 @@ void ide_dma_start(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 dma_cmd		= hwif->INB(hwif->dma_command);
+	u8 dma_stat		= hwif->INB(hwif->dma_status);
+
+	/* The intr bit of dma_status might has been set by the CDB interrupt.
+	 * Clear the INTR & ERROR bits here to prevent DMA irq lost later.
+	 */
+	hwif->OUTB(dma_stat|6, hwif->dma_status);
 
 	/* Note that this is done *after* the cmd has
 	 * been issued to the drive, as per the BM-IDE spec.


