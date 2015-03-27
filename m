From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/9] libata: whitespace fixes in ata_to_sense_error()
Date: Fri, 27 Mar 2015 16:46:32 +0100
Message-ID: <1427471198-62676-4-git-send-email-hare@suse.de>
References: <1427471198-62676-1-git-send-email-hare@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427471198-62676-1-git-send-email-hare@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-scsi.c | 61 +++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b061ba2..d2b6196 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -849,40 +849,59 @@ static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
 	/* Based on the 3ware driver translation table */
 	static const unsigned char sense_table[][4] = {
 		/* BBD|ECC|ID|MAR */
-		{0xd1, 		ABORTED_COMMAND, 0x00, 0x00}, 	// Device busy                  Aborted command
+		{0xd1,		ABORTED_COMMAND, 0x00, 0x00},
+			// Device busy                  Aborted command
 		/* BBD|ECC|ID */
-		{0xd0,  	ABORTED_COMMAND, 0x00, 0x00}, 	// Device busy                  Aborted command
+		{0xd0,		ABORTED_COMMAND, 0x00, 0x00},
+			// Device busy                  Aborted command
 		/* ECC|MC|MARK */
-		{0x61, 		HARDWARE_ERROR, 0x00, 0x00}, 	// Device fault                 Hardware error
+		{0x61,		HARDWARE_ERROR, 0x00, 0x00},
+			// Device fault                 Hardware error
 		/* ICRC|ABRT */		/* NB: ICRC & !ABRT is BBD */
-		{0x84, 		ABORTED_COMMAND, 0x47, 0x00}, 	// Data CRC error               SCSI parity error
+		{0x84,		ABORTED_COMMAND, 0x47, 0x00},
+			// Data CRC error               SCSI parity error
 		/* MC|ID|ABRT|TRK0|MARK */
-		{0x37, 		NOT_READY, 0x04, 0x00}, 	// Unit offline                 Not ready
+		{0x37,		NOT_READY, 0x04, 0x00},
+			// Unit offline                 Not ready
 		/* MCR|MARK */
-		{0x09, 		NOT_READY, 0x04, 0x00}, 	// Unrecovered disk error       Not ready
+		{0x09,		NOT_READY, 0x04, 0x00},
+			// Unrecovered disk error       Not ready
 		/*  Bad address mark */
-		{0x01, 		MEDIUM_ERROR, 0x13, 0x00}, 	// Address mark not found       Address mark not found for data field
-		/* TRK0 */
-		{0x02, 		HARDWARE_ERROR, 0x00, 0x00}, 	// Track 0 not found		Hardware error
+		{0x01,		MEDIUM_ERROR, 0x13, 0x00},
+			// Address mark not found for data field
+		/* TRK0 - Track 0 not found */
+		{0x02,		HARDWARE_ERROR, 0x00, 0x00},
+			// Hardware error
 		/* Abort: 0x04 is not translated here, see below */
 		/* Media change request */
-		{0x08, 		NOT_READY, 0x04, 0x00}, 	// Media change request	  FIXME: faking offline
-		/* SRV/IDNF */
-		{0x10, 		ILLEGAL_REQUEST, 0x21, 0x00}, 	// ID not found                 Logical address out of range
-		/* MC */
-		{0x20, 		UNIT_ATTENTION, 0x28, 0x00}, 	// Media Changed		Not ready to ready change, medium may have changed
-		/* ECC */
-		{0x40, 		MEDIUM_ERROR, 0x11, 0x04}, 	// Uncorrectable ECC error      Unrecovered read error
+		{0x08,		NOT_READY, 0x04, 0x00},
+			// FIXME: faking offline
+		/* SRV/IDNF - ID not found */
+		{0x10,		ILLEGAL_REQUEST, 0x21, 0x00},
+			// Logical address out of range
+		/* MC - Media Changed */
+		{0x20,		UNIT_ATTENTION, 0x28, 0x00},
+			// Not ready to ready change, medium may have changed
+		/* ECC - Uncorrectable ECC error */
+		{0x40,		MEDIUM_ERROR, 0x11, 0x04},
+			// Unrecovered read error
 		/* BBD - block marked bad */
-		{0x80, 		MEDIUM_ERROR, 0x11, 0x04}, 	// Block marked bad		Medium error, unrecovered read error
+		{0x80,		MEDIUM_ERROR, 0x11, 0x04},
+			// Block marked bad	Medium error, unrecovered read error
 		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
 	};
 	static const unsigned char stat_table[][4] = {
 		/* Must be first because BUSY means no other bits valid */
-		{0x80, 		ABORTED_COMMAND, 0x47, 0x00},	// Busy, fake parity for now
-		{0x20, 		HARDWARE_ERROR,  0x44, 0x00}, 	// Device fault, internal target failure
-		{0x08, 		ABORTED_COMMAND, 0x47, 0x00},	// Timed out in xfer, fake parity for now
-		{0x04, 		RECOVERED_ERROR, 0x11, 0x00},	// Recovered ECC error	  Medium error, recovered
+		{0x80,		ABORTED_COMMAND, 0x47, 0x00},
+		// Busy, fake parity for now
+		{0x40,		ILLEGAL_REQUEST, 0x21, 0x04},
+		// Device ready, unaligned write command
+		{0x20,		HARDWARE_ERROR,  0x44, 0x00},
+		// Device fault, internal target failure
+		{0x08,		ABORTED_COMMAND, 0x47, 0x00},
+		// Timed out in xfer, fake parity for now
+		{0x04,		RECOVERED_ERROR, 0x11, 0x00},
+		// Recovered ECC error	  Medium error, recovered
 		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
 	};
 
-- 
1.8.5.2
