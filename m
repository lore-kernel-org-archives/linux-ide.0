From: "Caspar Smit" <c.smit@truebit.nl>
Subject: RE: Random shutdown of disks using sata_mv
Date: Wed, 2 Dec 2009 11:40:13 +0100 (CET)
Message-ID: <1469.62.195.29.195.1259750413.squirrel@ketsers.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 80-69-81-65.colo.transip.net ([80.69.81.65]:36579 "EHLO
	ns1.emsolutions.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbZLBKkM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Dec 2009 05:40:12 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Jackson <sjackson@bluearc.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>



Hi Simon,

We are not experiencing that "FAILED TO
IDENTIFY" error.

Kind regards,
Caspar


> We are investigating a similar type of problem seen on several
of
our
> systems.
> Seemingly at random (though some
systems
seem more susceptible than
> others) we see the ata
link reset and
subsequently there is a FAILED TO
> IDENTIFY
error logged. 
smartctl is unable to get information from the
> drive and a power
cycle of the drive is required to bring it
back on line.
> 
> I would be interested to know if the
ata level errors are similar
to those
> we are seeing.
> 
> 
>
-----Original Message-----
>
From:
linux-ide-owner@vger.kernel.org
>
[mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Caspar Smit
> Sent: 01 December 2009 12:16
> To:
linux-ide@vger.kernel.org
> Subject: Random shutdown of disks
using sata_mv
> 
> 
> 
> Hi,
>

> I'm having a problem where in random one of my disks shuts
> down and is disconnected from the linux kernel. In other words I
have to
> reboot the system or physically unplug/replug the
disk
to get it to work
> again.
> 
> I will
provide my
configuration:
> 
> SuperMicro
>
SC-216 chassis
(24 bay 2,5" disks)
> 24x Seagate
ST9500420AS 500Gb
>
7200 RPM Hard Drives
> 3x
SuperMicro AOC-SAT2-MV8 (SATA
Controller
> using the sata_mv
kernel driver)
> 
>
I use Debian Lenny 5.0 and
> kernel:
linux-image-2.6.30-bpo.2-amd64
>
(2.6.30-8~bpo50+1) from the
> backports repository.
> 
> The symptom is that
after a while of
> operation a
disk is shut down and kicked out of
a RAID set. It doesn't
>
matter if there is load or not on the
system.
> 
>
The logging
> says:
> 
> sd 11:0:0:0: [sdk]
Unhandled error code
> sd 11:0:0:0:
> Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> sd
11:0:0:0:
> end_request: I/O error, dev sdk, sector 0
>

> In this case sdk,
> but it happens to all
disks.
> Then the disk is not readable by the
> system
anymore.
> 
> When I check the disk for errors
>
(badblocks/smart) in another system it doesn't give any
errors.
>
I
> only have this with 2,5"
systems.
> 
> Is
this a sata_mv
> problem? A
disk problem? or anything else?
> I can provide more info if
> needed.
> 
>
Kind regards,
> Caspar
Smit
> 
> --
> To
unsubscribe from this list:
send the line "unsubscribe
linux-ide" in
> the body
of a message to
majordomo@vger.kernel.org
> More majordomo
info at 
http://vger.kernel.org/majordomo-info.html
>

