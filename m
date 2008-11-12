From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH] fix pata-rb532-cf
Date: Wed, 12 Nov 2008 01:13:03 +0100
Message-ID: <1226448783-10047-1-git-send-email-n0-1@freewrt.org>
References: <1225403251-15705-1-git-send-email-n0-1@freewrt.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:38301 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbYKLANM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Nov 2008 19:13:12 -0500
In-Reply-To: <1225403251-15705-1-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Florian Fainelli <florian@openwrt.org>

The following patch series is a complete updated set of changes I did to
the pata-rb532-cf driver. In ordered detail: fix functionality, restore
the behaviour of the original driver when doing transfers and eliminate
compiler warnings.

Greetings, Phil

---

After applying the following changes I could verify functionality by
mounting a filesystem on the cfdisk and reading/writing files in it.

The set_irq_type() function must be wrong, as there is no set_type()
function defined for the rb532 IRQ chip. But as the used IRQ actually is
being triggered by a GPIO, setting it's interrupt level should be the
right alternative. Also to clear a GPIO triggered IRQ, the source has to
be cleared. This is being done at the end of rb532_pata_irq_handler.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
Acked-by: Florian Fainelli <florian@openwrt.org>
---
 drivers/ata/pata_rb532_cf.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index f8b3ffc..7b11f40 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -31,6 +31,7 @@
 #include <scsi/scsi_host.h>
 
 #include <asm/gpio.h>
+#include <asm/mach-rc32434/gpio.h>
 
 #define DRV_NAME	"pata-rb532-cf"
 #define DRV_VERSION	"0.1.0"
@@ -39,7 +40,8 @@
 #define RB500_CF_MAXPORTS	1
 #define RB500_CF_IO_DELAY	400
 
-#define RB500_CF_REG_CMD	0x0800
+#define RB500_CF_REG_BASE	0x0800
+#define RB500_CF_REG_ERR	0x080D
 #define RB500_CF_REG_CTRL	0x080E
 #define RB500_CF_REG_DATA	0x0C00
 
@@ -62,7 +64,7 @@ static inline void rb532_pata_finish_io(struct ata_port *ap)
 	ata_sff_dma_pause(ap);
 	ndelay(RB500_CF_IO_DELAY);
 
-	set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);
+	rb532_gpio_set_ilevel(1, info->gpio_line);
 }
 
 static void rb532_pata_exec_command(struct ata_port *ap,
@@ -109,13 +111,15 @@ static irqreturn_t rb532_pata_irq_handler(int irq, void *dev_instance)
 	struct rb532_cf_info *info = ah->private_data;
 
 	if (gpio_get_value(info->gpio_line)) {
-		set_irq_type(info->irq, IRQ_TYPE_LEVEL_LOW);
+		rb532_gpio_set_ilevel(0, info->gpio_line);
 		if (!info->frozen)
 			ata_sff_interrupt(info->irq, dev_instance);
 	} else {
-		set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);
+		rb532_gpio_set_ilevel(1, info->gpio_line);
 	}
 
+	rb532_gpio_set_istat(0, info->gpio_line);
+
 	return IRQ_HANDLED;
 }
 
@@ -146,13 +150,14 @@ static void rb532_pata_setup_ports(struct ata_host *ah)
 	ap->pio_mask	= 0x1f; /* PIO4 */
 	ap->flags	= ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO;
 
-	ap->ioaddr.cmd_addr	= info->iobase + RB500_CF_REG_CMD;
+	ap->ioaddr.cmd_addr	= info->iobase + RB500_CF_REG_BASE;
 	ap->ioaddr.ctl_addr	= info->iobase + RB500_CF_REG_CTRL;
 	ap->ioaddr.altstatus_addr = info->iobase + RB500_CF_REG_CTRL;
 
 	ata_sff_std_ports(&ap->ioaddr);
 
 	ap->ioaddr.data_addr	= info->iobase + RB500_CF_REG_DATA;
+	ap->ioaddr.error_addr	= info->iobase + RB500_CF_REG_ERR;
 }
 
 static __devinit int rb532_pata_driver_probe(struct platform_device *pdev)
-- 
1.5.6.4

