From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Is there a reliable way to ID a SSD?
Date: Thu, 6 Jan 2011 15:11:31 -0500
Message-ID: <AANLkTi=53KtpKzsTcU9J6RViQAZPCj=EKxTNvNkDiOR1@mail.gmail.com>
References: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com>
 <4D2223BF.8090901@canonical.com> <AANLkTinbFHFv-x6VWxAmuCn0o8BSzvUmXoeTv1XGq7A+@mail.gmail.com>
 <4D2247A3.2060506@canonical.com> <4D25E96D.10400@computer.org>
 <AANLkTin1ZjPmbk1M=9-SGStU7zLUozwxX7Ddtu53xNE2@mail.gmail.com>
 <AANLkTim=AxrJybApL-5oG7+i08tkKofk0eyP+3XhjhBJ@mail.gmail.com> <yq18vyxq15w.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40725 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab1AFULw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 15:11:52 -0500
Received: by iyi12 with SMTP id 12so15187658iyi.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Jan 2011 12:11:51 -0800 (PST)
In-Reply-To: <yq18vyxq15w.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jan Ceuleers <jan.ceuleers@computer.org>, "Peter M. Petrakis" <peter.petrakis@canonical.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

On Thu, Jan 6, 2011 at 2:31 PM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Greg" == Greg Freemyer <greg.freemyer@gmail.com> writes:
>
> Greg> As the maintainer, can you provide direction as to how quirks
> Greg> should be maintained for the rotating disk flag (as reflected in
> Greg> /sys/block/sda/queue/rotational).
>
> Greg> There is Bart's patch, Peter's patch, and Martin says it can be
> Greg> overridden from userspace (I'm not sure which tool,
>
> # echo 0 > /sys/block/sda/queue/rotational
>
>
> Greg> nor do I know if there is already a userspace quirks table to add
> Greg> to.).
>
> I agree with Jeff that Tejun's tool would be the right place. And
> there's always udev...
>
> But the question is whether it's worth the hassle since there a many of
> these devices out there and it is unclear whether treating them as
> non-rotational is a win. If you can provide some compelling performance
> improvement numbers for a particular device we can look into adding a
> quirk for it.

My application is a little different, so it may be that my need of a
quirk table would not be accepted into a general tool, but if I have
to build it, it might as well benefit others.

But my real need is to truly know if the device is rotating or
non-rotating.  I don't need to know about performance issues per se.

My use is for disk sanitizing / wiping.  If a disk is a rotating disk,
my client currently implements a sector by sector wiping process.
They sanitize on the order of thousands of computers a month this way
via a dedicated wiping appliance.  (the original PC is booted via PXE,
so the hardware specifics and BIOSes vary greatly over the universe of
sanitized machines.)

As I'm sure you know, a SSD cannot be safely sanitized this way.

Thus, they need to identify SSDs / flash to ensure that a Security
Erase is attempted and if that fails for whatever reason (including
the command being blocked by the local bios) the technician is
notified that the wiping effort failed.

Note, I've seen several BIOSes that do not allow the Security Erase
command to be passed to the drive, so we have avoided using this
method for rotating media thus far, but for SSD there is no choice.

fyi: all of those thousands of machines are shipped to a central
location for auditing after being sanitized in the field.  At the
central location, the technicians re-perform the wiping process and
can attempt to identify SSDs that were mis-categorized and add them to
a quirks table. It is not a perfect process, but it is as good as we
have for now.

Greg
