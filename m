From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] SB600 SATA controller PMP support
Date: Mon, 09 Jun 2008 14:10:10 +0900
Message-ID: <484CBB32.4080808@gmail.com>
References: <1212547888.5722.5.camel@chunhao-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:6662 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbYFIFKR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jun 2008 01:10:17 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1681041waf.23
        for <linux-ide@vger.kernel.org>; Sun, 08 Jun 2008 22:10:17 -0700 (PDT)
In-Reply-To: <1212547888.5722.5.camel@chunhao-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Huang <shane.huang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello, Shane.

I think it's in the right direction.  Just a few nits.

Shane Huang wrote:
> +static int ahci_sb600_check_ready(struct ata_link *link)
> +{
> +	void __iomem *port_mmio = ahci_port_base(link->ap);
> +

Please kill this empty line inbetween variable declarations.

> +	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
> +	u32 irq_status = readl(port_mmio + PORT_IRQ_STAT);
> +
> +	if (irq_status & PORT_IRQ_BAD_PMP)
> +		return -EIO;
> +
> +	return ata_check_ready(status);
> +}
> +
> +static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
> +			     int pmp, unsigned long deadline,
> +			     int (*check_ready)(struct ata_link *link))

Why take @class if not used?

>  {
>  	struct ata_port *ap = link->ap;
> -	int pmp = sata_srst_pmp(link);
>  	const char *reason = NULL;
>  	unsigned long now, msecs;
>  	struct ata_taskfile tf;
> @@ -1312,15 +1333,12 @@
>  	ahci_exec_polled_cmd(ap, pmp, &tf, 0, 0, 0);
>  
>  	/* wait for link to become ready */
> -	rc = ata_wait_after_reset(link, deadline, ahci_check_ready);
> +	rc = ata_wait_after_reset(link, deadline, check_ready);
>  	/* link occupied, -ENODEV too is an error */
>  	if (rc) {
>  		reason = "device not ready";
>  		goto fail;
>  	}
> -	*class = ahci_dev_classify(ap);
> -
> -	DPRINTK("EXIT, class=%u\n", *class);

Or maybe you can leave this part in ahci_do_softreset()?

> +static int ahci_softreset(struct ata_link *link, unsigned int *class,
> +			  unsigned long deadline)
> +{
> +	struct ata_port *ap = link->ap;
> +	int pmp = sata_srst_pmp(link);
> +	int rc;
> +
> +	DPRINTK("ENTER\n");
> +
> +	rc = ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
> +	if (!rc) {
> +		*class = ahci_dev_classify(ap);
> +		DPRINTK("EXIT, class=%u\n", *class);
> +	}
> +	return rc;
> +}
> +
> +static int ahci_sb600_softreset(struct ata_link *link, unsigned int *class,
> +				unsigned long deadline)
> +{
> +	struct ata_port *ap = link->ap;
> +	void __iomem *port_mmio = ahci_port_base(ap);
> +	int pmp = sata_srst_pmp(link);
> +	int rc;
> +	u32 irq_sts;
> +
> +	DPRINTK("ENTER\n");
> +
> +	rc = ahci_do_softreset(link, class, pmp, deadline,
> +				ahci_sb600_check_ready);
> +
> +	/* Soft reset fails on some ATI chips with IPMS set when PMP
> +	   is enabled but SATA HDD/ODD is connected to SATA port,
> +	   do soft reset again to port 0. */

Please use

/* Blah... blah
 * blah
 */

Or

/*
 * Blah blah
 * blah
 */

> +	if (rc == -EIO) {
> +		irq_sts = readl(port_mmio + PORT_IRQ_STAT);
> +		if (irq_sts & PORT_IRQ_BAD_PMP) {
> +			ata_link_printk(link, KERN_WARNING,
> +					"softreset failed, try again\n");

Please use a bit more detailed message.

> +			rc = ahci_do_softreset(link, class, 0, deadline,
> +						ahci_check_ready);
> +		}
> +	}
> +
> +	if (!rc) {
> +		*class = ahci_dev_classify(ap);
> +		DPRINTK("EXIT, class=%u\n", *class);
> +	}
> +	return rc;
> +}

I think it's better to organize functions in the following order.

 ahci_do_softreset()
 ahci_ready()
 ahci_softreset()
 ahci_sb600_ready()
 ahci_sb600_softreset()

W/ explanation on how sb600_ready and sb600_softreset are different.
Please at least add why BAD_PMP quick exit path is necessary in
ahci_sb600_ready().

Thanks.

-- 
tejun
