From: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
Subject: Re: ide-io.c, ide_do_request -- race condition?
Date: Sat, 10 Jul 2004 15:25:05 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40F04291.434D8AF9@verizon.net>
References: <40E99531.BDB8D339@verizon.net> <200407072143.07618.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out003pub.verizon.net ([206.46.170.103]:27831 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S266352AbUGJTYk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Jul 2004 15:24:40 -0400
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Tuesday 06 of July 2004 00:51, Max T. Woodbury wrote:
> 
> > (The fact that the machine runs other OSs without noticeable
> > problems is also an indication that the underlying hardware
> > is in working order.  Only the system software and disk
> > drive changed between the two setups and I have explained
> > why I do not think it is the disk drive.)
> 
> disk drive changed?  please explain

The drives in the Thinkpad 760 are mounted in caddies that can
be easily exchanged when the power is off.  I have three drives.
One runs the machine as a GPS, the second as a code development
Windows box and the third is my Linux code development machine.
I'm having a fair amount of trouble getting the Linux setup to do
what I want it to do.  Not only did the Linux install flake out,
but I still can't get the PCMCIA sockets working, but that's another
issue for another list and I haven't quite got enough information
on that set of problems to make a request for help useful...  In
order to get to the internet with Linux I have to use its docking
station.  No such problem with Windoze.  (Yeah, absolutely
disgusting but that's what's happening.)

> > I concluded that there was a race condition someplace in
> > the disk drivers sequence and went a hunting through the
> > driver code starting from the IDE end.
> >
> > In ide-io.c there is a block comment just before the place
> 
> next time please just paste the code/comments you refer to,
> it will make reading/replying a lot easier

It's a bit difficult but willco...

> > where the i/o request setup routine is called.  It notes
> > that some older chipsets do not like to be interrupted
> > during the setup process.  It also notes that 'massive
> > fs corruption" will result if the setup process is
> > interrupted.  (Hmmmm.)  A search of the kernel mailing list
> > archives found one note on this piece of code where commands
> > were getting lost (rarely) in an SMP environment.  I thought
> 
> do you have a link to this note handy?

not handy but... linux-kernel 2003-03-27 23:54:19

Hmmm. I don't remember what my original search criteria was, but
this search brought up a Lot more stuff... mostly irrelevant...

> if I guess right, you are referring to this part of ide-io.c (2.6.7 here):
> 
>                 /*
>                  * Some systems have trouble with IDE IRQs arriving while
>                  * the driver is still setting things up.  So, here we disable
>                  * the IRQ used by this interface while the request is being started.
>                  * This may look bad at first, but pretty much the same thing
>                  * happens anyway when any interrupt comes in, IDE or otherwise
>                  *  -- the kernel masks the IRQ while it is being handled.
>                  */
>                 if (hwif->irq != masked_irq)
>                         disable_irq_nosync(hwif->irq);
> 
> mask IRQ used by the IDE port
> 
>                 spin_unlock(&ide_lock);
>                 local_irq_enable();
> 
> enable local IRQs, IDE IRQ stays masked
> 
>                         /* allow other IRQs while we start this request */
>                 startstop = start_request(drive, rq);
> 
> start request
> 
>                 spin_lock_irq(&ide_lock);
> 
> disable local IRQs
> 
>                 if (hwif->irq != masked_irq)
>                         enable_irq(hwif->irq);
> 
> unmask IDE IRQ

Yep.  That's the chunk...

> 
> > This is 2.4.22 code, but it has not been changed for 2.4.26.
> > There is some significant changes with 2.6.7, but it is worse
> > if anything.  A little more explanation is probably in order.
> 
> I don't think it's worse, more below.
> 
> > At the top of the routine all interrupts are turned off and
> 
> If you are referring to a __cli() at a top of ide_do_request()
> please notice that comment says "paranoia" - IRQs should be already
> disabled by block layer which does spin_lock_irqsave() earlier.

Yep, but enables and disables should be paired and that is the one
that paired with the enable just before the call to start_request.

> 
> > the hardware group busy bit is set.  This bit is protected by
> > a spinlock, so there should be no need to lock out interrupts
> > while manipulating it.  There are a few other conditions
> > checked next, none requiring interrupt lockout.  So a whole
> 
> Please note that the same spinlock can be accessed from IRQ
> and non-IRQ context so IRQs must be disabled in non-IRQ context
> to prevent deadlocks.

Yep.  There were LOTS of problems in VMS drivers with exactly that
problem.  I had to explain it to customers a few times.  The concept
of spinlock priority and its use to prevent deadlocks and the relation
between priority and interrupt lockout level was more complex in VMS
than in Linux, since the resource allocation model was more complex.
Your design is less complex, thus less prone to problems.  Still, the
Intel interrupt model reminds me of the one on the cheaper PDP-11s,
but that's getting way off topic.  At any rate, the concept is about
20 years old and I have a reasonable idea of what you are saying and
why it is important.  (Spin locks themselves go back at least 30 years.)

> __cli() there is just "paranoia" and it is gone in 2.6 kernels

That's not quite correct.  There is a check and a BUG() call to assure
that interrupts are disabled on entry in the 2.6 code I've seen.  If I
understand the new code correctly, you've replaced the single interrupt
disable call at the top of this routine by a bunch of similar calls
elsewhere before entering this routine.  That would make interrupt latency
worse, not better.

> > bunch of code has been executing under interrupt lockout when
> > there was no need for the lockout.  Not a huge problem, just
> > strange.  Also, in 2.6, the lockout has to begin before the
> > routine is called which is why I said 2.6 was worse.
> 
> 2.6 is much better - you have one spinlock per block queue while
> in 2.4 you have one global spinlock (io_request_lock) for all
> block requests.

Yep.  That's a little courser than the model I was using on the never
completed OS design I did in the early 70s, but it is better than the
single global lock in 2.4 and way better than the design of many other
OSs I've waded into.  Still, you've got a complete interrupt lockout
in place at the top of this routine which has two bad effects: 1) the
interrupt latency is longer and 2) there is no one place to turn it off
any longer.

> > Then comes the block comment, the all-CPU lockout of completion
> > interrupts, and just when the comment suggests that all
> > interrupts should be turned off, they are turned back on.
> >
> > I can understand the problem the comment might be addressing.
> > The interface could well be sensitive to the timing of the
> > over-all load sequence or a read from the status register
> > checking for 'ready' could bollix the whole setup process.
> > This final setup phase really should be an atomic operation.
> >
> > I've done a little 'playing' with this code.  First I tried
> > just removing the enable call.  It seems to have had absolutely
> > no effect.  The system did NOT hang because the interrupt lock
> > out did not end.  The file system corruption showed up again
> > on applying a subsequent update.  I've also made a slightly
> > more venturesome change.  I pulled the disable at the head of
> > the routine and put it just before the setup call and moved
> > the enable to after the setup call.  I've seen no problems
> 
> please just inline your changes / patches (please use 'diff -u')

If you don't mind, I'd prefer to wait on that.  I asked for comments
because the results of the modification were not exactly as I expected
and further testing seems to indicate that this may not be the real
source of the problem.  Since my understanding is incomplete, any patch
I post is likely to be wrong in one way or another.

> > process for an IDE controller could be fairly lengthy and
> > that interrupt latency could become a problem, and enabling
> > local interrupts would relieve the problem, but not at the
> > cost of corrupting system integrity?
> 
> yes, if this is a issue here but we don't know yet
> 
> > C) What is the procedure for getting it included?
> 
> sending patch ('diff -u' format) with a description to Maintainer
> (happens to be me in case of IDE ;-) and linux-ide mailing list,
> also linux-kernel mailing list if the patch is important / needs
> more testers etc.)

Thanks.  I was hoping to get your attention, but I did not want to
presume on your time, thus the post to linux-ide.  (If you don't
mind, linux-kernel is way too noisy.  I subscribed once a good while
ago and turned it off because I could not handle the volume of just
plain junk that gets posted to that list.  Linus must be some kind of
saint if he wades through all of it...)

> You may also want to read
>         Documentation/SubmittingPatches

Done that even before I posted this.  Since this problem is not even
close to the reliable patch stage, and is down=level on even the current
2.4 series, much less the 2.6 series, posting a patch did not seem to be
appropriate.

> and
>         Documentation/CodingStyle
> from the linux kernel source package.

Which is honored more in the breach than the observance... (OK. I
exaggerate.)

> 
> > I've been going through the linux-ide archives and noticed
> > that there have been a number of mystery fs corruption issues
> > that just disappeared.  This might be related.  There was also
> > a DMA problem that might have been relevant, but I know it does
> > not apply in this case since "hdparm" shows DMA turned off by
> > default on this machine.
> 
> dmesg output would be helpful, the same goes for lspci output

That is an important part of this issue.  Nothing shows in dmesg
until it is much too late.  The read errors get reported, but no
write errors.  There should be a 'pirntk' in 'ide_abort' and 
'idedisk_abort' (I may have the routine names wrong, I'm doing
this from memory) but there isn't,  (I'll post a patch for that fix
if you want.) so I can't tell if the problem is coming down from
the upper layers.  I also think there should be a 'printk' associated
with the posting of the immediate stop command.  (Again, this is from
memory.  I'll post a patch with all this if you want me to.  It will
not fix any problems, but might shed light.)

> You may also consider opening bug at http://bugme.osdl.org
> and attaching all useful files to a bug entry (dmesg, lspci
> and hdparm outputs, kernel config etc.).

If it was a problem with relevant dmesg or hdparm results, I would
have done exactly that.  The problem is fairly reproducible with my
hardware, in the sense that it will definitely happen within a two
hour window while doing an installation from floppy and CD on a
stand-alone machine, but there is no command that I can type that will
always produce the problem within a reasonable amount of time after
that command is issued.  I've been trying to produce an installation
floppy where I actually have the .config file that goes with the kernel
that is blowing up, but dissecting the RedHat installation image is not
exactly easy, and the hardware is probably listed as 'unsupported' by
them so they will just duck the issue.  (Since the machine can NOT boot
from a CD, I can not install FC2 which does 2.6 and it does not have
enough memory to install E3.  My understanding of the kernel is probably
better than my knowledge of all the command line tools and procedures.)

Still, this is an important problem.  File system corruption is just not
something an OS should allow to happen unless the user does something
extreme.

> 
> Regards,
> Bartlomiej

Max
