From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: Re: SATAPI timing
Date: Tue, 1 Feb 2005 18:49:27 +0800
Message-ID: <001801c5084b$b5687b60$6401a8c0@tw.ibm.com>
References: <83EB8C3C-7142-11D9-B91E-000A95D2AC6A@iomega.com> <41FA7ABF.7080404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:45566 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261954AbVBAKuK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Feb 2005 05:50:10 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, gp <poppitzg@iomega.com>
Cc: linux-ide@vger.kernel.org

> gp wrote:
> > Jeff
> > 
> > I think I may have found an issue in the ATAPI code in the function 
> > atapi_packet_task.
> > 
> >  From my testing with the sata_via driver, I have been getting a timeout 
> > when sending the first inquiry command.
> > 
> > 
> > Here is the section of code of interest:
> > 
> > 
> >     /* make sure DRQ is set */
> >     status = ata_chk_status(ap);
> >     if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)
> >         goto err_out;
> > 
> >     /* send SCSI cdb */
> >     DPRINTK("send cdb\n");
> >     assert(ap->cdb_len >= 12);
> >     ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
> > 
> > ** Wait is needed here to work correctly
> > DPRINTK("Wait for a bit\n");
> > 
> >     /* if we are DMA'ing, irq handler takes over from here */
> >     if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
> >         ap->ops->bmdma_start(qc);        /* initiate bmdma */
> > 
> > 
> > In the test case, the dma transfer is being used. From my perusal of the 
> > ATA spec in section 9.8, it looks like there needs to be a definite 
> > state transition before issuing the bmdma_start.
> 
> Yeah, it looks like there needs to be an intrq-wait state in there...
> 
> Wanna submit a patch?  :)
> 

I'm a little confused about what is the "correct behavior" of ATAPI DMA INTRQ.

1. The ATA-4 flowchart and ATA-6 state diagram seems to be inconsistent.
In the ATA-4 flowchart, no wait for INTRQ is specified.

2. From the ATA-5 errata:
http://www.t13.org/project/e01122r0.pdf

"...Page 265 through 270 of NCITS 340-2000 clause 9.8 was not properly converted from the flow
charts in NCITS 317-1998 to the state diagrams. The state diagrams figures 33 and 34 and
associated text is modified to indicate that the device interrupts only at command completion. "

Notice the "device interrupts only at command completion." statement.
However, the diagrams in the errata are inconsistent with the above statement.

3. The ide-cd code does not wait for INTRQ before starting BM-DMA

        /* Arm the interrupt handler. */
        ide_set_handler(drive, handler, rq->timeout, cdrom_timer_expiry);

        /* ATAPI commands get padded out to 12 bytes minimum */
        cmd_len = COMMAND_SIZE(rq->cmd[0]);
        if (cmd_len < ATAPI_MIN_CDB_BYTES)
            cmd_len = ATAPI_MIN_CDB_BYTES;

        /* Send the command to the device. */
        HWIF(drive)->atapi_output_bytes(drive, rq->cmd, cmd_len);

        /* Start the DMA if need be */
        if (info->dma)
            hwif->dma_start(drive);

        return ide_started;

4. My CD-ROM drive does not generate INTRQ after it received the command packet.
   It only assert DMARQ.

Maybe the state diagrams in ATA-5 and ATA-6 are incorrect?  Any idea?

Albert


