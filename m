From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATAPI timing
Date: Fri, 28 Jan 2005 12:47:43 -0500
Message-ID: <41FA7ABF.7080404@pobox.com>
References: <83EB8C3C-7142-11D9-B91E-000A95D2AC6A@iomega.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58783 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261518AbVA1RsG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Jan 2005 12:48:06 -0500
In-Reply-To: <83EB8C3C-7142-11D9-B91E-000A95D2AC6A@iomega.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gp <poppitzg@iomega.com>
Cc: linux-ide@vger.kernel.org

gp wrote:
> Jeff
> 
> I think I may have found an issue in the ATAPI code in the function 
> atapi_packet_task.
> 
>  From my testing with the sata_via driver, I have been getting a timeout 
> when sending the first inquiry command.
> 
> 
> Here is the section of code of interest:
> 
> 
>     /* make sure DRQ is set */
>     status = ata_chk_status(ap);
>     if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)
>         goto err_out;
> 
>     /* send SCSI cdb */
>     DPRINTK("send cdb\n");
>     assert(ap->cdb_len >= 12);
>     ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
> 
> ** Wait is needed here to work correctly
> DPRINTK("Wait for a bit\n");
> 
>     /* if we are DMA'ing, irq handler takes over from here */
>     if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
>         ap->ops->bmdma_start(qc);        /* initiate bmdma */
> 
> 
> In the test case, the dma transfer is being used. From my perusal of the 
> ATA spec in section 9.8, it looks like there needs to be a definite 
> state transition before issuing the bmdma_start.

Yeah, it looks like there needs to be an intrq-wait state in there...

Wanna submit a patch?  :)

	Jeff



