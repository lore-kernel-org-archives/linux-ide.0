From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata_sil data corruption, possible workarounds
Date: Tue, 18 Dec 2012 21:44:49 -0600
Message-ID: <50D13831.9040105@gmail.com>
References: <kahap3$mur$1@ger.gmane.org> <50CCF1E0.9070804@gmail.com> <kakea2$dh1$1@ger.gmane.org> <50CEB13B.9010100@gmail.com> <kaq1n6$hqa$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:39399 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071Ab2LSDox (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Dec 2012 22:44:53 -0500
In-Reply-To: <kaq1n6$hqa$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bl0 <bl0-052@playker.info>
Cc: linux-ide@vger.kernel.org, linux-pci@vger.kernel.org

On 12/18/2012 09:23 AM, bl0 wrote:
> On Monday 17 December 2012 06:44, Robert Hancock wrote:
>
>> Hmm, looks like I was looking at the wrong register. The CLS itself =
is
>> described by what I posted, so changing that does affect things (i.e=
=2E
>> the threshold for Memory Read Multiple). The other value being writt=
en
>> into fifo_cfg is the FIFO Write Request Control and FIFO Read Reques=
t
>> Control field (that's why it's written to bits 0-2 and 8-10).
>>
>> "The FIFO Write Request Control and FIFO Read Request Control fields=
 in
>> these registers provide threshold settings for establishing when PCI
>> requests are made to the Arbiter. The Arbiter arbitrates among the f=
our
>> requests using fixed priority with masking. The fixed priority is, f=
rom
>> highest to lowest: channel 0; channel 1; channel 2; and channel 3. I=
f
>> multiple requests are present, the arbiter grants PCI bus access to =
the
>> highest priority channel that is not masked. That channel=E2=80=99s =
request is
>> then masked as long as any unmasked requests are present.
>>
>> ..
>>
>> FIFO Read Request Control.  This bit field defines the FIFO threshol=
d to
>> assign priority when requesting a PCI bus read operation. A value of=
 00H
>> indicates that read request priority is set whenever the FIFO has
>> greater than 32 bytes available space, while a value of 07H indicate=
s
>> that read request priority is set whenever the FIFO has greater than
>> 7x32 bytes (=3D224 bytes) available space.
>
> A fencepost error? They probably mean 8x32 bytes...

Yeah, I would think so.

>
>> This bit field is useful when
>> multiple DMA channels are competing for accessing the PCI bus.
>>
>>
>> FIFO Write Request Control. This bit field defines the FIFO threshol=
d to
>> assign priority when requesting a PCI bus write operation. A value o=
f
>> 00H indicates that write request priority is set whenever the FIFO
>> contains greater than 32 bytes, while a value of 07H indicates that
>> write request priority is set whenever the FIFO contains greater tha=
n
>> 7x32 bytes (=3D224 bytes). This bit field is useful when multiple DM=
A
>> channels are competing for the PCI bus."
>>
>> The value apparently being written to the register according to the =
code
>> (and given that the value in the CLS register is in units of 32-bit
>> words) is (cache line size >> 3) + 1.
>>
>>   From looking at the history of this code (which dates from the pre=
-git
>> days in 2005) it comes from:
>>
>>
> https://git.kernel.org/?p=3Dlinux/kernel/git/tglx/history.git;a=3Dcom=
mit;h=3Dfceff08ed7660f9bbe96ee659acb02841a3f1f39
>>
>> which refers to an issue with DMA FIFO thresholds which could cause =
data
>> corruption. The description is pretty much hand-waving and doesn't
>> really describe what is going on.
>
>  From the description: "The patch is to setup the DMA fifo threshold =
so that
> there is no chance for the DMA engine to change protocol." Is there a=
 way to
> check (or add debugging messages) if/when this change of protocol is
> happening?

I'm not sure exactly what they're talking about, but I would imagine=20
this is something internal to the chip which we likely wouldn't have an=
y=20
visibility into (without specialized equipment like a PCI bus analyzer=20
or something).

>
>> But it seems quite likely that
>> whatever magic numbers this code is picking don't work on your syste=
m
>> for some reason. It appears the root cause is likely a bug in the Si=
I
>> chip. There shouldn't be any region why messing around with these va=
lues
>> should cause data corruption other than that.
>
> Do you think something should be done about it in the linux sata_sil =
driver?
> For a lack of a better solution, here is my suggestion. There is alre=
ady
> one option 'slow_down' for problematic disks. Another option, for
> example 'cache_line_workaround', could be added for problematic
> motherboards. If enabled, the most straightforward way is to set cach=
e line
> size to 0 and not worry about the fifo_cfg register. If someone else
> confirms that it solves the problem for them, this option could be en=
abled
> automatically if certain motherboard chipset is detected.

We'd have to somehow narrow down which chipsets were involved, which=20
might be a hard task. Do you have an idea of how much the performance i=
s=20
hurt by these workarounds? If it's not a lot, it might make sense to do=
=20
it by default.

>
> A comment in the source of another Silicon Image driver, siimage.c: "=
If you
> have strange problems with nVidia chipset systems please see the SI s=
upport
> documentation and update your system BIOS if necessary". Do you (or a=
nyone
> else) know what support documentation it's refering to?

I don't remember seeing such a thing before. There might have been=20
something on their web site at some point, but who knows if it hasn't=20
been reorganized out of existence by now.
