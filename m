From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: ide-io.c, ide_do_request -- race condition?
Date: Sat, 10 Jul 2004 22:07:19 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200407102207.19713.bzolnier@elka.pw.edu.pl>
References: <40E99531.BDB8D339@verizon.net> <200407072143.07618.bzolnier@elka.pw.edu.pl> <40F04291.434D8AF9@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:52454 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266364AbUGJUBh
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Jul 2004 16:01:37 -0400
In-Reply-To: <40F04291.434D8AF9@verizon.net>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
Cc: linux-ide@vger.kernel.org

On Saturday 10 of July 2004 21:25, Max T. Woodbury wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> >
> > On Tuesday 06 of July 2004 00:51, Max T. Woodbury wrote:
> > > (The fact that the machine runs other OSs without noticeable
> > > problems is also an indication that the underlying hardware
> > > is in working order.  Only the system software and disk
> > > drive changed between the two setups and I have explained
> > > why I do not think it is the disk drive.)
> >
> > disk drive changed?  please explain
>
> The drives in the Thinkpad 760 are mounted in caddies that can
> be easily exchanged when the power is off.  I have three drives.
> One runs the machine as a GPS, the second as a code development
> Windows box and the third is my Linux code development machine.
> I'm having a fair amount of trouble getting the Linux setup to do
> what I want it to do.  Not only did the Linux install flake out,
> but I still can't get the PCMCIA sockets working, but that's another
> issue for another list and I haven't quite got enough information
> on that set of problems to make a request for help useful...  In
> order to get to the internet with Linux I have to use its docking
> station.  No such problem with Windoze.  (Yeah, absolutely
> disgusting but that's what's happening.)

Are you sure that 'Linux' disk is okay?
http://smartmontool.sf.net

> > __cli() there is just "paranoia" and it is gone in 2.6 kernels
>
> That's not quite correct.  There is a check and a BUG() call to assure
> that interrupts are disabled on entry in the 2.6 code I've seen.  If I
> understand the new code correctly, you've replaced the single interrupt
> disable call at the top of this routine by a bunch of similar calls
> elsewhere before entering this routine.  That would make interrupt latency
> worse, not better.

This is not correct - __cli() is really just a "paranoia", you may remove
it if you like and it shouldn't change anything (but we would like to know
if it changes something ie. fixes fs corruption :-).

Please take a look at generic_unplug_device() in drivers/block/ll_rw_blk.c:

spin_lock_irq() disables IRQs
__generic_unplug_device() calls queue->request_fn (ide_do_request)
spin_unlock_irq() enables IRQs

The only difference between 2.4 and 2.6 is that 2.4 is using
spin_lock_irqsave() / spin_unlock_irqrestore() variants.

> > > bunch of code has been executing under interrupt lockout when
> > > there was no need for the lockout.  Not a huge problem, just
> > > strange.  Also, in 2.6, the lockout has to begin before the
> > > routine is called which is why I said 2.6 was worse.
> >
> > 2.6 is much better - you have one spinlock per block queue while
> > in 2.4 you have one global spinlock (io_request_lock) for all
> > block requests.
>
> Yep.  That's a little courser than the model I was using on the never
> completed OS design I did in the early 70s, but it is better than the
> single global lock in 2.4 and way better than the design of many other
> OSs I've waded into.  Still, you've got a complete interrupt lockout
> in place at the top of this routine which has two bad effects: 1) the
> interrupt latency is longer and 2) there is no one place to turn it off
> any longer.

'lockout' happens earlier both in 2.4 and 2.6 -> generic_unplug_device().

> Thanks.  I was hoping to get your attention, but I did not want to
> presume on your time, thus the post to linux-ide.  (If you don't
> mind, linux-kernel is way too noisy.  I subscribed once a good while
> ago and turned it off because I could not handle the volume of just
> plain junk that gets posted to that list.  Linus must be some kind of
> saint if he wades through all of it...)

well, I don't read everything and I guess Linus does the same 8)

> > > I've been going through the linux-ide archives and noticed
> > > that there have been a number of mystery fs corruption issues
> > > that just disappeared.  This might be related.  There was also
> > > a DMA problem that might have been relevant, but I know it does
> > > not apply in this case since "hdparm" shows DMA turned off by
> > > default on this machine.
> >
> > dmesg output would be helpful, the same goes for lspci output
>
> That is an important part of this issue.  Nothing shows in dmesg
> until it is much too late.  The read errors get reported, but no
> write errors.  There should be a 'pirntk' in 'ide_abort' and
> 'idedisk_abort' (I may have the routine names wrong, I'm doing
> this from memory) but there isn't,  (I'll post a patch for that fix
> if you want.) so I can't tell if the problem is coming down from
> the upper layers.  I also think there should be a 'printk' associated
> with the posting of the immediate stop command.  (Again, this is from
> memory.  I'll post a patch with all this if you want me to.  It will
> not fix any problems, but might shed light.)

I believe that dmesg/lspci would be useful for me or other people reading
this because it allows us to know a bit more about this specific hardware
('Thinkpad 760' is really not enough).

> Still, this is an important problem.  File system corruption is just not
> something an OS should allow to happen unless the user does something
> extreme.

Without more info we won't go further in solving this issue.

Bartlomiej

