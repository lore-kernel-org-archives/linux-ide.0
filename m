From: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
Subject: Re: ide-io.c, ide_do_request -- race condition?
Date: Sun, 11 Jul 2004 10:38:16 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40F150D8.B7FB27D3@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out012pub.verizon.net ([206.46.170.137]:27377 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S266607AbUGKOiP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Jul 2004 10:38:15 -0400
Received: from M2Dual.localdomain ([4.15.37.40]) by out012.verizon.net
          (InterMail vM.5.01.06.06 201-253-122-130-106-20030910) with ESMTP
          id <20040711143814.ZPYF2198.out012.verizon.net@M2Dual.localdomain>
          for <linux-ide@vger.kernel.org>; Sun, 11 Jul 2004 09:38:14 -0500
Received: from verizon.net ([10.0.0.10])
	by M2Dual.localdomain (8.12.8/8.12.8) with ESMTP id i6BEcClo013904
	for <linux-ide@vger.kernel.org>; Sun, 11 Jul 2004 10:38:13 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Saturday 10 of July 2004 21:25, Max T. Woodbury wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> > > On Tuesday 06 of July 2004 00:51, Max T. Woodbury wrote:
> > > > (The fact that the machine runs other OSs without noticeable
> > > > problems is also an indication that the underlying hardware
> > > > is in working order.  Only the system software and disk
> > > > drive changed between the two setups and I have explained
> > > > why I do not think it is the disk drive.)
> > >
> > > disk drive changed?  please explain
> >
> > The drives in the Thinkpad 760 are mounted in caddies that can
> > be easily exchanged when the power is off.  I have three drives.
> > One runs the machine as a GPS, the second as a code development
> > Windows box and the third is my Linux code development machine.
> > I'm having a fair amount of trouble getting the Linux setup to do
> > what I want it to do.  Not only did the Linux install flake out,
> > but I still can't get the PCMCIA sockets working, but that's another
> > issue for another list and I haven't quite got enough information
> > on that set of problems to make a request for help useful...  In
> > order to get to the internet with Linux I have to use its docking
> > station.  No such problem with Windoze.  (Yeah, absolutely
> > disgusting but that's what's happening.)
>
> Are you sure that 'Linux' disk is okay?
> http://smartmontool.sf.net

Yes.  The CDs all passed the scanner RedHat provided and they installed
correctly on a desktop system. The drive I used for linux was zeroed
and it passed a read/write badblock scan on the whole disk and several
on the partition in question.  Still, it could be that the drive is
getting the data into its buffer correctly but not out to the magnetic
media, but the fact that the errors move around so much indicates that
it is not the media itself that is bad.  My next comment is on the
fringes of my competence and is mostly opinion:  If the drive is
failing to actually transfer the data from its buffer to the media,
there should be an error indication of some sort and it should be passed
back to the OS where it can be logged.  I didn't see any such code, but
I'm not sure I'd recognize it if I saw it.

I do wish there were a write check option.  It does nasty things to
performance, but improves system integrity.  Of course I haven't checked
the upper layers in the system yet.  There might be such an option at the
block cache or file system levels and I'd not have seen it yet. It's
been about four years since I went through that code last so I'm foggy on
the details and it has almost certainly changed since I looked at it.

> > > __cli() there is just "paranoia" and it is gone in 2.6 kernels
> >
> > That's not quite correct.  There is a check and a BUG() call to assure
> > that interrupts are disabled on entry in the 2.6 code I've seen.  If I
> > understand the new code correctly, you've replaced the single interrupt
> > disable call at the top of this routine by a bunch of similar calls
> > elsewhere before entering this routine.  That would make interrupt latency
> > worse, not better.
>
> This is not correct - __cli() is really just a "paranoia", you may remove
> it if you like and it shouldn't change anything (but we would like to know
> if it changes something ie. fixes fs corruption :-).

Hmm. At the place it was, it was harmless paranoia, but I thought you might
not have been being paranoid enough.  You should not have taken the lockout
off until after the command was actually started.  But doing that was not
enough to fix the problem...

I did a quick scan of the IRQ level code in the arch/i386 tree to get an idea o
f what it did and recognized the pattern from other OSs I've seen, so I did not
look at all the details closely.  I think I saw CLI and STI pairs that might
have nulled the CLI in ide-io.c in there, but I did not try to figure exactly
which conditionals were on or off so I was not certain of the exact set of code
that was operational.  As I said, I was scanning for an overall pattern.

> Please take a look at generic_unplug_device() in drivers/block/ll_rw_blk.c:

If I remember correctly, that's the block cache layer.  The last time I looked
at it, it didn't do hot-plug, so I need to look at it again...  I'll do as you
suggest.

> > > > bunch of code has been executing under interrupt lockout when
> > > > there was no need for the lockout.  Not a huge problem, just
> > > > strange.  Also, in 2.6, the lockout has to begin before the
> > > > routine is called which is why I said 2.6 was worse.
> > >
> > > 2.6 is much better - you have one spinlock per block queue while
> > > in 2.4 you have one global spinlock (io_request_lock) for all
> > > block requests.
> >
> > Yep.  That's a little courser than the model I was using on the never
> > completed OS design I did in the early 70s, but it is better than the
> > single global lock in 2.4 and way better than the design of many other
> > OSs I've waded into.  Still, you've got a complete interrupt lockout
> > in place at the top of this routine which has two bad effects: 1) the
> > interrupt latency is longer and 2) there is no one place to turn it off
> > any longer.
>
> 'lockout' happens earlier both in 2.4 and 2.6 -> generic_unplug_device().

Hmm.  I'll have to look at that layer again.  I think we're talking about
a different level of lockout.  I suspect that you mean that this is a
critical region of code and only one thread of execution can be in it at
one time.  I was thinking 'atomic' in the sense that it could not be
interrupted and that its timing was consistent.  I'm not sure I am using
the term in the same way everyone else does.

> > > > I've been going through the linux-ide archives and noticed
> > > > that there have been a number of mystery fs corruption issues
> > > > that just disappeared.  This might be related.  There was also
> > > > a DMA problem that might have been relevant, but I know it does
> > > > not apply in this case since "hdparm" shows DMA turned off by
> > > > default on this machine.
> > >
> > > dmesg output would be helpful, the same goes for lspci output
> >
> > That is an important part of this issue.  Nothing shows in dmesg
> > until it is much too late.  The read errors get reported, but no
> > write errors.  There should be a 'pirntk' in 'ide_abort' and
> > 'idedisk_abort' (I may have the routine names wrong, I'm doing
> > this from memory) but there isn't,  (I'll post a patch for that fix
> > if you want.) so I can't tell if the problem is coming down from
> > the upper layers.  I also think there should be a 'printk' associated
> > with the posting of the immediate stop command.  (Again, this is from
> > memory.  I'll post a patch with all this if you want me to.  It will
> > not fix any problems, but might shed light.)
>
> I believe that dmesg/lspci would be useful for me or other people reading
> this because it allows us to know a bit more about this specific hardware
> ('Thinkpad 760' is really not enough).

Yep. lspci will be OS version independent.  I'll get you that shortly.
(I booted the original FC1 distribution in an attempt to get the PCMCIA
stuff to work and it promptly (well after 12 hours) messed up the file
system.)  I'm in the process of cleaning up the disk again.

'dmesg' is somewhat dependent on the OS features configured.  I'll get
you the one from the installation boot disk where the problem was first
noticed.  I take it you want the initial boot part, not the part after
rc.sysinit or whatever is driving the installation process takes over.
It also makes a difference if the machine is docked or undocked.  I'll
get you one of the undocked machine.  Both configurations have the problem
but the undocked configuration is simpler.

 > > Still, this is an important problem.  File system corruption is just not
> > something an OS should allow to happen unless the user does something
> > extreme.
>
> Without more info we won't go further in solving this issue.

I really don't expect you to solve the problem for me.  I have to do
most of the work myself.  I'd recognized that I was on the borders of my
competence and have asked for advice.  I recognized that I was making
assumptions about the code that I needed to check.  While you haven't
exactly answered the questions I asked, you have responded in a way that
provides most of the information I need and pointed me to more places to
look for answers.

There was also the possibility that this problem has an impact beyond my
personal involvement.  I'm not certain that it does, but it would be
irresponsible of me to ignore such a possibility.  (And I just arrogant
enough that I think I have such a responsibility...)

Thank you for your help so far.

Max
