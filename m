From: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>
Subject: [PATCH 1/1] Several fixes for the AVR32 PATA driver
Date: Thu, 29 Nov 2007 12:01:51 +0100
Message-ID: <200711291201.51598.kngregertsen@norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:57808 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758116AbXK2KCu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Nov 2007 05:02:50 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, kngregertsen@norway.atmel.com, gregerts@stud.ntnu.no, Haavard Skinnemoen <hskinnemoen@atmel.com>, kernel@avr32linux.org

Several fixes for the AVR32 PATA driver:

* Updated to use new AVR32 SMC timing API. This removes the need for "magic"
constants in signal timing.

* Removed the ATA_FLAG_PIO_POLLING, the driver should use interrupts.

* Removed .port_disable and .irq_ack as these are no longer needed.

* Improved some comments.

Signed-off-by: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>
---
diff --git a/drivers/ata/pata_at32.c b/drivers/ata/pata_at32.c
index bb250a4..67e574d 100644
--- a/drivers/ata/pata_at32.c
+++ b/drivers/ata/pata_at32.c
@@ -28,7 +28,7 @@
 #include <asm/arch/smc.h>
 
 #define DRV_NAME "pata_at32"
-#define DRV_VERSION "0.0.2"
+#define DRV_VERSION "0.0.3"
 
 /*
  * CompactFlash controller memory layout relative to the base address:
@@ -64,6 +64,8 @@
  *	Mode 2	| 8.3	| 240 ns	 | 0x07
  *	Mode 3	| 11.1	| 180 ns	 | 0x0f
  *	Mode 4	| 16.7	| 120 ns	 | 0x1f
+ *
+ * Alter PIO_MASK below according to table to set maximal PIO mode.
  */
 #define PIO_MASK (0x1f)
 
@@ -85,36 +87,40 @@ struct at32_ide_info {
  */
 static int pata_at32_setup_timing(struct device *dev,
 				  struct at32_ide_info *info,
-				  const struct ata_timing *timing)
+				  const struct ata_timing *ata)
 {
-	/* These two values are found through testing */
-	const int min_recover = 25;
-	const int ncs_hold    = 15;
-
 	struct smc_config *smc = &info->smc;
+	struct smc_timing timing;
 
 	int active;
 	int recover;
 
+	memset(&timing, 0, sizeof(struct smc_timing));
+
 	/* Total cycle time */
-	smc->read_cycle	= timing->cyc8b;
+	timing.read_cycle  = ata->cyc8b;
 
 	/* DIOR <= CFIOR timings */
-	smc->nrd_setup = timing->setup;
-	smc->nrd_pulse = timing->act8b;
+	timing.nrd_setup   = ata->setup;
+	timing.nrd_pulse   = ata->act8b;
+	timing.nrd_recover = ata->rec8b;
+
+	/* Convert nanosecond timing to clock cycles */
+	smc_set_timing(smc, &timing);
 
-	/* Compute recover, extend total cycle if needed */
-	active	= smc->nrd_setup + smc->nrd_pulse;
+	/* Add one extra cycle setup due to signal ring */
+	smc->nrd_setup = smc->nrd_setup + 1;
+
+	active  = smc->nrd_setup + smc->nrd_pulse;
 	recover = smc->read_cycle - active;
 
-	if (recover < min_recover) {
-		smc->read_cycle = active + min_recover;
-		recover = min_recover;
-	}
+	/* Need at least two cycles recovery */
+	if (recover < 2)
+	  smc->read_cycle = active + 2;
 
 	/* (CS0, CS1, DIR, OE) <= (CFCE1, CFCE2, CFRNW, NCSX) timings */
-	smc->ncs_read_setup  = 0;
-	smc->ncs_read_pulse  = active + ncs_hold;
+	smc->ncs_read_setup = 1;
+	smc->ncs_read_pulse = smc->read_cycle - 2;
 
 	/* Write timings same as read timings */
 	smc->write_cycle = smc->read_cycle;
@@ -123,11 +129,13 @@ static int pata_at32_setup_timing(struct device *dev,
 	smc->ncs_write_setup = smc->ncs_read_setup;
 	smc->ncs_write_pulse = smc->ncs_read_pulse;
 
-	/* Do some debugging output */
-	dev_dbg(dev, "SMC: C=%d S=%d P=%d R=%d NCSS=%d NCSP=%d NCSR=%d\n",
+	/* Do some debugging output of ATA and SMC timings */
+	dev_dbg(dev, "ATA: C=%d S=%d P=%d R=%d\n",
+		ata->cyc8b, ata->setup, ata->act8b, ata->rec8b);
+
+	dev_dbg(dev, "SMC: C=%d S=%d P=%d NS=%d NP=%d\n",
 		smc->read_cycle, smc->nrd_setup, smc->nrd_pulse,
-		recover, smc->ncs_read_setup, smc->ncs_read_pulse,
-		smc->read_cycle - smc->ncs_read_pulse);
+		smc->ncs_read_setup, smc->ncs_read_pulse);
 
 	/* Finally, configure the SMC */
 	return smc_set_configuration(info->cs, smc);
@@ -182,7 +190,6 @@ static struct scsi_host_template at32_sht = {
 };
 
 static struct ata_port_operations at32_port_ops = {
-	.port_disable		= ata_port_disable,
 	.set_piomode		= pata_at32_set_piomode,
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
@@ -203,7 +210,6 @@ static struct ata_port_operations at32_port_ops = {
 
 	.irq_clear		= pata_at32_irq_clear,
 	.irq_on			= ata_irq_on,
-	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_sff_port_start,
 };
@@ -223,8 +229,7 @@ static int __init pata_at32_init_one(struct device *dev,
 	/* Setup ATA bindings */
 	ap->ops	     = &at32_port_ops;
 	ap->pio_mask = PIO_MASK;
-	ap->flags    = ATA_FLAG_MMIO | ATA_FLAG_SLAVE_POSS
-		| ATA_FLAG_PIO_POLLING;
+	ap->flags   |= ATA_FLAG_MMIO | ATA_FLAG_SLAVE_POSS;
 
 	/*
 	 * Since all 8-bit taskfile transfers has to go on the lower
@@ -357,12 +362,12 @@ static int __init pata_at32_probe(struct platform_device *pdev)
 	info->smc.tdf_mode	 = 0; /* TDF optimization disabled */
 	info->smc.tdf_cycles	 = 0; /* No TDF wait cycles */
 
-	/* Setup ATA timing */
+	/* Setup SMC to ATA timing */
 	ret = pata_at32_setup_timing(dev, info, &initial_timing);
 	if (ret)
 		goto err_setup_timing;
 
-	/* Setup ATA addresses */
+	/* Map ATA address space */
 	ret = -ENOMEM;
 	info->ide_addr = devm_ioremap(dev, info->res_ide.start, 16);
 	info->alt_addr = devm_ioremap(dev, info->res_alt.start, 16);
@@ -373,7 +378,7 @@ static int __init pata_at32_probe(struct platform_device *pdev)
 	pata_at32_debug_bus(dev, info);
 #endif
 
-	/* Register ATA device */
+	/* Setup and register ATA device */
 	ret = pata_at32_init_one(dev, info);
 	if (ret)
 		goto err_ata_device;
