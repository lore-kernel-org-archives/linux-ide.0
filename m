From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [FOR 3.3 PATCH 2/2] pata/at91: use newly introduce smc accessor
Date: Sun,  5 Feb 2012 19:22:54 +0100
Message-ID: <1328466174-27946-2-git-send-email-plagnioj@jcrosoft.com>
References: <1328466174-27946-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1328466174-27946-1-git-send-email-plagnioj@jcrosoft.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

this will allow to use the pata_at91 on a single zImage

and fix the pata since the cleanup of SMC in commit faee0cc33c3df3

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-ide@vger.kernel.org
---
Hi,

	it's depends on other patch for AT91 can we apply via at91

Best Regards,
J.
 drivers/ata/pata_at91.c |   46 ++++++++++++++++++++--------------------------
 1 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
index a7d91a7..53d3770 100644
--- a/drivers/ata/pata_at91.c
+++ b/drivers/ata/pata_at91.c
@@ -207,11 +207,11 @@ static void set_smc_timing(struct device *dev, struct ata_device *adev,
 {
 	int ret = 0;
 	int use_iordy;
+	struct sam9_smc_config smc;
 	unsigned int t6z;         /* data tristate time in ns */
 	unsigned int cycle;       /* SMC Cycle width in MCK ticks */
 	unsigned int setup;       /* SMC Setup width in MCK ticks */
 	unsigned int pulse;       /* CFIOR and CFIOW pulse width in MCK ticks */
-	unsigned int cs_setup = 0;/* CS4 or CS5 setup width in MCK ticks */
 	unsigned int cs_pulse;    /* CS4 or CS5 pulse width in MCK ticks*/
 	unsigned int tdf_cycles;  /* SMC TDF MCK ticks */
 	unsigned long mck_hz;     /* MCK frequency in Hz */
@@ -244,26 +244,20 @@ static void set_smc_timing(struct device *dev, struct ata_device *adev,
 	}
 
 	dev_dbg(dev, "Use IORDY=%u, TDF Cycles=%u\n", use_iordy, tdf_cycles);
-	info->mode |= AT91_SMC_TDF_(tdf_cycles);
 
-	/* write SMC Setup Register */
-	at91_sys_write(AT91_SMC_SETUP(info->cs),
-			AT91_SMC_NWESETUP_(setup) |
-			AT91_SMC_NRDSETUP_(setup) |
-			AT91_SMC_NCS_WRSETUP_(cs_setup) |
-			AT91_SMC_NCS_RDSETUP_(cs_setup));
-	/* write SMC Pulse Register */
-	at91_sys_write(AT91_SMC_PULSE(info->cs),
-			AT91_SMC_NWEPULSE_(pulse) |
-			AT91_SMC_NRDPULSE_(pulse) |
-			AT91_SMC_NCS_WRPULSE_(cs_pulse) |
-			AT91_SMC_NCS_RDPULSE_(cs_pulse));
-	/* write SMC Cycle Register */
-	at91_sys_write(AT91_SMC_CYCLE(info->cs),
-			AT91_SMC_NWECYCLE_(cycle) |
-			AT91_SMC_NRDCYCLE_(cycle));
-	/* write SMC Mode Register*/
-	at91_sys_write(AT91_SMC_MODE(info->cs), info->mode);
+	/* SMC Setup Register */
+	smc.nwe_setup = smc.nrd_setup = setup;
+	smc.ncs_write_setup = smc.ncs_read_setup = 0;
+	/* SMC Pulse Register */
+	smc.nwe_pulse = smc.nrd_pulse = pulse;
+	smc.ncs_write_pulse = smc.ncs_read_pulse = cs_pulse;
+	/* SMC Cycle Register */
+	smc.write_cycle = smc.read_cycle = cycle;
+	/* SMC Mode Register*/
+	smc.tdf_cycles = tdf_cycles;
+	smc.mode = info->mode;
+
+	sam9_smc_configure(0, info->cs, &smc);
 }
 
 static void pata_at91_set_piomode(struct ata_port *ap, struct ata_device *adev)
@@ -288,20 +282,20 @@ static unsigned int pata_at91_data_xfer_noirq(struct ata_device *dev,
 	struct at91_ide_info *info = dev->link->ap->host->private_data;
 	unsigned int consumed;
 	unsigned long flags;
-	unsigned int mode;
+	struct sam9_smc_config smc;
 
 	local_irq_save(flags);
-	mode = at91_sys_read(AT91_SMC_MODE(info->cs));
+	sam9_smc_read_mode(0, info->cs, &smc);
 
 	/* set 16bit mode before writing data */
-	at91_sys_write(AT91_SMC_MODE(info->cs),
-			(mode & ~AT91_SMC_DBW) | AT91_SMC_DBW_16);
+	smc.mode = (smc.mode & ~AT91_SMC_DBW) | AT91_SMC_DBW_16;
+	sam9_smc_write_mode(0, info->cs, &smc);
 
 	consumed = ata_sff_data_xfer(dev, buf, buflen, rw);
 
 	/* restore 8bit mode after data is written */
-	at91_sys_write(AT91_SMC_MODE(info->cs),
-			(mode & ~AT91_SMC_DBW) | AT91_SMC_DBW_8);
+	smc.mode = (smc.mode & ~AT91_SMC_DBW) | AT91_SMC_DBW_8;
+	sam9_smc_write_mode(0, info->cs, &smc);
 
 	local_irq_restore(flags);
 	return consumed;
-- 
1.7.7
