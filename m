From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: Random shutdown of disks using sata_mv
Date: Tue, 1 Dec 2009 17:45:54 +0200
Message-ID: <c70ff3ad0912010745o77dca817v3cae2020581026e7@mail.gmail.com>
References: <34963.87.210.74.220.1259669744.squirrel@ketsers.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:41873 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbZLAPpu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Dec 2009 10:45:50 -0500
Received: by yxe17 with SMTP id 17so4663669yxe.33
        for <linux-ide@vger.kernel.org>; Tue, 01 Dec 2009 07:45:55 -0800 (PST)
In-Reply-To: <34963.87.210.74.220.1259669744.squirrel@ketsers.dhs.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Caspar Smit <c.smit@truebit.nl>
Cc: linux-ide@vger.kernel.org

On Tue, Dec 1, 2009 at 2:15 PM, Caspar Smit <c.smit@truebit.nl> wrote:
>
>
> Hi,
>
> I'm having a problem where in random one of my disks shuts
> down and is disconnected from the linux kernel. In other words I have=
 to
> reboot the system or physically unplug/replug the disk to get it to w=
ork
> again.
>
> I will provide my configuration:
>
> SuperMicro
> SC-216 chassis (24 bay 2,5" disks)
> 24x Seagate ST9500420AS 500Gb
> 7200 RPM Hard Drives
> 3x SuperMicro AOC-SAT2-MV8 (SATA Controller
> using the sata_mv kernel driver)
>
> I use Debian Lenny 5.0 and
> kernel: linux-image-2.6.30-bpo.2-amd64
> (2.6.30-8~bpo50+1) from the
> backports repository.
>
> The symptom is that after a while of
> operation a disk is shut down and kicked out of a RAID set. It doesn'=
t
> matter if there is load or not on the system.
>
> The logging
> says:
>
> sd 11:0:0:0: [sdk] Unhandled error code
> sd 11:0:0:0:
> Result: hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK
> sd 11:0:0:0:
> end_request: I/O error, dev sdk, sector 0
This part of the log doesn't show any message from the libata nor the
sata_mv drivers.
can you send the whole system log?
>
> In this case sdk,
> but it happens to all disks.
> Then the disk is not readable by the
> system anymore.
>
> When I check the disk for errors
> (badblocks/smart) in another system it doesn't give any errors.
> I
> only have this with 2,5" systems.
>
> Is this a sata_mv
> problem? A disk problem? or anything else?
> I can provide more info if
> needed.
>
> Kind regards,
> Caspar Smit
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
