From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Is there a reliable way to ID a SSD?
Date: Tue, 4 Jan 2011 11:22:03 -0500
Message-ID: <AANLkTim-xG1s8=XJc1Nq0oPdwUT61TfFoiuam3Jp85oK@mail.gmail.com>
References: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com>
 <4D2223BF.8090901@canonical.com> <AANLkTinbFHFv-x6VWxAmuCn0o8BSzvUmXoeTv1XGq7A+@mail.gmail.com>
 <4D2247A3.2060506@canonical.com> <AANLkTi=Kv8f3e8zhSkDohkgJqOv+XKQ_dPR=aFbpzm27@mail.gmail.com>
 <4D23412F.2080802@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62836 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189Ab1ADQWX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2011 11:22:23 -0500
Received: by iyi12 with SMTP id 12so13105338iyi.19
        for <linux-ide@vger.kernel.org>; Tue, 04 Jan 2011 08:22:23 -0800 (PST)
In-Reply-To: <4D23412F.2080802@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: "Peter M. Petrakis" <peter.petrakis@canonical.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, Jan 4, 2011 at 10:47 AM, Mark Lord <kernel@teksavvy.com> wrote:
> On 11-01-03 05:50 PM, Greg Freemyer wrote:
>>
>> Would it be better if hdparm looked at /sys/block/sda/queue/rotation=
al
>> instead of just using word 217 of the identify block?
>>
>> The current divergence is:
>>
>> 1) The kernel routine =A0ata_id_rotation_rate() (in ata.h) is only
>> trusting =A0word 217 if its ATA7 or higher.
>>
>> http://lxr.linux.no/#linux+v2.6.36/include/linux/ata.h#L799
>>
>> 2) There have been a couple proposed kernel patches to libata-scsi.c
>> to quirk in a HORKAGE flag to set the rotation_rate to 1 (meaning SS=
D)
>> for some known devices. =A0I don't see those being ACKed yet, but if=
 one
>> ever gets in, hdparm will diverge from the kernels info since its
>> going straight to the identify block for its info.
>
> That's what hdparm is for. =A0It reads only from the identify block
> for most of the -I output, so that we (kernel developers) can see
> exactly what the drive itself is reporting.
>
> This reporting is what makes it useful, rather than simply parroting
> whatever is already reported (or not) in /sys/
>
> Cheers

Interesting to know.  Maybe the man page could be even more explicit ab=
out that.

ie. it currently says:

=3D=3D=3D
-I     Request identification info directly from the drive, which is
displayed in a new expanded format with considerably more detail than
with the older -i flag.

=3D=3D=3D

Maybe an additional sentence or two like::

---
This explicitly avoids all kernel quirk logic, thus -I is reporting
exactly what the drive reports and may not agree with other kernel
ABI's which are typically impacted by various kernel quirk logic.  In
some cases when decoding the Identify Block, it will decode and report
information regardless of the ATA  standard supported.
---

I gather that last sentence from the fact hdparm is decoding word 217
for all drives, even though it is not defined until ATA8, but glancing
at the source, in other situations it appears to take the ATA standard
for the drive into account during the identify block decoding.

Thanks
Greg
