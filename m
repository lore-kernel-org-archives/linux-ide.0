From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH alt2] libata resume fixes
Date: Sat, 27 May 2006 15:21:41 -0400
Message-ID: <4478A6C5.2040201@rtr.ca>
References: <20060527191323.GA26671@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:20913 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964937AbWE0TVk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 15:21:40 -0400
In-Reply-To: <20060527191323.GA26671@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org, axboe@suse.de

Jeff Garzik wrote:
...
> +
> +int pata_pci_device_resume(struct pci_dev *pdev)
> +{
> +	struct device *dev = pci_dev_to_dev(pdev);
> +	struct ata_host_set *host_set = dev_get_drvdata(dev);
> +	struct ata_port *ap;
> +	u8 status;
> +	int i;
> +
> +	ata_pci_device_resume(pdev);
> +
> +	mdelay(400);
> +
> +	for (i = 0; i < host_set->n_ports; i++) {
> +		ap = host_set->ports[i];
> +
> +		status = ata_busy_wait(ap, ATA_BUSY, 200000);
> +		if (status & ATA_BUSY)
> +			printk(KERN_ERR "ata%u: failed to resume\n", ap->id);
> +	}
> +
> +	return 0;
...

Okay, back again after two reboots.  Same failure mode as all of the others.
System freezes for a 30-second timeout with no LCD-backlight on,
then comes up without functioning hard drive access.  An immediate reboot
is necessary to do anything.

Linus's one-liner works perfectly, though.

Cheers
