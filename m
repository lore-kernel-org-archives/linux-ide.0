From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: Slow disks.
Date: Mon, 27 Dec 2010 01:21:00 -0600
Message-ID: <4D183E5C.1040806@hardwarefreak.com>
References: <x49aajxsrh3.fsf@segfault.boston.devel.redhat.com> <20101222224416.GE30941@bitwizard.nl> <x494oa48scp.fsf@segfault.boston.devel.redhat.com> <20101223170109.GA31591@bitwizard.nl> <x49bp4c7555.fsf@segfault.boston.devel.redhat.com> <AANLkTikbhzopmyfbJuHUQdEBJLLP9e65n0cNBuUjhDdd@mail.gmail.com> <4D139EAE.9090307@jcz.nl> <AANLkTimXCb00Hj1iPG5XKdfSmvQCwtw1Oo7Qr14ZR=Ge@mail.gmail.com> <20101224114008.GL30941@bitwizard.nl> <AANLkTi=e4aXeSSqCPRo4-t6j1GeW7Dj7hecHDK9KxhJ9@mail.gmail.com> <20101227002750.GF18227@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:39379 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab0L0H1c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Dec 2010 02:27:32 -0500
Received: from [192.168.100.53] (gffx.hardwarefreak.com [192.168.100.53])
	by greer.hardwarefreak.com (Postfix) with ESMTP id 20CBC6C106
	for <linux-ide@vger.kernel.org>; Mon, 27 Dec 2010 01:21:01 -0600 (CST)
In-Reply-To: <20101227002750.GF18227@bitwizard.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Rogier Wolff put forth on 12/26/2010 6:27 PM:

> It turns out that, barring an easy way to "simulate the workload of a
> mail server"

http://lmgtfy.com/?q=smtp+benchmark
http://lmgtfy.com/?q=imap+benchmark

Want ones specific to Postfix and Dovecot?

http://www.postfix.org/smtp-source.1.html
http://imapwiki.org/ImapTest/Installation

Or use iozone and focus on the small file/block random write/rewrite tests.

> This will at least provide for the benchmarked workload the optimal
> setup.

That's a nonsense statement and you know it.  Concentrate on getting
yourself some education in this thread and the solution you want/need,
instead of reaching for straws to keep yourself from "appearing wrong"
WRT something you already stated.  It's ok to be wrong on occasion.  No
one is all knowing.  Never dig your heels in when you know your argument
is on shaky ground.  Free non-technical advice there, please don't take
offense but simply ponder what I've said.

> We all agree that this does not guarantee optimal performance
> for the actual workload.

It _never_ is.  The only valid benchmark for an application workload is
the application itself or a synthetic load generator that is
applications specific.  Generic synthetic disk tests are typically
useful for comparing hardware/OS to hardware/OS or a 10 drive RAID
against a 5 drive RAID, not judging an app's performance. So don't use
such things as a yard stick, especially if they simulate a load
(streaming) that doesn't match your app (random).  You're only causing
yourself trouble.

RAID 3/4/5/6/50/60, or any other RAID scheme that uses parity, is
absolutely horrible for random read/write performance.  Multiply by
10/100/1000/? if you have cylinder/block misalignment on top of parity RAID.

Mail servers, DB servers, etc, are all random IO workloads.  If you
manage such systems, and they are running at high load regularly, or if
you have SLAs guaranteeing certain response times and latencies, then
the only way to go is with a non-parity RAID level, whether you're using
software or hardware based RAID.

This leaves you with RAID levels 1, 0, and 10 as options.  Level 1 and
zero are out, as 1 doesn't scale in size or performance, and 0 provides
negative redundancy (more failure prone than a single disk).  This
leaves RAID 10 as your only sane option.  And I mean real RAID 10, 1+0,
whatever you choose to call it, NOT the mdraid "RAID 10 layouts" which
allow "RAID 10" with only two or 3 disks.  That isn't RAID 10 and I
still can't understand why Neil or whoever decided this calls it RAID
10.  It's not RAID 10.

Here is some data showing why parity RAID levels suck:

http://www.kendalvandyke.com/2009/02/disk-performance-hands-on-part-5-raid.html

Ignore the blue/red block height of the first three graphs which fools
the non observant reader into thinking RAID 5 is 2-3 times as fast when
it's only about 10-20% faster.  The author skewed the bars high--note
the numbers on the left hand side.  Read the author's conclusions after
the table at the bottom.

http://weblogs.sqlteam.com/billg/archive/2007/06/18/RAID-10-vs.-RAID-5-Performance.aspx

http://www.yonahruss.com/architecture/raid-10-vs-raid-5-performance-cost-space-and-ha.html

https://support.nstein.com/blog/archives/73

And we've not even touched degraded performance (1 drive down) or array
rebuild times.  RAID 5/6 degraded performance is a factor of 10 or more
worse than normal operational baseline performance, and hundreds of
times worse if you're trying to rebuild the array while normal
transaction loads are present.

RAID 10 suffers little, if any, performance penalty in degraded mode
(depending a bit on firmware implementation).  And rebuilds take place
in a few hours max as only one drive must be re-written as a copy of its
mirror pair.  No striped reads of the entire array are required.

RAID 5/6 rebuilds, however, with modern drive sizes (500GB to 2TB), can
take _days_ to complete.  This is because each stripe must be read from
all disks, parity regenerated, and the stripe be rewritten to all disks,
including the replacement disk--just to rebuild one failed disk!  With
misalignment, that can take many times longer, turning a 1-2 day rebuild
into something lasting almost a week.

Those who need (or think they need) parity RAID such as 5/6 need loads
of cheap space more than they need performance, fault tolerance, or
minimal rebuild down time.

If you believe you need performance, the only real solution is RAID 10.
 If you want a little more flexibility in managing your storage, less
performance than RAID 10, but with better performance than parity RAID,
better degraded performance and rebuild time, consider using many mdraid
1 pairs and lay an LVM stripe across them.  Doing so is a little
trickier than RAID due to calculating optimal filesystem stripe size, if
you use XFS anyway.  For large RAID storage it's the best FS hands down.

-- 
Stan

