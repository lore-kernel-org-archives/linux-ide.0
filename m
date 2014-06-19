From: Norman Diamond <n0diamond@yahoo.co.jp>
Subject: Re: libata's awful reaction to passworded disks
Date: Fri, 20 Jun 2014 07:48:47 +0900 (JST)
Message-ID: <454151.47928.qm@web100012.mail.kks.yahoo.co.jp>
References: <508686.83315.qm@web100003.mail.kks.yahoo.co.jp> <20140619113807.401e21ea@alan.etchedpixels.co.uk> <20140619140137.GK11042@htj.dyndns.org>
Reply-To: Norman Diamond <n0diamond@yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web100012.mail.kks.yahoo.co.jp ([114.111.98.186]:23431 "HELO
	web100012.mail.kks.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965601AbaFSWsu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Jun 2014 18:48:50 -0400
In-Reply-To: <20140619140137.GK11042@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Sorry that Yahoo web mail is probably going to deformat this message.

Tejun Heo replied to me and One Thousand Gnomes:
>>>
>>> If someone has set a password on an ATA/SATA hard drive and someone
>>>=A0later connects the drive to a Linux system (before or after booti=
ng
>>>=A0that Linux system), libata reacts in an unbearably stupid manner.
>>=20
>> Yes. It's well known. Send patches if you care. So far nobody has ca=
red
>> enough to write the code to use the key rings to deal with drive
>> unlocking.
>
>Hmmm... the reads are prolly from the partition code
=A0
What?=A0 When the driver doesn't even know whether the disk has partiti=
ons
(it might not have been partitioned before the password was set)
there is already code trying to read partitions?
=A0
And it is partition code that sends resets to the port and to the
port multiplier, interfering with all drives connected to the port?
=A0
Anyway, the drive's identification data already reveals that the drive
is passworded and locked.=A0 hdparm knows how to interpret and display
that fact.=A0 The driver has enough information to decide not to even
try looking for partitions, not try reading, not issue an error, etc.
=A0
Only later if a program tries to read something, it might be reasonable
to try reading before delivering an error, because maybe the driver
didn't check if the drive has become unlocked in the meantime.=A0 But
when the error occurs, check to see if the reason is a password lock
and do not send resets to the port and the port multiplier.

>Does anyone want to give a crack at it?

One Thousand Gnomes said I should ^_^
=A0
I think it was last year that I asked about my proposed code to
increase some timeouts (drives connected through port multipliers
do not always respond as quickly as the driver thinks) but no one
answered.=A0 I made the change myself but am not sure yet if it helps.
=A0
I think it was last year that I commented on some WTF code in a
Marvell SAS driver.=A0 No one answered.
=A0
Even if I find time to make this contribution (fat chance), I cannot
realisticly expect anyone to accept my code.
