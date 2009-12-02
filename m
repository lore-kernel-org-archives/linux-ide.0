From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: Random shutdown of disks using sata_mv
Date: Wed, 2 Dec 2009 17:54:00 +0200
Message-ID: <c70ff3ad0912020754o71f7e704ob400293e184ebb60@mail.gmail.com>
References: <1469.62.195.29.195.1259750413.squirrel@ketsers.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:35840 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbZLBPyA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Dec 2009 10:54:00 -0500
Received: by ywh12 with SMTP id 12so331569ywh.21
        for <linux-ide@vger.kernel.org>; Wed, 02 Dec 2009 07:54:07 -0800 (PST)
In-Reply-To: <1469.62.195.29.195.1259750413.squirrel@ketsers.dhs.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Caspar Smit <c.smit@truebit.nl>
Cc: Simon Jackson <sjackson@bluearc.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

the following lines from the kern.log:
Nov 24 23:03:23 supernas02 kernel: [131523.808631] ata19.00: exception
Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
Nov 24 23:03:23 supernas02 kernel: [131523.808690] ata19.00: cmd
b0/da:00:00:4f:c2/00:00:00:00:00/00 tag 0
Nov 24 23:03:23 supernas02 kernel: [131523.808691]          res
40/00:01:01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Nov 24 23:03:23 supernas02 kernel: [131523.808770] ata19.00: status: { =
DRDY }
Nov 24 23:03:23 supernas02 kernel: [131523.808801] ata19: hard resettin=
g link
Nov 24 23:03:28 supernas02 kernel: [131529.324010] ata19: link is slow
to respond, please be patient (ready=3D0)
Nov 24 23:03:33 supernas02 kernel: [131533.860010] ata19: SRST failed
(errno=3D-16)
Nov 24 23:03:33 supernas02 kernel: [131533.860038] ata19: hard resettin=
g link
Nov 24 23:03:38 supernas02 kernel: [131539.376009] ata19: link is slow
to respond, please be patient (ready=3D0)
Nov 24 23:03:43 supernas02 kernel: [131543.912006] ata19: SRST failed
(errno=3D-16)
Nov 24 23:03:43 supernas02 kernel: [131543.912033] ata19: hard resettin=
g link
Nov 24 23:03:48 supernas02 kernel: [131549.428010] ata19: link is slow
to respond, please be patient (ready=3D0)
Nov 24 23:04:18 supernas02 kernel: [131578.940012] ata19: SRST failed
(errno=3D-16)
Nov 24 23:04:18 supernas02 kernel: [131578.940048] ata19: limiting
SATA link speed to 1.5 Gbps
Nov 24 23:04:18 supernas02 kernel: [131578.940077] ata19: hard resettin=
g link
Nov 24 23:04:23 supernas02 kernel: [131583.952009] ata19: SRST failed
(errno=3D-16)
Nov 24 23:04:23 supernas02 kernel: [131583.958191] ata19: reset
failed, giving up
Nov 24 23:04:23 supernas02 kernel: [131583.958218] ata19.00: disabled
Nov 24 23:04:23 supernas02 kernel: [131583.958253] ata19: EH complete

means that a timeout error occurred, the after then, the disk didn't re=
spond.
is it the same disks that fails all the time?

saeed

On Wed, Dec 2, 2009 at 12:40 PM, Caspar Smit <c.smit@truebit.nl> wrote:
>
>
> Hi Simon,
>
> We are not experiencing that "FAILED TO
> IDENTIFY" error.
>
> Kind regards,
> Caspar
>
>
>> We are investigating a similar type of problem seen on several
> of
> our
>> systems.
>> Seemingly at random (though some
> systems
> seem more susceptible than
>> others) we see the ata
> link reset and
> subsequently there is a FAILED TO
>> IDENTIFY
> error logged.
> smartctl is unable to get information from the
>> drive and a power
> cycle of the drive is required to bring it
> back on line.
>>
>> I would be interested to know if the
> ata level errors are similar
> to those
>> we are seeing.
>>
>>
>>
> -----Original Message-----
>>
> From:
> linux-ide-owner@vger.kernel.org
>>
> [mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Caspar Smit
>> Sent: 01 December 2009 12:16
>> To:
> linux-ide@vger.kernel.org
>> Subject: Random shutdown of disks
> using sata_mv
>>
>>
>>
>> Hi,
>>
>
>> I'm having a problem where in random one of my disks shuts
>> down and is disconnected from the linux kernel. In other words I
> have to
>> reboot the system or physically unplug/replug the
> disk
> to get it to work
>> again.
>>
>> I will
> provide my
> configuration:
>>
>> SuperMicro
>>
> SC-216 chassis
> (24 bay 2,5" disks)
>> 24x Seagate
> ST9500420AS 500Gb
>>
> 7200 RPM Hard Drives
>> 3x
> SuperMicro AOC-SAT2-MV8 (SATA
> Controller
>> using the sata_mv
> kernel driver)
>>
>>
> I use Debian Lenny 5.0 and
>> kernel:
> linux-image-2.6.30-bpo.2-amd64
>>
> (2.6.30-8~bpo50+1) from the
>> backports repository.
>>
>> The symptom is that
> after a while of
>> operation a
> disk is shut down and kicked out of
> a RAID set. It doesn't
>>
> matter if there is load or not on the
> system.
>>
>>
> The logging
>> says:
>>
>> sd 11:0:0:0: [sdk]
> Unhandled error code
>> sd 11:0:0:0:
>> Result:
> hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK
>> sd
> 11:0:0:0:
>> end_request: I/O error, dev sdk, sector 0
>>
>
>> In this case sdk,
>> but it happens to all
> disks.
>> Then the disk is not readable by the
>> system
> anymore.
>>
>> When I check the disk for errors
>>
> (badblocks/smart) in another system it doesn't give any
> errors.
>>
> I
>> only have this with 2,5"
> systems.
>>
>> Is
> this a sata_mv
>> problem? A
> disk problem? or anything else?
>> I can provide more info if
>> needed.
>>
>>
> Kind regards,
>> Caspar
> Smit
>>
>> --
>> To
> unsubscribe from this list:
> send the line "unsubscribe
> linux-ide" in
>> the body
> of a message to
> majordomo@vger.kernel.org
>> More majordomo
> info at
> http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
