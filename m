From: Randy Dunlap <randy.d.dunlap@intel.com>
Subject: [PATCH] libata docs/DPRINTK fixups
Date: Tue, 3 Jan 2006 10:01:17 -0800
Message-ID: <20060103100117.732326de.randy.d.dunlap@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:9450 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932394AbWACSA1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jan 2006 13:00:27 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Fix some kernel-doc.
Fix typo/spello.
Put some comments in <= 80 columns.
Change one DPRINTK() string to be unique (was a duplicate but should not be).

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 drivers/scsi/libata-core.c |   27 +++++++++++----------------
 1 files changed, 11 insertions(+), 16 deletions(-)

--- linux-2615-work.orig/drivers/scsi/libata-core.c
+++ linux-2615-work/drivers/scsi/libata-core.c
@@ -1323,12 +1323,11 @@ static inline u8 ata_dev_knobble(const s
 }
 
 /**
- * 	ata_dev_config - Run device specific handlers and check for
- * 			 SATA->PATA bridges
- * 	@ap: Bus
- * 	@i:  Device
+ * ata_dev_config - Run device-specific handlers & check for SATA->PATA bridges
+ * @ap: ATA port
+ * @i:  Device index
  *
- * 	LOCKING:
+ * LOCKING:
  */
 
 void ata_dev_config(struct ata_port *ap, unsigned int i)
@@ -1624,9 +1623,9 @@ int ata_timing_compute(struct ata_device
 	ata_timing_quantize(t, t, T, UT);
 
 	/*
-	 * Even in DMA/UDMA modes we still use PIO access for IDENTIFY, S.M.A.R.T
-	 * and some other commands. We have to ensure that the DMA cycle timing is
-	 * slower/equal than the fastest PIO timing.
+	 * Even in DMA/UDMA modes we still use PIO access for IDENTIFY,
+	 * S.M.A.R.T. and some other commands. We have to ensure that the
+	 * DMA cycle timing is slower/equal than the fastest PIO timing.
 	 */
 
 	if (speed > XFER_PIO_4) {
@@ -1635,7 +1634,7 @@ int ata_timing_compute(struct ata_device
 	}
 
 	/*
-	 * Lenghten active & recovery time so that cycle time is correct.
+	 * Lengthen active & recovery time so that cycle time is correct.
 	 */
 
 	if (t->act8b + t->rec8b < t->cyc8b) {
@@ -1803,7 +1802,6 @@ err_out:
  *	or a timeout occurs.
  *
  *	LOCKING: None.
- *
  */
 
 static unsigned int ata_busy_sleep (struct ata_port *ap,
@@ -1897,7 +1895,6 @@ static void ata_bus_post_reset(struct at
  *	LOCKING:
  *	PCI/etc. bus probe sem.
  *	Obtains host_set lock.
- *
  */
 
 static unsigned int ata_bus_edd(struct ata_port *ap)
@@ -2682,7 +2679,6 @@ skip_map:
  *
  *	RETURNS:
  *	Zero on success, negative on error.
- *
  */
 
 static int ata_sg_setup(struct ata_queued_cmd *qc)
@@ -2778,7 +2774,7 @@ void ata_poll_qc_complete(struct ata_que
 }
 
 /**
- *	ata_pio_poll -
+ *	ata_pio_poll - poll using PIO, depending on current state
  *	@ap: the target ata_port
  *
  *	LOCKING:
@@ -2878,7 +2874,7 @@ static int ata_pio_complete (struct ata_
 
 
 /**
- *	swap_buf_le16 - swap halves of 16-words in place
+ *	swap_buf_le16 - swap halves of 16-bit words in place
  *	@buf:  Buffer to swap
  *	@buf_words:  Number of 16-bit words in buffer.
  *
@@ -3062,7 +3058,6 @@ static void ata_pio_sector(struct ata_qu
  *
  *	LOCKING:
  *	Inherited from caller.
- *
  */
 
 static void __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
@@ -4394,7 +4389,7 @@ int ata_device_add(const struct ata_prob
 	}
 
 	/* probes are done, now scan each port's disk(s) */
-	DPRINTK("probe begin\n");
+	DPRINTK("probe-scan begin\n");
 	for (i = 0; i < count; i++) {
 		struct ata_port *ap = host_set->ports[i];
 


---
