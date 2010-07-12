From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v6] libata: pata_samsung: Add Samsung PATA controller
 driver
Date: Mon, 12 Jul 2010 13:33:40 +0400
Message-ID: <4C3AE174.7090509@mvista.com>
References: <1278904780-20592-1-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33280 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006Ab0GLJew (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jul 2010 05:34:52 -0400
In-Reply-To: <1278904780-20592-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, ben-linux@fluff.org, jgarzik@redhat.com, sshtylyov@mvista.com, Abhilash Kesavan <a.kesavan@samsung.com>

Hello.

Kukjin Kim wrote:

> From: Abhilash Kesavan <a.kesavan@samsung.com>

> Adds support for the Samsung PATA controller. This driver is based on the
> Libata subsystem and references the earlier patches sent for IDE subsystem.

> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>

    There's probably still a place for improvement... sorry that I dind't 
notice before. Other than that:

Acked-by: Sergei Shtylyov <sshtylyov@mvista.com>

[...]

> diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
> new file mode 100644
> index 0000000..5718220
> --- /dev/null
> +++ b/drivers/ata/pata_samsung_cf.c
> @@ -0,0 +1,727 @@
[...]
> +/*
> + * pata_s3c_wait_after_reset - wait for devices to become ready after reset
> + */
> +static int pata_s3c_wait_after_reset(struct ata_link *link,
> +		unsigned int devmask, unsigned long deadline)
> +{
> +	struct ata_port *ap = link->ap;
> +	struct ata_ioports *ioaddr = &ap->ioaddr;
> +	unsigned int dev0 = devmask & (1 << 0);
> +	unsigned int dev1 = devmask & (1 << 1);
> +	int rc, ret = 0;
> +
> +	msleep(ATA_WAIT_AFTER_RESET);
> +
> +	/* always check readiness of the master device */
> +	rc = ata_sff_wait_ready(link, deadline);
> +	/* -ENODEV means the odd clown forgot the D7 pulldown resistor
> +	 * and TF status is 0xff, bail out on it too.
> +	 */
> +	if (rc)
> +		return rc;
> +
> +	/* if device 1 was found in ata_devchk, wait for register
> +	 * access briefly, then wait for BSY to clear.
> +	 */

    You don't call pata_s3c_devchk() for device 1, so in principle you can 
drop the following block:

> +	if (dev1) {
> +		int i;
> +
> +		pata_s3c_dev_select(ap, 1);
> +
> +		/* Wait for register access.  Some ATAPI devices fail
> +		 * to set nsect/lbal after reset, so don't waste too
> +		 * much time on it.  We're gonna wait for !BSY anyway.
> +		 */
> +		for (i = 0; i < 2; i++) {
> +			u8 nsect, lbal;
> +
> +			nsect = ata_inb(ap->host, ioaddr->nsect_addr);
> +			lbal = ata_inb(ap->host, ioaddr->lbal_addr);
> +			if ((nsect == 1) && (lbal == 1))
> +				break;
> +			msleep(50);	/* give drive a breather */
> +		}
> +
> +		rc = ata_sff_wait_ready(link, deadline);
> +		if (rc) {
> +			if (rc != -ENODEV)
> +				return rc;
> +			ret = rc;
> +		}
> +	}
> +
> +	/* is all this really necessary? */
> +	pata_s3c_dev_select(ap, 0);
> +	if (dev1)
> +		pata_s3c_dev_select(ap, 1);

    This too...

> +	if (dev0)
> +		pata_s3c_dev_select(ap, 0);
> +
> +	return ret;
> +}
> +
[...]
> +static int pata_s3c_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct ata_host *host = platform_get_drvdata(pdev);
> +	struct s3c_ide_platdata *pdata = pdev->dev.platform_data;
> +	struct s3c_ide_info *info;
> +
> +	info = host->private_data;

    Could be initializer...

MBR, Sergei
