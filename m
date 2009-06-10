From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/2] ata_piix: Enable parallel scan
Date: Wed, 10 Jun 2009 11:06:17 -0400
Message-ID: <4A2FCBE9.9060505@garzik.org>
References: <20090513135941.11247.13097.stgit@t61.ukuu.org.uk> <20090513140233.11247.66014.stgit@t61.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54618 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754070AbZFJPGR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Jun 2009 11:06:17 -0400
In-Reply-To: <20090513140233.11247.66014.stgit@t61.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> From: Arjan van de Ven <arjan@infradead.org>
> 
> This patch turns on parallel scanning for the ata_piix driver.
> This driver is used on most netbooks (no AHCI for cheap storage it seems).
> The scan is the dominating time factor in the kernel boot for these
> devices; with this flag it gets cut in half for the device I used
> for testing (eeepc).
> Alan took a look at the driver source and concluded that it ought to be safe
> to do for this driver.  Alan has also checked with the hardware team.
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/ata/ata_piix.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 0fba112..4ea02a7 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -1580,6 +1580,7 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
>  		host->ports[1]->mwdma_mask = 0;
>  		host->ports[1]->udma_mask = 0;
>  	}
> +	host->flags |= ATA_HOST_PARALLEL_SCAN;
>  
>  	pci_set_master(pdev);
>  	return ata_pci_sff_activate_host(host, ata_sff_interrupt, &piix_sht);

applied...  let's see what explodes




