From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/6] ide-h8300: add ->{in,out}put_data methods
Date: Sun, 30 Mar 2008 21:43:13 +0200
Message-ID: <200803302143.13428.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754947AbYC3Tbu@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/h8300/ide-h8300.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: b/drivers/ide/h8300/ide-h8300.c
===================================================================
--- a/drivers/ide/h8300/ide-h8300.c
+++ b/drivers/ide/h8300/ide-h8300.c
@@ -56,6 +56,16 @@ static void mm_insw(unsigned long addr, 
 		*bp = bswap(*(volatile u16 *)addr);
 }
 
+static void h8300_input_data(ide_drive_t *drive, void *buf, unsigned int len)
+{
+	mm_insw(drive->hwif->io_ports.data_addr, buf, (len + 1) / 2);
+}
+
+static void h8300_output_data(ide_drive_t *drive, void *buf, unsigned int len)
+{
+	mm_outsw(drive->hwif->io_ports.data_addr, buf, (len + 1) / 2);
+}
+
 #define H8300_IDE_GAP (2)
 
 static inline void hw_setup(hw_regs_t *hw)
@@ -74,6 +84,9 @@ static inline void hwif_setup(ide_hwif_t
 {
 	default_hwif_iops(hwif);
 
+	hwif->input_data  = h8300_input_data;
+	hwif->output_data = h8300_output_data;
+
 	hwif->OUTW  = mm_outw;
 	hwif->OUTSW = mm_outsw;
 	hwif->INW   = mm_inw;
