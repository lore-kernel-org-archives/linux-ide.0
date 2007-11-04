From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/18] ide: don't BUG() on unsupported transfer modes
Date: Mon, 5 Nov 2007 00:29:19 +0100
Message-ID: <200711050029.20029.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:53675 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288AbXKDX3o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:44 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219918nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:43 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Fix ide-cris, cs5530, sc1200 and sis5513 host drivers to just return instead
of OOPS-ing for unsupported modes in ->set_dma_mode methods.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cris/ide-cris.c |    3 +--
 drivers/ide/pci/cs5530.c    |    3 +--
 drivers/ide/pci/sc1200.c    |    3 +--
 drivers/ide/pci/sis5513.c   |    1 -
 4 files changed, 3 insertions(+), 7 deletions(-)

Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -748,8 +748,7 @@ static void cris_set_dma_mode(ide_drive_
 			hold = ATA_DMA2_HOLD;
 			break;
 		default:
-			BUG();
-			break;
+			return;
 	}
 
 	if (speed >= XFER_UDMA_0)
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -117,8 +117,7 @@ static void cs5530_set_dma_mode(ide_driv
 		case XFER_MW_DMA_1:	timings = 0x00012121; break;
 		case XFER_MW_DMA_2:	timings = 0x00002020; break;
 		default:
-			BUG();
-			break;
+			return;
 	}
 	basereg = CS5530_BASEREG(drive->hwif);
 	reg = inl(basereg + 4);			/* get drive0 config register */
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -186,8 +186,7 @@ static void sc1200_set_dma_mode(ide_driv
 			}
 			break;
 		default:
-			BUG();
-			break;
+			return;
 	}
 
 	if (unit == 0) {			/* are we configuring drive0? */
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -368,7 +368,6 @@ static void sis_set_dma_mode(ide_drive_t
 			sis_program_timings(drive, speed);
 			break;
 		default:
-			BUG();
 			break;
 	}
 }
