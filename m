From: Simon Jackson <sjackson@bluearc.com>
Subject: RE: Random shutdown of disks using sata_mv
Date: Tue, 1 Dec 2009 14:29:40 +0000
Message-ID: <ABFC24E4C13D81489F7F624E14891C8661539155@uk-ex-mbx1.terastack.bluearc.com>
References: <34963.87.210.74.220.1259669744.squirrel@ketsers.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from p01c12o144.mxlogic.net ([208.65.145.67]:43583 "EHLO
	p01c12o144.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbZLAObH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Dec 2009 09:31:07 -0500
In-Reply-To: <34963.87.210.74.220.1259669744.squirrel@ketsers.dhs.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Caspar Smit <c.smit@truebit.nl>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

We are investigating a similar type of problem seen on several of our systems.
Seemingly at random (though some systems seem more susceptible than others) we see the ata link reset and subsequently there is a FAILED TO IDENTIFY error logged.  smartctl is unable to get information from the drive and a power cycle of the drive is required to bring it back on line.

I would be interested to know if the ata level errors are similar to those we are seeing.


-----Original Message-----
From: linux-ide-owner@vger.kernel.org [mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Caspar Smit
Sent: 01 December 2009 12:16
To: linux-ide@vger.kernel.org
Subject: Random shutdown of disks using sata_mv



Hi,

I'm having a problem where in random one of my disks shuts
down and is disconnected from the linux kernel. In other words I have to
reboot the system or physically unplug/replug the disk to get it to work
again.

I will provide my configuration:

SuperMicro
SC-216 chassis (24 bay 2,5" disks)
24x Seagate ST9500420AS 500Gb
7200 RPM Hard Drives
3x SuperMicro AOC-SAT2-MV8 (SATA Controller
using the sata_mv kernel driver)

I use Debian Lenny 5.0 and
kernel: linux-image-2.6.30-bpo.2-amd64
(2.6.30-8~bpo50+1) from the
backports repository.

The symptom is that after a while of
operation a disk is shut down and kicked out of a RAID set. It doesn't
matter if there is load or not on the system.

The logging
says:

sd 11:0:0:0: [sdk] Unhandled error code
sd 11:0:0:0:
Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
sd 11:0:0:0:
end_request: I/O error, dev sdk, sector 0 

In this case sdk,
but it happens to all disks.
Then the disk is not readable by the
system anymore.

When I check the disk for errors
(badblocks/smart) in another system it doesn't give any errors.
I
only have this with 2,5" systems.

Is this a sata_mv
problem? A disk problem? or anything else?
I can provide more info if
needed.

Kind regards,
Caspar Smit

--
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
