From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v5] libata: pata_samsung: Add Samsung PATA controller
 driver
Date: Sun, 11 Jul 2010 14:31:39 +0400
Message-ID: <4C399D8B.2050700@ru.mvista.com>
References: <1277809518-1122-1-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1277809518-1122-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, jgarzik@redhat.com, sshtylyov@mvista.com, Abhilash Kesavan <a.kesavan@samsung.com>
List-Id: linux-ide@vger.kernel.org

Hello.

Kukjin Kim wrote:

> From: Abhilash Kesavan <a.kesavan@samsung.com>

> Adds support for the Samsung PATA controller. This driver is based on the
> Libata subsystem and references the earlier patches sent for IDE subsystem.

> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>

    Looks like there's issues still...

[...]

> diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
> new file mode 100644
> index 0000000..26b96c3
> --- /dev/null
> +++ b/drivers/ata/pata_samsung_cf.c
> @@ -0,0 +1,728 @@
> +/*
> + * pata_s3c_tf_load - send taskfile registers to host controller
> + */
> +static void pata_s3c_tf_load(struct ata_port *ap,
> +				const struct ata_taskfile *tf)
> +{
> +	struct ata_ioports *ioaddr = &ap->ioaddr;
> +	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
> +
> +	if (tf->ctl != ap->last_ctl) {
> +		ata_outb(ap->host, tf->ctl, ioaddr->ctl_addr);
> +		ap->last_ctl = tf->ctl;
> +		ata_wait_idle(ap);
> +	}
> +

[...]

> +/*
> + * pata_s3c_tf_read - input device's ATA taskfile shadow registers
> + */
> +static void pata_s3c_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
> +{
> +	struct ata_ioports *ioaddr = &ap->ioaddr;
> +
> +	tf->feature = ata_inb(ap->host, ioaddr->error_addr);
> +	tf->nsect = ata_inb(ap->host, ioaddr->nsect_addr);
> +	tf->lbal = ata_inb(ap->host, ioaddr->lbal_addr);
> +	tf->lbam = ata_inb(ap->host, ioaddr->lbam_addr);
> +	tf->lbah = ata_inb(ap->host, ioaddr->lbah_addr);
> +	tf->device = ata_inb(ap->host, ioaddr->device_addr);
> +
> +	if (tf->flags & ATA_TFLAG_LBA48) {
> +		iowrite8(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
> +		tf->hob_feature = ata_inb(ap->host, ioaddr->error_addr);
> +		tf->hob_nsect = ata_inb(ap->host, ioaddr->nsect_addr);
> +		tf->hob_lbal = ata_inb(ap->host, ioaddr->lbal_addr);
> +		tf->hob_lbam = ata_inb(ap->host, ioaddr->lbam_addr);
> +		tf->hob_lbah = ata_inb(ap->host, ioaddr->lbah_addr);
> +		iowrite8(tf->ctl, ioaddr->ctl_addr);

    I don't understand why you're using ata_outb() to awrite to the device 
control register in tf_load() method but use iowrite8() here...

> +#ifdef CONFIG_PM
> +static int pata_s3c_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct ata_host *host = platform_get_drvdata(pdev);
> +	pm_message_t state = PMSG_SUSPEND;

    Don't see why this variable is needed...

MBR, Sergei
