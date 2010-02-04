From: Chandra Shekhar Sah <edu4madh@gmail.com>
Subject: Re: port multiplier problem
Date: Thu, 04 Feb 2010 11:39:56 -0500
Message-ID: <4B6AF85C.6050104@gmail.com>
References: <4B5885F7.2020007@gmail.com> <4B679EA9.6030203@kernel.org>	 <4B6833DD.1020001@gmail.com> <4B683581.7070708@kernel.org>	 <4B683DEF.3000302@gmail.com>	 <da824cf31002020844r12cada26x57f96b0aa24b59c6@mail.gmail.com>	 <4B686B2B.2080406@gmail.com>	 <da824cf31002021104v72efcd05ne639091042d5999d@mail.gmail.com>	 <4B687B7C.2070406@gmail.com> <da824cf31002031837t1cf2357bsbb53a3b4ea5e671f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:61323 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758325Ab0BDQkE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Feb 2010 11:40:04 -0500
In-Reply-To: <da824cf31002031837t1cf2357bsbb53a3b4ea5e671f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi Grant,

I compared PMP part with Chris dmesg and here are some similarities:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Similarity
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
sata_sil24 0000:03:02.0: version 1.1
sata_sil24 0000:03:02.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
scsi3 : sata_sil24
scsi4 : sata_sil24
scsi5 : sata_sil24
scsi6 : sata_sil24
ata3: SATA max UDMA/100 host m128@0xea009000 port 0xea000000 irq 18
ata4: SATA max UDMA/100 host m128@0xea009000 port 0xea002000 irq 18
ata5: SATA max UDMA/100 host m128@0xea009000 port 0xea004000 irq 18
ata6: SATA max UDMA/100 host m128@0xea009000 port 0xea006000 irq 18
aic7xxx 0000:03:04.1: PCI INT B -> GSI 18 (level, low) -> IRQ 18
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
ata3.00: hard resetting link
ata3.00: SATA link down (SStatus 0 SControl 10)
ata3.01: hard resetting link
ata3.01: SATA link down (SStatus 0 SControl 320)
ata3.02: hard resetting link
ata3.02: SATA link down (SStatus 0 SControl 320)
ata3.03: hard resetting link
ata3.03: SATA link down (SStatus 0 SControl 320)
ata3.04: hard resetting link
ata3.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.05: hard resetting link
ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata3.04: failed to IDENTIFY (I/O error, err_mask=3D0x11)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

However, I got some extra errors in my case (shown below):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ata3.04: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xf
ata3.04: SError: { PHYRdyChg DevExch }

ata3.04: PHY status changed but maxed out on retries, giving up
ata3.04: Manully issue scan to resume this link
ata3.04: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf t4
ata3.04: irq_stat 0x01060002, failed to transmit command FIS
ata3.04: SError: { PHYRdyChg CommWake DevExch }
ata3.04: limiting SATA link speed to 1.5 Gbps

ata4.15: hard resetting link
ata3.15: qc timeout (cmd 0xe4)
ata3.01: failed to read SCR 2 (Emask=3D0x4)
ata3.01: COMRESET failed (errno=3D-5)
ata3.01: failed to read SCR 0 (Emask=3D0x40)
ata3.01: reset failed, giving up

ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata4: PMP SError.N set for some ports, repeating recovery
ata4.04: hard resetting link

ata4.15: hard resetting link
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_cont=
exts
ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)

ata4: PMP SError.N set for some ports, repeating recovery
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Chris's post remind me about the LED light. In my drives (all hot=20
swappable), each has two LEDs: one for power (green light) and another=20
(orange light) probably showing the activity of the drive and it is=20
related with PMP because this orange light does not lit if I connect th=
e=20
drive to direct sata port (with direct sata connection, disks are=20
working fine).

When the disk array was working fine (few months ago), the orange light=
=20
lit for a very short time when the disk's power is switched on and then=
=20
it turns off. It lit again when disk is working. However, now the orang=
e=20
light does not turn off. I saw similar thing in the manual of sil3726=20
PMP, saying that some light turn off after disk is ready (I don't know=20
which light).

Thanks,
CN


On 2/3/10 9:37 PM, Grant Grundler wrote:
> On Tue, Feb 2, 2010 at 11:22 AM, Chandra Shekhar Sah<edu4madh@gmail.c=
om>  wrote:
>   =20
>> Hi Grant,
>>
>> Thank for reply.
>> Yes, PMP is sil3726. The backplane of the disk array has two PMP (ea=
ch
>> 1-to-5 as you have mentioned) and two sata direct connection without=
 PMP.
>> So, 10 disk are behind 2 PMP.
>>     =20
> Ah ok. That explains your "5-5-1-1" comment now. I tried to find a
> Data sheet for this board but only found one in Chinese:
>      www.norco.com.cn/UpLoadFile/Manual/DS-12X0-CN.pdf
>
> and I unfortunately don't speak/read chinese. Probably doesn't matter
> though since...
>
> This email thread looks like a duplicate of a previous bug report:
>     http://markmail.org/message/lp3ynvfefejpiy2r
>
> (or search for  "Ubuntu 9.04 (2.6.28-14) and eSATA Port Multiplier
> (PMP) Not working")
>
> Chandra, you might read through that thread and dmesg output (posted =
by Chris K)
> to see what else you have in common.
>
> I had two questions on that thread that never got answered:
>     http://markmail.org/message/snpekoj4qexrslk5
>
> | How can we find out if anyone has the SEMB properly wired up?
> | Would it be hard to make libata aware of "SEMB port not responding"=
 case?
> | ie if the SEMB port times out or has no link, reduce the port count=
 of
> | the sil3726 PMP by one.
> |
> | Maybe add a "enable_sil24_semb" flag to libata?
> | (avoid checking unless someone asks for it). I hate magic flags but=
 also
> | don't want to subject most people to the timeout delay.
>
> I (or Gwendal) can post a patch (and lightly test) for any of the abo=
ve.
> Just need to get some guidance so we don't waste our time.
>
> thanks,
> grant
>
>   =20
>> Total is 12 disks. The sata host controller is
>> sil3124. Picture of the backplane is attached.
>>
>> Thanks,
>> Chandra
>>
>> On 2/2/10 2:04 PM, Grant Grundler wrote:
>>     =20
>>> On Tue, Feb 2, 2010 at 10:12 AM, Chandra Shekhar Sah<edu4madh@gmail=
=2Ecom>
>>>   wrote:
>>>
>>>       =20
>>>> Hi Grant,
>>>>
>>>> There are 6 Seagate Barracuda and 6 Hitachi DeskStar.
>>>>
>>>>         =20
>>> I thought 0x1095/0x3726 was a Silicon Image part. Can you confirm t=
his?
>>>
>>> If it is, this sounds like a broken implementation to me. Here is w=
hat
>>> the Silicon Image 3726 Data Sheet says in the introduction:
>>>      Silicon Image=E2=80=99s SiI3726 is 1-to-5 SATA Port Multiplier=
 designed to
>>> provide a high performance link between a single SATA host port and=
 5
>>> SATA device ports.
>>>
>>> So I don't know where the 6th device is getting connected. Some
>>> explanation/data sheet from the HW vendor would be helpful at this
>>> point.
>>>
>>>
>>>       =20
>>>> Seagate Model: ST3750640AS
>>>> Firmware: 3.AAK
>>>>
>>>> Hitachi Model:HDS721075KLA330
>>>> Firmware: Not sure
>>>>
>>>>         =20
>>> Both of these drives work behind Sil3726. (First hand experience).
>>>
>>>
>>>       =20
>>>> I have attached pictures of both labels, in case.
>>>>
>>>>         =20
>>> Perfect - thanks for posting those.
>>>
>>> thanks,
>>> grant
>>>
>>>
>>>       =20
>>
>>     =20
>   =20

