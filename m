From: Norman Diamond <n0diamond@yahoo.co.jp>
Subject: libata's awful reaction to passworded disks
Date: Thu, 19 Jun 2014 13:18:34 +0900 (JST)
Message-ID: <508686.83315.qm@web100003.mail.kks.yahoo.co.jp>
Reply-To: Norman Diamond <n0diamond@yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web100003.mail.kks.yahoo.co.jp ([114.111.98.177]:45266 "HELO
	web100003.mail.kks.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750708AbaFSEZQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Jun 2014 00:25:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

If someone has set a password on an ATA/SATA hard drive and someone lat=
er connects the drive to a Linux system (before or after booting that L=
inux system), libata reacts in an unbearably stupid manner.
=A0
Someone might have connected the drive with the intention of running th=
e hdparm command to unlock the drive, or maybe even to remove the passw=
ord.=A0 Or maybe they didn't know that the drive was passworded.=A0 But=
 either way, there's no reason for libata to make a mess.
=A0
It is possible to look at the drive's inquiry data to find out if the d=
rive has a password set and currently locked.=A0 It is possible to know=
 that READ DMA QUEUED and READ DMA etc. are all going to fail.=A0 It is=
 possible to know that no purpose in resetting the drive, resetting the=
 port multiplier, retyring the reads, retrying the reads, retrying the =
resets, retrying the reads, retrying the resets, retrying the reads, re=
trying the resets, retrying the reads, retrying the resets, wow this st=
uff sure is trying.
=A0
Now, is it really insane to retry the same command over and over again =
hoping for a different result?=A0 Not always.=A0 If a glitch is transie=
nt, it might be helpful to observe the error return, maybe try a reset =
if necessary, and wait 30 seconds before retrying the read.=A0 In fact =
if four drives are connected to the same port multiplier or two drives =
are connected to the same SATA controller then transient glitches are f=
requent and retries (after patient delays) are meaningful.
=A0
But retrying automatically, over and over again, when the user hasn't h=
ad time to type an hdparm command?=A0 Come on.
=A0
Just look to see if the drive is passworded.=A0 Don't bother trying to =
do the read.
=A0
Some time later, if the user runs some program that tries to do a read,=
 try it and see if maybe the password is gone.=A0 Try it when the user =
asks for it.=A0 But even then, if it fails because the drive is passwor=
ded, don't reset the drive, don't reset the port multiplier, and don't =
retry.=A0 OK?

