From: Norman Diamond <n0diamond@yahoo.co.jp>
Subject: Re: libata's awful reaction to passworded disks
Date: Thu, 19 Jun 2014 13:39:07 +0900 (JST)
Message-ID: <737041.56270.qm@web100018.mail.kks.yahoo.co.jp>
Reply-To: Norman Diamond <n0diamond@yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web100018.mail.kks.yahoo.co.jp ([114.111.98.192]:29472 "HELO
	web100018.mail.kks.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750782AbaFSEj2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Jun 2014 00:39:28 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Believe it or not, libata's reaction to passworded disks is even more a=
wful than
Yahoo web mail's latest handling of plain text e-mail.
=C2=A0
Let's see if manual formatting is better.
=C2=A0If someone has set a password on an ATA/SATA hard drive and someo=
ne later
connects the drive to a Linux system (before or after booting that Linu=
x
system), libata reacts in an unbearably stupid manner.

Someone might have connected the drive with the intention of running th=
e
hdparm command to unlock the drive, or maybe even to remove the passwor=
d.
Or maybe they didn't know that the drive was passworded.=EF=A3=B0 But e=
ither way,
there's no reason for libata to make a mess.

It is possible to look at the drive's inquiry data to find out if the
drive has a password set and currently locked.=EF=A3=B0 It is possible =
to know
that READ DMA QUEUED and READ DMA etc. are all going to fail.=EF=A3=B0 =
It is
possible to know that no purpose in resetting the drive, resetting the
port multiplier, retyring the reads, retrying the reads, retrying the
resets, retrying the reads, retrying the resets, retrying the reads,
retrying the resets, retrying the reads, retrying the resets, wow this
stuff sure is trying.

Now, is it really insane to retry the same command over and over again
hoping for a different result?=EF=A3=B0 Not always.=EF=A3=B0 If a glitc=
h is transient,
it might be helpful to observe the error return, maybe try a reset if
necessary, and wait 30 seconds before retrying the read.=EF=A3=B0 In fa=
ct if
four drives are connected to the same port multiplier or two drives are
connected to the same SATA controller then transient glitches are
frequent and retries (after patient delays) are meaningful.

But retrying automatically, over and over again, when the user hasn't
had time to type an hdparm command?=EF=A3=B0 Come on.

Just look to see if the drive is passworded.=EF=A3=B0 Don't bother tryi=
ng to do
the read.

Some time later, if the user runs some program that tries to do a read,
try it and see if maybe the password is gone.=EF=A3=B0 Try it when the =
user
asks for it.=EF=A3=B0 But even then, if it fails because the drive is
passworded, don't reset the drive, don't reset the port multiplier, and
don't retry.=EF=A3=B0 OK?
