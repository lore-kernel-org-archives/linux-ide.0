From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 02/64] pata_ali: documentation fixes
Date: Mon, 18 Jan 2010 18:14:05 +0100
Message-ID: <20100118171405.14623.95544.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:8245 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab0ARRPQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:15:16 -0500
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_ali: documentation fixes

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_ali.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: b/drivers/ata/pata_ali.c
===================================================================
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -159,8 +159,7 @@ static void ali_fifo_control(struct ata_
  *	ali_program_modes	-	load mode registers
  *	@ap: ALi channel to load
  *	@adev: Device the timing is for
- *	@cmd: Command timing
- *	@data: Data timing
+ *	@t: timing data
  *	@ultra: UDMA timing or zero for off
  *
  *	Loads the timing registers for cmd/data and disable UDMA if
@@ -202,8 +201,7 @@ static void ali_program_modes(struct ata
  *	@ap: ATA interface
  *	@adev: ATA device
  *
- *	Program the ALi registers for PIO mode. FIXME: add timings for
- *	PIO5.
+ *	Program the ALi registers for PIO mode.
  */
 
 static void ali_set_piomode(struct ata_port *ap, struct ata_device *adev)
@@ -237,7 +235,7 @@ static void ali_set_piomode(struct ata_p
  *	@ap: ATA interface
  *	@adev: ATA device
  *
- *	FIXME: MWDMA timings
+ *	Program the ALi registers for DMA mode.
  */
 
 static void ali_set_dmamode(struct ata_port *ap, struct ata_device *adev)
