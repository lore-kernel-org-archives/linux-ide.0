From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [PATCH] PATA driver for CF interface on AT91SAM9260 SoC
Date: Thu, 18 Jun 2009 22:24:01 +0400
Message-ID: <20090618222401.462b2d44@realm>
References: <1245181151-7040-1-git-send-email-geomatsi@gmail.com>
	<20090618002004.54701b40@realm>
	<20090617235351.1cb05c97@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f212.google.com ([209.85.220.212]:55096 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbZFRSbc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jun 2009 14:31:32 -0400
Received: by fxm8 with SMTP id 8so1276512fxm.37
        for <linux-ide@vger.kernel.org>; Thu, 18 Jun 2009 11:31:32 -0700 (PDT)
In-Reply-To: <20090617235351.1cb05c97@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, Sergey Lapin <slapin@ossfans.org>, Andrew Victor <avictor.za@gmail.com>

On Wed, 17 Jun 2009 23:53:51 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > This patch provides PATA driver for CompactFlash interface in True
> > IDE mode on AT91SAM9260 SoC.
>=20
> Couple of points
>=20
> > +static int pio_mask =3D ATA_PIO4;
> > +module_param(pio_mask, int, 0);
>=20
> This doesn't appear to be used ? is it a left over that can go
>=20
> > +	set_smc_timing(dev, info, &initial_timing);
> > +	set_smc_mode(info);
>=20
> The core libata code will call your speed setting methods for PIO_0
> before probing the port. I don't think this is needed ?
>=20
> Alan

Hello,

Concerning the first point, this module parameter is used in driver
probing function:=20
	ap->pio_mask =3D pio_mask;

I would suggest to keep pio_mask as a module parameter, since it might
be useful to modify it in order to =D1=81ut down PIO speed, e.g. for te=
sting
purposes.=20

Concerning the second point, I removed set_smc_timing/set_smc_mode from
driver probing function.

Here is updated patch:



This patch provides PATA driver for CompactFlash interface in True IDE
mode on AT91SAM9260 SoC.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 drivers/ata/Kconfig     |    8 +
 drivers/ata/Makefile    |    1 +
 drivers/ata/pata_at91.c |  364 +++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 373 insertions(+), 0 deletions(-)
 create mode 100644 drivers/ata/pata_at91.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 2aa1908..b17c57f 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -679,6 +679,14 @@ config PATA_PLATFORM
=20
 	  If unsure, say N.
=20
+config PATA_AT91
+	tristate "PATA support for AT91SAM9260"
+	depends on ARM && ARCH_AT91
+	help
+	  This option enables support for IDE devices on the Atmel AT91SAM926=
0 SoC.
+
+	  If unsure, say N.
+
 config PATA_OF_PLATFORM
 	tristate "OpenFirmware platform device PATA support"
 	depends on PATA_PLATFORM && PPC_OF
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 1558059..38906f9 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_PATA_SCH)		+=3D pata_sch.o
 obj-$(CONFIG_PATA_BF54X)	+=3D pata_bf54x.o
 obj-$(CONFIG_PATA_OCTEON_CF)	+=3D pata_octeon_cf.o
 obj-$(CONFIG_PATA_PLATFORM)	+=3D pata_platform.o
+obj-$(CONFIG_PATA_AT91)	+=3D pata_at91.o
 obj-$(CONFIG_PATA_OF_PLATFORM)	+=3D pata_of_platform.o
 obj-$(CONFIG_PATA_ICSIDE)	+=3D pata_icside.o
 # Should be last but two libata driver
diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
new file mode 100644
index 0000000..170a80e
--- /dev/null
+++ b/drivers/ata/pata_at91.c
@@ -0,0 +1,364 @@
+/*
+ * PATA driver for AT91SAM9260 Static Memory Controller
+ * with CompactFlash interface in True IDE mode
+ *
+ * Copyright (C) 2009 Matyukevich Sergey
+ *
+ * Based on:
+ *      * generic platform driver by Paul Mundt: drivers/ata/pata_plat=
form.c
+ *      * pata_at32 driver by Kristoffer Nyborg Gregertsen
+ *      * at91_ide driver by Stanislaw Gruszka
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <scsi/scsi_host.h>
+#include <linux/ata.h>
+#include <linux/clk.h>
+#include <linux/libata.h>
+#include <linux/platform_device.h>
+#include <linux/ata_platform.h>
+
+#include <mach/at91sam9260_matrix.h>
+#include <mach/at91sam9_smc.h>
+#include <mach/at91sam9260.h>
+#include <mach/board.h>
+#include <mach/gpio.h>
+
+
+#define DRV_NAME "pata_at91"
+#define DRV_VERSION "0.1"
+
+#define CF_IDE_OFFSET	    0x00c00000
+#define CF_ALT_IDE_OFFSET   0x00e00000
+#define CF_IDE_RES_SIZE     0x08
+
+static int pio_mask =3D ATA_PIO4;
+module_param(pio_mask, int, 0);
+
+struct at91_ide_info {
+	unsigned long mode;
+	unsigned int cs;
+
+	void __iomem *ide_addr;
+	void __iomem *alt_addr;
+};
+
+const struct ata_timing initial_timing =3D
+	{XFER_PIO_0, 70, 290, 240, 600, 165, 150, 600, 0};
+
+static unsigned int calc_mck_cycles(unsigned int ns, unsigned int mck_=
hz)
+{
+	unsigned long mul;
+
+    /*
+     * cycles =3D x [nsec] * f [Hz] / 10^9 [ns in sec] =3D
+     *     x * (f / 1_000_000_000) =3D
+     *     x * ((f * 65536) / 1_000_000_000) / 65536 =3D
+     *     x * (((f / 10_000) * 65536) / 100_000) / 65536 =3D
+     */
+
+    mul =3D (mck_hz / 10000) << 16;
+    mul /=3D 100000;
+
+    return (ns * mul + 65536) >> 16;    /* rounding */
+}
+
+static void set_smc_mode(struct at91_ide_info *info)
+{
+    at91_sys_write(AT91_SMC_MODE(info->cs), info->mode);
+    return;
+}
+
+static void set_smc_timing(struct device *dev,
+		struct at91_ide_info *info, const struct ata_timing *ata)
+{
+	int read_cycle, write_cycle, active, recover;
+	int nrd_setup, nrd_pulse, nrd_recover;
+	int nwe_setup, nwe_pulse;
+
+	int ncs_write_setup, ncs_write_pulse;
+	int ncs_read_setup, ncs_read_pulse;
+
+	unsigned int mck_hz;
+	struct clk *mck;
+
+	read_cycle  =3D ata->cyc8b;
+	nrd_setup   =3D ata->setup;
+	nrd_pulse   =3D ata->act8b;
+	nrd_recover =3D ata->rec8b;
+
+	mck =3D clk_get(NULL, "mck");
+	BUG_ON(IS_ERR(mck));
+	mck_hz =3D clk_get_rate(mck);
+
+	read_cycle  =3D calc_mck_cycles(read_cycle, mck_hz);
+	nrd_setup   =3D calc_mck_cycles(nrd_setup, mck_hz);
+	nrd_pulse   =3D calc_mck_cycles(nrd_pulse, mck_hz);
+	nrd_recover =3D calc_mck_cycles(nrd_recover, mck_hz);
+
+	clk_put(mck);
+
+	active  =3D nrd_setup + nrd_pulse;
+	recover =3D read_cycle - active;
+
+	/* Need at least two cycles recovery */
+	if (recover < 2)
+		read_cycle =3D active + 2;
+
+	/* (CS0, CS1, DIR, OE) <=3D (CFCE1, CFCE2, CFRNW, NCSX) timings */
+	ncs_read_setup =3D 1;
+	ncs_read_pulse =3D read_cycle - 2;
+
+	/* Write timings same as read timings */
+	write_cycle =3D read_cycle;
+	nwe_setup =3D nrd_setup;
+	nwe_pulse =3D nrd_pulse;
+	ncs_write_setup =3D ncs_read_setup;
+	ncs_write_pulse =3D ncs_read_pulse;
+
+	dev_dbg(dev, "ATA timings: nrd_setup =3D %d nrd_pulse =3D %d nrd_cycl=
e =3D %d\n",
+			nrd_setup, nrd_pulse, read_cycle);
+	dev_dbg(dev, "ATA timings: nwe_setup =3D %d nwe_pulse =3D %d nwe_cycl=
e =3D %d\n",
+			nwe_setup, nwe_pulse, write_cycle);
+	dev_dbg(dev, "ATA timings: ncs_read_setup =3D %d ncs_read_pulse =3D %=
d\n",
+			ncs_read_setup, ncs_read_pulse);
+	dev_dbg(dev, "ATA timings: ncs_write_setup =3D %d ncs_write_pulse =3D=
 %d\n",
+			ncs_write_setup, ncs_write_pulse);
+
+	at91_sys_write(AT91_SMC_SETUP(info->cs),
+			AT91_SMC_NWESETUP_(nwe_setup) |
+			AT91_SMC_NRDSETUP_(nrd_setup) |
+			AT91_SMC_NCS_WRSETUP_(ncs_write_setup) |
+			AT91_SMC_NCS_RDSETUP_(ncs_read_setup));
+
+	at91_sys_write(AT91_SMC_PULSE(info->cs),
+			AT91_SMC_NWEPULSE_(nwe_pulse) |
+			AT91_SMC_NRDPULSE_(nrd_pulse) |
+			AT91_SMC_NCS_WRPULSE_(ncs_write_pulse) |
+			AT91_SMC_NCS_RDPULSE_(ncs_read_pulse));
+
+	at91_sys_write(AT91_SMC_CYCLE(info->cs),
+			AT91_SMC_NWECYCLE_(write_cycle) |
+			AT91_SMC_NRDCYCLE_(read_cycle));
+
+	return;
+}
+
+static void pata_at91_set_piomode(struct ata_port *ap, struct ata_devi=
ce *adev)
+{
+	struct at91_ide_info *info =3D ap->host->private_data;
+	struct ata_timing timing;
+	int ret;
+
+	/* Compute ATA timing and set it to SMC */
+	ret =3D ata_timing_compute(adev, adev->pio_mode, &timing, 1000, 0);
+	if (ret) {
+		dev_warn(ap->dev, "Failed to compute ATA timing %d, \
+				set PIO_0 timing\n", ret);
+		set_smc_timing(ap->dev, info, &initial_timing);
+	} else {
+		set_smc_timing(ap->dev, info, &timing);
+	}
+
+	/* Setup SMC mode */
+	set_smc_mode(info);
+
+	return;
+}
+
+static unsigned int pata_at91_data_xfer_noirq(struct ata_device *dev,
+		unsigned char *buf, unsigned int buflen, int rw)
+{
+	struct at91_ide_info *info =3D dev->link->ap->host->private_data;
+	unsigned int consumed;
+	unsigned long flags;
+	unsigned int mode;
+
+	local_irq_save(flags);
+	mode =3D at91_sys_read(AT91_SMC_MODE(info->cs));
+
+	/* set 16bit mode before writing data */
+	at91_sys_write(AT91_SMC_MODE(info->cs),
+			(mode & ~AT91_SMC_DBW) | AT91_SMC_DBW_16);
+
+	consumed =3D ata_sff_data_xfer(dev, buf, buflen, rw);
+
+	/* restore 8bit mode after data is written */
+	at91_sys_write(AT91_SMC_MODE(info->cs),
+			(mode & ~AT91_SMC_DBW) | AT91_SMC_DBW_8);
+
+	local_irq_restore(flags);
+	return consumed;
+}
+
+static struct scsi_host_template pata_at91_sht =3D {
+	ATA_PIO_SHT(DRV_NAME),
+};
+
+static struct ata_port_operations pata_at91_port_ops =3D {
+	.inherits	=3D &ata_sff_port_ops,
+
+	.sff_data_xfer	=3D pata_at91_data_xfer_noirq,
+	.set_piomode	=3D pata_at91_set_piomode,
+	.cable_detect	=3D ata_cable_40wire,
+	.port_start	=3D ATA_OP_NULL,
+};
+
+static int __devinit pata_at91_probe(struct platform_device *pdev)
+{
+	struct at91_cf_data *board =3D pdev->dev.platform_data;
+	struct device *dev =3D &pdev->dev;
+	struct at91_ide_info *info;
+	struct resource *mem_res;
+	struct ata_host *host;
+	struct ata_port *ap;
+	int irq_flags =3D 0;
+	int irq =3D 0;
+	int ret;
+
+	/*  get platform resources: IO/CTL memories and irq/rst pins */
+
+	if (pdev->num_resources !=3D 1) {
+		dev_err(&pdev->dev, "invalid number of resources\n");
+		return -EINVAL;
+	}
+
+	mem_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!mem_res) {
+		dev_err(dev, "failed to get mem resource\n");
+		return -EINVAL;
+	}
+
+	irq =3D board->irq_pin;
+
+	/* init ata host */
+
+	host =3D ata_host_alloc(dev, 1);
+
+	if (!host)
+		return -ENOMEM;
+
+	ap =3D host->ports[0];
+	ap->ops =3D &pata_at91_port_ops;
+	ap->flags |=3D ATA_FLAG_SLAVE_POSS;
+	ap->pio_mask =3D pio_mask;
+
+	if (!irq) {
+		ap->flags |=3D ATA_FLAG_PIO_POLLING;
+		ata_port_desc(ap, "no IRQ, using PIO polling");
+	}
+
+	info =3D kzalloc(sizeof(*info), GFP_KERNEL);
+
+	if (!info) {
+		dev_err(dev, "failed to allocate memory for private data\n");
+		return -ENOMEM;
+	}
+
+	info->cs    =3D board->chipselect;
+	info->mode  =3D AT91_SMC_READMODE | AT91_SMC_WRITEMODE |
+		AT91_SMC_EXNWMODE_READY | AT91_SMC_BAT_SELECT |
+		AT91_SMC_DBW_8 | AT91_SMC_TDF_(0);
+
+	info->ide_addr =3D devm_ioremap(dev,
+			mem_res->start + CF_IDE_OFFSET, CF_IDE_RES_SIZE);
+
+	if (!info->ide_addr) {
+		dev_err(dev, "failed to map IO base\n");
+		ret =3D -ENOMEM;
+		goto err_ide_ioremap;
+	}
+
+	info->alt_addr =3D devm_ioremap(dev,
+			mem_res->start + CF_ALT_IDE_OFFSET, CF_IDE_RES_SIZE);
+
+	if (!info->alt_addr) {
+		dev_err(dev, "failed to map CTL base\n");
+		ret =3D -ENOMEM;
+		goto err_alt_ioremap;
+	}
+
+	ap->ioaddr.cmd_addr =3D info->ide_addr;
+	ap->ioaddr.ctl_addr =3D info->alt_addr + 0x06;
+	ap->ioaddr.altstatus_addr =3D ap->ioaddr.ctl_addr;
+
+	ata_sff_std_ports(&ap->ioaddr);
+
+	ata_port_desc(ap, "mmio cmd 0x%llx ctl 0x%llx",
+			(unsigned long long)mem_res->start + CF_IDE_OFFSET,
+			(unsigned long long)mem_res->start + CF_ALT_IDE_OFFSET);
+
+	host->private_data =3D info;
+
+	return ata_host_activate(host, irq ? gpio_to_irq(irq) : 0,
+			irq ? ata_sff_interrupt : NULL,
+			irq_flags, &pata_at91_sht);
+
+err_alt_ioremap:
+	devm_iounmap(dev, info->ide_addr);
+
+err_ide_ioremap:
+	kfree(info);
+
+	return ret;
+}
+
+static int __devexit pata_at91_remove(struct platform_device *pdev)
+{
+	struct ata_host *host =3D dev_get_drvdata(&pdev->dev);
+	struct at91_ide_info *info =3D host->private_data;
+	struct device *dev =3D &pdev->dev;
+
+	if (!host)
+		return 0;
+
+	ata_host_detach(host);
+
+	if (!info)
+		return 0;
+
+	devm_iounmap(dev, info->ide_addr);
+	devm_iounmap(dev, info->alt_addr);
+
+	kfree(info);
+	return 0;
+}
+
+static struct platform_driver pata_at91_driver =3D {
+	.probe		=3D pata_at91_probe,
+	.remove		=3D __devexit_p(pata_at91_remove),
+	.driver 	=3D {
+		.name		=3D DRV_NAME,
+		.owner		=3D THIS_MODULE,
+	},
+};
+
+static int __init pata_at91_init(void)
+{
+	return platform_driver_register(&pata_at91_driver);
+}
+
+static void __exit pata_at91_exit(void)
+{
+	platform_driver_unregister(&pata_at91_driver);
+}
+
+
+module_init(pata_at91_init);
+module_exit(pata_at91_exit);
+
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Driver for CF in True IDE mode on AT91SAM9260 SoC"=
);
+MODULE_AUTHOR("Matyukevich Sergey");
+MODULE_VERSION(DRV_VERSION);
+
--=20
1.6.2.5



