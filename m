From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 4/4] ata_piix: Remove stale comment
Date: Wed, 20 May 2009 16:12:12 -0400
Message-ID: <4A14641C.90502@garzik.org>
References: <20090506160612.24191.90737.stgit@t61.ukuu.org.uk> <20090506161013.24191.43445.stgit@t61.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50447 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220AbZETUMN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 May 2009 16:12:13 -0400
In-Reply-To: <20090506161013.24191.43445.stgit@t61.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> Combined mode pci quirk hacks went away - so the table to keep in sync
> no longer exists.
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/ata/ata_piix.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 3434468..0fba112 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -223,10 +223,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
>  	/* ICH8 Mobile PATA Controller */
>  	{ 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
>  
> -	/* NOTE: The following PCI ids must be kept in sync with the
> -	 * list in drivers/pci/quirks.c.
> -	 */
> -
> +	/* SATA ports */
> +	
>  	/* 82801EB (ICH5) */

applied


