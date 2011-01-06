From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Is there a reliable way to ID a SSD?
Date: Thu, 6 Jan 2011 13:40:41 -0500
Message-ID: <AANLkTim=AxrJybApL-5oG7+i08tkKofk0eyP+3XhjhBJ@mail.gmail.com>
References: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com>
 <4D2223BF.8090901@canonical.com> <AANLkTinbFHFv-x6VWxAmuCn0o8BSzvUmXoeTv1XGq7A+@mail.gmail.com>
 <4D2247A3.2060506@canonical.com> <4D25E96D.10400@computer.org> <AANLkTin1ZjPmbk1M=9-SGStU7zLUozwxX7Ddtu53xNE2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42849 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab1AFSoj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 13:44:39 -0500
Received: by iyi12 with SMTP id 12so15116011iyi.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Jan 2011 10:44:38 -0800 (PST)
In-Reply-To: <AANLkTin1ZjPmbk1M=9-SGStU7zLUozwxX7Ddtu53xNE2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Ceuleers <jan.ceuleers@computer.org>
Cc: "Peter M. Petrakis" <peter.petrakis@canonical.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

(resend, sorry for the duplicate)

Jeff,

As the maintainer, can you provide direction as to how quirks should
be maintained for the rotating disk flag (as reflected in
/sys/block/sda/queue/rotational).

There is Bart's patch, Peter's patch, and Martin says it can be
overridden from userspace (I'm not sure which tool,=A0 nor do I know if
there is already a userspace quirks table to add to.).

Bart's atang PATCH: http://marc.info/?l=3Dlinux-ide&m=3D126677421807814=
&w=3D2

Peter's patch: http://www.spinics.net/lists/linux-ide/msg38944.html

Greg

> On Thu, Jan 6, 2011 at 11:10 AM, Jan Ceuleers <jan.ceuleers@computer.=
org> wrote:
>>
>> On 03/01/11 23:03, Peter M. Petrakis wrote:
>>>
>>> Ah you mean /sys/block/sda/queue/rotational.
>>
>> A few data points:
>>
>> - Four rotational disks in my server are correctly reported as such.
>>
>> - The rotational disk in my laptop is as well.
>>
>> - The Intel SSD in my set-top box is reported correctly as non-rotat=
ional.
>>
>> - However, the CompactFlash card in my broadband router is incorrect=
ly reported as rotational. I attach lshw for this system.
>>
>> Cheers, Jan
>
>
>
> --
> Greg Freemyer
> Head of EDD Tape Extraction and Processing team
> Litigation Triage Solutions Specialist
> http://www.linkedin.com/in/gregfreemyer
> CNN/TruTV Aired Forensic Imaging Demo -
> =A0=A0 http://insession.blogs.cnn.com/2010/03/23/how-computer-evidenc=
e-gets-retrieved/
>
> The Norcross Group
> The Intersection of Evidence & Technology
> http://www.norcrossgroup.com



--
Greg Freemyer
Head of EDD Tape Extraction and Processing team
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
CNN/TruTV Aired Forensic Imaging Demo -
=A0=A0 http://insession.blogs.cnn.com/2010/03/23/how-computer-evidence-=
gets-retrieved/

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
