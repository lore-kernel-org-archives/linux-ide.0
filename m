From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: ATA support for 4k sector size
Date: Mon, 16 Mar 2009 10:51:28 -0400
Message-ID: <87f94c370903160751t6de5ed2t40163a6590ba633@mail.gmail.com>
References: <1235600698-6446-1-git-send-email-matthew@wil.cx>
	 <49A5CBF7.9000501@zytor.com> <yq1hc2iumg9.fsf@sermon.lab.mkp.net>
	 <20090226025043.GJ1363@mit.edu>
	 <20090226030735.GA16891@parisc-linux.org>
	 <yq1eixlg4mn.fsf@sermon.lab.mkp.net> <49A6B604.1060702@zytor.com>
	 <yq1iqmxey1o.fsf@sermon.lab.mkp.net> <49A70379.3050306@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f122.google.com ([209.85.221.122]:59320 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbZCPOva convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Mar 2009 10:51:30 -0400
In-Reply-To: <49A70379.3050306@zytor.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Matthew Wilcox <matthew@wil.cx>, Theodore Tso <tytso@mit.edu>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sandeen@redhat.com

On Thu, Feb 26, 2009 at 5:02 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> Martin K. Petersen wrote:
>>>>>>>
>>>>>>> "hpa" =3D=3D H Peter Anvin <hpa@zytor.com> writes:
>>
>>>> Quick answer from one of my contacts. =A0Desktop drives will indee=
d
>>>> ship with an alignment of 1(*). =A0The alignment is hardwired at t=
ime
>>>> of manufacture and can't be changed.
>>>>
>>
>> hpa> Oh God.
>>
>> hpa> This is a disaster.
>>
>> Rationale being that modern Microsoft operating systems know how to
>> interpret the alignment bits. =A0Legacy XP will work without changes
>> thanks to the shifted alignment. =A0And Vista+ will do the right thi=
ng to
>> align partition 1 to what the drive reports.
>>
>> Also note that Windows only aligns the first partition. =A0That's
>> something we need to be aware of when setting up dual boot systems.
>>
>
> Yeah, but all of this completely breaks the disk image abstraction, w=
hich is
> a very powerful paradigm.
>
> =A0 =A0 =A0 =A0-hpa
>
If the reported geometry of these drives was changed to have sectors /
track be a multiple of 8, wouldn't that fix most of the issues.

ie. If the drive were to report 56 sectors per track, then a
traditional partitioning tool would start the first partition as
sector 56 and a Vista like partitioning tool would place the first
partition at sector 2048.  Both would have the same 4K sector
alignment.

If my logic is sound, anyway to get this recommendation upstream to
hardware manufacturers.  It seems like an almost trivial change for
them.

=46YI: It sounds to me like partitioning tools should totally drop
efforts to align with cylinders, instead they should start asking what
the unit of atomic read/writes is at the physical layer and if any
offsets are needed to align the partition with the atomic write areas.

That would fit better for both SSD technology and for this 4K sectors
issue than trying to continue to support cylinders at all.

Thanks
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
