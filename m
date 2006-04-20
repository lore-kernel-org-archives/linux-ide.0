From: Roger Heflin <rheflin@atipa.com>
Subject: sata_mv issues with more than 1 disk in FC5 2.6.16-1.2096
Date: Thu, 20 Apr 2006 15:08:32 -0500
Message-ID: <4447EA40.9010503@atipa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:64773 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1751242AbWDTUIg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Apr 2006 16:08:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I know the FC5 2.6.16-1.2096 is based off of one of the 2.6.16
stable releases.   I am not sure exactly which one this is based
on.

I have several machines with this controller, the ones with a single
disks all work correctly using the Marvell controller.

An identical MB/controller/chassis fails when there are 2 disks
using software mirroring.  We have tested with 2 separate chassis,
both exhibit the same failure.

Moving the 2 disks to a different built-in sata controller
(sata_nv) results in the disks and the mirror working
correctly.

The errors that it returns are:
ata4: status=0xd0 { Busy }
ata2: status=0xd0 { Busy }
And the machine is terribly slow while this error is happening.
The error appears to be happening when the disks are trying
to be mounted.

We have tested the disk on a couple of different combinations of
ports and this does not seem to change anything.

The single disk machines don't get this error like the 2 disk
machines, though  they do get this error, every 30 minutes
or so (probably from  smartd), but this error does not
appear to be causing issues.
Apr 19 16:26:19 lab229 kernel: ata1: status=0xd0 { Busy }
Apr 19 16:26:19 lab229 kernel: ATA: abnormal status 0xD0 on
     port 0xFFFFC2001012211C

Any thoughts?

                                 Roger
