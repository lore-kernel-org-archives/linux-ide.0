From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATAPI timing
Date: Sat, 19 Feb 2005 00:15:42 -0500
Message-ID: <4216CB7E.1030109@pobox.com>
References: <83EB8C3C-7142-11D9-B91E-000A95D2AC6A@iomega.com> <41FA7ABF.7080404@pobox.com> <001801c5084b$b5687b60$6401a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23741 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261629AbVBSFQD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Feb 2005 00:16:03 -0500
In-Reply-To: <001801c5084b$b5687b60$6401a8c0@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: gp <poppitzg@iomega.com>, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>

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
> 
> 4. My CD-ROM drive does not generate INTRQ after it received the command packet.
>    It only assert DMARQ.
> 
> Maybe the state diagrams in ATA-5 and ATA-6 are incorrect?  Any idea?


As I mentioned in an earlier email, research seems to indicate the 
IDENTIFY PACKET DEVICE word 0, bits 6-5 can be used to indicate INTRQ 
will be delivered.  This is consistent with my ATA-4 specification.

Apparently this behavior is obsolete, but we still need to support it.

Thus, libata has a few ATAPI deficiencies that need correcting:

* for one value of word 0, bit 6-5, check for INTRQ bit presence

* for other values of word 0, bit 6-5, we should honor the requested 
delay before checking for DRQ

* guarantee that the total length of an ATAPI DMA transfer is a multiple 
of 4 bytes

