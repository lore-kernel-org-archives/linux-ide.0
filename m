From: Jens Axboe <axboe@suse.de>
Subject: Re: SATAPI timing
Date: Mon, 21 Feb 2005 08:54:45 +0100
Message-ID: <20050221075445.GU4056@suse.de>
References: <83EB8C3C-7142-11D9-B91E-000A95D2AC6A@iomega.com> <41FA7ABF.7080404@pobox.com> <001801c5084b$b5687b60$6401a8c0@tw.ibm.com> <4216CB7E.1030109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from ns.virtualhost.dk ([195.184.98.160]:23782 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261910AbVBUHzL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Feb 2005 02:55:11 -0500
Content-Disposition: inline
In-Reply-To: <4216CB7E.1030109@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, gp <poppitzg@iomega.com>, linux-ide@vger.kernel.org

On Sat, Feb 19 2005, Jeff Garzik wrote:
> Albert Lee wrote:
> >I'm a little confused about what is the "correct behavior" of ATAPI DMA 
> >INTRQ.
> >
> >1. The ATA-4 flowchart and ATA-6 state diagram seems to be inconsistent.
> >In the ATA-4 flowchart, no wait for INTRQ is specified.
> >
> >2. From the ATA-5 errata:
> >http://www.t13.org/project/e01122r0.pdf
> >
> >"...Page 265 through 270 of NCITS 340-2000 clause 9.8 was not properly 
> >converted from the flow
> >charts in NCITS 317-1998 to the state diagrams. The state diagrams figures 
> >33 and 34 and
> >associated text is modified to indicate that the device interrupts only at 
> >command completion. "
> >
> >Notice the "device interrupts only at command completion." statement.
> >However, the diagrams in the errata are inconsistent with the above 
> >statement.
> >
> >3. The ide-cd code does not wait for INTRQ before starting BM-DMA
> >
> >        /* Arm the interrupt handler. */
> >        ide_set_handler(drive, handler, rq->timeout, cdrom_timer_expiry);
> >
> >        /* ATAPI commands get padded out to 12 bytes minimum */
> >        cmd_len = COMMAND_SIZE(rq->cmd[0]);
> >        if (cmd_len < ATAPI_MIN_CDB_BYTES)
> >            cmd_len = ATAPI_MIN_CDB_BYTES;
> >
> >        /* Send the command to the device. */
> >        HWIF(drive)->atapi_output_bytes(drive, rq->cmd, cmd_len);
> >
> >        /* Start the DMA if need be */
> >        if (info->dma)
> >            hwif->dma_start(drive);
> >
> >        return ide_started;
> >
> >4. My CD-ROM drive does not generate INTRQ after it received the command 
> >packet.
> >   It only assert DMARQ.
> >
> >Maybe the state diagrams in ATA-5 and ATA-6 are incorrect?  Any idea?
> 
> 
> As I mentioned in an earlier email, research seems to indicate the 
> IDENTIFY PACKET DEVICE word 0, bits 6-5 can be used to indicate INTRQ 
> will be delivered.  This is consistent with my ATA-4 specification.
> 
> Apparently this behavior is obsolete, but we still need to support it.

ide-cd uses those bits to check for interrupt delivery, see
drq_interrupt in that file.

-- 
Jens Axboe

