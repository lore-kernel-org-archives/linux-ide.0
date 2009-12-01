From: "Caspar Smit" <c.smit@truebit.nl>
Subject: Random shutdown of disks using sata_mv
Date: Tue, 1 Dec 2009 13:15:44 +0100 (CET)
Message-ID: <34963.87.210.74.220.1259669744.squirrel@ketsers.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 80-69-81-65.colo.transip.net ([80.69.81.65]:57516 "EHLO
	ns1.emsolutions.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbZLAMYI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Dec 2009 07:24:08 -0500
Received: from ns1.emsolutions.nl (www-data@localhost.localdomain [127.0.0.1])
	by ns1.emsolutions.nl (8.13.8/8.13.8/Debian-3) with ESMTP id nB1CFiVc014545
	for <linux-ide@vger.kernel.org>; Tue, 1 Dec 2009 13:15:44 +0100
References: 
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org



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

