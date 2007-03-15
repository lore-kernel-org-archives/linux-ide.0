From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/2] ide: don't allow DMA to be enabled if CONFIG_IDEDMA_{ICS,PCI}_AUTO=n
Date: Thu, 15 Mar 2007 21:45:40 +0100
Message-ID: <200703152145.40644.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:17829 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbXCOUiu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 16:38:50 -0400
Received: by ug-out-1314.google.com with SMTP id 44so487107uga
        for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 13:38:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Patrick Horn <phrh@yahoo.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Russell King <rmk+lkml@arm.linux.org.uk>


[PATCH] ide: don't allow DMA to be enabled if CONFIG_IDEDMA_{ICS,PCI}_AUTO=n

For CONFIG_IDEDMA_{ICS,PCI}_AUTO=n and/or "ide=nodma" option the host/device
are not programmed for DMA and it is also explicitly disabled by ide_set_dma()
(->ide_dma_check returns "-1").  However the code responsible for manually
enabling DMA ("hdparm -d 1") has a bug which results in DMA being erroneously
enabled - ide_set_dma() incorrectly passes "0" return value to set_using_dma().
This may work if BIOS/firmware configured the host/device for DMA and chipset
allows independent configuration of DMA/PIO modes but won't work after suspend
and is generally unsafe on many chipsets (possibly including data corruption
if the same registers are used for DMA/PIO timings).

This patch fixes kernel bugzilla bug #8169 (piix host driver fixes for
setting PIO mode exposed the problem described above).  The side-effect of
the fix is that some rare configuration may be forced to PIO mode when DMA
mode was previously used - this is addressed by the next patch which removes
CONFIG_IDEDMA_{PCI,ICS}_AUTO config option completely.

Thanks goes out to Patrick Horn for reporting the issue, narrowing it down
to the specific commit and testing the fix.  Also thanks to Sergei Shtylyov
for help in debugging the problem.

Cc: Patrick Horn <phrh@yahoo.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/ide-dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -767,7 +767,7 @@ int ide_set_dma(ide_drive_t *drive)
 	switch(rc) {
 	case -1: /* DMA needs to be disabled */
 		hwif->dma_off_quietly(drive);
-		return 0;
+		return -1;
 	case  0: /* DMA needs to be enabled */
 		return hwif->ide_dma_on(drive);
 	case  1: /* DMA setting cannot be changed */
