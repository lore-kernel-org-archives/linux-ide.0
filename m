From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ide: mark expected switch fall-throughs
Date: Tue, 3 Jul 2018 14:23:05 -0500
Message-ID: <20180703192305.GA3413@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-ide@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/ide/hpt366.c       | 5 +++--
 drivers/ide/ide-floppy.c   | 1 +
 drivers/ide/ide-probe.c    | 1 +
 drivers/ide/ide-taskfile.c | 3 ++-
 drivers/ide/sis5513.c      | 1 +
 5 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index e52c58c..4d565b0 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -574,13 +574,14 @@ static u8 hpt3xx_udma_filter(ide_drive_t *drive)
 		if (!HPT370_ALLOW_ATA100_5 ||
 		    check_in_drive_list(drive, bad_ata100_5))
 			return ATA_UDMA4;
+		/* else: fall through */
 	case HPT372 :
 	case HPT372A:
 	case HPT372N:
 	case HPT374 :
 		if (ata_id_is_sata(drive->id))
 			mask &= ~0x0e;
-		/* Fall thru */
+		/* fall through */
 	default:
 		return mask;
 	}
@@ -600,7 +601,7 @@ static u8 hpt3xx_mdma_filter(ide_drive_t *drive)
 	case HPT374 :
 		if (ata_id_is_sata(drive->id))
 			return 0x00;
-		/* Fall thru */
+		/* else: fall through */
 	default:
 		return 0x07;
 	}
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 5bd2aaf..a8df300 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -427,6 +427,7 @@ static int ide_floppy_get_capacity(ide_drive_t *drive)
 				 * (maintains previous driver behaviour)
 				 */
 				break;
+			/* else: fall through */
 		case CAPACITY_CURRENT:
 			/* Normal Zip/LS-120 disks */
 			if (memcmp(cap_desc, &floppy->cap_desc, 8))
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 416a2f3..3b75a7b 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -142,6 +142,7 @@ static void ide_classify_atapi_dev(ide_drive_t *drive)
 		}
 		/* Early cdrom models used zero */
 		type = ide_cdrom;
+		/* fall through */
 	case ide_cdrom:
 		drive->dev_flags |= IDE_DFLAG_REMOVABLE;
 #ifdef CONFIG_PPC
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index 89b2902..c21d5c5 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -128,7 +128,7 @@ ide_startstop_t do_rw_taskfile(ide_drive_t *drive, struct ide_cmd *orig_cmd)
 			return pre_task_out_intr(drive, cmd);
 		}
 		handler = task_pio_intr;
-		/* fall-through */
+		/* fall through */
 	case ATA_PROT_NODATA:
 		if (handler == NULL)
 			handler = task_no_data_intr;
@@ -140,6 +140,7 @@ ide_startstop_t do_rw_taskfile(ide_drive_t *drive, struct ide_cmd *orig_cmd)
 		hwif->expiry = dma_ops->dma_timer_expiry;
 		ide_execute_command(drive, cmd, ide_dma_intr, 2 * WAIT_CMD);
 		dma_ops->dma_start(drive);
+		/* fall through */
 	default:
 		return ide_started;
 	}
diff --git a/drivers/ide/sis5513.c b/drivers/ide/sis5513.c
index c3062b5..024bc7b 100644
--- a/drivers/ide/sis5513.c
+++ b/drivers/ide/sis5513.c
@@ -494,6 +494,7 @@ static int init_chipset_sis5513(struct pci_dev *dev)
 		pci_read_config_byte(dev, 0x09, &reg);
 		if ((reg & 0x0f) != 0x00)
 			pci_write_config_byte(dev, 0x09, reg&0xf0);
+		/* fall through */
 	case ATA_16:
 		/* force per drive recovery and active timings
 		   needed on ATA_33 and below chips */
-- 
2.7.4
