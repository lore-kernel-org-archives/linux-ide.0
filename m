From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 4/5] pata_hpt{37x|3x2n}: improve timing register documentation
Date: Mon, 7 Dec 2009 23:38:11 +0400
Message-ID: <200912072238.11053.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:37476 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S932195AbZLGTgv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 14:36:51 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Describe UDMA timing bits 18-20 and 21 separately; add a note to bit 31 about
it being meaningful for PIO only.  Reformat the whole comment, while at it...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/pata_hpt37x.c  |   31 +++++++++++++++----------------
 drivers/ata/pata_hpt3x2n.c |   31 +++++++++++++++----------------
 2 files changed, 30 insertions(+), 32 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt37x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt37x.c
+++ linux-2.6/drivers/ata/pata_hpt37x.c
@@ -39,25 +39,24 @@ struct hpt_chip {
 
 /* key for bus clock timings
  * bit
- * 0:3    data_high_time. inactive time of DIOW_/DIOR_ for PIO and MW
- *        DMA. cycles = value + 1
- * 4:8    data_low_time. active time of DIOW_/DIOR_ for PIO and MW
- *        DMA. cycles = value + 1
- * 9:12   cmd_high_time. inactive time of DIOW_/DIOR_ during task file
+ * 0:3    data_high_time. Inactive time of DIOW_/DIOR_ for PIO and MW DMA.
+ *        cycles = value + 1
+ * 4:8    data_low_time. Active time of DIOW_/DIOR_ for PIO and MW DMA.
+ *        cycles = value + 1
+ * 9:12   cmd_high_time. Inactive time of DIOW_/DIOR_ during task file
  *        register access.
- * 13:17  cmd_low_time. active time of DIOW_/DIOR_ during task file
+ * 13:17  cmd_low_time. Active time of DIOW_/DIOR_ during task file
  *        register access.
- * 18:21  udma_cycle_time. clock freq and clock cycles for UDMA xfer.
- *        during task file register access.
- * 22:24  pre_high_time. time to initialize 1st cycle for PIO and MW DMA
- *        xfer.
- * 25:27  cmd_pre_high_time. time to initialize 1st PIO cycle for task
+ * 18:20  udma_cycle_time. Clock cycles for UDMA xfer.
+ * 21     CLK frequency for UDMA: 0=ATA clock, 1=dual ATA clock.
+ * 22:24  pre_high_time. Time to initialize 1st cycle for PIO and MW DMA xfer.
+ * 25:27  cmd_pre_high_time. Time to initialize 1st PIO cycle for task file
  *        register access.
- * 28     UDMA enable
- * 29     DMA enable
- * 30     PIO_MST enable. if set, the chip is in bus master mode during
- *        PIO.
- * 31     FIFO enable.
+ * 28     UDMA enable.
+ * 29     DMA  enable.
+ * 30     PIO_MST enable. If set, the chip is in bus master mode during
+ *        PIO xfer.
+ * 31     FIFO enable. Only for PIO.
  */
 
 static struct hpt_clock hpt37x_timings_33[] = {
Index: linux-2.6/drivers/ata/pata_hpt3x2n.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt3x2n.c
+++ linux-2.6/drivers/ata/pata_hpt3x2n.c
@@ -45,25 +45,24 @@ struct hpt_chip {
 
 /* key for bus clock timings
  * bit
- * 0:3    data_high_time. inactive time of DIOW_/DIOR_ for PIO and MW
- *        DMA. cycles = value + 1
- * 4:8    data_low_time. active time of DIOW_/DIOR_ for PIO and MW
- *        DMA. cycles = value + 1
- * 9:12   cmd_high_time. inactive time of DIOW_/DIOR_ during task file
+ * 0:3    data_high_time. Inactive time of DIOW_/DIOR_ for PIO and MW DMA.
+ *        cycles = value + 1
+ * 4:8    data_low_time. Active time of DIOW_/DIOR_ for PIO and MW DMA.
+ *        cycles = value + 1
+ * 9:12   cmd_high_time. Inactive time of DIOW_/DIOR_ during task file
  *        register access.
- * 13:17  cmd_low_time. active time of DIOW_/DIOR_ during task file
+ * 13:17  cmd_low_time. Active time of DIOW_/DIOR_ during task file
  *        register access.
- * 18:21  udma_cycle_time. clock freq and clock cycles for UDMA xfer.
- *        during task file register access.
- * 22:24  pre_high_time. time to initialize 1st cycle for PIO and MW DMA
- *        xfer.
- * 25:27  cmd_pre_high_time. time to initialize 1st PIO cycle for task
+ * 18:20  udma_cycle_time. Clock cycles for UDMA xfer.
+ * 21     CLK frequency for UDMA: 0=ATA clock, 1=dual ATA clock.
+ * 22:24  pre_high_time. Time to initialize 1st cycle for PIO and MW DMA xfer.
+ * 25:27  cmd_pre_high_time. Time to initialize 1st PIO cycle for task file
  *        register access.
- * 28     UDMA enable
- * 29     DMA enable
- * 30     PIO_MST enable. if set, the chip is in bus master mode during
- *        PIO.
- * 31     FIFO enable.
+ * 28     UDMA enable.
+ * 29     DMA  enable.
+ * 30     PIO_MST enable. If set, the chip is in bus master mode during
+ *        PIO xfer.
+ * 31     FIFO enable. Only for PIO.
  */
 
 /* 66MHz DPLL clocks */

