From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 04/12] ahci: make NO_NCQ handling more consistent
Date: Tue, 03 Jul 2007 10:28:37 -0400
Message-ID: <468A5D15.6080501@garzik.org>
References: <11832836173613-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60482 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754324AbXGCO2k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 10:28:40 -0400
In-Reply-To: <11832836173613-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> ahci_save_initial_config() is responsible for reading, screening the
> host CAP register and storing the modified result into hpriv->cap for
> the rest of the driver.  Move ATA_FLAG_NO_NCQ handling into
> ahci_save_initial_config().  It's more consistent this way and the
> rest of the driver can always refer to hpriv->cap to determine
> configured capability.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ahci.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 0e001ad..0555db5 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -527,13 +527,19 @@ static void ahci_save_initial_config(struct pci_dev *pdev,
>  	hpriv->saved_cap = cap = readl(mmio + HOST_CAP);
>  	hpriv->saved_port_map = port_map = readl(mmio + HOST_PORTS_IMPL);
>  
> -	/* some chips lie about 64bit support */
> +	/* some chips lie about their capabilities, bust them */
>  	if ((cap & HOST_CAP_64) && (pi->flags & AHCI_FLAG_32BIT_ONLY)) {
>  		dev_printk(KERN_INFO, &pdev->dev,
>  			   "controller can't do 64bit DMA, forcing 32bit\n");
>  		cap &= ~HOST_CAP_64;
>  	}
>  
> +	if ((cap & HOST_CAP_NCQ) && (pi->flags & AHCI_FLAG_NO_NCQ)) {
> +		dev_printk(KERN_INFO, &pdev->dev,
> +			   "controller can't do NCQ, turning off CAP_NCQ\n");
> +		cap &= ~HOST_CAP_NCQ;
> +	}

ACK, even though I dislike the manipulation of cap.

Your patch did not start this manipulation, as illustrated by 
AHCI_FLAG_32BIT_ONLY handling, but it is nonetheless a loss of 
information we may later come to regret.  I predict the creation of 
'original_cap' sometime in the distant future :)


