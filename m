From: Mike Snitzer <snitzer@redhat.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Thu, 11 Mar 2010 11:01:41 -0500
Message-ID: <170fa0d21003110801p3ce6c5e9xe77b6f9f833fe19d@mail.gmail.com>
References: <4B947393.2050002@kernel.org> <201003111927.24829.knikanth@suse.de>
	 <472A4C80-30CE-4875-8073-F7E61659B6F0@mit.edu>
	 <201003112030.44605.knikanth@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:42385 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083Ab0CKQBn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Mar 2010 11:01:43 -0500
In-Reply-To: <201003112030.44605.knikanth@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nikanth Karthikesan <knikanth@suse.de>
Cc: Theodore Tso <tytso@mit.edu>, Damian Lukowski <damian@tvk.rwth-aachen.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Matthew Wilcox <matthew@wil.cx>, "Martin K. Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@suse.de>, Tejun Heo <tj@kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Mark Lord <kernel@teksavvy.com>, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, aschnell@suse.de, jdelvare@suse.de

On Thu, Mar 11, 2010 at 10:00 AM, Nikanth Karthikesan <knikanth@suse.de=
> wrote:
> On Thursday 11 March 2010 19:58:11 Theodore Tso wrote:
>> On Mar 11, 2010, at 8:57 AM, Nikanth Karthikesan wrote:
>> > I guess, what he meant was, to keep filesystem blocks aligned, eve=
n if
>> > the partition is not. Say if the partition is mis-aligned by 512-b=
ytes,
>> > let the filesystem waste 4k-512bytes and keep it's blocks aligned.=
 But it
>> > might be a case of over-engineering, possibly requiring disk forma=
t
>> > change.
>>
>> Ah, yes, I agree with you; that's probably what he meant.
>>
>> Sure, that's theoretically possible, but it would mean changing ever=
y
>> =A0single filesystem, and it would require a file system format chan=
ge --- or
>> =A0at least a file system format extension.
>>
>> It would seem to be way easier to simply fix the partitioning tools =
to do
>> =A0the right thing, though.
>>
>
> Yes. May be, just a simple but transparent device-mapper like mapping=
 on top
> of the mis-aligned partition, to do the alignment. Then the file-syst=
em code
> need not change much.
>
> But Linux already has device-mapper and Linux will not be affected wi=
th mis-
> aligned partitions, when we use LVM.

Well, device-mapper and LVM needed to be updated to make them "just
work" but yes that work has been done.

> But the actual problem here is that partitioning tools might create p=
artitions
> that wont allow other operating-systems to boot. So it might be enoug=
h, if the
> partitioning tools just create partitions with (mis-)alignment requir=
ement for
> Windows.

I'm not following...

Anyway, 4K drives that are 512b logical and 4K physical may or may not
also have "DOS partition compensation" that use LBA -1 as the first
naturally (4K) aligned start.  This means that the partition tools
need to shift the start of the first primary partition to be offset by
3584 bytes (7 512b sectors) for use with Linux.  But for windows,
AFAIK windows XP and windows 7 create all partitions aligned on 1MB
boundaries.  Linux's parted and fdisk create 1MB aligned partitions
now too.

So the only outlier is older versions of windows (< XP) and Linux (old
fdisk and parted, etc also use DOS partitioning) that don't use
naturally aligned (e.g. 1MB) partition boundaries.  In those versions
of Windows and LInux there are ways to change the default start of
sector 63.   That said, there is an opportunity to improve
documentation for how to workaround DOS partitioning on these
operating systems.

One other piece worth mentioning on this "IO Toplogy" support in the
entire Linux I/O Stack is the virt layers.  hch has already extended
the virt-io protocol and qemu is in the finishing stages of being
updated to properly consume the "IO Topology" information.  So we
really don't have any gaps in the Linux I/O stack.

mkp in particular, Jens, James, myself, and others implemented and
refined the SCSI and block changes.  kzak, jim meyering, hans de
goede, hch, eric sandeen, bob peterson, myself and others updated all
other I/O stack layers ranging from DM to LVM, libblkid, fdisk, parted
to anaconda to mkfs.ext[234], mkfs.xfs, mkfs.gfs2 to virt-io and qemu.
 FYI, all of these advances will be in Fedora 13 (quite a few are
already in Fedora 12).

There are obviously other Linux systems and userland tools (likely
Xen, other mkfs.* and more) that should be updated.  Hopefully
maintainers and/or contributors of these projects will follow-up to
address those that need updating.

Again please see:
http://oss.oracle.com/~mkp/docs/linux-advanced-storage.pdf
http://people.redhat.com/msnitzer/docs/io-limits.txt
Some omissions include: Linux MD, which has been updated as mkp
pointed out, and I neglected to talk about virt-io and qemu (but like
I said they have been updated too).

Hopefully we're all closer to being on the same page now.

Mike
