From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: ide-io.c, ide_do_request -- race condition?
Date: Wed, 7 Jul 2004 21:43:07 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200407072143.07618.bzolnier@elka.pw.edu.pl>
References: <40E99531.BDB8D339@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20964 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265354AbUGGThp
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Jul 2004 15:37:45 -0400
In-Reply-To: <40E99531.BDB8D339@verizon.net>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
Cc: linux-ide@vger.kernel.org


Hi,

On Tuesday 06 of July 2004 00:51, Max T. Woodbury wrote:

> The problem did not end there.  Updating from the
> installation base to the current patch level also corrupted
> the file system.  It took three more tries, from scratch, to
> get a usable system.
>
> Surprisingly, a kernel build did NOT produce any corruption.
> This pretty much eliminated memory as a source of the problem.
> The build process is a much more memory intense process than
> the installation process.  It would have blown up faster than
> the installations if there was a memory problem.
>
> (The fact that the machine runs other OSs without noticeable
> problems is also an indication that the underlying hardware
> is in working order.  Only the system software and disk
> drive changed between the two setups and I have explained
> why I do not think it is the disk drive.)

disk drive changed?  please explain

> I concluded that there was a race condition someplace in
> the disk drivers sequence and went a hunting through the
> driver code starting from the IDE end.
>
> In ide-io.c there is a block comment just before the place

next time please just paste the code/comments you refer to,
it will make reading/replying a lot easier

> where the i/o request setup routine is called.  It notes
> that some older chipsets do not like to be interrupted
> during the setup process.  It also notes that 'massive
> fs corruption" will result if the setup process is
> interrupted.  (Hmmmm.)  A search of the kernel mailing list
> archives found one note on this piece of code where commands
> were getting lost (rarely) in an SMP environment.  I thought

do you have a link to this note handy?

> that this would be a good piece of code to fine tooth.
>
> The code was more or less what I expected.  A pair of calls
> locked the register set by turing the relevant interrupt off
> before the setup and back on when it was done.  They were the
> obvious places to do the SMP synchronization and inspection
> proved that that was in fact the case so premature interrupts
> should not be a problem if everything else was kosher.
>
> What I found next was very surprising given the comments.
> Local interrupts were then turned back on!  I expected to see
> ALL interrupts turned off here because the setup had to be
> atomic, but the opposite was what the code did.  What is going
> on here?

if I guess right, you are referring to this part of ide-io.c (2.6.7 here):

		/*
		 * Some systems have trouble with IDE IRQs arriving while
		 * the driver is still setting things up.  So, here we disable
		 * the IRQ used by this interface while the request is being started.
		 * This may look bad at first, but pretty much the same thing
		 * happens anyway when any interrupt comes in, IDE or otherwise
		 *  -- the kernel masks the IRQ while it is being handled.
		 */
		if (hwif->irq != masked_irq)
			disable_irq_nosync(hwif->irq);

mask IRQ used by the IDE port

		spin_unlock(&ide_lock);
		local_irq_enable();

enable local IRQs, IDE IRQ stays masked

			/* allow other IRQs while we start this request */
		startstop = start_request(drive, rq);

start request

		spin_lock_irq(&ide_lock);

disable local IRQs

		if (hwif->irq != masked_irq)
			enable_irq(hwif->irq);

unmask IDE IRQ

> This is 2.4.22 code, but it has not been changed for 2.4.26.
> There is some significant changes with 2.6.7, but it is worse
> if anything.  A little more explanation is probably in order.

I don't think it's worse, more below.

> At the top of the routine all interrupts are turned off and

If you are referring to a __cli() at a top of ide_do_request()
please notice that comment says "paranoia" - IRQs should be already
disabled by block layer which does spin_lock_irqsave() earlier.

> the hardware group busy bit is set.  This bit is protected by
> a spinlock, so there should be no need to lock out interrupts
> while manipulating it.  There are a few other conditions
> checked next, none requiring interrupt lockout.  So a whole

Please note that the same spinlock can be accessed from IRQ
and non-IRQ context so IRQs must be disabled in non-IRQ context
to prevent deadlocks.

__cli() there is just "paranoia" and it is gone in 2.6 kernels

> bunch of code has been executing under interrupt lockout when
> there was no need for the lockout.  Not a huge problem, just
> strange.  Also, in 2.6, the lockout has to begin before the
> routine is called which is why I said 2.6 was worse.

2.6 is much better - you have one spinlock per block queue while
in 2.4 you have one global spinlock (io_request_lock) for all
block requests.

> Then comes the block comment, the all-CPU lockout of completion
> interrupts, and just when the comment suggests that all
> interrupts should be turned off, they are turned back on.
>
> I can understand the problem the comment might be addressing.
> The interface could well be sensitive to the timing of the
> over-all load sequence or a read from the status register
> checking for 'ready' could bollix the whole setup process.
> This final setup phase really should be an atomic operation.
>
> I've done a little 'playing' with this code.  First I tried
> just removing the enable call.  It seems to have had absolutely
> no effect.  The system did NOT hang because the interrupt lock
> out did not end.  The file system corruption showed up again
> on applying a subsequent update.  I've also made a slightly
> more venturesome change.  I pulled the disable at the head of
> the routine and put it just before the setup call and moved
> the enable to after the setup call.  I've seen no problems

please just inline your changes / patches (please use 'diff -u')

> with this variant, but I might not see any with the hardware
> I have.  A machine with more than one IDE interface on the
> same IRQ line might show a problem, particularly if it was a
> multi-processor running SMP.  (I have an SMP machine, but not
> one with three IDE controllers.)
>
> I haven't dug around the Linux kernel as much as I probably
> should have.  (That does not mean I am not familiar with
> kernels.  I did a lot of digging through PDP 11 and VAX
> operating system code including RSX-11 A, B, D and M,
> RSTS-11, RT-11, DOS-11 and VMS plus some bare metal [paper
> tape loader!] applications.)  I can see that the setup

:-)

> process for an IDE controller could be fairly lengthy and
> that interrupt latency could become a problem, and enabling
> local interrupts would relieve the problem, but not at the
> cost of corrupting system integrity?

yes, if this is a issue here but we don't know yet

> Could someone else fine tooth this?  Just to make sure I'm
> not missing something major (or minor)...
>
> 1) Modify the FC1 installation environment so that the
>    correct lockout sequence is used.  This will require that
>    I build a new boot floppy.
>
> 2) Do another installation without using the system load
>    trick.  This should be fairly definitive since I have not
>    be able to do a complete system load without problem in
>    half a dozen attempts.
>
> 3) Do the updates without the system load trick.
>
> Finally, if this proves to be an acceptable cure to my
> problem,
>
> A) Does there need to be a way to turn this fix off when
>    it is not needed? (and how do you tell if it is needed?
>    boot command line option?  Blacklist?)

depends on the fix, we need to see it

> B) Should it be included in the standard distribution?

in the standard kernel, yes

> C) What is the procedure for getting it included?

sending patch ('diff -u' format) with a description to Maintainer
(happens to be me in case of IDE ;-) and linux-ide mailing list,
also linux-kernel mailing list if the patch is important / needs
more testers etc.)

You may also want to read
	Documentation/SubmittingPatches
and
	Documentation/CodingStyle
from the linux kernel source package.

> I've been going through the linux-ide archives and noticed
> that there have been a number of mystery fs corruption issues
> that just disappeared.  This might be related.  There was also
> a DMA problem that might have been relevant, but I know it does
> not apply in this case since "hdparm" shows DMA turned off by
> default on this machine.

dmesg output would be helpful, the same goes for lspci output

You may also consider opening bug at http://bugme.osdl.org
and attaching all useful files to a bug entry (dmesg, lspci
and hdparm outputs, kernel config etc.).

Regards,
Bartlomiej

