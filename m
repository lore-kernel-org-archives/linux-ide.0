From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: Re: SATAPI timing
Date: Tue, 22 Feb 2005 14:33:25 +0800
Message-ID: <001501c518a8$c7b3f840$6401a8c0@tw.ibm.com>
References: <83EB8C3C-7142-11D9-B91E-000A95D2AC6A@iomega.com> <41FA7ABF.7080404@pobox.com> <001801c5084b$b5687b60$6401a8c0@tw.ibm.com> <4216CB7E.1030109@pobox.com> <20050221075445.GU4056@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:1013 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262215AbVBVGgi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Feb 2005 01:36:38 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>
Cc: gp <poppitzg@iomega.com>, linux-ide@vger.kernel.org

> On Sat, Feb 19 2005, Jeff Garzik wrote:
> > Albert Lee wrote:
> > >I'm a little confused about what is the "correct behavior" of ATAPI DMA 
> > >INTRQ.
> > >
> > >1. The ATA-4 flowchart and ATA-6 state diagram seems to be inconsistent.
> > >In the ATA-4 flowchart, no wait for INTRQ is specified.
> > >
> > >2. From the ATA-5 errata:
> > >http://www.t13.org/project/e01122r0.pdf
> > >
> > >"...Page 265 through 270 of NCITS 340-2000 clause 9.8 was not properly 
> > >converted from the flow
> > >charts in NCITS 317-1998 to the state diagrams. The state diagrams figures 
> > >33 and 34 and
> > >associated text is modified to indicate that the device interrupts only at 
> > >command completion. "
> > >
> > >Notice the "device interrupts only at command completion." statement.
> > >However, the diagrams in the errata are inconsistent with the above 
> > >statement.
> > >
> > >3. The ide-cd code does not wait for INTRQ before starting BM-DMA
> > >
> > >        /* Arm the interrupt handler. */
> > >        ide_set_handler(drive, handler, rq->timeout, cdrom_timer_expiry);
> > >
> > >        /* ATAPI commands get padded out to 12 bytes minimum */
> > >        cmd_len = COMMAND_SIZE(rq->cmd[0]);
> > >        if (cmd_len < ATAPI_MIN_CDB_BYTES)
> > >            cmd_len = ATAPI_MIN_CDB_BYTES;
> > >
> > >        /* Send the command to the device. */
> > >        HWIF(drive)->atapi_output_bytes(drive, rq->cmd, cmd_len);
> > >
> > >        /* Start the DMA if need be */
> > >        if (info->dma)
> > >            hwif->dma_start(drive);
> > >
> > >        return ide_started;
> > >
> > >4. My CD-ROM drive does not generate INTRQ after it received the command 
> > >packet.
> > >   It only assert DMARQ.
> > >
> > >Maybe the state diagrams in ATA-5 and ATA-6 are incorrect?  Any idea?
> > 
> > 
> > As I mentioned in an earlier email, research seems to indicate the 
> > IDENTIFY PACKET DEVICE word 0, bits 6-5 can be used to indicate INTRQ 
> > will be delivered.  This is consistent with my ATA-4 specification.
> > 
> > Apparently this behavior is obsolete, but we still need to support it.
> 
> ide-cd uses those bits to check for interrupt delivery, see
> drq_interrupt in that file.
> 
  I've read the ide-cd code about the drq_interrupt indicated by config word 0, bits 6-5. 
The DRQ interrupt seems to be after PACKET command 0xA0 and _before_ the command packet 
is written to the device:

if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
  /* packet command */
  ide_execute_command(drive, WIN_PACKETCMD, handler, ATAPI_WAIT_PC, cdrom_timer_expiry);
  return ide_started;
 } else {
  unsigned long flags;

  /* packet command */
  spin_lock_irqsave(&ide_lock, flags);
  hwif->OUTBSYNC(drive, WIN_PACKETCMD, IDE_COMMAND_REG);
  ndelay(400);
  spin_unlock_irqrestore(&ide_lock, flags);

  return (*handler) (drive);
 }

  However, it seems not the same interrupt mentioned by gp and ATA-6 chap. 9.8 Figure 33.
The interrupt is _after_ the command packet is sent to the device: (HPD1:HPD3)
"When the Data register has been written, the writing of the command packet is completed,
and nIEN is cleared to zero, the host shall make a transition to the HPD3: INTRQ wait state."

Albert

