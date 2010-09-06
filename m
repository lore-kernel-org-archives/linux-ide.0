From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream 1/3] libata: add @ap to ata_wait_register() and
 introduce ata_msleep()
Date: Mon, 06 Sep 2010 17:56:29 +0200
Message-ID: <4C850F2D.4030601@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58152 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999Ab0IFP4v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Sep 2010 11:56:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, yuanding02@gmail.com

Add optional @ap argument to ata_wait_register() and replace msleep()
calls with ata_msleep() which take optional @ap in addition to the
duration.  These will be used to implement EH exclusion.

This patch doesn't cause any behavior difference.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
These three patches fix the long-standing EH exclusion bug which was
reported more than three years ago and recently caused obscure
problems during parallel probing for ata_piix w/ SIDPR.

It basically implements EH big lock which guarantees that only single
EH of a host is running.  This achieves proper EH exclusion without
pervasive changes to each driver which would be fragile while not
harming parallel probing/EH too much.

Thanks.

 drivers/ata/libahci.c         |   18 +++++++++---------
 drivers/ata/libata-core.c     |   21 ++++++++++++++-------
 drivers/ata/libata-eh.c       |    2 +-
 drivers/ata/libata-sff.c      |   12 ++++++------
 drivers/ata/pata_bf54x.c      |    4 ++--
 drivers/ata/pata_samsung_cf.c |    2 +-
 drivers/ata/pata_scc.c        |    4 ++--
 drivers/ata/sata_fsl.c        |   19 ++++++++++---------
 drivers/ata/sata_inic162x.c   |    2 +-
 drivers/ata/sata_sil24.c      |   14 +++++++-------
 drivers/ata/sata_via.c        |    2 +-
 include/linux/libata.h        |    5 +++--
 12 files changed, 57 insertions(+), 48 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 68dc678..32bfe55 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -577,7 +577,7 @@ int ahci_stop_engine(struct ata_port *ap)
 	writel(tmp, port_mmio + PORT_CMD);

 	/* wait for engine to stop. This could be as long as 500 msec */
-	tmp = ata_wait_register(port_mmio + PORT_CMD,
+	tmp = ata_wait_register(ap, port_mmio + PORT_CMD,
 				PORT_CMD_LIST_ON, PORT_CMD_LIST_ON, 1, 500);
 	if (tmp & PORT_CMD_LIST_ON)
 		return -EIO;
@@ -624,7 +624,7 @@ static int ahci_stop_fis_rx(struct ata_port *ap)
 	writel(tmp, port_mmio + PORT_CMD);

 	/* wait for completion, spec says 500ms, give it 1000 */
-	tmp = ata_wait_register(port_mmio + PORT_CMD, PORT_CMD_FIS_ON,
+	tmp = ata_wait_register(ap, port_mmio + PORT_CMD, PORT_CMD_FIS_ON,
 				PORT_CMD_FIS_ON, 10, 1000);
 	if (tmp & PORT_CMD_FIS_ON)
 		return -EBUSY;
@@ -673,7 +673,7 @@ static void ahci_disable_alpm(struct ata_port *ap)
 	cmd = readl(port_mmio + PORT_CMD);

 	/* wait 10ms to be sure we've come out of any low power state */
-	msleep(10);
+	ata_msleep(ap, 10);

 	/* clear out any PhyRdy stuff from interrupt status */
 	writel(PORT_IRQ_PHYRDY, port_mmio + PORT_IRQ_STAT);
@@ -821,7 +821,7 @@ static void ahci_start_port(struct ata_port *ap)
 							       emp->led_state,
 							       4);
 				if (rc == -EBUSY)
-					msleep(1);
+					ata_msleep(ap, 1);
 				else
 					break;
 			}
@@ -880,7 +880,7 @@ int ahci_reset_controller(struct ata_host *host)
 		 * reset must complete within 1 second, or
 		 * the hardware should be considered fried.
 		 */
-		tmp = ata_wait_register(mmio + HOST_CTL, HOST_RESET,
+		tmp = ata_wait_register(NULL, mmio + HOST_CTL, HOST_RESET,
 					HOST_RESET, 10, 1000);

 		if (tmp & HOST_RESET) {
@@ -1260,7 +1260,7 @@ int ahci_kick_engine(struct ata_port *ap)
 	writel(tmp, port_mmio + PORT_CMD);

 	rc = 0;
-	tmp = ata_wait_register(port_mmio + PORT_CMD,
+	tmp = ata_wait_register(ap, port_mmio + PORT_CMD,
 				PORT_CMD_CLO, PORT_CMD_CLO, 1, 500);
 	if (tmp & PORT_CMD_CLO)
 		rc = -EIO;
@@ -1290,8 +1290,8 @@ static int ahci_exec_polled_cmd(struct ata_port *ap, int pmp,
 	writel(1, port_mmio + PORT_CMD_ISSUE);

 	if (timeout_msec) {
-		tmp = ata_wait_register(port_mmio + PORT_CMD_ISSUE, 0x1, 0x1,
-					1, timeout_msec);
+		tmp = ata_wait_register(ap, port_mmio + PORT_CMD_ISSUE,
+					0x1, 0x1, 1, timeout_msec);
 		if (tmp & 0x1) {
 			ahci_kick_engine(ap);
 			return -EBUSY;
@@ -1338,7 +1338,7 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	}

 	/* spec says at least 5us, but be generous and sleep for 1ms */
-	msleep(1);
+	ata_msleep(ap, 1);

 	/* issue the second D2H Register FIS */
 	tf.ctl &= ~ATA_SRST;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9ceb493..77b8ca6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3596,7 +3596,7 @@ int ata_wait_ready(struct ata_link *link, unsigned long deadline,
 			warned = 1;
 		}

-		msleep(50);
+		ata_msleep(link->ap, 50);
 	}
 }

@@ -3617,7 +3617,7 @@ int ata_wait_ready(struct ata_link *link, unsigned long deadline,
 int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
 				int (*check_ready)(struct ata_link *link))
 {
-	msleep(ATA_WAIT_AFTER_RESET);
+	ata_msleep(link->ap, ATA_WAIT_AFTER_RESET);

 	return ata_wait_ready(link, deadline, check_ready);
 }
@@ -3665,7 +3665,7 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 	last_jiffies = jiffies;

 	while (1) {
-		msleep(interval);
+		ata_msleep(link->ap, interval);
 		if ((rc = sata_scr_read(link, SCR_STATUS, &cur)))
 			return rc;
 		cur &= 0xf;
@@ -3730,7 +3730,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 		 * immediately after resuming.  Delay 200ms before
 		 * debouncing.
 		 */
-		msleep(200);
+		ata_msleep(link->ap, 200);

 		/* is SControl restored correctly? */
 		if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
@@ -3868,7 +3868,7 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
 	 * 10.4.2 says at least 1 ms.
 	 */
-	msleep(1);
+	ata_msleep(link->ap, 1);

 	/* bring link back */
 	rc = sata_link_resume(link, timing, deadline);
@@ -6606,8 +6606,14 @@ int ata_ratelimit(void)
 	return __ratelimit(&ratelimit);
 }

+void ata_msleep(struct ata_port *ap, unsigned int msecs)
+{
+	msleep(msecs);
+}
+
 /**
  *	ata_wait_register - wait until register value changes
+ *	@ap: ATA port to wait register for, can be NULL
  *	@reg: IO-mapped register
  *	@mask: Mask to apply to read register value
  *	@val: Wait condition
@@ -6629,7 +6635,7 @@ int ata_ratelimit(void)
  *	RETURNS:
  *	The final register value.
  */
-u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
+u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask, u32 val,
 		      unsigned long interval, unsigned long timeout)
 {
 	unsigned long deadline;
@@ -6644,7 +6650,7 @@ u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
 	deadline = ata_deadline(jiffies, timeout);

 	while ((tmp & mask) == val && time_before(jiffies, deadline)) {
-		msleep(interval);
+		ata_msleep(ap, interval);
 		tmp = ioread32(reg);
 	}

@@ -6727,6 +6733,7 @@ EXPORT_SYMBOL_GPL(ata_std_postreset);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_pair);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
+EXPORT_SYMBOL_GPL(ata_msleep);
 EXPORT_SYMBOL_GPL(ata_wait_register);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0108731..a9b47f1 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -779,7 +779,7 @@ void ata_port_wait_eh(struct ata_port *ap)

 	/* make sure SCSI EH is complete */
 	if (scsi_host_in_recovery(ap->scsi_host)) {
-		msleep(10);
+		ata_msleep(ap, 10);
 		goto retry;
 	}
 }
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index c7e3c45..030b1c4 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -222,7 +222,7 @@ int ata_sff_busy_sleep(struct ata_port *ap,
 	timeout = ata_deadline(timer_start, tmout_pat);
 	while (status != 0xff && (status & ATA_BUSY) &&
 	       time_before(jiffies, timeout)) {
-		msleep(50);
+		ata_msleep(ap, 50);
 		status = ata_sff_busy_wait(ap, ATA_BUSY, 3);
 	}

@@ -234,7 +234,7 @@ int ata_sff_busy_sleep(struct ata_port *ap,
 	timeout = ata_deadline(timer_start, tmout);
 	while (status != 0xff && (status & ATA_BUSY) &&
 	       time_before(jiffies, timeout)) {
-		msleep(50);
+		ata_msleep(ap, 50);
 		status = ap->ops->sff_check_status(ap);
 	}

@@ -360,7 +360,7 @@ static void ata_dev_select(struct ata_port *ap, unsigned int device,

 	if (wait) {
 		if (can_sleep && ap->link.device[device].class == ATA_DEV_ATAPI)
-			msleep(150);
+			ata_msleep(ap, 150);
 		ata_wait_idle(ap);
 	}
 }
@@ -1342,7 +1342,7 @@ fsm_start:
 	 */
 	status = ata_sff_busy_wait(ap, ATA_BUSY, 5);
 	if (status & ATA_BUSY) {
-		msleep(2);
+		ata_msleep(ap, 2);
 		status = ata_sff_busy_wait(ap, ATA_BUSY, 10);
 		if (status & ATA_BUSY) {
 			ata_sff_queue_pio_task(ap, ATA_SHORT_PAUSE);
@@ -1917,7 +1917,7 @@ int ata_sff_wait_after_reset(struct ata_link *link, unsigned int devmask,
 	unsigned int dev1 = devmask & (1 << 1);
 	int rc, ret = 0;

-	msleep(ATA_WAIT_AFTER_RESET);
+	ata_msleep(ap, ATA_WAIT_AFTER_RESET);

 	/* always check readiness of the master device */
 	rc = ata_sff_wait_ready(link, deadline);
@@ -1946,7 +1946,7 @@ int ata_sff_wait_after_reset(struct ata_link *link, unsigned int devmask,
 			lbal = ioread8(ioaddr->lbal_addr);
 			if ((nsect == 1) && (lbal == 1))
 				break;
-			msleep(50);	/* give drive a breather */
+			ata_msleep(ap, 50);	/* give drive a breather */
 		}

 		rc = ata_sff_wait_ready(link, deadline);
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 9cae65d..e1423cd 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1046,7 +1046,7 @@ static void bfin_bus_post_reset(struct ata_port *ap, unsigned int devmask)
 			dev1 = 0;
 			break;
 		}
-		msleep(50);	/* give drive a breather */
+		ata_msleep(ap, 50);	/* give drive a breather */
 	}
 	if (dev1)
 		ata_sff_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
@@ -1087,7 +1087,7 @@ static unsigned int bfin_bus_softreset(struct ata_port *ap,
 	 *
 	 * Old drivers/ide uses the 2mS rule and then waits for ready
 	 */
-	msleep(150);
+	ata_msleep(ap, 150);

 	/* Before we perform post reset processing we want to see if
 	 * the bus shows 0xFF because the odd clown forgets the D7
diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index 6f9cfb2..8a51d67 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -322,7 +322,7 @@ static int pata_s3c_wait_after_reset(struct ata_link *link,
 {
 	int rc;

-	msleep(ATA_WAIT_AFTER_RESET);
+	ata_msleep(link->ap, ATA_WAIT_AFTER_RESET);

 	/* always check readiness of the master device */
 	rc = ata_sff_wait_ready(link, deadline);
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index fe36966..093715c 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -530,7 +530,7 @@ static int scc_wait_after_reset(struct ata_link *link, unsigned int devmask,
 	 *
 	 * Old drivers/ide uses the 2mS rule and then waits for ready.
 	 */
-	msleep(150);
+	ata_msleep(ap, 150);

 	/* always check readiness of the master device */
 	rc = ata_sff_wait_ready(link, deadline);
@@ -559,7 +559,7 @@ static int scc_wait_after_reset(struct ata_link *link, unsigned int devmask,
 			lbal = in_be32(ioaddr->lbal_addr);
 			if ((nsect == 1) && (lbal == 1))
 				break;
-			msleep(50);	/* give drive a breather */
+			ata_msleep(ap, 50);	/* give drive a breather */
 		}

 		rc = ata_sff_wait_ready(link, deadline);
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 1440dc0..b0214d0 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -678,7 +678,7 @@ static void sata_fsl_port_stop(struct ata_port *ap)
 	iowrite32(temp, hcr_base + HCONTROL);

 	/* Poll for controller to go offline - should happen immediately */
-	ata_wait_register(hcr_base + HSTATUS, ONLINE, ONLINE, 1, 1);
+	ata_wait_register(ap, hcr_base + HSTATUS, ONLINE, ONLINE, 1, 1);

 	ap->private_data = NULL;
 	dma_free_coherent(dev, SATA_FSL_PORT_PRIV_DMA_SZ,
@@ -729,7 +729,8 @@ try_offline_again:
 	iowrite32(temp, hcr_base + HCONTROL);

 	/* Poll for controller to go offline */
-	temp = ata_wait_register(hcr_base + HSTATUS, ONLINE, ONLINE, 1, 500);
+	temp = ata_wait_register(ap, hcr_base + HSTATUS, ONLINE, ONLINE,
+				 1, 500);

 	if (temp & ONLINE) {
 		ata_port_printk(ap, KERN_ERR,
@@ -752,7 +753,7 @@ try_offline_again:
 	/*
 	 * PHY reset should remain asserted for atleast 1ms
 	 */
-	msleep(1);
+	ata_msleep(ap, 1);

 	/*
 	 * Now, bring the host controller online again, this can take time
@@ -766,7 +767,7 @@ try_offline_again:
 	temp |= HCONTROL_PMP_ATTACHED;
 	iowrite32(temp, hcr_base + HCONTROL);

-	temp = ata_wait_register(hcr_base + HSTATUS, ONLINE, 0, 1, 500);
+	temp = ata_wait_register(ap, hcr_base + HSTATUS, ONLINE, 0, 1, 500);

 	if (!(temp & ONLINE)) {
 		ata_port_printk(ap, KERN_ERR,
@@ -784,7 +785,7 @@ try_offline_again:
 	 * presence
 	 */

-	temp = ata_wait_register(hcr_base + HSTATUS, 0xFF, 0, 1, 500);
+	temp = ata_wait_register(ap, hcr_base + HSTATUS, 0xFF, 0, 1, 500);
 	if ((!(temp & 0x10)) || ata_link_offline(link)) {
 		ata_port_printk(ap, KERN_WARNING,
 				"No Device OR PHYRDY change,Hstatus = 0x%x\n",
@@ -797,7 +798,7 @@ try_offline_again:
 	 * Wait for the first D2H from device,i.e,signature update notification
 	 */
 	start_jiffies = jiffies;
-	temp = ata_wait_register(hcr_base + HSTATUS, 0xFF, 0x10,
+	temp = ata_wait_register(ap, hcr_base + HSTATUS, 0xFF, 0x10,
 			500, jiffies_to_msecs(deadline - start_jiffies));

 	if ((temp & 0xFF) != 0x18) {
@@ -880,7 +881,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 		iowrite32(pmp, CQPMP + hcr_base);
 	iowrite32(1, CQ + hcr_base);

-	temp = ata_wait_register(CQ + hcr_base, 0x1, 0x1, 1, 5000);
+	temp = ata_wait_register(ap, CQ + hcr_base, 0x1, 0x1, 1, 5000);
 	if (temp & 0x1) {
 		ata_port_printk(ap, KERN_WARNING, "ATA_SRST issue failed\n");

@@ -896,7 +897,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 		goto err;
 	}

-	msleep(1);
+	ata_msleep(ap, 1);

 	/*
 	 * SATA device enters reset state after receving a Control register
@@ -915,7 +916,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 	if (pmp != SATA_PMP_CTRL_PORT)
 		iowrite32(pmp, CQPMP + hcr_base);
 	iowrite32(1, CQ + hcr_base);
-	msleep(150);		/* ?? */
+	ata_msleep(ap, 150);		/* ?? */

 	/*
 	 * The above command would have signalled an interrupt on command
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index a36149e..83a4447 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -614,7 +614,7 @@ static int inic_hardreset(struct ata_link *link, unsigned int *class,

 	writew(IDMA_CTL_RST_ATA, idma_ctl);
 	readw(idma_ctl);	/* flush */
-	msleep(1);
+	ata_msleep(ap, 1);
 	writew(0, idma_ctl);

 	rc = sata_link_resume(link, timing, deadline);
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index be7726d..af41c6f 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -589,9 +589,9 @@ static int sil24_init_port(struct ata_port *ap)
 		sil24_clear_pmp(ap);

 	writel(PORT_CS_INIT, port + PORT_CTRL_STAT);
-	ata_wait_register(port + PORT_CTRL_STAT,
+	ata_wait_register(ap, port + PORT_CTRL_STAT,
 			  PORT_CS_INIT, PORT_CS_INIT, 10, 100);
-	tmp = ata_wait_register(port + PORT_CTRL_STAT,
+	tmp = ata_wait_register(ap, port + PORT_CTRL_STAT,
 				PORT_CS_RDY, 0, 10, 100);

 	if ((tmp & (PORT_CS_INIT | PORT_CS_RDY)) != PORT_CS_RDY) {
@@ -631,7 +631,7 @@ static int sil24_exec_polled_cmd(struct ata_port *ap, int pmp,
 	writel((u64)paddr >> 32, port + PORT_CMD_ACTIVATE + 4);

 	irq_mask = (PORT_IRQ_COMPLETE | PORT_IRQ_ERROR) << PORT_IRQ_RAW_SHIFT;
-	irq_stat = ata_wait_register(port + PORT_IRQ_STAT, irq_mask, 0x0,
+	irq_stat = ata_wait_register(ap, port + PORT_IRQ_STAT, irq_mask, 0x0,
 				     10, timeout_msec);

 	writel(irq_mask, port + PORT_IRQ_STAT); /* clear IRQs */
@@ -719,9 +719,9 @@ static int sil24_hardreset(struct ata_link *link, unsigned int *class,
 				"state, performing PORT_RST\n");

 		writel(PORT_CS_PORT_RST, port + PORT_CTRL_STAT);
-		msleep(10);
+		ata_msleep(ap, 10);
 		writel(PORT_CS_PORT_RST, port + PORT_CTRL_CLR);
-		ata_wait_register(port + PORT_CTRL_STAT, PORT_CS_RDY, 0,
+		ata_wait_register(ap, port + PORT_CTRL_STAT, PORT_CS_RDY, 0,
 				  10, 5000);

 		/* restore port configuration */
@@ -740,7 +740,7 @@ static int sil24_hardreset(struct ata_link *link, unsigned int *class,
 		tout_msec = 5000;

 	writel(PORT_CS_DEV_RST, port + PORT_CTRL_STAT);
-	tmp = ata_wait_register(port + PORT_CTRL_STAT,
+	tmp = ata_wait_register(ap, port + PORT_CTRL_STAT,
 				PORT_CS_DEV_RST, PORT_CS_DEV_RST, 10,
 				tout_msec);

@@ -1253,7 +1253,7 @@ static void sil24_init_controller(struct ata_host *host)
 		tmp = readl(port + PORT_CTRL_STAT);
 		if (tmp & PORT_CS_PORT_RST) {
 			writel(PORT_CS_PORT_RST, port + PORT_CTRL_CLR);
-			tmp = ata_wait_register(port + PORT_CTRL_STAT,
+			tmp = ata_wait_register(NULL, port + PORT_CTRL_STAT,
 						PORT_CS_PORT_RST,
 						PORT_CS_PORT_RST, 10, 100);
 			if (tmp & PORT_CS_PORT_RST)
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 4730c42..c215899 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -349,7 +349,7 @@ static int vt6420_prereset(struct ata_link *link, unsigned long deadline)

 	/* wait for phy to become ready, if necessary */
 	do {
-		msleep(200);
+		ata_msleep(link->ap, 200);
 		svia_scr_read(link, SCR_STATUS, &sstatus);
 		if ((sstatus & 0xf) != 1)
 			break;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 89115f8..1da3374 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -994,8 +994,9 @@ extern int ata_host_suspend(struct ata_host *host, pm_message_t mesg);
 extern void ata_host_resume(struct ata_host *host);
 #endif
 extern int ata_ratelimit(void);
-extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
-			     unsigned long interval, unsigned long timeout);
+extern void ata_msleep(struct ata_port *ap, unsigned int msecs);
+extern u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask,
+			u32 val, unsigned long interval, unsigned long timeout);
 extern int atapi_cmd_type(u8 opcode);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 			  u8 pmp, int is_cmd, u8 *fis);
-- 
1.7.1

