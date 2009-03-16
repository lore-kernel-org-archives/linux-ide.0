From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: ATA support for 4k sector size
Date: Mon, 16 Mar 2009 13:37:07 -0400
Message-ID: <87f94c370903161037q52ff5e1nb7512726e58e652c@mail.gmail.com>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>
	 <yq1hc2iumg9.fsf@sermon.lab.mkp.net> <20090226025043.GJ1363@mit.edu>
	 <20090226030735.GA16891@parisc-linux.org>
	 <yq1eixlg4mn.fsf@sermon.lab.mkp.net> <49A6B604.1060702@zytor.com>
	 <yq1iqmxey1o.fsf@sermon.lab.mkp.net> <49A70379.3050306@zytor.com>
	 <87f94c370903160751t6de5ed2t40163a6590ba633@mail.gmail.com>
	 <49BE7DEF.1060005@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f122.google.com ([209.85.221.122]:44332 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397AbZCPRhL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Mar 2009 13:37:11 -0400
In-Reply-To: <49BE7DEF.1060005@zytor.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Matthew Wilcox <matthew@wil.cx>, Theodore Tso <tytso@mit.edu>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

On Mon, Mar 16, 2009 at 12:27 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> Greg Freemyer wrote:
>> If the reported geometry of these drives was changed to have sectors=
 /
>> track be a multiple of 8, wouldn't that fix most of the issues.
>>
>> ie. If the drive were to report 56 sectors per track, then a
>> traditional partitioning tool would start the first partition as
>> sector 56 and a Vista like partitioning tool would place the first
>> partition at sector 2048. =A0Both would have the same 4K sector
>> alignment.
>>
>> If my logic is sound, anyway to get this recommendation upstream to
>> hardware manufacturers. =A0It seems like an almost trivial change fo=
r
>> them.
>>
>> FYI: It sounds to me like partitioning tools should totally drop
>> efforts to align with cylinders, instead they should start asking wh=
at
>> the unit of atomic read/writes is at the physical layer and if any
>> offsets are needed to align the partition with the atomic write area=
s.
>>
>> That would fit better for both SSD technology and for this 4K sector=
s
>> issue than trying to continue to support cylinders at all.
>
> As long as BIOSes played along with it (which some of them may not do=
 --
> remember the geometry that matters is the one reported by the BIOS)
> However, it definitely would be a major step in the right direction, =
as
> it would let *most* systems Do The Right Thing instead of weirdly
> misaligning the partitions and trying to cope with that.
>
> =A0 =A0 =A0 =A0-hpa

I'm not intimate with the details, but I would hope most boot loaders
by now use LBA values to find the boot code, not CHS.

If so the issue becomes the partitioning tools (fdisk etc.) putting
the partitions at the right place.  Can't those tools bypass the bios
somehow and ask the drive itself what it's geometry is?

=46rom what I understand Vista has already made the jump and is now
ignoring CHS and instead just putting the first partition at 1 MiB
into the drive.  (sector 2048 with 512 byte sectors.)

Sounds like fdisk and friends should be updated to do the same.

A bigger issue in my mind is lots of clones, images, etc. are probably
LBA based today and simply start the first partition at sector 63.
Thus the hardware vendors will need to have drives that perform well
with partitions that start at sector 63.  The existing scheme
described may be as good as it gets for that need.

Also, how are SDD manufacturers handling this.  Their erase blocks
don't align with partitions that start at sector 63 either I assume?

Greg
--=20
Greg Freemyer
Head of EDD Tape Extraction and Processing team
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
=46irst 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.p=
df

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
