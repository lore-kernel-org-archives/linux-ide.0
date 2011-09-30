From: Jim Mills <jmills007@gmail.com>
Subject: Re: Possible MD RAID 5 or sata_sil driver issues.
Date: Fri, 30 Sep 2011 10:14:48 -0400
Message-ID: <CAPoxMr=KMmYnsFSf1cwNdQpJUSSYVp5ZVi=9UFvBuhV7q6dxsQ@mail.gmail.com>
References: <CAPoxMrn17Z63GDiZ4fOskRoBauQwOd12RMBgBtBGgmB=+gU9VA@mail.gmail.com>
	<20110929205016.GA28611@psychosis.jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51157 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739Ab1I3OOt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Sep 2011 10:14:49 -0400
Received: by vws1 with SMTP id 1so1319619vws.19
        for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2011 07:14:48 -0700 (PDT)
In-Reply-To: <20110929205016.GA28611@psychosis.jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: neilb@suse.de, neilb@cse.unsw.edu.au, jgarzik@pobox.com, linux-ide@vger.kernel.org

I was pretty sure both md and sil drivers are solid... just didn't
know if their might be some weird interactions between the two.  I
might try blktrace to narrow it down.

When I get some time, I will try downgrading to some other SIL bioses.
 I do see some exceptions for certain hard drives in the SIL kernel
code, so it could be interactions with my particular drives.

If it is RAM on the hard drive, I have no real idea how to check this
one.  Maybe disabling the read/write cache to minimize the affect.

System RAM is good, and has been tested 24+ hours with memtest+.  This
is an older system, and I am contemplating just building another
system with a MB with many built in sata ports.

Is there any easy way to figure out how MD maps it to a particular
drive vs. me having to do manual math, etc?



On Thu, Sep 29, 2011 at 4:50 PM, Jim Paris <jim@jtan.com> wrote:
> Jim Mills wrote:
>> Possible MD RAID 5 or sata_sil driver issues.
>>
>> Summary:
>> I created an XFS filesystem on top of a MD RAID5 across 4 SATA drive=
s
>> connected to a single SIL3114 PCI card.
>>
>> Problem: =C2=A0I am seeing errors and corrupted files, as checked by=
 CRC
>> and PAR2. =C2=A0This is a brand new filesystem, on new drives. =C2=A0=
The drives
>> do not have smart errors, and have even been zeroed out, as well as
>> reading all blocks with offline smart checks, badblocks, and even
>> ddrescue. =C2=A0This also shows up in the mismatch_cnt after sending=
 check
>> to sync_action. =C2=A0Sending repair to sync_action, and then later =
sending
>> check doesn't fix it.
>>
>> I have seen this issue regardless if it is XFS or even EXT4, so I am
>> not assuming it is not related to the filesystem. =C2=A0Although I d=
id note
>> that MD didn't start recovering after being created until a filesyst=
em
>> was created.
>>
>> I do not see these issues when using the drives without RAID.
>>
>> This leaves me with the only common pieces is the card and the md
>> software, which is why I am writing both of you. =C2=A0It might be
>> something weird with the interaction of the two.
>>
>> I have tried looking at the sata_sil code, and don't see an easy way
>> to enable debugging via insmod. =C2=A0I have not tried turning on an=
y debug
>> in md, and can't unload it as my root, etc. is on a md mirror.
>>
>> Linux Kernel: SUSE 3.0.4-2-desktop.
>> SiI 3114 IDE BIOS =C2=A0 =C2=A0 4/22/2008 =C2=A0 =C2=A0 =C2=A0 5.5.0=
=2E0
>>
>> Please let me know what additional details would be helpful, and if =
I
>> should point this at a particular email distribution.
>
> Just some random input from a bystander:
>
> The md raid5 code and sata_sil drivers can usually be considered
> really solid, they're very commonly used and well-tested.
>
> I had similar issues once, with file corruption sometimes showing up
> on a MD raid5. =C2=A0The disks always tested out fine individually (w=
riting
> pseudorandom data and reading it back), and they were still fine with
> a raid1 across all disks, so I thought it might be raid5 related. =C2=
=A0It
> turns out that it was actually bad RAM on one of the HDDs, and the
> glitch was triggered only by certain access patterns that showed up
> while writing to the raid5 array.
>
> It's probably worth looking into hardware issues. =C2=A0Maybe your po=
wer
> supply isn't good enough and these particular access patterns trigger
> a problem. =C2=A0Or system RAM could be bad, or maybe your motherboar=
d has
> problems with heavy traffic on the PCI bus, etc.
>
> It could help to figure out exactly what the corruption is, by writin=
g
> known data to the entire raid5 array and seeing where it differs when
> you read it back.
>
> -jim
>
