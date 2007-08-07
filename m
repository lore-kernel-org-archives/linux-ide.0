From: Kristoffer Nyborg Gregertsen <gregerts@stud.ntnu.no>
Subject: Re: [PATCH 0/1] AVR32 PATA driver
Date: Tue, 7 Aug 2007 20:18:03 +0200
Message-ID: <200708072018.03413.gregerts@stud.ntnu.no>
References: <200708071126.08735.kngregertsen@norway.atmel.com> <20070807165812.4e939531@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from merke.itea.ntnu.no ([129.241.7.61]:38260 "EHLO
	merke.itea.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbXHGSSH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 14:18:07 -0400
In-Reply-To: <20070807165812.4e939531@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>, linux-ide@vger.kernel.org, gregerts@stud.ntnu.no

On Tuesday 07 August 2007 17:58:12 Alan Cox wrote:
> > 1) In PIO1 and PIO2 there are rare freezes:
> >
> > ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> > ata3.00: cmd 20/00:00:d3:7e:5d/00:00:00:00:00/e1 tag 0 cdb 0x0 data
> > 131072 in res 58/00:01:d2:7f:5d/00:00:01:00:00/e1 Emask 0x2 (HSM
> > violation)
> >
> > The freezes happen close to each other in time. The freezes does not make
> > file operations fail.
>
> Are you 100% sure all your timings are right and there are no I/O posting
> prolems that might lead the various required delays to come out wrong ?

I've looked at the signals with a logic analyzer, they seem to be correct. The 
timings are computed by ata_timing_compute. I've also added pull-up resistors 
on all the control signals just to make sure they are always sane.

Since the there is no problems for PIO3 and 4, perhaps this error is related 
to the problem of pata_at32_data_xfer being non-atomic while changing the SMC 
timings that you addressed in your other mail?

> +     /* Set SMC to data transfer speed */
> +     if (info->smc_pio_mode < 3)
> +             smc_restore_registers(info->cs, &info->smc_16.reg);
> +
> +     /* Transfer data */
> +     ata_data_xfer(adev, buf, buflen, write_data);
> +
> +     /* Set SMC back to register transfer speed */
> +     if (info->smc_pio_mode < 3)
> +             smc_restore_registers(info->cs, &info->smc_8.reg);

I'll test to see if this is causing the errors. If so I'll setup different 
memory spaces for data and register transfers as described in the my last 
mail.

> > 2) After being in operation for a long time (+24 hours) the disk reports
> > wrong identity:
> >
> > ata4.00: model number mismatch 'IC35L060AVV207-0' != ''
> > ata4.00: revalidation failed (errno=-19)
> > ata4.00: limiting speed to PIO2
> > ata4: failed to recover some devices, retrying in 5 secs
> > ata4.00: model number mismatch 'IC35L060AVV207-0' != 'AV07-0 *GARBEL*
> >
> > This has happend with both the devices I am testing, the 'Quantum
> > Fireball' reported it self to be 'Quanpum Fiveball' after 24 hours of
> > testing.
>
> That sounds to me like your hardware - heat, clock drift ?

Perhaps it's heat. The disks lie on my desk with no ventilation besides the 
air circulating in the room. Turning them off for a little while solves the 
problem.

> > I also have a question regrding INTRQ / IRQ handeling. Since I am not
> > using DMA, there seems to be no reason to handle interrupts, so I set the
> > polling flag. Not using the polling flag gives a lot of interrupts that
> > does not seem to do anything except eating my CPU cycles. Is this
> > correct?
> >
> > If so, what shall I do when activating the host to not get "irq 65:
> > nobody cared" ... "Disabling IRQ #65". Should I give an negative irq
> > number?
>
> When you get an IRQ you need to clear the IRQ status. Good question why
> you are getting them but you may well do in the resetting phases even
> with nIEN in use.
>
> OTOH if you get one or two per command then someone must have nIEN wrong
> on command issue. Either way you need to clear down IRQs that occur -
> some hardware doesn't get nIEN right and interrupts anyway in some cases.

I just read in the ATA spec and realize that I need to add a pull-down 
resistor on the INTRQ signal. The signal is now floating when nIEN is set. I 
feel silly, sorry to bother you with HW design faults :)
-- 
With kind regards

Kristoffer Nyborg Gregertsen

Student, Department of Engineering Cybernetics
Norwegian University of Science and Technology
Trondheim, Norway
