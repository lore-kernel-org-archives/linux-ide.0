From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] libata: Use IGN_SIMPLEX for ALi
Date: Wed, 13 May 2009 19:56:28 +0400
Message-ID: <4A0AEDAC.1020202@ru.mvista.com>
References: <20090513135941.11247.13097.stgit@t61.ukuu.org.uk> <20090513140201.11247.76226.stgit@t61.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:42050 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758306AbZEMPzv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 May 2009 11:55:51 -0400
In-Reply-To: <20090513140201.11247.76226.stgit@t61.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Hello.

Alan Cox wrote:

> Some ALi devices report simplex if they have been disabled and re-enabled, and
> restoring the byte does not work. Ignore it - the needed supporting logic is
> already present for the SATA ULi ports.

> Signed-off-by: Alan Cox <alan@linux.intel.com>

    Whitespace police on guard. :-)

> diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
> index 751b7ea..fc9c5d6 100644
> --- a/drivers/ata/pata_ali.c
> +++ b/drivers/ata/pata_ali.c
> @@ -497,14 +497,16 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  	};
>  	/* Revision 0x20 added DMA */
>  	static const struct ata_port_info info_20 = {
> -		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
> +		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48 |
> +							ATA_FLAG_IGN_SIMPLEX,
>  		.pio_mask = ATA_PIO4,
>  		.mwdma_mask = ATA_MWDMA2,
>  		.port_ops = &ali_20_port_ops
>  	};
>  	/* Revision 0x20 with support logic added UDMA */
>  	static const struct ata_port_info info_20_udma = {
> -		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
> +		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48 |
> +							ATA_FLAG_IGN_SIMPLEX,
>  		.pio_mask = ATA_PIO4,
>  		.mwdma_mask = ATA_MWDMA2,
>  		.udma_mask = ATA_UDMA2,
> @@ -512,7 +514,8 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  	};
>  	/* Revision 0xC2 adds UDMA66 */
>  	static const struct ata_port_info info_c2 = {
> -		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
> +		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48 |
> +							ATA_FLAG_IGN_SIMPLEX,
>  		.pio_mask = ATA_PIO4,
>  		.mwdma_mask = ATA_MWDMA2,
>  		.udma_mask = ATA_UDMA4,
> @@ -520,7 +523,8 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  	};
>  	/* Revision 0xC3 is UDMA66 for now */
>  	static const struct ata_port_info info_c3 = {
> -		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
> +		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48 |
> +							ATA_FLAG_IGN_SIMPLEX,
>  		.pio_mask = ATA_PIO4,
>  		.mwdma_mask = ATA_MWDMA2,
>  		.udma_mask = ATA_UDMA4,
> @@ -528,7 +532,8 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  	};
>  	/* Revision 0xC4 is UDMA100 */
>  	static const struct ata_port_info info_c4 = {
> -		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
> +		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48 |
> +							ATA_FLAG_IGN_SIMPLEX,

    Why it's always so far to the right?

>  		.pio_mask = ATA_PIO4,
>  		.mwdma_mask = ATA_MWDMA2,
>  		.udma_mask = ATA_UDMA5,
> @@ -536,7 +541,7 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  	};
>  	/* Revision 0xC5 is UDMA133 with LBA48 DMA */
>  	static const struct ata_port_info info_c5 = {
> -		.flags = ATA_FLAG_SLAVE_POSS,
> +		.flags = ATA_FLAG_SLAVE_POSS | 	ATA_FLAG_IGN_SIMPLEX,

    Extra space here.

>  		.pio_mask = ATA_PIO4,
>  		.mwdma_mask = ATA_MWDMA2,
>  		.udma_mask = ATA_UDMA6,

MBR, Sergei
