From: Juergen Schindele <schindele@nentec.de>
Subject: Re: [PATCH v5] libata: pata_samsung: Add Samsung PATA controller
	driver
Date: Tue, 29 Jun 2010 15:29:43 +0200
Message-ID: <201006291529.45822.schindele@nentec.de>
References: <1277809518-1122-1-git-send-email-kgene.kim@samsung.com>
Reply-To: schindele@nentec.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1277809518-1122-1-git-send-email-kgene.kim@samsung.com>
Content-Disposition: inline
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
Cc: Kukjin Kim <kgene.kim@samsung.com>, sshtylyov@mvista.com, linux-ide@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Abhilash Kesavan <a.kesavan@samsung.com>, jgarzik@redhat.com
List-Id: linux-ide@vger.kernel.org

Am Dienstag, 29. Juni 2010 schrieb Kukjin Kim:
> From: Abhilash Kesavan <a.kesavan@samsung.com>
> =

> Adds support for the Samsung PATA controller. This driver is based on the
> Libata subsystem and references the earlier patches sent for IDE subsyste=
m.
Dear Kukjin Kim,
as i had trouble with CF / trueIDE on PXA, have you read this thread ??
<http://www.spinics.net/lists/arm-kernel/msg91461.html>
Are you sure you dont need a "dcache_flush-page" ???
Its just a thought to help you avoid problems.

Bye
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
>  drivers/ata/Kconfig           |    9 +
>  drivers/ata/Makefile          |    1 +
>  drivers/ata/pata_samsung_cf.c |  728 +++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 738 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/pata_samsung_cf.c
> =

> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 73f8833..51e28e7 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -796,6 +796,15 @@ config PATA_RZ1000
>  =

>  	  If unsure, say N.
>  =

> +config PATA_SAMSUNG_CF
> +	tristate "Samsung SoC PATA support"
> +	depends on SAMSUNG_DEV_IDE
> +	help
> +	  This option enables basic support for Samsung's S3C/S5P board
> +	  PATA controllers via the new ATA layer
> +
> +	  If unsure, say N.
> +
>  config PATA_WINBOND_VLB
>  	tristate "Winbond W83759A VLB PATA support (Experimental)"
>  	depends on ISA && EXPERIMENTAL
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 7ef89d7..9576776 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_PATA_OF_PLATFORM)	+=3D pata_of_platform.o
>  obj-$(CONFIG_PATA_QDI)		+=3D pata_qdi.o
>  obj-$(CONFIG_PATA_RB532)	+=3D pata_rb532_cf.o
>  obj-$(CONFIG_PATA_RZ1000)	+=3D pata_rz1000.o
> +obj-$(CONFIG_PATA_SAMSUNG_CF)	+=3D pata_samsung_cf.o
>  obj-$(CONFIG_PATA_WINBOND_VLB)	+=3D pata_winbond.o
>  =

>  # Should be last but two libata driver
> diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
> new file mode 100644
> index 0000000..26b96c3
> --- /dev/null
> +++ b/drivers/ata/pata_samsung_cf.c
> @@ -0,0 +1,728 @@
> +/*
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * PATA driver for Samsung SoCs.
> + * Supports CF Interface in True IDE mode. Currently only PIO mode has b=
een
> + * implemented; UDMA support has to be added.
> + *
> + * Based on:
> + *	PATA driver for AT91SAM9260 Static Memory Controller
> + *	PATA driver for Toshiba SCC controller
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/libata.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <plat/ata.h>
> +#include <plat/regs-ata.h>
> +
> +#define DRV_NAME "pata_samsung_cf"
> +#define DRV_VERSION "0.1"
> +
> +enum s3c_cpu_type {
> +	TYPE_S3C64XX,
> +	TYPE_S5PC100,
> +	TYPE_S5PV210,
> +};
> +
> +/*
> + * struct s3c_ide_info - S3C PATA instance.
> + * @clk: The clock resource for this controller.
> + * @ide_addr: The area mapped for the hardware registers.
> + * @sfr_addr: The area mapped for the special function registers.
> + * @irq: The IRQ number we are using.
> + * @cpu_type: The exact type of this controller.
> + * @fifo_status_reg: The ATA_FIFO_STATUS register offset.
> + */
> +struct s3c_ide_info {
> +	struct clk *clk;
> +	void __iomem *ide_addr;
> +	void __iomem *sfr_addr;
> +	unsigned int irq;
> +	enum s3c_cpu_type cpu_type;
> +	unsigned int fifo_status_reg;
> +};
> +
> +static void pata_s3c_set_endian(void __iomem *s3c_ide_regbase, u8 mode)
> +{
> +	u32 reg =3D readl(s3c_ide_regbase + S3C_ATA_CFG);
> +	reg =3D mode ? (reg & ~S3C_ATA_CFG_SWAP) : (reg | S3C_ATA_CFG_SWAP);
> +	writel(reg, s3c_ide_regbase + S3C_ATA_CFG);
> +}
> +
> +static void pata_s3c_cfg_mode(void __iomem *s3c_ide_sfrbase)
> +{
> +	/* Select true-ide as the internal operating mode */
> +	writel(readl(s3c_ide_sfrbase + S3C_CFATA_MUX) | S3C_CFATA_MUX_TRUEIDE,
> +		s3c_ide_sfrbase + S3C_CFATA_MUX);
> +}
> +
> +static unsigned long
> +pata_s3c_setup_timing(struct s3c_ide_info *info, const struct ata_timing=
 *ata)
> +{
> +	int t1 =3D ata->setup;
> +	int t2 =3D ata->act8b;
> +	int t2i =3D ata->rec8b;
> +	ulong piotime;
> +
> +	piotime =3D ((t2i & 0xff) << 12) | ((t2 & 0xff) << 4) | (t1 & 0xf);
> +
> +	return piotime;
> +}
> +
> +static void pata_s3c_set_piomode(struct ata_port *ap, struct ata_device =
*adev)
> +{
> +	struct s3c_ide_info *info =3D ap->host->private_data;
> +	struct ata_timing timing;
> +	int cycle_time;
> +	ulong ata_cfg =3D readl(info->ide_addr + S3C_ATA_CFG);
> +	ulong piotime;
> +
> +	/* Enables IORDY if mode requires it */
> +	if (ata_pio_need_iordy(adev))
> +		ata_cfg |=3D S3C_ATA_CFG_IORDYEN;
> +	else
> +		ata_cfg &=3D ~S3C_ATA_CFG_IORDYEN;
> +
> +	cycle_time =3D (int)(1000000000UL / clk_get_rate(info->clk));
> +
> +	ata_timing_compute(adev, adev->pio_mode, &timing,
> +					cycle_time * 1000, 0);
> +
> +	piotime =3D pata_s3c_setup_timing(info, &timing);
> +
> +	writel(ata_cfg, info->ide_addr + S3C_ATA_CFG);
> +	writel(piotime, info->ide_addr + S3C_ATA_PIO_TIME);
> +}
> +
> +/*
> + * Waits until the IDE controller is able to perform next read/write
> + * operation to the disk. Needed for 64XX series boards only.
> + */
> +static int wait_for_host_ready(struct s3c_ide_info *info)
> +{
> +	ulong timeout;
> +	void __iomem *fifo_reg =3D info->ide_addr + info->fifo_status_reg;
> +
> +	/* wait for maximum of 20 msec */
> +	timeout =3D jiffies + msecs_to_jiffies(20);
> +	while (time_before(jiffies, timeout)) {
> +		if ((readl(fifo_reg) >> 28) =3D=3D 0)
> +			return 0;
> +	}
> +	return -EBUSY;
> +}
> +
> +/*
> + * Writes to one of the task file registers.
> + */
> +static void ata_outb(struct ata_host *host, u8 addr, void __iomem *reg)
> +{
> +	struct s3c_ide_info *info =3D host->private_data;
> +
> +	wait_for_host_ready(info);
> +	writeb(addr, reg);
> +}
> +
> +/*
> + * Reads from one of the task file registers.
> + */
> +static u8 ata_inb(struct ata_host *host, void __iomem *reg)
> +{
> +	struct s3c_ide_info *info =3D host->private_data;
> +	u8 temp;
> +
> +	wait_for_host_ready(info);
> +	(void) readb(reg);
> +	wait_for_host_ready(info);
> +	temp =3D readb(info->ide_addr + S3C_ATA_PIO_RDATA);
> +	return temp;
> +}
> +
> +/*
> + * pata_s3c_tf_load - send taskfile registers to host controller
> + */
> +static void pata_s3c_tf_load(struct ata_port *ap,
> +				const struct ata_taskfile *tf)
> +{
> +	struct ata_ioports *ioaddr =3D &ap->ioaddr;
> +	unsigned int is_addr =3D tf->flags & ATA_TFLAG_ISADDR;
> +
> +	if (tf->ctl !=3D ap->last_ctl) {
> +		ata_outb(ap->host, tf->ctl, ioaddr->ctl_addr);
> +		ap->last_ctl =3D tf->ctl;
> +		ata_wait_idle(ap);
> +	}
> +
> +	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
> +		ata_outb(ap->host, tf->hob_feature, ioaddr->feature_addr);
> +		ata_outb(ap->host, tf->hob_nsect, ioaddr->nsect_addr);
> +		ata_outb(ap->host, tf->hob_lbal, ioaddr->lbal_addr);
> +		ata_outb(ap->host, tf->hob_lbam, ioaddr->lbam_addr);
> +		ata_outb(ap->host, tf->hob_lbah, ioaddr->lbah_addr);
> +	}
> +
> +	if (is_addr) {
> +		ata_outb(ap->host, tf->feature, ioaddr->feature_addr);
> +		ata_outb(ap->host, tf->nsect, ioaddr->nsect_addr);
> +		ata_outb(ap->host, tf->lbal, ioaddr->lbal_addr);
> +		ata_outb(ap->host, tf->lbam, ioaddr->lbam_addr);
> +		ata_outb(ap->host, tf->lbah, ioaddr->lbah_addr);
> +	}
> +
> +	if (tf->flags & ATA_TFLAG_DEVICE)
> +		ata_outb(ap->host, tf->device, ioaddr->device_addr);
> +
> +	ata_wait_idle(ap);
> +}
> +
> +/*
> + * pata_s3c_tf_read - input device's ATA taskfile shadow registers
> + */
> +static void pata_s3c_tf_read(struct ata_port *ap, struct ata_taskfile *t=
f)
> +{
> +	struct ata_ioports *ioaddr =3D &ap->ioaddr;
> +
> +	tf->feature =3D ata_inb(ap->host, ioaddr->error_addr);
> +	tf->nsect =3D ata_inb(ap->host, ioaddr->nsect_addr);
> +	tf->lbal =3D ata_inb(ap->host, ioaddr->lbal_addr);
> +	tf->lbam =3D ata_inb(ap->host, ioaddr->lbam_addr);
> +	tf->lbah =3D ata_inb(ap->host, ioaddr->lbah_addr);
> +	tf->device =3D ata_inb(ap->host, ioaddr->device_addr);
> +
> +	if (tf->flags & ATA_TFLAG_LBA48) {
> +		iowrite8(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
> +		tf->hob_feature =3D ata_inb(ap->host, ioaddr->error_addr);
> +		tf->hob_nsect =3D ata_inb(ap->host, ioaddr->nsect_addr);
> +		tf->hob_lbal =3D ata_inb(ap->host, ioaddr->lbal_addr);
> +		tf->hob_lbam =3D ata_inb(ap->host, ioaddr->lbam_addr);
> +		tf->hob_lbah =3D ata_inb(ap->host, ioaddr->lbah_addr);
> +		iowrite8(tf->ctl, ioaddr->ctl_addr);
> +		ap->last_ctl =3D tf->ctl;
> +	}
> +}
> +
> +/*
> + * pata_s3c_exec_command - issue ATA command to host controller
> + */
> +static void pata_s3c_exec_command(struct ata_port *ap,
> +				const struct ata_taskfile *tf)
> +{
> +	ata_outb(ap->host, tf->command, ap->ioaddr.command_addr);
> +	ata_sff_pause(ap);
> +}
> +
> +/*
> + * pata_s3c_check_status - Read device status register
> + */
> +static u8 pata_s3c_check_status(struct ata_port *ap)
> +{
> +	return ata_inb(ap->host, ap->ioaddr.status_addr);
> +}
> +
> +/*
> + * pata_s3c_check_altstatus - Read alternate device status register
> + */
> +static u8 pata_s3c_check_altstatus(struct ata_port *ap)
> +{
> +	return ata_inb(ap->host, ap->ioaddr.altstatus_addr);
> +}
> +
> +/*
> + * pata_s3c_data_xfer - Transfer data by PIO
> + */
> +unsigned int pata_s3c_data_xfer(struct ata_device *dev, unsigned char *b=
uf,
> +				unsigned int buflen, int rw)
> +{
> +	struct ata_port *ap =3D dev->link->ap;
> +	struct s3c_ide_info *info =3D ap->host->private_data;
> +	void __iomem *data_addr =3D ap->ioaddr.data_addr;
> +	unsigned int words =3D buflen >> 1, i;
> +	u16 *data_ptr =3D (u16 *)buf;
> +
> +	/* Requires wait same as in ata_inb/ata_outb */
> +	if (rw =3D=3D READ)
> +		for (i =3D 0; i < words; i++, data_ptr++) {
> +			wait_for_host_ready(info);
> +			(void) readw(data_addr);
> +			wait_for_host_ready(info);
> +			*data_ptr =3D readw(info->ide_addr
> +					+ S3C_ATA_PIO_RDATA);
> +		}
> +	else
> +		for (i =3D 0; i < words; i++, data_ptr++) {
> +			wait_for_host_ready(info);
> +			writew(*data_ptr, data_addr);
> +		}
> +
> +	if (buflen & 0x01)
> +		dev_err(ap->dev, "unexpected trailing data\n");
> +
> +	return words << 1;
> +}
> +
> +/*
> + * pata_s3c_dev_select - Select device on ATA bus
> + */
> +static void pata_s3c_dev_select(struct ata_port *ap, unsigned int device)
> +{
> +	u8 tmp =3D ATA_DEVICE_OBS;
> +
> +	if (device !=3D 0)
> +		tmp |=3D ATA_DEV1;
> +
> +	ata_outb(ap->host, tmp, ap->ioaddr.device_addr);
> +	ata_sff_pause(ap);
> +}
> +
> +/*
> + * pata_s3c_devchk - PATA device presence detection
> + */
> +static unsigned int pata_s3c_devchk(struct ata_port *ap,
> +				unsigned int device)
> +{
> +	struct ata_ioports *ioaddr =3D &ap->ioaddr;
> +	u8 nsect, lbal;
> +
> +	pata_s3c_dev_select(ap, device);
> +
> +	ata_outb(ap->host, 0x55, ioaddr->nsect_addr);
> +	ata_outb(ap->host, 0xaa, ioaddr->lbal_addr);
> +
> +	ata_outb(ap->host, 0xaa, ioaddr->nsect_addr);
> +	ata_outb(ap->host, 0x55, ioaddr->lbal_addr);
> +
> +	ata_outb(ap->host, 0x55, ioaddr->nsect_addr);
> +	ata_outb(ap->host, 0xaa, ioaddr->lbal_addr);
> +
> +	nsect =3D ata_inb(ap->host, ioaddr->nsect_addr);
> +	lbal =3D ata_inb(ap->host, ioaddr->lbal_addr);
> +
> +	if ((nsect =3D=3D 0x55) && (lbal =3D=3D 0xaa))
> +		return 1;	/* we found a device */
> +
> +	return 0;		/* nothing found */
> +}
> +
> +/*
> + * pata_s3c_wait_after_reset - wait for devices to become ready after re=
set
> + */
> +static int pata_s3c_wait_after_reset(struct ata_link *link,
> +		unsigned int devmask, unsigned long deadline)
> +{
> +	struct ata_port *ap =3D link->ap;
> +	struct ata_ioports *ioaddr =3D &ap->ioaddr;
> +	unsigned int dev0 =3D devmask & (1 << 0);
> +	unsigned int dev1 =3D devmask & (1 << 1);
> +	int rc, ret =3D 0;
> +
> +	msleep(ATA_WAIT_AFTER_RESET);
> +
> +	/* always check readiness of the master device */
> +	rc =3D ata_sff_wait_ready(link, deadline);
> +	/* -ENODEV means the odd clown forgot the D7 pulldown resistor
> +	 * and TF status is 0xff, bail out on it too.
> +	 */
> +	if (rc)
> +		return rc;
> +
> +	/* if device 1 was found in ata_devchk, wait for register
> +	 * access briefly, then wait for BSY to clear.
> +	 */
> +	if (dev1) {
> +		int i;
> +
> +		pata_s3c_dev_select(ap, 1);
> +
> +		/* Wait for register access.  Some ATAPI devices fail
> +		 * to set nsect/lbal after reset, so don't waste too
> +		 * much time on it.  We're gonna wait for !BSY anyway.
> +		 */
> +		for (i =3D 0; i < 2; i++) {
> +			u8 nsect, lbal;
> +
> +			nsect =3D ata_inb(ap->host, ioaddr->nsect_addr);
> +			lbal =3D ata_inb(ap->host, ioaddr->lbal_addr);
> +			if ((nsect =3D=3D 1) && (lbal =3D=3D 1))
> +				break;
> +			msleep(50);	/* give drive a breather */
> +		}
> +
> +		rc =3D ata_sff_wait_ready(link, deadline);
> +		if (rc) {
> +			if (rc !=3D -ENODEV)
> +				return rc;
> +			ret =3D rc;
> +		}
> +	}
> +
> +	/* is all this really necessary? */
> +	pata_s3c_dev_select(ap, 0);
> +	if (dev1)
> +		pata_s3c_dev_select(ap, 1);
> +	if (dev0)
> +		pata_s3c_dev_select(ap, 0);
> +
> +	return ret;
> +}
> +
> +/*
> + * pata_s3c_bus_softreset - PATA device software reset
> + */
> +static unsigned int pata_s3c_bus_softreset(struct ata_port *ap,
> +		unsigned int devmask, unsigned long deadline)
> +{
> +	struct ata_ioports *ioaddr =3D &ap->ioaddr;
> +
> +	/* software reset.  causes dev0 to be selected */
> +	ata_outb(ap->host, ap->ctl, ioaddr->ctl_addr);
> +	udelay(20);
> +	ata_outb(ap->host, ap->ctl | ATA_SRST, ioaddr->ctl_addr);
> +	udelay(20);
> +	ata_outb(ap->host, ap->ctl, ioaddr->ctl_addr);
> +	ap->last_ctl =3D ap->ctl;
> +
> +	return pata_s3c_wait_after_reset(&ap->link, devmask, deadline);
> +}
> +
> +/*
> + * pata_s3c_softreset - reset host port via ATA SRST
> + */
> +static int pata_s3c_softreset(struct ata_link *link, unsigned int *class=
es,
> +			 unsigned long deadline)
> +{
> +	struct ata_port *ap =3D link->ap;
> +	unsigned int devmask =3D 0;
> +	int rc;
> +	u8 err;
> +
> +	/* determine if device 0/1 are present */
> +	if (pata_s3c_devchk(ap, 0))
> +		devmask |=3D (1 << 0);
> +
> +	/* select device 0 again */
> +	pata_s3c_dev_select(ap, 0);
> +
> +	/* issue bus reset */
> +	rc =3D pata_s3c_bus_softreset(ap, devmask, deadline);
> +	/* if link is occupied, -ENODEV too is an error */
> +	if (rc && rc !=3D -ENODEV) {
> +		ata_link_printk(link, KERN_ERR, "SRST failed (errno=3D%d)\n", rc);
> +		return rc;
> +	}
> +
> +	/* determine by signature whether we have ATA or ATAPI devices */
> +	classes[0] =3D ata_sff_dev_classify(&ap->link.device[0],
> +					  devmask & (1 << 0), &err);
> +
> +	return 0;
> +}
> +
> +/*
> + * pata_s3c_set_devctl - Write device control register
> + */
> +static void pata_s3c_set_devctl(struct ata_port *ap, u8 ctl)
> +{
> +	ata_outb(ap->host, ctl, ap->ioaddr.ctl_addr);
> +}
> +
> +static struct scsi_host_template pata_s3c_sht =3D {
> +	ATA_PIO_SHT(DRV_NAME),
> +};
> +
> +static struct ata_port_operations pata_s3c_port_ops =3D {
> +	.inherits		=3D &ata_sff_port_ops,
> +	.sff_check_status	=3D pata_s3c_check_status,
> +	.sff_check_altstatus    =3D pata_s3c_check_altstatus,
> +	.sff_tf_load		=3D pata_s3c_tf_load,
> +	.sff_tf_read		=3D pata_s3c_tf_read,
> +	.sff_data_xfer		=3D pata_s3c_data_xfer,
> +	.sff_exec_command	=3D pata_s3c_exec_command,
> +	.sff_dev_select         =3D pata_s3c_dev_select,
> +	.sff_set_devctl         =3D pata_s3c_set_devctl,
> +	.softreset		=3D pata_s3c_softreset,
> +	.set_piomode		=3D pata_s3c_set_piomode,
> +};
> +
> +static struct ata_port_operations pata_s5p_port_ops =3D {
> +	.inherits		=3D &ata_sff_port_ops,
> +	.set_piomode		=3D pata_s3c_set_piomode,
> +};
> +
> +static void pata_s3c_enable(void *s3c_ide_regbase, bool state)
> +{
> +	u32 temp =3D readl(s3c_ide_regbase + S3C_ATA_CTRL);
> +	temp =3D state ? (temp | 1) : (temp & ~1);
> +	writel(temp, s3c_ide_regbase + S3C_ATA_CTRL);
> +}
> +
> +static irqreturn_t pata_s3c_irq(int irq, void *dev_instance)
> +{
> +	struct ata_host *host =3D dev_instance;
> +	struct s3c_ide_info *info =3D host->private_data;
> +	u32 reg;
> +
> +	reg =3D readl(info->ide_addr + S3C_ATA_IRQ);
> +	writel(reg, info->ide_addr + S3C_ATA_IRQ);
> +
> +	return ata_sff_interrupt(irq, dev_instance);
> +}
> +
> +static void pata_s3c_hwinit(struct s3c_ide_info *info,
> +				struct s3c_ide_platdata *pdata)
> +{
> +	switch (info->cpu_type) {
> +	case TYPE_S3C64XX:
> +		/* Configure as big endian */
> +		pata_s3c_cfg_mode(info->sfr_addr);
> +		pata_s3c_set_endian(info->ide_addr, 1);
> +		pata_s3c_enable(info->ide_addr, true);
> +		msleep(100);
> +
> +		/* Remove IRQ Status */
> +		writel(0x1f, info->ide_addr + S3C_ATA_IRQ);
> +		writel(0x1b, info->ide_addr + S3C_ATA_IRQ_MSK);
> +		break;
> +
> +	case TYPE_S5PC100:
> +		pata_s3c_cfg_mode(info->sfr_addr);
> +		/* FALLTHROUGH */
> +
> +	case TYPE_S5PV210:
> +		/* Configure as little endian */
> +		pata_s3c_set_endian(info->ide_addr, 0);
> +		pata_s3c_enable(info->ide_addr, true);
> +		msleep(100);
> +
> +		/* Remove IRQ Status */
> +		writel(0x3f, info->ide_addr + S3C_ATA_IRQ);
> +		writel(0x3f, info->ide_addr + S3C_ATA_IRQ_MSK);
> +		break;
> +
> +	default:
> +		BUG();
> +	}
> +}
> +
> +static int __init pata_s3c_probe(struct platform_device *pdev)
> +{
> +	struct s3c_ide_platdata *pdata =3D pdev->dev.platform_data;
> +	struct device *dev =3D &pdev->dev;
> +	struct s3c_ide_info *info;
> +	struct resource *res;
> +	struct ata_port *ap;
> +	struct ata_host *host;
> +	enum s3c_cpu_type cpu_type;
> +	int ret;
> +
> +	cpu_type =3D platform_get_device_id(pdev)->driver_data;
> +
> +	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		dev_err(dev, "failed to allocate memory for device data\n");
> +		return -ENOMEM;
> +	}
> +
> +	info->irq =3D platform_get_irq(pdev, 0);
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res =3D=3D NULL) {
> +		dev_err(dev, "failed to get mem resource\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!devm_request_mem_region(dev, res->start,
> +				resource_size(res), DRV_NAME)) {
> +		dev_err(dev, "error requesting register region\n");
> +		return -EBUSY;
> +	}
> +
> +	info->ide_addr =3D devm_ioremap(dev, res->start, resource_size(res));
> +	if (!info->ide_addr) {
> +		dev_err(dev, "failed to map IO base address\n");
> +		return -ENOMEM;
> +	}
> +
> +	info->clk =3D clk_get(&pdev->dev, "cfcon");
> +	if (IS_ERR(info->clk)) {
> +		dev_err(dev, "failed to get access to cf controller clock\n");
> +		ret =3D PTR_ERR(info->clk);
> +		info->clk =3D NULL;
> +		return ret;
> +	}
> +
> +	clk_enable(info->clk);
> +
> +	/* init ata host */
> +	host =3D ata_host_alloc(dev, 1);
> +	if (!host) {
> +		dev_err(dev, "failed to allocate ide host\n");
> +		ret =3D -ENOMEM;
> +		goto stop_clk;
> +	}
> +
> +	ap =3D host->ports[0];
> +	ap->flags |=3D ATA_FLAG_MMIO;
> +	ap->pio_mask =3D ATA_PIO4;
> +
> +	if (cpu_type =3D=3D TYPE_S3C64XX) {
> +		ap->ops =3D &pata_s3c_port_ops;
> +		info->sfr_addr =3D info->ide_addr + 0x1800;
> +		info->ide_addr +=3D 0x1900;
> +		info->fifo_status_reg =3D 0x94;
> +	} else if (cpu_type =3D=3D TYPE_S5PC100) {
> +		ap->ops =3D &pata_s5p_port_ops;
> +		info->sfr_addr =3D info->ide_addr + 0x1800;
> +		info->ide_addr +=3D 0x1900;
> +		info->fifo_status_reg =3D 0x84;
> +	} else {
> +		ap->ops =3D &pata_s5p_port_ops;
> +		info->fifo_status_reg =3D 0x84;
> +	}
> +
> +	info->cpu_type =3D cpu_type;
> +
> +	if (info->irq <=3D 0) {
> +		ap->flags |=3D ATA_FLAG_PIO_POLLING;
> +		info->irq =3D 0;
> +		ata_port_desc(ap, "no IRQ, using PIO polling\n");
> +	}
> +
> +	ap->ioaddr.cmd_addr =3D  info->ide_addr + S3C_ATA_CMD;
> +	ap->ioaddr.data_addr =3D info->ide_addr + S3C_ATA_PIO_DTR;
> +	ap->ioaddr.error_addr =3D info->ide_addr + S3C_ATA_PIO_FED;
> +	ap->ioaddr.feature_addr =3D info->ide_addr + S3C_ATA_PIO_FED;
> +	ap->ioaddr.nsect_addr =3D info->ide_addr + S3C_ATA_PIO_SCR;
> +	ap->ioaddr.lbal_addr =3D info->ide_addr + S3C_ATA_PIO_LLR;
> +	ap->ioaddr.lbam_addr =3D info->ide_addr + S3C_ATA_PIO_LMR;
> +	ap->ioaddr.lbah_addr =3D info->ide_addr + S3C_ATA_PIO_LHR;
> +	ap->ioaddr.device_addr =3D info->ide_addr + S3C_ATA_PIO_DVR;
> +	ap->ioaddr.status_addr =3D info->ide_addr + S3C_ATA_PIO_CSD;
> +	ap->ioaddr.command_addr =3D info->ide_addr + S3C_ATA_PIO_CSD;
> +	ap->ioaddr.altstatus_addr =3D info->ide_addr + S3C_ATA_PIO_DAD;
> +	ap->ioaddr.ctl_addr =3D info->ide_addr + S3C_ATA_PIO_DAD;
> +
> +	ata_port_desc(ap, "mmio cmd 0x%llx ",
> +			(unsigned long long)res->start);
> +
> +	host->private_data =3D info;
> +
> +	if (pdata && pdata->setup_gpio)
> +		pdata->setup_gpio();
> +
> +	/* Set endianness and enable the interface */
> +	pata_s3c_hwinit(info, pdata);
> +
> +	platform_set_drvdata(pdev, host);
> +
> +	return ata_host_activate(host, info->irq,
> +			info->irq ? pata_s3c_irq : NULL,
> +			0, &pata_s3c_sht);
> +
> +stop_clk:
> +	clk_disable(info->clk);
> +	clk_put(info->clk);
> +	return ret;
> +}
> +
> +static int __exit pata_s3c_remove(struct platform_device *pdev)
> +{
> +	struct ata_host *host =3D platform_get_drvdata(pdev);
> +	struct s3c_ide_info *info;
> +
> +	info =3D host->private_data;
> +	ata_host_detach(host);
> +
> +	clk_disable(info->clk);
> +	clk_put(info->clk);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int pata_s3c_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct ata_host *host =3D platform_get_drvdata(pdev);
> +	pm_message_t state =3D PMSG_SUSPEND;
> +
> +	return ata_host_suspend(host, state);
> +}
> +
> +static int pata_s3c_resume(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct ata_host *host =3D platform_get_drvdata(pdev);
> +	struct s3c_ide_platdata *pdata =3D pdev->dev.platform_data;
> +	struct s3c_ide_info *info;
> +
> +	info =3D host->private_data;
> +
> +	pata_s3c_hwinit(info, pdata);
> +	ata_host_resume(host);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops pata_s3c_pm_ops =3D {
> +	.suspend	=3D pata_s3c_suspend,
> +	.resume		=3D pata_s3c_resume,
> +};
> +#endif
> +
> +/* driver device registration */
> +static struct platform_device_id pata_s3c_driver_ids[] =3D {
> +	{
> +		.name		=3D "s3c64xx-pata",
> +		.driver_data	=3D TYPE_S3C64XX,
> +	}, {
> +		.name		=3D "s5pc100-pata",
> +		.driver_data	=3D TYPE_S5PC100,
> +	}, {
> +		.name		=3D "s5pv210-pata",
> +		.driver_data	=3D TYPE_S5PV210,
> +	},
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(platform, pata_s3c_driver_ids);
> +
> +static struct platform_driver pata_s3c_driver =3D {
> +	.remove		=3D __exit_p(pata_s3c_remove),
> +	.id_table	=3D pata_s3c_driver_ids,
> +	.driver		=3D {
> +		.name	=3D DRV_NAME,
> +		.owner	=3D THIS_MODULE,
> +#ifdef CONFIG_PM
> +		.pm	=3D &pata_s3c_pm_ops,
> +#endif
> +	},
> +};
> +
> +static int __init pata_s3c_init(void)
> +{
> +	return platform_driver_probe(&pata_s3c_driver, pata_s3c_probe);
> +}
> +
> +static void __exit pata_s3c_exit(void)
> +{
> +	platform_driver_unregister(&pata_s3c_driver);
> +}
> +
> +module_init(pata_s3c_init);
> +module_exit(pata_s3c_exit);
> +
> +MODULE_AUTHOR("Abhilash Kesavan, <a.kesavan@samsung.com>");
> +MODULE_DESCRIPTION("low-level driver for Samsung PATA controller");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VERSION);



-- =

--------------------------------------------------------------
J=FCrgen Schindele  =

Software-Entwicklung

PSI NENTEC GmbH
Greschbachstr. 12
76229 Karlsruhe
Deutschland
Telefon: +49 721 94249-51
Telefax: +49 721 94249-10
E-Mail:  schindele@nentec.de
WEB:     www.nentec.de
 =

Gesch=E4ftsf=FChrung: Klaus Becker, Roland Knapp
Sitz der Gesellschaft: Karlsruhe
Handelsregister: Amtsgericht Mannheim HRB 107658
 =

Diese E-Mail enth=E4lt vertrauliche oder rechtlich gesch=FCtzte Information=
en.
Wenn Sie nicht der vorgesehene Empf=E4nger sind, informieren Sie bitte sofo=
rt
den Absender und l=F6schen Sie diese E-Mail. Das unbefugte Kopieren dieser =
E-Mail
oder die unbefugte Weitergabe der enthaltenen Informationen ist nicht gesta=
ttet.
 =

The information contained in this message is confidential or protected by l=
aw.
If you are not the intended recipient, please contact the sender and delete=
 this
message. Any unauthorised copying of this message or unauthorised distribut=
ion of
the information contained herein is prohibited.
--------------------------------------------------------------
