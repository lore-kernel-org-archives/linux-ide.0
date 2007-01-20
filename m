From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_uli: ignore SIMPLEX
Date: Fri, 19 Jan 2007 19:17:02 -0500
Message-ID: <45B15F7E.2080807@pobox.com>
References: <20070116055551.GN10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53763 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932825AbXATARF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Jan 2007 19:17:05 -0500
In-Reply-To: <20070116055551.GN10987@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Some uli controllers have stuck SIMPLEX bit which can't be cleared
> with ata_pci_clear_simplex(), but the controller is capable of doing
> DMAs on both channels simultaneously.  Ignore it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
> index 5c603ca..62b9269 100644
> --- a/drivers/ata/sata_uli.c
> +++ b/drivers/ata/sata_uli.c
> @@ -226,6 +226,13 @@ static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	probe_ent->private_data = hpriv;
>  
> +	/* these chips have stuck dummy simplex bit, ignore it */
> +	if (probe_ent->_host_flags & ATA_HOST_SIMPLEX) {
> +		dev_printk(KERN_INFO, &pdev->dev,
> +			   "BMDMA simplex set, ignored\n");
> +		probe_ent->_host_flags &= ~ATA_HOST_SIMPLEX;
> +	}

This is going to be the common case going forward.  Please create an 
'ignore simplex bit' flag, and set it in sata_uli

	Jeff



