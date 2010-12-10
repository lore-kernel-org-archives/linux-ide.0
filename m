From: Igor Plyatov <plyatov@gmail.com>
Subject: [PATCH] ata: pata_at91.c bugfix for high master clock
Date: Fri, 10 Dec 2010 23:03:50 +0300
Message-ID: <1292011430-20835-1-git-send-email-plyatov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, geomatsi@gmail.com, Igor Plyatov <plyatov@gmail.com>
List-Id: linux-ide@vger.kernel.org

The AT91SAM9 microcontrollers with master clock higher then 105 MHz
and PIO0, have overflow of the NCS_RD_PULSE value in the MSB. This
lead to "NCS_RD_PULSE" pulse longer then "NRD_CYCLE" pulse and pata_at91
driver does detect ATA device.

Signed-off-by: Igor Plyatov <plyatov@gmail.com>
---
 drivers/ata/pata_at91.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
index 0da0dcc..2e189be 100644
--- a/drivers/ata/pata_at91.c
+++ b/drivers/ata/pata_at91.c
@@ -33,12 +33,14 @@
 
 
 #define DRV_NAME "pata_at91"
-#define DRV_VERSION "0.1"
+#define DRV_VERSION "0.2"
 
 #define CF_IDE_OFFSET	    0x00c00000
 #define CF_ALT_IDE_OFFSET   0x00e00000
 #define CF_IDE_RES_SIZE     0x08
 
+#define NCS_RD_PULSE_LIMIT  0x3f /* maximal value for pulse bitfields */
+
 struct at91_ide_info {
 	unsigned long mode;
 	unsigned int cs;
@@ -50,7 +52,7 @@ struct at91_ide_info {
 };
 
 static const struct ata_timing initial_timing =
-	{XFER_PIO_0, 70, 290, 240, 600, 165, 150, 600, 0};
+	{XFER_PIO_0, 70, 290, 240, 600, 165, 150, 0, 600, 0};
 
 static unsigned long calc_mck_cycles(unsigned long ns, unsigned long mck_hz)
 {
@@ -109,6 +111,11 @@ static void set_smc_timing(struct device *dev,
 	/* (CS0, CS1, DIR, OE) <= (CFCE1, CFCE2, CFRNW, NCSX) timings */
 	ncs_read_setup = 1;
 	ncs_read_pulse = read_cycle - 2;
+	if (ncs_read_pulse > NCS_RD_PULSE_LIMIT) {
+		ncs_read_pulse = NCS_RD_PULSE_LIMIT;
+		dev_dbg(dev, "ncs_read_pulse limited to maximal value %lu\n",
+			ncs_read_pulse);
+	}
 
 	/* Write timings same as read timings */
 	write_cycle = read_cycle;
-- 
1.7.0.4
