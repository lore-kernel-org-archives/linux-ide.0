From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata: Use IGN_SIMPLEX for ALi
Date: Wed, 13 May 2009 15:32:38 +0200
Message-ID: <200905131532.38811.bzolnier@gmail.com>
References: <20090513135855.11205.36917.stgit@t61.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:56007 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbZEMN2y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2009 09:28:54 -0400
Received: by bwz22 with SMTP id 22so644855bwz.37
        for <linux-ide@vger.kernel.org>; Wed, 13 May 2009 06:28:53 -0700 (PDT)
In-Reply-To: <20090513135855.11205.36917.stgit@t61.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Wednesday 13 May 2009 15:59:09 Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> Some ALi devices report simplex if they have been disabled and re-enabled, and
> restoring the byte does not work. Ignore it - the needed supporting logic is
> already present for the SATA ULi ports.
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>

ACK, the original driver has always ignored simplex

[ Sigh, this issue seems to go back to:

  commit 669a5db411d85a14f86cd92bc16bf7ab5b8aa235
  Author: Jeff Garzik <jeff@garzik.org>
  Date:   Tue Aug 29 18:12:40 2006 -0400

    [libata] Add a bunch of PATA drivers. ]

> ---
> 
>  drivers/ata/pata_ali.c |   17 +++++++++++------
>  1 files changed, 11 insertions(+), 6 deletions(-)
> 
> 
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
>  		.pio_mask = ATA_PIO4,
>  		.mwdma_mask = ATA_MWDMA2,
>  		.udma_mask = ATA_UDMA5,
> @@ -536,7 +541,7 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  	};
>  	/* Revision 0xC5 is UDMA133 with LBA48 DMA */
>  	static const struct ata_port_info info_c5 = {
> -		.flags = ATA_FLAG_SLAVE_POSS,
> +		.flags = ATA_FLAG_SLAVE_POSS | 	ATA_FLAG_IGN_SIMPLEX,
>  		.pio_mask = ATA_PIO4,
>  		.mwdma_mask = ATA_MWDMA2,
>  		.udma_mask = ATA_UDMA6,
