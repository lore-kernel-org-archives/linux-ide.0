From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [PATCH 3/3] ide/at91: use new introduce smc accessor
Date: Thu,  8 Dec 2011 16:23:04 +0100
Message-ID: <1323357784-17555-3-git-send-email-plagnioj@jcrosoft.com>
References: <20111208150348.GD23884@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111208150348.GD23884@game.jcrosoft.org>
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

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-ide@vger.kernel.org
---
Hi,

	it's depends on other patch for AT91 can we apply via at91

Best Regards,
J.
 drivers/ide/at91_ide.c |   65 +++++++++++++++++++++++++++--------------------
 1 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
index 41d4155..407595b 100644
--- a/drivers/ide/at91_ide.c
+++ b/drivers/ide/at91_ide.c
@@ -59,41 +59,50 @@
 #define ALT_MODE	0x00e00000
 #define REGS_SIZE	8
 
-#define enter_16bit(cs, mode) do {					\
-	mode = at91_sys_read(AT91_SMC_MODE(cs));			\
-	at91_sys_write(AT91_SMC_MODE(cs), mode | AT91_SMC_DBW_16);	\
-} while (0)
+static inline void enter_16bit(int cs, struct sam9_smc_config *smc)
+{
+	sam9_smc_read_mode(0, cs, smc);
+	smc->mode = (smc->mode & ~AT91_SMC_DBW) | AT91_SMC_DBW_16;
+	sam9_smc_write_mode(0, cs, smc);
+}
 
-#define leave_16bit(cs, mode) at91_sys_write(AT91_SMC_MODE(cs), mode);
+static inline void leave_16bit(int cs, struct sam9_smc_config *smc)
+{
+	smc->mode = (smc->mode & ~AT91_SMC_DBW) | AT91_SMC_DBW_8;
+	sam9_smc_write_mode(0, cs, smc);
+}
 
 static void set_smc_timings(const u8 chipselect, const u16 cycle,
 			    const u16 setup, const u16 pulse,
 			    const u16 data_float, int use_iordy)
 {
-	unsigned long mode = AT91_SMC_READMODE | AT91_SMC_WRITEMODE |
+	struct sam9_smc_config smc;
+
+	smc.mode = AT91_SMC_READMODE | AT91_SMC_WRITEMODE |
 			     AT91_SMC_BAT_SELECT;
 
 	/* disable or enable waiting for IORDY signal */
 	if (use_iordy)
-		mode |= AT91_SMC_EXNWMODE_READY;
+		smc.mode |= AT91_SMC_EXNWMODE_READY;
 
-	/* add data float cycles if needed */
-	if (data_float)
-		mode |= AT91_SMC_TDF_(data_float);
+	/* add data ofloat cycles if needed */
+	smc.tdf_cycles = data_float;
 
-	at91_sys_write(AT91_SMC_MODE(chipselect), mode);
+	/* write SMC Setup Register */
+	smc.nrd_setup = setup;
+	smc.nwe_setup = smc.nrd_setup;
+	smc.ncs_read_setup = 0;
+	smc.ncs_write_setup = smc.ncs_read_setup;
+	/* write SMC Pulse Register */
+	smc.nrd_pulse = pulse;
+	smc.nwe_pulse = smc.nrd_pulse;
+	smc.ncs_read_pulse = cycle;
+	smc.ncs_write_pulse = smc.ncs_read_pulse;
+	/* write SMC Cycle Register */
+	smc.read_cycle = cycle;
+	smc.write_cycle = smc.read_cycle;
 
-	/* setup timings in SMC */
-	at91_sys_write(AT91_SMC_SETUP(chipselect), AT91_SMC_NWESETUP_(setup) |
-						   AT91_SMC_NCS_WRSETUP_(0) |
-						   AT91_SMC_NRDSETUP_(setup) |
-						   AT91_SMC_NCS_RDSETUP_(0));
-	at91_sys_write(AT91_SMC_PULSE(chipselect), AT91_SMC_NWEPULSE_(pulse) |
-						   AT91_SMC_NCS_WRPULSE_(cycle) |
-						   AT91_SMC_NRDPULSE_(pulse) |
-						   AT91_SMC_NCS_RDPULSE_(cycle));
-	at91_sys_write(AT91_SMC_CYCLE(chipselect), AT91_SMC_NWECYCLE_(cycle) |
-						   AT91_SMC_NRDCYCLE_(cycle));
+	sam9_smc_configure(0, chipselect, &smc);
 }
 
 static unsigned int calc_mck_cycles(unsigned int ns, unsigned int mck_hz)
@@ -146,15 +155,15 @@ static void at91_ide_input_data(ide_drive_t *drive, struct ide_cmd *cmd,
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	u8 chipselect = hwif->select_data;
-	unsigned long mode;
+	struct sam9_smc_config smc;
 
 	pdbg("cs %u buf %p len %d\n", chipselect, buf, len);
 
 	len++;
 
-	enter_16bit(chipselect, mode);
+	enter_16bit(chipselect, &smc);
 	readsw((void __iomem *)io_ports->data_addr, buf, len / 2);
-	leave_16bit(chipselect, mode);
+	leave_16bit(chipselect, &smc);
 }
 
 static void at91_ide_output_data(ide_drive_t *drive, struct ide_cmd *cmd,
@@ -163,13 +172,13 @@ static void at91_ide_output_data(ide_drive_t *drive, struct ide_cmd *cmd,
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	u8 chipselect = hwif->select_data;
-	unsigned long mode;
+	struct sam9_smc_config smc;
 
 	pdbg("cs %u buf %p len %d\n", chipselect,  buf, len);
 
-	enter_16bit(chipselect, mode);
+	enter_16bit(chipselect, &smc);
 	writesw((void __iomem *)io_ports->data_addr, buf, len / 2);
-	leave_16bit(chipselect, mode);
+	leave_16bit(chipselect, &smc);
 }
 
 static void at91_ide_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
-- 
1.7.7
