From: Elias Oltmanns <eo@nebensachen.de>
Subject: Disk shock protection interferes with standby timers, please advise
Date: Thu, 07 Mar 2013 00:16:00 +0100
Message-ID: <876214glvz.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([78.46.130.30]:38320 "EHLO nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753043Ab3CFX0X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Mar 2013 18:26:23 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Aaron Lu <aaron.lu@intel.com>
Cc: linux-ide@vger.kernel.org, =?iso-8859-15?Q?Tom=E1=A8_Janou=A8ek?= <tomi@nomi.cz>

Hi there,

Tom=C3=A1s Janousek has reported that the standby timer of his notebook=
 hd is
not properly reenabled after a shock protection event. This is the
scenario:
1. Standby timer is initialised using hdparm -S ... and everything work=
s
   as expected.
2. Until disk heads are being unloaded due to a shock protection event.
   Standby is prevented for as long as the request to unload_heads had
   indicated =E2=80=93 still as expected.
3. The current implementation of shock protection issues a Check Power
   Mode command once the imminent danger is over. This was meant
   specifically to reenable the standby timer and used to work on the
   Hitachi drive I used for testing at the time. Alas, for some drives,
   including a Western Digital I have here at my disposal, that is not
   enough and they keep spinning until any command *but* Check Power
   Mode or Idle Immediate with Unload Feature is received.

Now, the ATA7 spec states that after receiving an Idle Immediate with
Unload Feature (section 6.20.10):

--8<---------------cut here---------------start------------->8---
The device shall stay at Low Power Idle mode, shall not go into Standby
mode and shall not load the head(s) onto the media until receiving a ne=
w
command.
[...]
The device shall retain data
in the write cache and resume writing the cached data onto the media
after receiving a Software Reset, a Hardware Reset, or any new command
except Idle Immediate with Unload Feature.
--8<---------------cut here---------------end--------------->8---

But then it says about the Check Power Mode command (section 6.8.8):

--8<---------------cut here---------------start------------->8---
The Check Power Mode command shall not cause the device to change power
or affect the operation of the Standby timer.
--8<---------------cut here---------------end--------------->8---

Hence, we should issue another command when the drive is not in standby
already in order to reenable the standby timer. Tom=C3=A1s suggested is=
suing
an Idle Immediate when Check Power Mode indicates that the disk is not
in standby already. Most obligingly, he even provided a patch to be
found at
<https://github.com/liskin/patches/blob/master/hacks/linux-3.3_hdaps-un=
prevent-standby.patch>.

My WD drive, however, gives a distinctly audible click when Idle
Immediate is issued after an Idle Immediate with Unload Feature. I rath=
er
suspect that the heads are actively loaded again, which is undesirable.
This can easily be tested, even without applying Tom=C3=A1s' patch, by
executing the following commands:

# hdparm -S 1 /dev/sda
[disk spins down after 5 seconds]
# hdparm --idle-immediate /dev/sda
[spins up again]
# hdparm --idle-unload /dev/sda
[keeps spinning until another command reaches disk, reenabling standby =
timer]
# hdparm -C /dev/sda
[reenables standby timer depending on disk model/manufacturer]
# hdparm --idle-immediate /dev/sda
[definitely reenables standby timer but also loads heads (click sound)]

On the other hand,

# hdparm -I /dev/sda

also reenables the standby timer yet leaves the heads alone. So my
question is this: Can anyone give some advice as to what command what b=
e
suitable to be issued instead of Idle Immediate when the shock
protection timeout has elapsed? Basically, it should be cheap, cause no
=E2=80=9Cmechanical action=E2=80=9D, and be anything *but* Check Power =
Mode.

Thanks for your help in advance,

Elias
