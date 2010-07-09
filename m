From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: If I have a single bad sector, how many failed reads should
	simple dd report?
Date: Fri, 9 Jul 2010 15:04:22 -0400
Message-ID: <AANLkTimWfp4mLF9DCpxtnnUQsYQ08gXmh491EfhARe1x@mail.gmail.com>
References: <AANLkTil2Zfhpkq24qrCoHZVx1vlbIPTcDMrZ508yODta@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52225 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab0GITEX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jul 2010 15:04:23 -0400
Received: by gwj18 with SMTP id 18so1009256gwj.19
        for <linux-ide@vger.kernel.org>; Fri, 09 Jul 2010 12:04:23 -0700 (PDT)
In-Reply-To: <AANLkTil2Zfhpkq24qrCoHZVx1vlbIPTcDMrZ508yODta@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>

Adding Mark Lord to CC because hdparm may be part of the problem.

On Thu, Jul 8, 2010 at 1:14 PM, Greg Freemyer <greg.freemyer@gmail.com>=
 wrote:
> All,
>
> I just ran a test against a IDE drive (/dev/sdb) and slightly older
> kernel (2.6.32).
>
> Similar to:
>
> dd if=3D/dev/sdb of=3D/dev/null conv=3Dnoerror,sync bs=3D4k
>
> With a good drive it ran fine.
>
> Then I used hdparm --make-bad-sector to intentionally corrupt a secto=
r
> on the drive.
>
> When I re-ran it, /var/log/messages reported 10 bad logical blocks.
> And even worse, dd reported 20 bad blocks. =A0I examined the data dd
> read and it had 80KB of zero'ed out data. =A0So that's 160 sectors wo=
rth
> of data lost because of a single bad sector. =A0At most I was expecti=
ng
> 4KB of zero'ed out data.
>
> I haven't started troubleshooting, but I want to know if this is
> expected behavior due to read-ahead or something. =A0(Is there
> read-ahead on the raw device, or just if a file system is involved.)
>
> I can redo my test with 2.6.34 and get logs if that is a bug.
>
> And if not a bug, is there a hdparm command I can issue to eliminate
> this behaviour.
>
> Thanks
> Greg

I retested with 2.6.25 and see the same behavior, so if its a bug, its
not a recently introduced one.  But 2.6.25 is showing a lot more media
errors than I recall from 2.6.32.

Even stranger, I'm now introducing the bad sector as sector 100,000
(ie. about 50 MB from the start of the drive).

Then doing a dd to capture just the first 100 MB to a file.

ie.
dd if=3D/dev/sdb of=3Dclean.dd conv=3Dnoerror,sync bs=3D4K count=3D2560=
0
hdparm --make-bad-sector 100000 --yes-i-know-what-i-am-doing /dev/sdb
dd if=3D/dev/sdb of=3Dcorrupt.dd conv=3Dnoerror,sync bs=3D4K count=3D25=
600
hdparm --write-sector 100000 --yes-i-know-what-i-am-doing /dev/sdb

(clearly don't do that to a disk you care about.  The data at sector
100,000 is permanently lost.)

cmp -bl clean.dd corrupt.dd > delta.log

Looking at delta.log, the bytes start disagreeing 4 bytes prior to the
sector boundary.  How can that be?

I guess hdparm --make-bad-sector may be corrupting an extra 4 bytes,
but that would surprise me.

That seems like a definite bug in either the kernel or hdparm.

Mark, do you have any input about either the early start of the
corruption, or the very large number of sectors that seem corrupted by
making a single sector bad.

Greg
