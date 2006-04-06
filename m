From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 8/8] sata_sil24: reimplement hardreset
Date: Thu, 06 Apr 2006 12:44:30 -0400
Message-ID: <4435456E.6060504@pobox.com>
References: <11442437423316-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:5560 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751273AbWDFQod (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Apr 2006 12:44:33 -0400
In-Reply-To: <11442437423316-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Reimplement hardreset according to the datasheet.  The old hardreset
> didn't reset controller status and the controller might not be ready
> after reset.  Also, as SStatus is a bit slow to reflect PHY status
> after reset, sata_std_hardrset() doesn't wait long enough before
> proceeding.
> 
> Note that as we're not depending on SStatus, we can't depend on DET==1
> condition to wait for link, so use shorter timeout for no device case.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/sata_sil24.c |   38 +++++++++++++++++++++++++++++++++++---
>  1 files changed, 35 insertions(+), 3 deletions(-)
> 
> 6d59c820f497b5af4db2532dcafab195759b7d28
> diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
> index 3d8047e..b468cca 100644
> --- a/drivers/scsi/sata_sil24.c
> +++ b/drivers/scsi/sata_sil24.c
> @@ -518,10 +518,42 @@ static int sil24_softreset(struct ata_po
>  
>  static int sil24_hardreset(struct ata_port *ap, unsigned int *class)
>  {
> -	unsigned int dummy_class;
> +	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
> +	const char *reason;
> +	int tout_msec, rc;
> +
> +	/* sil24 does the right thing (tm) without any protection */
> +	ata_set_sata_spd(ap);
> +
> +	tout_msec = 100;
> +	if (sata_dev_present(ap))
> +		tout_msec = 5000;
> +
> +	writel(PORT_CS_DEV_RST, port + PORT_CTRL_STAT);
> +	rc = sil24_poll_register(port + PORT_CTRL_STAT,
> +				 PORT_CS_DEV_RST, 0, 10, tout_msec);
> +
> +	if (rc) {
> +		if (!sata_dev_present(ap))
> +			return 0;
> +		reason = "link not ready";
> +		goto err;
> +	}
> +
> +	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
> +		reason = "device not ready";
> +		goto err;
> +	}
> +
> +	/* SStatus is a bit sluggish (reports 0) on sil24, wait for it */
> +	sil24_poll_register(port + PORT_SSTATUS, 0xf, 0x0, 10, 100);

Its weird to poll BSY before polling SStatus.


> +	/* no classification, just return */

bad comment?

> +	return 0;
>  
> -	/* sil24 doesn't report device signature after hard reset */
> -	return sata_std_hardreset(ap, &dummy_class);
> + err:
> +	printk(KERN_ERR "ata%u: hardreset failed (%s)\n", ap->id, reason);
> +	return -EIO;
>  }
>  
>  static int sil24_probe_reset(struct ata_port *ap, unsigned int *classes)

