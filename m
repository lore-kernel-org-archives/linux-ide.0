From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with SSD
Date: Wed, 21 Oct 2009 14:55:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32328 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753903AbZJUSzZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Oct 2009 14:55:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org

Hi

This patch fixes a data corruption when SSD is connected to Ultra 5.

Mikulas

--

Serialize CMD643 and CMD646 to fix a hardware bug with SSD

CMD646 corrupts data on concurrent transfers on both channels when IDE SSD is
connected to one of the channels.

Setup that demonstrates this hardware bug: Ultra 5, onboard CMD646, rev 3.
/dev/hda is 8GB Seagate ST38410A in MWDMA2
/dev/hdd is 32GB SSD SiliconHardDisk in MWDMA2

- When reading /dev/hdd (for example with dd or fsck), reads from /dev/hda
  are corrupted, there are twiddled single bits 1->0 and some full 32-bit
  words corrupted, sometimes commands fail (which switches /dev/hda to
  PIO mode but the corruptions happen even in PIO).
- Reads from /dev/hdd don't seem to be corrupted (i.e. fsck passes fine).
- When I connected normal rotating harddisk to /dev/hdd, there was no
  corruption, so the corruption is something specific to SSD.
- I tried the same setup on a PCI card with CMD649 and saw no corruption.

This patch serializes the operation for CMD646 and 643 (I didn't test
CMD643 but it may have the same hw bug too because it's earlier design).
CMD649 is good. I don't know anything about CMD 648.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/ide/cmd64x.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6.31-fast/drivers/ide/cmd64x.c
===================================================================
--- linux-2.6.31-fast.orig/drivers/ide/cmd64x.c	2009-10-21 06:08:42.000000000 +0200
+++ linux-2.6.31-fast/drivers/ide/cmd64x.c	2009-10-21 06:09:09.000000000 +0200
@@ -379,7 +379,8 @@ static const struct ide_port_info cmd64x
 		.enablebits	= {{0x00,0x00,0x00}, {0x51,0x08,0x08}},
 		.port_ops	= &cmd64x_port_ops,
 		.host_flags	= IDE_HFLAG_CLEAR_SIMPLEX |
-				  IDE_HFLAG_ABUSE_PREFETCH,
+				  IDE_HFLAG_ABUSE_PREFETCH |
+				  IDE_HFLAG_SERIALIZE,
 		.pio_mask	= ATA_PIO5,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= 0x00, /* no udma */
@@ -389,7 +390,8 @@ static const struct ide_port_info cmd64x
 		.init_chipset	= init_chipset_cmd64x,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.port_ops	= &cmd648_port_ops,
-		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH,
+		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH |
+				  IDE_HFLAG_SERIALIZE,
 		.pio_mask	= ATA_PIO5,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA2,
