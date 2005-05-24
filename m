From: thorild@Update.UU.SE (Thorild Selen)
Subject: Problems with pdc20318 (Promise SATA150 TX4 rev. 02), 2.6.11.10
Date: Tue, 24 May 2005 03:29:40 +0200
Message-ID: <17042.33668.214764.117576@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pernis.its.UU.SE ([130.238.4.153]:64141 "EHLO pernis.its.uu.se")
	by vger.kernel.org with ESMTP id S261263AbVEXB3q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 May 2005 21:29:46 -0400
Received: from Psilocybe.Update.UU.SE (Psilocybe.Update.UU.SE [130.238.19.25])
	by pernis.its.uu.se (Postfix) with ESMTP id 90D8A240
	for <linux-ide@vger.kernel.org>; Tue, 24 May 2005 03:29:40 +0200 (MSZ)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Greetings,

I'm trying to diagnose a disk related problem, and would be very
thankful for help and suggestions for how to go on.

The system is a x86, 1 Intel Xeon processor (HT) machine currently
running a 2.6.11.10 kernel. It has a Adaptec AIC-7902 U320 SCSI
controller which appears to work just fine, and a Promise SATA150 TX4
(rev. 02, pdc20318) controller that apparently does not (the below is
from dmesg):

  ata2: status=3D0x51 { DriveReady SeekComplete Error }
  ata2: error=3D0x84 { DriveStatusError BadCRC }
  ata1: status=3D0x51 { DriveReady SeekComplete Error }
  ata1: error=3D0x84 { DriveStatusError BadCRC }
  [...time passes...]
 =20
  ata1: status=3D0x51 { DriveReady SeekComplete Error }
  ata1: error=3D0x84 { DriveStatusError BadCRC }
  ata4: status=3D0x51 { DriveReady SeekComplete Error }
  ata4: error=3D0x84 { DriveStatusError BadCRC }
  [...more time passes...]
 =20
  ata4: status=3D0x51 { DriveReady SeekComplete Error }
  ata4: error=3D0x84 { DriveStatusError BadCRC }
  ata4: status=3D0x51 { DriveReady SeekComplete Error }
  ata4: error=3D0x10 { SectorIdNotFound }
  [...even more time passes...]
 =20
  ata4: status=3D0x51 { DriveReady SeekComplete Error }
  ata4: error=3D0x84 { DriveStatusError BadCRC }
  ata4: status=3D0x51 { DriveReady SeekComplete Error }
  ata4: error=3D0x10 { SectorIdNotFound }
  [last two lines repeated a bunch of times, and then...]
 =20
  SCSI error : <5 0 0 0> return code =3D 0x8000002
  sdf: Current: sense key: Aborted Command
  Additional sense: Recorded entity not found
  end_request: I/O error, dev sdf, sector 24330039

The fact that the errors appear to be rather evenly distributed over
the disks (it has also affected ata3 at other occasions) make me
believe that either the controller or the driver is to blame. (It
seems improbable to me that all the disks have gone bad together --
tell me if I'm wrong.) The disks are Hitachi Deskstar model
HDS722516VLSA80, SATA. Voltages and temperatures seem OK. (I haven't
checked the disks with SMART as the driver doesn't support it.)

The kernel is compiled with gcc 3.3.6 (Debian 1:3.3.6-4), and is using
APIC and cfq elevator. For the disks ext3 atop LVM atop md is used,
but the low-level character of the errors make me believe that the
error lies in a lower layer (driver, controller or possibly disks).

The problem started to appear somewhere around 2.6.7 I believe, but
downgrading does not seem appealing as several security issues have
been addressed in later kernels. Also, could it be that the problem
existed to some extent before, but wasn't shown due to less/different
error handling?  I believe that some more error handling code was
added to the Promise SATA driver not too long ago.

Any ideas? I've been looking for other reports of similar problems,
but I haven't really found anything matching.


Thorild Sel=E9n
Datorf=F6reningen Update / Update Computer Club, Uppsala, SE
