From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v4] libata: pata_samsung_cf: Add Samsung PATA controller
 driver
Date: Tue, 29 Jun 2010 17:25:32 +0900
Message-ID: <00c601cb1764$a9231c10$fb695430$%kim@samsung.com>
References: <1276499263-12217-1-git-send-email-kgene.kim@samsung.com>
 <4C287576.6050506@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <4C287576.6050506@ru.mvista.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Sergei Shtylyov' <sshtylyov@mvista.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, jgarzik@pobox.com, 'Abhilash Kesavan' <a.kesavan@samsung.com>
List-Id: linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> 
> Hello.
> 
Hello :-)

Thanks for your review and comments.

> Kukjin Kim wrote:
> 
> > From: Abhilash Kesavan <a.kesavan@samsung.com>
> 
> > Adds support for the Samsung PATA controller. This driver is based on
the
> > Libata subsystem and references the earlier patches sent for IDE
subsystem.
> 
> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> [...]
> 
> > diff --git a/drivers/ata/pata_samsung_cf.c
b/drivers/ata/pata_samsung_cf.c
> > new file mode 100644
> > index 0000000..aeb2825
> > --- /dev/null
> > +++ b/drivers/ata/pata_samsung_cf.c
> > @@ -0,0 +1,735 @@
> [...]
> > +static unsigned long
> > +pata_s3c_setup_timing(struct s3c_ide_info *info, const struct
ata_timing *ata)
> > +{
> > +	int t1;
> > +	int t2;
> > +	int t2i;
> > +	ulong piotime;
> > +
> > +	t1 = ata->setup;
> > +	t2 = ata->act8b;
> > +	t2i = ata->rec8b;
> 
>     Could be initializers...
> 
OK.

> [...]
> 
> > +/*
> > + * pata_s3c_data_xfer - Transfer data by PIO
> > + */
> > +unsigned int pata_s3c_data_xfer(struct ata_device *dev, unsigned char
*buf,
> > +				unsigned int buflen, int rw)
> > +{
> > +	struct ata_port *ap = dev->link->ap;
> > +	struct s3c_ide_info *info = ap->host->private_data;
> > +	void __iomem *data_addr = ap->ioaddr.data_addr;
> > +	unsigned int words = buflen >> 1, i;
> > +	u16 *data_ptr = (u16 *)buf;
> > +
> > +	/* Requires wait same as in ata_inb/ata_outb */
> > +	if (rw == READ)
> > +		for (i = 0; i < words; i++, data_ptr++) {
> > +			wait_for_host_ready(info);
> > +			(void) readw(data_addr);
> > +			wait_for_host_ready(info);
> > +			*data_ptr = readw(info->ide_addr
> > +					+ S3C_ATA_PIO_RDATA);
> > +		}
> > +	else
> > +		for (i = 0; i < words; i++, data_ptr++) {
> > +			wait_for_host_ready(info);
> > +			writew(*data_ptr, data_addr);
> > +		}
> > +
> > +	if (buflen & 0x01) {
> > +		dev_err(ap->dev, "unexpected trailing data\n");
> > +		return -EINVAL;
> 
>     This method should return number of bytes consumed, never error...
> 
OK..will remove the invalid return.

> > +	}
> > +
> > +	return words << 1;
> > +}
> 
> [...]
> 
> > +/*
> > + * pata_s3c_devchk - PATA device presence detection
> > + */
> > +static unsigned int pata_s3c_devchk(struct ata_port *ap,
> > +				unsigned int device)
> > +{
> > +	struct ata_ioports *ioaddr = &ap->ioaddr;
> > +	u8 nsect, lbal;
> > +
> > +	ap->ops->sff_dev_select(ap, device);
> 
>     Can call pata_s3c_dev_select() directly...
> 
Will replace it throughout the file.

> > +/*
> > + * pata_s3c_wait_after_reset - wait for devices to become ready after
reset
> > + */
> > +static int pata_s3c_wait_after_reset(struct ata_link *link,
> > +		unsigned int devmask, unsigned long deadline)
> > +{
> > +	struct ata_port *ap = link->ap;
> > +	struct ata_ioports *ioaddr = &ap->ioaddr;
> > +	unsigned int dev0 = devmask & (1 << 0);
> > +	unsigned int dev1 = devmask & (1 << 1);
> > +	int rc, ret = 0;
> > +
> > +	msleep(ATA_WAIT_AFTER_RESET);
> > +
> > +	/* always check readiness of the master device */
> > +	rc = ata_sff_wait_ready(link, deadline);
> > +	if (rc)
> > +		return rc;
> > +
> > +	/* if device 1 was found in ata_devchk, wait for register
> > +	 * access briefly, then wait for BSY to clear.
> > +	 */
> > +	if (dev1) {
> > +		int i;
> > +
> > +		ap->ops->sff_dev_select(ap, 1);
> 
>     Ditto.
> 
> > +
> > +		for (i = 0; i < 2; i++) {
> > +			u8 nsect, lbal;
> > +
> > +			nsect = ata_inb(ap->host, ioaddr->nsect_addr);
> > +			lbal = ata_inb(ap->host, ioaddr->lbal_addr);
> > +			if ((nsect == 1) && (lbal == 1))
> > +				break;
> > +			msleep(50);	/* give drive a breather */
> > +		}
> > +
> > +		rc = ata_sff_wait_ready(link, deadline);
> > +		if (rc) {
> > +			if (rc != -ENODEV)
> > +				return rc;
> > +			ret = rc;
> > +		}
> > +	}
> > +
> 
>     Should have copied the original commant here, cause I dount that this
> drive selection trickery is indeed necessary...
> 
Will add comment.

> > +	ap->ops->sff_dev_select(ap, 0);
> > +	if (dev1)
> > +		ap->ops->sff_dev_select(ap, 1);
> > +	if (dev0)
> > +		ap->ops->sff_dev_select(ap, 0);
> 
>     Ditto.
> 
> > +/*
> > + * pata_s3c_softreset - reset host port via ATA SRST
> > + */
> > +static int pata_s3c_softreset(struct ata_link *link, unsigned int
*classes,
> > +			 unsigned long deadline)
> > +{
> > +	struct ata_port *ap = link->ap;
> > +	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
> 
>     I don't see where you set this flag, hence the check seems useless.
> 
Will remove the checks associated with this flag.

> > +	unsigned int devmask = 0;
> > +	int rc;
> > +	u8 err;
> > +
> > +	/* determine if device 0/1 are present */
> > +	if (pata_s3c_devchk(ap, 0))
> > +		devmask |= (1 << 0);
> > +	if (slave_possible && pata_s3c_devchk(ap, 1))
> > +		devmask |= (1 << 1);
> > +
> > +	/* select device 0 again */
> > +	ap->ops->sff_dev_select(ap, 0);
> 
>     Can call pata_s3c_dev_select() directly...
> 
> > +
> > +	/* issue bus reset */
> > +	rc = pata_s3c_bus_softreset(ap, devmask, deadline);
> > +	/* if link is occupied, -ENODEV too is an error */
> > +	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
> 
>     sata_scr_valid() doesn't apply to your PATA driver, no need to call
it.
> 
OK

> > +static void pata_s3c_hwinit(struct s3c_ide_info *info,
> > +				struct s3c_ide_platdata *pdata)
> > +{
> > +	switch (info->cpu_type) {
> > +	case TYPE_S3C64XX:
> > +		/* Configure as big endian */
> > +		pata_s3c_cfg_mode(info->sfr_addr);
> > +		pata_s3c_set_endian(info->ide_addr, 1);
> > +		pata_s3c_enable(info->ide_addr, true);
> > +		msleep(100);
> > +
> > +		/* Remove IRQ Status */
> > +		writel(0x1f, info->ide_addr + S3C_ATA_IRQ);
> > +		writel(0x1b, info->ide_addr + S3C_ATA_IRQ_MSK);
> > +	break;
> 
>     Mis-indented: one more tab needed.
> 
> > +
> > +	case TYPE_S5PC100:
> > +		pata_s3c_cfg_mode(info->sfr_addr);
> 
>     There should be a comment like /* FALLTHRU */ if *break* is omitted.
> 
> > +	case TYPE_S5PV210:
> > +		/* Configure as little endian */
> > +		pata_s3c_set_endian(info->ide_addr, 0);
> > +		pata_s3c_enable(info->ide_addr, true);
> > +		msleep(100);
> > +
> > +		/* Remove IRQ Status */
> > +		writel(0x3f, info->ide_addr + S3C_ATA_IRQ);
> > +		writel(0x3f, info->ide_addr + S3C_ATA_IRQ_MSK);
> > +	break;
> 
>     Mis-indented.
> 
Will correct the indentation and add a fall through comment.

> > +static int __devinit pata_s3c_probe(struct platform_device *pdev)
> 
>     Is this device really hot-pluggable? Shouldn't this be '__init'
instead?
> 
No, it's not..will change to __init.

> > +{
> > +	struct s3c_ide_platdata *pdata = pdev->dev.platform_data;
> > +	struct device *dev = &pdev->dev;
> > +	struct s3c_ide_info *info;
> > +	struct resource *res;
> > +	struct ata_port *ap;
> > +	struct ata_host *host;
> > +	enum s3c_cpu_type cpu_type;
> > +	int ret;
> > +
> > +	cpu_type = platform_get_device_id(pdev)->driver_data;
> > +
> > +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> > +	if (!info) {
> > +		dev_err(dev, "failed to allocate memory for device data\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	info->irq = platform_get_irq(pdev, 0);
> > +	if (info->irq < 0) {
> > +		dev_err(dev, "could not obtain irq number\n");
> 
>     You driver permits working without IRQ -- why require an IRQ resource
even
> if there's no IRQ?
> 
Will remove the check as driver can be used in polling mode.

> [...]
> 
> > +	if (!info->irq) {
> 
>     Should be (info->irq <= 0) instead, I think, with the above check
removed.
> 
OK

> > +		ap->flags |= ATA_FLAG_PIO_POLLING;
> > +		ata_port_desc(ap, "no IRQ, using PIO polling\n");
> > +	}
> > +
> 
> [...]
> 
> > +static struct platform_driver pata_s3c_driver = {
> > +	.probe		= pata_s3c_probe,
> 
>     If this function will be '__init', this needs to be removed.
> 
Will remove probe method and used platform_driver_probe().

> [...]
> 
> > +static int __init pata_s3c_init(void)
> > +{
> > +	return platform_driver_register(&pata_s3c_driver);
> 
>     I'd coinsider platform_driver_probe() -- this device doesn't seem to
be
> hot-pluggable...
> 

Thanks. Will re-submit updated soon.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
