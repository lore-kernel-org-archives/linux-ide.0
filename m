From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Tue, 10 Jan 2017 13:53:53 +0100
Message-ID: <3939493.HXZ6C33pKV@amdc3058>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com>
 <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
 <CAOmrzkJP6s34DPOHd4OFFx=CXko35Kt=CfeDZthOPvKDJy-9YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-reply-to: <CAOmrzkJP6s34DPOHd4OFFx=CXko35Kt=CfeDZthOPvKDJy-9YA@mail.gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


Hi,

On Friday, January 06, 2017 10:01:49 AM Michael Schmitz wrote:
> Hi Bartlomiej,
> 
> thanks for caring to support our legacy PATA systems!
> 
> On Sat, Dec 31, 2016 at 3:01 AM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > Hi,
> >
> > This patchset adds m68k/Atari Falcon PATA support to libata.
> > The major difference in the new libata's pata_falcon host
> > driver when compared to legacy IDE's falconide host driver is
> > that we are using polled PIO mode and thus avoiding the need
> > for STDMA locking magic altogether.
> 
> I don't suppose this is the default libata mode for PIO?

No, by default it is used only for some commands (i.e. IDENTIFY,
SET FEATURES - XFER MODE).

> How is polling implemented in libata? Sleeping for something
> approximating the average seek latency shouldn't hurt but spinning
> wont be acceptable for a low performance single CPU architecture like
> the Falcon.

You can find actual implementation in libata-sff.c.

Please see ata_sff_pio_task() for the main polling logic:

fsm_start:
	WARN_ON_ONCE(ap->hsm_task_state == HSM_ST_IDLE);

	/*
	 * This is purely heuristic.  This is a fast path.
	 * Sometimes when we enter, BSY will be cleared in
	 * a chk-status or two.  If not, the drive is probably seeking
	 * or something.  Snooze for a couple msecs, then
	 * chk-status again.  If still busy, queue delayed work.
	 */
	status = ata_sff_busy_wait(ap, ATA_BUSY, 5);
	if (status & ATA_BUSY) {
		spin_unlock_irq(ap->lock);
		ata_msleep(ap, 2);
		spin_lock_irq(ap->lock);

		status = ata_sff_busy_wait(ap, ATA_BUSY, 10);
		if (status & ATA_BUSY) {
			ata_sff_queue_pio_task(link, ATA_SHORT_PAUSE);
			goto out_unlock;
		}
	}

	/*
	 * hsm_move() may trigger another command to be processed.
	 * clean the link beforehand.
	 */
	ap->sff_pio_task_link = NULL;
	/* move the HSM */
	poll_next = ata_sff_hsm_move(ap, qc, status, 1);

	/* another command or interrupt handler
	 * may be running at this point.
	 */
	if (poll_next)
		goto fsm_start;
out_unlock:


ata_sff_busy_wait()'s last argument is number of 10uS waits so
first check (50uS) should be quite quick.  If device is still
busy we sleep for 2ms.  Then we quickly (100uS) busy wait and
if needed  queue delayed work (with ATA_SHORT_PAUSE == 16 ms
delay).

Overall the current heuristic looks fine and spinning should be
minimal.

> > Tested under ARAnyM emulator.
> 
> Not sure that the emulator is really feature complete enough - I'll
> get this tested on my Falcon in the next few weeks. I'm a bit worried

Great!

> about IDE still generating interrupts on seek completion (did you spot
> anything like that, Geert?).
> 
> Cheers,
> 
>   Michael

BTW according to comment in arch/m68k/atari/stdma.c:

/* On the Falcon, the IDE bus uses just the ACSI/Floppy interrupt, but */
/* not the ST-DMA chip itself. So falhd.c needs not to lock the        */
/* chip. The interrupt is routed to falhd.c if IDE is configured, the  */
/* model is a Falcon and the interrupt was caused by the HD controller */
/* (can be determined by looking at its status register).              */

it should be okay to use IDE at the same time as SCSI/Floppy which
is what the new driver does (the old one is serialized operations by
ST-DMA related IRQ handling magic).

Also the comment itself may need some fixups as on Falcon it is SCSI
not ACSI (according to the earlier comment in same file) and the old
IDE host driver name is not falhd.c but falconide.c.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
