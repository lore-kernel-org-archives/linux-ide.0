From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 15/24] ata_generic - generic BIOS setup SFF ATA driver
Date: Fri, 07 Jul 2006 12:31:28 -0400
Message-ID: <44AE8C60.5060004@pobox.com>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036119810-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361203144-git-send-email-alan@lxo
 rguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:8680 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932191AbWGGQbe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jul 2006 12:31:34 -0400
In-Reply-To: <11520361203144-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Alan Cox <alan@redhat.com>

alan@lxorguk.ukuu.org.uk wrote:
> +			/* We don't really care */
> +			dev->pio_mode = XFER_PIO_0;
> +			dev->dma_mode = XFER_MW_DMA_0;
> +			/* We do need the right mode information for DMA or PIO 
> +			   and this comes from the current configuration flags */
> +			/* FIXME: at some point in the future this should become
> +			   a library helper which reads the disk modes from the
> +			   disk as well */

This sounds like a comment bug?

We already have the IDENTIFY [PACKET] DEVICE page with this info...



> +static int all_generic_ide;		/* Set to claim all devices */

Maybe a better name is 'claim_all'?



> +static struct pci_driver pata_generic_pci_driver = {
> +        .name 		= DRV_NAME,

weird whitespace


> +MODULE_AUTHOR("Alan Cox");
> +MODULE_DESCRIPTION("low-level driver for generic ATA");
> +MODULE_LICENSE("GPL");
> +MODULE_DEVICE_TABLE(pci, pata_generic);
> +MODULE_VERSION(DRV_VERSION);

Various symbols and strings seem to be confused as to whether this is 
generic PATA or generic ATA.

Suggest either s/pata_/ata_/ or s/ata_/pata_/

ACK everything else

	Jeff


