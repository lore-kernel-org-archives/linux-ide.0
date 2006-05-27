From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH alt4] libata resume fixes
Date: Sat, 27 May 2006 16:13:01 -0400
Message-ID: <4478B2CD.8000304@rtr.ca>
References: <20060527195847.GA28334@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:28880 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964949AbWE0UM7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 16:12:59 -0400
In-Reply-To: <20060527195847.GA28334@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org

Jeff Garzik wrote:
..
> +int pata_pci_device_resume(struct pci_dev *pdev)
> +{
> +	struct device *dev = pci_dev_to_dev(pdev);
> +	struct ata_host_set *host_set = dev_get_drvdata(dev);
> +	struct ata_port *ap;
> +	int i;
> +
> +	ata_pci_device_resume(pdev);
> +
> +	for (i = 0; i < host_set->n_ports; i++) {
> +		ap = host_set->ports[i];
> +		if (ata_bus_probe(ap))
> +			printk(KERN_ERR "ata%u: failed to resume\n", ap->id);
> +	}
> +
> +	return 0;
> +}
..

I'm replying in the correct thread this time. ;)

Sorry to say, but no user-visible difference from previous attempts.
Still fails the same way, after a 30-ish second timeout on resume.

Cheers 
