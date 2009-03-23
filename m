From: =?KOI8-R?Q?=F7=CC=C1=C4=C9=CD=C9=D2_=E4=C1=DB=C5=D7=D3=CB=C9=CA?=
	<vladimir.dashevsky@gmail.com>
Subject: Re: hot plug on ICH9 with AHCI on
Date: Mon, 23 Mar 2009 14:38:20 +0300
Message-ID: <49C774AC.50603@gmail.com>
References: <49C171D7.1080706@gmail.com> <49C2F9B5.90000@kernel.org> <49C36816.306@gmail.com> <49C39933.4020501@kernel.org> <49C63457.8040203@gmail.com> <49C6547E.5050005@kernel.org> <49C6623D.7080305@gmail.com> <49C66A24.5000804@kernel.org> <49C682CD.9010007@gmail.com> <49C6EE49.9080307@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:36984 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786AbZCWLkO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Mar 2009 07:40:14 -0400
Received: by ewy9 with SMTP id 9so1573548ewy.37
        for <linux-ide@vger.kernel.org>; Mon, 23 Mar 2009 04:40:10 -0700 (PDT)
In-Reply-To: <49C6EE49.9080307@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Tejun!
> Hello,
>
> =F7=CC=C1=C4=C9=CD=C9=D2 =E4=C1=DB=C5=D7=D3=CB=C9=CA wrote:
>  =20
>>>> Well, for example, USB devices have a pull-up resistor on their D+=
 line.
>>>> DC bias can be used for detection of device presence without mecha=
nical
>>>> switch.
>>>>        =20
>>> SATA is not USB and onlineness detection isn't that simple.  Also,
>>> have you tried to run a system on a USB device over flaky connectio=
n?
>>>  =20
>>>      =20
>> Well, I cannot argue with you here. All that I wanted to say is that=
 I
>> would prefer more optimistic software behavior if the hardware reall=
y
>> supports device connection status.
>>    =20
>
> I really don't follow your train of thoughts here.  Are you saying
> that the driver should be optimistic about the reliability about
> status reported by the hardware even when it is inherently imprecise
> (please read the spec) and real world experiments prove that?
>  =20
No. I ment that driver should performs better if the hardware supports=20
some features for that. Consider two different cases.
1. hardware derives port population status by sensing the carrier in th=
e=20
data link. In this case it is possible that some EMI noise can damage=20
link integrity so strongly that not data bits but also a carrier will b=
e=20
lost for a short time. This will lead to 'port is not present' status=20
however noone has actually removed the drive.
2. Hardware implements some feature like pull-up resistor in USB, or=20
special shorter 'present' contact as in PCI or CPCI connectors, or it=20
simply senses some dc current through power lines etc. In this case por=
t=20
status is robust over EMI noise and be used to inform driver of actual=20
connection.
My thought was to improve driver behavior in case 2, either autodetecte=
d=20
by PCI IDs or manually overriden by some configure script.
>>> -EIO will happen, fuser, but if you want something intelligent, hal=
 +
>>> dbus.
>>>  =20
>>>      =20
>> Sorry, I missed the sense of this sentence.
>>    =20
>
> -EIO will happen to any processes trying to do IO on the removed
> device.  fuser will find out who's using the block device but if you
> want something more intelligent, look at hal + dbus.
>  =20
Hm, I tried to write fuser /dev/sda and got empty output. It seems that=
=20
file system does not open sda. How it works?
>> I tried this deletion with fdisk and see that fdisk does not even
>> comply for device failure. It just starts to print empty partition
>> table and so on. So the question is how to properly close any
>> activity concerned with device being deleted if I do not know
>> exactly what is that activity? Are the most typical programs which
>> are allowed to use raw block devices aware of unexpected block
>> device loss?
>>    =20
> Please take a look at how desktop guys are handling the issue.  It's
> not something which can be handled in kernel proper.
>  =20
Ok.
>  =20
>>> I don't really follow what you're trying to achieve but if you want
>>> some fancy snapshotting + remapping trick, the best place would be =
dm.
>>>  =20
>>>      =20
>> Well, I didn't think of any tricks. I just deleted the drive as you
>> taught me and tried to get it back without moving myself in front of=
 the
>> server. :-)
>> However, I think that some call to rescan scsi devices will be usefu=
l.
>>    =20
>
> Ah.. in that case, you can do
>
>  # echo - - - > /sys/class/scsi_host/hostN/scan
>  =20
well, it works but it takes of about 10 seconds to finish scan for=20
deleted drive. is this ok?
Probably, that's because drive goes down after deletion and it starts t=
o=20
spin up during this scan.
>>> The biggest obstacle is that there aren't too many enclosure device=
s
>>> floating around.  What kind of device are you using?
>>>  =20
>>>      =20
>> I don't know exactly what device are you talking about. I was talkin=
g
>> about LED message types that are supported in ICH9.
>> As for my server, ICH9 provides SGPIO interface that is routed to
>> 4-drive hot-swap backplane based on AMI MG9071 chip. However, this
>> information isn't needed to program ICH9 since the LED message mecha=
nism
>> is supported in it. Other message types are not supported. And it is
>> very strange that linux ahci still does not support this functionali=
ty
>> since it was first introduced in ICH8 (datasheet first release in Ju=
ne
>> of 2006).
>>    =20
>
> Yeah, I know it has been in the spec but without hardware to play wit=
h
> it's difficult to add driver features and lack of general availabilit=
y
> also means lower demand.
>  =20
Well, I just cannot imagine how software raid can work without clearly=20
visible state. One drive mixed up in RAID5 and the whole array can get=20
damaged. And it is not so difficult to mix them up because drive names=20
may differ from physical slot numbers.

>> PS: My code has about 11Kb of text and supports all useful RAID stat=
es:
>> NORMAL, LOCATE, REBUILD, FAILURE, HOTSPARE, PREDICTED FAILURE SOON. =
I
>> have tested in on my server and it works. I think it can be useful f=
or
>> other implementations of soft RAID systems with hat swap support.
>>    =20
>
> I think it should be independent from RAID but having general
> enclosure support will be nice.  Care to post the patches?
>
>  =20
Well, I can provide you with a code which works on my ICH9 Supermicro=20
platform. I believe it will also work with both ICH8 and ICH10.
However, since I could not install this module as traditional pci drive=
r=20
(the kernel decided not to claim my ahci device since the main driver=20
present in the system) I had to rewrite it as a general linux kernel=20
module. It justs scan pci devices for AHCI capable ones and remaps thei=
r=20
ABAR to try enclosure management support. For now, only my ICH9 PCI IDs=
=20
are in my try list. All AHCI EM-capable devices get their associated=20
proc interface - /proc/ahci_emX/leds*. This module actually works in=20
parallel with kernel ahci driver but I think it will be a conflict with=
=20
it once the kernel driver starts to support em by itself. I guess, the=20
best way would be to document some API for controlling the EM, then to=20
declare some kernel ahci flag that will indicate full EM presence in th=
e=20
kernel. Then I can improve my ahci_em module to skip its installation=20
when similar functions are built into the kernel.

My interface is quite simple. You just write a char to leds-controlling=
=20
proc file to set state of leds, for example:
echo r > /proc/ahci_em0/leds0 means you asked for REBUILD state=20
indicated in the bay of port 0.
I think that most of users would prefer additional module rather that=20
kernel udgrade, for the first time. Also, I am not very close to linux=20
kernel to provide a kernel patch.

Thanks.

Best regards, Vladimir Dashevsky



