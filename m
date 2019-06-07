From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: [PATCH] drivers/ata: print trim features at device initialization
Date: Fri, 07 Jun 2019 10:34:39 +0300
Message-ID: <155989287898.1506.14253954112551051148.stgit@buzz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
List-Id: linux-ide@vger.kernel.org

Print trim status once at ata device initialization in form:

ataX.YZ: trim: <supported|blacklisted>, queued: <no|yes|blacklisted>, zero_after_trim: <no|yes|maybe>

Full example:

  ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
  ata1.00: NCQ Send/Recv Log not supported
  ata1.00: ATA-9: SAMSUNG MZ7GE900HMHP-000DX, EXT03Y3Q, max UDMA/133
  ata1.00: 1758174768 sectors, multi 16: LBA48 NCQ (depth 32), AA
  ata1.00: trim: supported, queued: no, zero_after_trim: maybe
  ata1.00: NCQ Send/Recv Log not supported
  ata1.00: configured for UDMA/133
  scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG MZ7GE900 3Y3Q PQ: 0 ANSI: 5
  sd 0:0:0:0: [sda] 1758174768 512-byte logical blocks: (900 GB/838 GiB)
  sd 0:0:0:0: Attached scsi generic sg0 type 0
  sd 0:0:0:0: [sda] Write Protect is off
  sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
  sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
   sda: sda1 sda2
  sd 0:0:0:0: [sda] Attached SCSI disk

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/ata/libata-core.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index aaa57e0c809d..6ff33e79cfc2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2617,6 +2617,34 @@ int ata_dev_configure(struct ata_device *dev)
 			}
 		}
 
+		if (print_info && ata_id_has_trim(id)) {
+			const char *trim_status;
+			const char *trim_queued;
+			const char *trim_zero;
+
+			if (dev->horkage & ATA_HORKAGE_NOTRIM)
+				trim_status = "backlisted";
+			else
+				trim_status = "supported";
+
+			if (!ata_fpdma_dsm_supported(dev))
+				trim_queued = "no";
+			else if (dev->horkage & ATA_HORKAGE_NO_NCQ_TRIM)
+				trim_queued = "backlisted";
+			else
+				trim_queued = "yes";
+
+			if (!ata_id_has_zero_after_trim(id))
+				trim_zero = "no";
+			else if (dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM)
+				trim_zero = "yes";
+			else
+				trim_zero = "maybe";
+
+			ata_dev_info(dev, "trim: %s, queued: %s, zero_after_trim: %s\n",
+				     trim_status, trim_queued, trim_zero);
+		}
+
 		/* Check and mark DevSlp capability. Get DevSlp timing variables
 		 * from SATA Settings page of Identify Device Data Log.
 		 */
