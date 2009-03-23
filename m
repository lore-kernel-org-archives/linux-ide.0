From: Tejun Heo <tj@kernel.org>
Subject: Re: hot plug on ICH9 with AHCI on
Date: Mon, 23 Mar 2009 21:01:04 +0900
Message-ID: <49C77A00.6020204@kernel.org>
References: <49C171D7.1080706@gmail.com> <49C2F9B5.90000@kernel.org> <49C36816.306@gmail.com> <49C39933.4020501@kernel.org> <49C63457.8040203@gmail.com> <49C6547E.5050005@kernel.org> <49C6623D.7080305@gmail.com> <49C66A24.5000804@kernel.org> <49C682CD.9010007@gmail.com> <49C6EE49.9080307@kernel.org> <49C774AC.50603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59630 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936AbZCWMBN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Mar 2009 08:01:13 -0400
In-Reply-To: <49C774AC.50603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?KOI8-R?Q?=F7=CC=C1=C4=C9=CD=C9=D2_=E4=C1=DB=C5=D7=D3=CB=C9=CA?= <vladimir.dashevsky@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello,

=F7=CC=C1=C4=C9=CD=C9=D2 =E4=C1=DB=C5=D7=D3=CB=C9=CA wrote:
>> I really don't follow your train of thoughts here.  Are you saying
>> that the driver should be optimistic about the reliability about
>> status reported by the hardware even when it is inherently imprecise
>> (please read the spec) and real world experiments prove that?
>>  =20
> No. I ment that driver should performs better if the hardware support=
s
> some features for that. Consider two different cases.
> 1. hardware derives port population status by sensing the carrier in =
the
> data link. In this case it is possible that some EMI noise can damage
> link integrity so strongly that not data bits but also a carrier will=
 be
> lost for a short time. This will lead to 'port is not present' status
> however noone has actually removed the drive.

SATA is even weaker than this.  If you put a machine under an EMI
test, SATA links check out the first together with unshielded serial
connections.

> 2. Hardware implements some feature like pull-up resistor in USB, or
> special shorter 'present' contact as in PCI or CPCI connectors, or it
> simply senses some dc current through power lines etc. In this case p=
ort
> status is robust over EMI noise and be used to inform driver of actua=
l
> connection.
> My thought was to improve driver behavior in case 2, either autodetec=
ted
> by PCI IDs or manually overriden by some configure script.

There is no extra line in SATA connector.  There are only two pairs of
wires, one for each direction.  Each pair is used to carry voltage
differential.  There is no common ground or closed circuits formed.
The only thing which distinguishes an online link from an offline one
is live signal on the receiving side, so the earlier mention of
mechnical switch.  ahci actually has support for it although I haven't
seen any which actually implemented it.

>> -EIO will happen to any processes trying to do IO on the removed
>> device.  fuser will find out who's using the block device but if you
>> want something more intelligent, look at hal + dbus.
>>  =20
> Hm, I tried to write fuser /dev/sda and got empty output. It seems th=
at
> file system does not open sda. How it works?

No it won't show up and I can't really answer all your linux related
questions.  Sorry.  :-P

>> Ah.. in that case, you can do
>>
>>  # echo - - - > /sys/class/scsi_host/hostN/scan
>>  =20
> well, it works but it takes of about 10 seconds to finish scan for
> deleted drive. is this ok?
> Probably, that's because drive goes down after deletion and it starts=
 to
> spin up during this scan.

Yeah, probably.

>> Yeah, I know it has been in the spec but without hardware to play wi=
th
>> it's difficult to add driver features and lack of general availabili=
ty
>> also means lower demand.
>>  =20
> Well, I just cannot imagine how software raid can work without clearl=
y
> visible state. One drive mixed up in RAID5 and the whole array can ge=
t
> damaged. And it is not so difficult to mix them up because drive name=
s
> may differ from physical slot numbers.

Yeah, it can be tricky but highend machine usually go with sas and
consumer grade machines don't really care, so there just aren't too
many ahci machines with enclosure support.  Well, not here anyway.

>> I think it should be independent from RAID but having general
>> enclosure support will be nice.  Care to post the patches?
>>
>>  =20
> Well, I can provide you with a code which works on my ICH9 Supermicro
> platform. I believe it will also work with both ICH8 and ICH10.
> However, since I could not install this module as traditional pci dri=
ver
> (the kernel decided not to claim my ahci device since the main driver
> present in the system) I had to rewrite it as a general linux kernel
> module. It justs scan pci devices for AHCI capable ones and remaps th=
eir
> ABAR to try enclosure management support. For now, only my ICH9 PCI I=
Ds
> are in my try list. All AHCI EM-capable devices get their associated
> proc interface - /proc/ahci_emX/leds*. This module actually works in
> parallel with kernel ahci driver but I think it will be a conflict wi=
th
> it once the kernel driver starts to support em by itself. I guess, th=
e
> best way would be to document some API for controlling the EM, then t=
o
> declare some kernel ahci flag that will indicate full EM presence in =
the
> kernel. Then I can improve my ahci_em module to skip its installation
> when similar functions are built into the kernel.
>=20
> My interface is quite simple. You just write a char to leds-controlli=
ng
> proc file to set state of leds, for example:
> echo r > /proc/ahci_em0/leds0 means you asked for REBUILD state
> indicated in the bay of port 0.
> I think that most of users would prefer additional module rather that
> kernel udgrade, for the first time. Also, I am not very close to linu=
x
> kernel to provide a kernel patch.

I don't think the design you described would fit into upstream kernel
too well but if you have it working it's some place to start.  Just
refresh in on top of the current devel kernel and let's see what can
be done.

Thanks.

--=20
tejun
