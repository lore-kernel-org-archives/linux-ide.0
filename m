From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata_sil data corruption, possible workarounds
Date: Sun, 16 Dec 2012 23:44:27 -0600
Message-ID: <50CEB13B.9010100@gmail.com>
References: <kahap3$mur$1@ger.gmane.org> <50CCF1E0.9070804@gmail.com> <kakea2$dh1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37935 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab2LQFob (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Dec 2012 00:44:31 -0500
In-Reply-To: <kakea2$dh1$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bl0 <bl0-052@playker.info>
Cc: linux-ide@vger.kernel.org, linux-pci@vger.kernel.org

On 12/16/2012 06:21 AM, bl0 wrote:
> Thanks for your response.
>
> On Saturday 15 December 2012 22:55, Robert Hancock wrote:
>
>> On 12/15/2012 02:02 AM, bl0 wrote:
>>> I have a PCI card based on Silicon Image 3114 SATA controller. Like=
 many
>>> people in the past I have experienced silent data corruption.
>>> I am lucky to have a hardware configuration where it is easy to rep=
roduce
>>> this behavior with 100% rate by copying a file from a USB stick plu=
gged
>>> into another PCI card. My motherboard has nvidia chipset.
>>>
>>> Going through messages and bug reports about this problem, someone
>>> mentioned that PCI cache line size may be relevant. I did some test=
ing
>>> with different CLS values and found that the problem of data corrup=
tion
>>> is solved if either
>>> A). CLS is set to 0, before or after sata_sil kernel driver is load=
ed
>>>     # setpci -d 1095:3114 CACHE_LINE_SIZE=3D0
>>> where 1095:3114 is the device id as shown by 'lspci -nn'. The same
>>> command can also be used in grub2 (recent versions) shell or
>>> configuration file before booting linux.
>>> or
>>> B). CLS is set to a sufficiently large value, only after sata_sil i=
s
>>> loaded.
>>>     # setpci -d 1095:3114 CACHE_LINE_SIZE=3D28
>>> (value is hexadecimal, in 4-byte units, here it's 160 bytes)
>>> What is a sufficiently large value depends on the value that is set
>>> before the driver is loaded. If the value before the driver is load=
ed is
>>> 32 or 64 bytes, I have to increase it (after the driver is loaded) =
to 128
>>> or 160 bytes, respectively.
>>>
>>> In sata_sil.c source in sil_init_controller it writes some
>>> hardware-specific value depending on PCI cache line size. By loweri=
ng
>>> this value I can get it to work with lower CLS. The lowest value 0 =
works
>>> with CLS 64 bytes. If the CLS is 32 bytes, I have to increase the C=
LS.
>>
>> The meaning of that value from the datasheet is: "This bit field is =
used
>> to specify the system cacheline size in terms of 32-bit words. The u=
pper
>> 2 bits are not used, resulting a maximum size of 64 32-bit words. Wi=
th
>> the SiI3114 as a master, initiating a read transaction, it issues PC=
I
>> command Read Multiple in place, when empty space in its FIFO is larg=
er
>> than the value programmed in this register."
>>
>> I think this value is likely the key. The cache line size itself
>> shouldn't make any difference with this controller as it only really
>> affects Memory Write & Invalidate (MWI) and the driver doesn't try t=
o
>> enable that for this device. But it's being used to derive the value
>> written into this register.
>
> In practice, on my hardware configuration, increasing the CLS after t=
he
> internal value has already been derived does make a difference.
>
>> Can you add in some output to figure out what values are being writt=
en
>> to this register
>
> If the CLS is 32 or 64 bytes, it writes 2 or 3, respectively.
>
>> and see which values are working or not working?
>
> That depends on the CLS. If the CLS is 32 bytes, it doesn't work (by =
work I
> mean it's safe from data corruption) no matter what value I write to =
that
> hardware register. If the CLS is 64 bytes, the only value that works =
is 0.
>
> CLS     A       B
> 32      2       none
> 64      3       0
> 96      4       1
> 128     5       2
> 160     6       3
>
> A: value written by default
> B: maximum value safe from data corruption, based on my testing, prob=
ably
> only applies to similar problematic hardware configurations.
>
> Looking at this table you can see that increasing the CLS to a large =
value
> can be a workaround after the driver has set the default value.

Hmm, looks like I was looking at the wrong register. The CLS itself is=20
described by what I posted, so changing that does affect things (i.e.=20
the threshold for Memory Read Multiple). The other value being written=20
into fifo_cfg is the FIFO Write Request Control and FIFO Read Request=20
Control field (that's why it's written to bits 0-2 and 8-10).

"The FIFO Write Request Control and FIFO Read Request Control fields in=
=20
these registers provide threshold settings for establishing when PCI=20
requests are made to the Arbiter. The Arbiter arbitrates among the four
requests using fixed priority with masking. The fixed priority is, from=
=20
highest to lowest: channel 0; channel 1; channel 2; and channel 3. If=20
multiple requests are present, the arbiter grants PCI bus access to the=
=20
highest priority channel that is not masked. That channel=E2=80=99s req=
uest is=20
then masked as long as any unmasked requests are present.

=2E.

=46IFO Read Request Control.  This bit field defines the FIFO threshold=
 to=20
assign priority when requesting a PCI bus read operation. A value of 00=
H=20
indicates that read request priority is set whenever the FIFO has=20
greater than 32 bytes available space, while a value of 07H indicates=20
that read request priority is set whenever the FIFO has greater than=20
7x32 bytes (=3D224 bytes) available space. This bit field is useful whe=
n=20
multiple DMA channels are competing for accessing the PCI bus.


=46IFO Write Request Control. This bit field defines the FIFO threshold=
 to=20
assign priority when requesting a PCI bus write operation. A value of=20
00H indicates that write request priority is set whenever the FIFO=20
contains greater than 32 bytes, while a value of 07H indicates that=20
write request priority is set whenever the FIFO contains greater than=20
7x32 bytes (=3D224 bytes). This bit field is useful when multiple DMA=20
channels are competing for the PCI bus."

The value apparently being written to the register according to the cod=
e=20
(and given that the value in the CLS register is in units of 32-bit=20
words) is (cache line size >> 3) + 1.

 From looking at the history of this code (which dates from the pre-git=
=20
days in 2005) it comes from:

https://git.kernel.org/?p=3Dlinux/kernel/git/tglx/history.git;a=3Dcommi=
t;h=3Dfceff08ed7660f9bbe96ee659acb02841a3f1f39

which refers to an issue with DMA FIFO thresholds which could cause dat=
a=20
corruption. The description is pretty much hand-waving and doesn't=20
really describe what is going on. But it seems quite likely that=20
whatever magic numbers this code is picking don't work on your system=20
for some reason. It appears the root cause is likely a bug in the SiI=20
chip. There shouldn't be any region why messing around with these value=
s=20
should cause data corruption other than that.

>
> By default on my system this part of sata_sil code just overwrites th=
e same
> value (2 for 32 bytes CLS) that is already in place (as retrieved usi=
ng
> readw()) because the same value gets set (by the sata controller bios=
?)
> after reboot. Changing this logic can work around data corruption pro=
blem.
> There is another problem, sata link becoming inaccessible (I wrote mo=
re
> about it in the first post), not affected by this part of sata_sil co=
de. My
> guess is that the main cause of the problems is elsewhere.
>
>>> Data corruption is the biggest problem for me and these workarounds=
 help
>>> but another problem remains, sometimes when accessing multiple PCI
>>> devices at the same time sata becomes inaccessible and times out wi=
th log
>>> messages similar to:
>>> [  411.351805] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 actio=
n 0x6
>>> frozen
>>> [  411.351824] ata3.00: cmd c8/00:00:00:af:00/00:00:00:00:00/e0 tag=
 0 dma
>>> 131072 in
>>> [  411.351826]          res 40/00:00:00:00:00/00:00:00:00:00/00 Ema=
sk 0x4
>>> (timeout)
>>> [  411.351830] ata3.00: status: { DRDY }
>>> [  411.351843] ata3: hard resetting link
>>> [  411.671775] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 31=
0)
>>> [  411.697059] ata3.00: configured for UDMA/100
>>> [  411.697080] ata3: EH complete
>>>
>>> Reboot is needed to access sata drives again. If I had the root
>>> filesystem on a sata drive it would probably crash the system.
>>>
>>> Another thing that may be related. Comparing lspci output reveals t=
hat
>>> when accessing multiple PCI devices at the same time, the flag
>>> DiscTmrStat (Discard Timer Status) gets toggled on for device "00:0=
8.0
>>> PCI bridge: nVidia Corporation nForce2 External PCI Bridge". I don'=
t know
>>> if it's normal or not.
>>
>> I'm not an expert on the whole PCI bridge/delayed completion stuff b=
ut
>> it appears that this means that a device (either the host bridge/CPU=
 or
>> a device behind that bridge) initiated a delayed transaction for a r=
ead,
>> but then didn't retry the request to pick up the read data later. Fr=
om
>> what I can tell this seems abnormal, at least in most cases.
>>
>> Can you post the full lspci -vv output? Do the problems only occur i=
f
>> there are multiple devices plugged in behind that bridge?
>
> 'lspci -vvv' output attached. Yes, I've only encountered problems wit=
h the
> sata controller if at least one other external PCI card is in active =
use.
> (The built-in devices which appear as PCI under another bridge do not=
 cause
> problems.)
>
>>> Finally, the same simple test that I use on Linux does not produce =
data
>>> corruption on FreeBSD. Either this problem doesn't occur there or i=
t's
>>> not trivial to reproduce.
>>>
>>> This bug has been around for so long. I hope someone will find this
>>> information useful.
>

