From: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
Subject: ide-io.c, ide_do_request -- race condition?
Date: Mon, 05 Jul 2004 23:51:45 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40E99531.BDB8D339@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out009pub.verizon.net ([206.46.170.131]:23779 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261763AbUGEWvt
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jul 2004 18:51:49 -0400
Received: from M2Dual.localdomain ([4.15.37.40]) by out009.verizon.net
          (InterMail vM.5.01.06.06 201-253-122-130-106-20030910) with ESMTP
          id <20040705225148.RAGW29216.out009.verizon.net@M2Dual.localdomain>
          for <linux-ide@vger.kernel.org>; Mon, 5 Jul 2004 17:51:48 -0500
Received: from verizon.net ([10.0.0.38])
	by M2Dual.localdomain (8.12.8/8.12.8) with ESMTP id i65MplnA010587
	for <linux-ide@vger.kernel.org>; Mon, 5 Jul 2004 18:51:48 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a question about a specific statement in the ide-io.c
code.  However, I know that I need to establish a context
for that question, so please be patient with the fairly long
discussion that follows.

I recently decided to install Linux (Fedora Core 1 to be
specific) on a venerably old (Thinkpad 760ED) laptop.
The process proved troublesome.  Part way through the
installation, the file system became corrupted, throwing
read errors on a block in the installed packages (i.e.
RPM) database.  I did a bad block scan, zeroed the partition
and tried again.  Twice.  The list of bad blocks was NOT
consistent from time to time.  That eliminated the disk
drive as the source of the problem.  A fourth attempt
produced a clue.  I was watching the installation using
"top" and it took a bit longer for the corruption to occur.
Three attempts later and I had a clean installation.  The
trick was to put a heavy computational load on the machine
("while [[ 0 == 0 ]]; do echo -n; done &" x 5) during the
installation.  However the installation took about 6 hours
as a result, two and a half to three times the normal time.

The problem did not end there.  Updating from the 
installation base to the current patch level also corrupted
the file system.  It took three more tries, from scratch, to
get a usable system.

Surprisingly, a kernel build did NOT produce any corruption.
This pretty much eliminated memory as a source of the problem.
The build process is a much more memory intense process than
the installation process.  It would have blown up faster than
the installations if there was a memory problem.

(The fact that the machine runs other OSs without noticeable
problems is also an indication that the underlying hardware
is in working order.  Only the system software and disk
drive changed between the two setups and I have explained
why I do not think it is the disk drive.)

I concluded that there was a race condition someplace in
the disk drivers sequence and went a hunting through the 
driver code starting from the IDE end.

In ide-io.c there is a block comment just before the place
where the i/o request setup routine is called.  It notes
that some older chipsets do not like to be interrupted
during the setup process.  It also notes that 'massive
fs corruption" will result if the setup process is
interrupted.  (Hmmmm.)  A search of the kernel mailing list
archives found one note on this piece of code where commands
were getting lost (rarely) in an SMP environment.  I thought
that this would be a good piece of code to fine tooth.

The code was more or less what I expected.  A pair of calls
locked the register set by turing the relevant interrupt off
before the setup and back on when it was done.  They were the
obvious places to do the SMP synchronization and inspection
proved that that was in fact the case so premature interrupts
should not be a problem if everything else was kosher.

What I found next was very surprising given the comments.
Local interrupts were then turned back on!  I expected to see
ALL interrupts turned off here because the setup had to be
atomic, but the opposite was what the code did.  What is going
on here?

This is 2.4.22 code, but it has not been changed for 2.4.26.
There is some significant changes with 2.6.7, but it is worse
if anything.  A little more explanation is probably in order.

At the top of the routine all interrupts are turned off and
the hardware group busy bit is set.  This bit is protected by
a spinlock, so there should be no need to lock out interrupts
while manipulating it.  There are a few other conditions
checked next, none requiring interrupt lockout.  So a whole
bunch of code has been executing under interrupt lockout when
there was no need for the lockout.  Not a huge problem, just
strange.  Also, in 2.6, the lockout has to begin before the
routine is called which is why I said 2.6 was worse.

Then comes the block comment, the all-CPU lockout of completion
interrupts, and just when the comment suggests that all 
interrupts should be turned off, they are turned back on.

I can understand the problem the comment might be addressing.
The interface could well be sensitive to the timing of the
over-all load sequence or a read from the status register
checking for 'ready' could bollix the whole setup process.
This final setup phase really should be an atomic operation.

I've done a little 'playing' with this code.  First I tried
just removing the enable call.  It seems to have had absolutely
no effect.  The system did NOT hang because the interrupt lock
out did not end.  The file system corruption showed up again
on applying a subsequent update.  I've also made a slightly
more venturesome change.  I pulled the disable at the head of
the routine and put it just before the setup call and moved
the enable to after the setup call.  I've seen no problems
with this variant, but I might not see any with the hardware
I have.  A machine with more than one IDE interface on the
same IRQ line might show a problem, particularly if it was a
multi-processor running SMP.  (I have an SMP machine, but not
one with three IDE controllers.)

I haven't dug around the Linux kernel as much as I probably
should have.  (That does not mean I am not familiar with
kernels.  I did a lot of digging through PDP 11 and VAX
operating system code including RSX-11 A, B, D and M, 
RSTS-11, RT-11, DOS-11 and VMS plus some bare metal [paper 
tape loader!] applications.)  I can see that the setup 
process for an IDE controller could be fairly lengthy and 
that interrupt latency could become a problem, and enabling
local interrupts would relieve the problem, but not at the
cost of corrupting system integrity?

Could someone else fine tooth this?  Just to make sure I'm
not missing something major (or minor)...

1) Modify the FC1 installation environment so that the
   correct lockout sequence is used.  This will require that
   I build a new boot floppy.

2) Do another installation without using the system load
   trick.  This should be fairly definitive since I have not
   be able to do a complete system load without problem in
   half a dozen attempts.

3) Do the updates without the system load trick.

Finally, if this proves to be an acceptable cure to my
problem,

A) Does there need to be a way to turn this fix off when
   it is not needed? (and how do you tell if it is needed?
   boot command line option?  Blacklist?)

B) Should it be included in the standard distribution?

C) What is the procedure for getting it included?

I've been going through the linux-ide archives and noticed
that there have been a number of mystery fs corruption issues
that just disappeared.  This might be related.  There was also
a DMA problem that might have been relevant, but I know it does
not apply in this case since "hdparm" shows DMA turned off by
default on this machine.

Max T.E. Woodbury
max@mtew.isa-geek.net
