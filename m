From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATAPI timing
Date: Sun, 06 Feb 2005 10:17:31 -0500
Message-ID: <4206350B.3030507@pobox.com>
References: <83EB8C3C-7142-11D9-B91E-000A95D2AC6A@iomega.com> <41FA7ABF.7080404@pobox.com> <001801c5084b$b5687b60$6401a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28635 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261156AbVBFPRp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Feb 2005 10:17:45 -0500
In-Reply-To: <001801c5084b$b5687b60$6401a8c0@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: gp <poppitzg@iomega.com>, linux-ide@vger.kernel.org

Albert Lee wrote:
> I'm a little confused about what is the "correct behavior" of ATAPI DMA INTRQ.
> 
> 1. The ATA-4 flowchart and ATA-6 state diagram seems to be inconsistent.
> In the ATA-4 flowchart, no wait for INTRQ is specified.
> 
> 2. From the ATA-5 errata:
> http://www.t13.org/project/e01122r0.pdf
> 
> "...Page 265 through 270 of NCITS 340-2000 clause 9.8 was not properly converted from the flow
> charts in NCITS 317-1998 to the state diagrams. The state diagrams figures 33 and 34 and
> associated text is modified to indicate that the device interrupts only at command completion. "
> 
> Notice the "device interrupts only at command completion." statement.
> However, the diagrams in the errata are inconsistent with the above statement.
> 
> 3. The ide-cd code does not wait for INTRQ before starting BM-DMA
> 
>         /* Arm the interrupt handler. */
>         ide_set_handler(drive, handler, rq->timeout, cdrom_timer_expiry);
> 
>         /* ATAPI commands get padded out to 12 bytes minimum */
>         cmd_len = COMMAND_SIZE(rq->cmd[0]);
>         if (cmd_len < ATAPI_MIN_CDB_BYTES)
>             cmd_len = ATAPI_MIN_CDB_BYTES;
> 
>         /* Send the command to the device. */
>         HWIF(drive)->atapi_output_bytes(drive, rq->cmd, cmd_len);
> 
>         /* Start the DMA if need be */
>         if (info->dma)
>             hwif->dma_start(drive);
> 
>         return ide_started;


This is a good point, and refreshes my memory on the subject from when 
the code was written (and updated by Bart).

I'll look into things further...

	Jeff


