From: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Wed, 11 Jan 2017 09:02:36 +1300
Message-ID: <CAOmrzkJfQu6PuCpyyRJL8PNvSYxYO42F-k8jEYf2d1-5C28A_A@mail.gmail.com>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com>
 <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
 <CAOmrzkJP6s34DPOHd4OFFx=CXko35Kt=CfeDZthOPvKDJy-9YA@mail.gmail.com> <3939493.HXZ6C33pKV@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <3939493.HXZ6C33pKV@amdc3058>
Sender: linux-m68k-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Andreas Schwab <schwab@linux-m68k.org>
List-Id: linux-ide@vger.kernel.org

Bartlomiej,


>> How is polling implemented in libata? Sleeping for something
>> approximating the average seek latency shouldn't hurt but spinning
>> wont be acceptable for a low performance single CPU architecture like
>> the Falcon.
>
> You can find actual implementation in libata-sff.c.
>
> Please see ata_sff_pio_task() for the main polling logic:
>
> fsm_start:
>         WARN_ON_ONCE(ap->hsm_task_state == HSM_ST_IDLE);
>
>         /*
>          * This is purely heuristic.  This is a fast path.
>          * Sometimes when we enter, BSY will be cleared in
>          * a chk-status or two.  If not, the drive is probably seeking
>          * or something.  Snooze for a couple msecs, then
>          * chk-status again.  If still busy, queue delayed work.
>          */
>         status = ata_sff_busy_wait(ap, ATA_BUSY, 5);
>         if (status & ATA_BUSY) {
>                 spin_unlock_irq(ap->lock);
>                 ata_msleep(ap, 2);
>                 spin_lock_irq(ap->lock);
>
>                 status = ata_sff_busy_wait(ap, ATA_BUSY, 10);
>                 if (status & ATA_BUSY) {
>                         ata_sff_queue_pio_task(link, ATA_SHORT_PAUSE);
>                         goto out_unlock;
>                 }
>         }
>
>         /*
>          * hsm_move() may trigger another command to be processed.
>          * clean the link beforehand.
>          */
>         ap->sff_pio_task_link = NULL;
>         /* move the HSM */
>         poll_next = ata_sff_hsm_move(ap, qc, status, 1);
>
>         /* another command or interrupt handler
>          * may be running at this point.
>          */
>         if (poll_next)
>                 goto fsm_start;
> out_unlock:
>
>
> ata_sff_busy_wait()'s last argument is number of 10uS waits so
> first check (50uS) should be quite quick.  If device is still
> busy we sleep for 2ms.  Then we quickly (100uS) busy wait and
> if needed  queue delayed work (with ATA_SHORT_PAUSE == 16 ms
> delay).
>
> Overall the current heuristic looks fine and spinning should be
> minimal.

Thanks, that looks entirely reasonable.

>> > Tested under ARAnyM emulator.
>>
>> Not sure that the emulator is really feature complete enough - I'll
>> get this tested on my Falcon in the next few weeks. I'm a bit worried
>
> Great!
>
>> about IDE still generating interrupts on seek completion (did you spot
>> anything like that, Geert?).
>>
>> Cheers,
>>
>>   Michael
>
> BTW according to comment in arch/m68k/atari/stdma.c:
>
> /* On the Falcon, the IDE bus uses just the ACSI/Floppy interrupt, but */
> /* not the ST-DMA chip itself. So falhd.c needs not to lock the        */
> /* chip. The interrupt is routed to falhd.c if IDE is configured, the  */
> /* model is a Falcon and the interrupt was caused by the HD controller */
> /* (can be determined by looking at its status register).              */

That comment is probably incorrect in part. Blame Linus :-)

Seriously though - that comment dates back to the dark ages (when m68k
was an entirely separate port and the IDE driver was indeed named
falhd.c). That would have been even before 2.2 or 2.4 times. The
comment just never got updated.

What is still correct is that the IDE driver does use the interrupt
only, not the ST-DMA chip. And a single IDE interrupt can be correctly
assigned to IDE by looking at the status register.

With the SCSI (and IIRC also floppy) interrupts, we don't have direct
access to the status registers without disturbing the state of the DMA
though. Unless we know for definite that either chips have raised the
interrupt (and DMA ops are in flight), we must not touch the DMA chip
at all.

The case I'm worried about is both IDE and SCSI raising an interrupt.
We don't currently mask the IDE/ST-DMA interrupt so a stacked
interrupt must be processed in the same pass as the initial interrupt
or it will get dropped. We'd have to peek at the DMA registers to
check the SCSI or floppy interrupt status, and we just can't safely do
that. So races of this kind are currently prevented by including IDE
in the IRQ locking process.

Whether it's possible to mask the interrupt, do one pass, unmask and
process the second interrupt I don't know. Maybe Andreas does?

Cheers,

  Michael


> it should be okay to use IDE at the same time as SCSI/Floppy which
> is what the new driver does (the old one is serialized operations by
> ST-DMA related IRQ handling magic).
>
> Also the comment itself may need some fixups as on Falcon it is SCSI
> not ACSI (according to the earlier comment in same file) and the old
> IDE host driver name is not falhd.c but falconide.c.
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
