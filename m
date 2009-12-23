From: Bjarke Istrup Pedersen <gurligebis@gmail.com>
Subject: Re: 2.6.32.2 SATA link detect failed, 2.6.32.1 works fine
Date: Wed, 23 Dec 2009 13:02:12 +0100
Message-ID: <9c30dffe0912230402s5af415c3i83d6f5ba4f8f1841@mail.gmail.com>
References: <alpine.LNX.2.00.0912211855460.1689@darkstar.example.net>
	 <4B30134C.1050609@gmail.com>
	 <alpine.LNX.2.00.0912220859060.1686@darkstar.example.net>
	 <51f3faa70912211708j200ab584wa835ffe50981415e@mail.gmail.com>
	 <alpine.LNX.2.00.0912220955341.1696@darkstar.example.net>
	 <4B31DB17.4050509@kernel.org>
	 <alpine.LNX.2.00.0912231719440.1694@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:46381 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbZLWMCP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Dec 2009 07:02:15 -0500
In-Reply-To: <alpine.LNX.2.00.0912231719440.1694@darkstar.example.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: fengxiangjun <fengxiangjun@neusoft.com>
Cc: Tejun Heo <tj@kernel.org>, Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

2009/12/23 fengxiangjun <fengxiangjun@neusoft.com>:
>
> Hi,
>
> with this patch, the problem still exists.
>
> ata1.01: XXX debounce start, SStatus=3D4
> ata1.01: XXX debounce done, SStatus=3D4, DET stable for 520 msecs
> ata1.00: SATA link down (SStatus 0 SControl 301)
> ata1.01: SATA link down (SStatus 0 Scontrol 300)
> ...
> VFS; cannot open root device ...
>
> The kernel just panic, and I can't see what's the messege printing be=
fore
> that.
>
> So, I tried 'console=3DttyS0 console=3Dtty1'=EF=BC=8Cfull dmesg attac=
hed=E3=80=82
>
> $ hdparm -I /dev/sda:
>
> /dev/sda:
>
> ATA device, with non-removable media
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Model Number: =C2=A0 =C2=A0 =C2=A0 WDC WD8=
00JD-60LSA5
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Serial Number: =C2=A0 =C2=A0 =C2=A0WD-WCAM=
9T882872
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Firmware Revision: =C2=A010.01E03
> Standards:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Supported: 7 6 5 4
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Likely used: 8
> Configuration:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Logical =C2=A0 =C2=A0 =C2=A0 =C2=A0 max =C2=
=A0 =C2=A0 current
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cylinders =C2=A0 =C2=A0 =C2=A0 16383 =C2=A0=
 16383
> =C2=A0 =C2=A0 =C2=A0 =C2=A0heads =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1=
6 =C2=A0 =C2=A0 =C2=A016
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sectors/track =C2=A0 63 =C2=A0 =C2=A0 =C2=A0=
63
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CHS current addressable sectors: =C2=A0 16=
514064
> =C2=A0 =C2=A0 =C2=A0 =C2=A0LBA =C2=A0 =C2=A0user addressable sectors:=
 =C2=A0156301488
> =C2=A0 =C2=A0 =C2=A0 =C2=A0LBA48 =C2=A0user addressable sectors: =C2=A0=
156301488
> =C2=A0 =C2=A0 =C2=A0 =C2=A0device size with M =3D 1024*1024: =C2=A0 =C2=
=A0 =C2=A0 76319 MBytes
> =C2=A0 =C2=A0 =C2=A0 =C2=A0device size with M =3D 1000*1000: =C2=A0 =C2=
=A0 =C2=A0 80026 MBytes (80 GB)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cache/buffer size =C2=A0=3D 8192 KBytes
> Capabilities:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0LBA, IORDY(can be disabled)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Standby timer values: spec'd by Standard, =
with device specific
> minimum
> =C2=A0 =C2=A0 =C2=A0 =C2=A0R/W multiple sector transfer: Max =3D 16 =C2=
=A0Current =3D 16
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 u=
dma3 udma4 *udma5
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Cycle time: min=3D120ns rec=
ommended=3D120ns
> =C2=A0 =C2=A0 =C2=A0 =C2=A0PIO: pio0 pio1 pio2 pio3 pio4
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Cycle time: no flow control=
=3D120ns =C2=A0IORDY flow control=3D120ns
> Commands/features:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Enabled Supported:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0SMART feature set
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Security Mode =
feature set
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0Power Management fe=
ature set
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0Write cache
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0Look-ahead
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0WRITE_BUFFER comman=
d
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0READ_BUFFER command
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0NOP cmd
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0DOWNLOAD_MICROCODE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A048-bit Address feat=
ure set
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0Device Configuratio=
n Overlay feature set
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0Mandatory FLUSH_CAC=
HE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0FLUSH_CACHE_EXT
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0SMART error logging
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0SMART self-test
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0General Purpose Log=
ging feature set
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0SATA-I signaling sp=
eed (1.5Gb/s)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0SATA-II signaling s=
peed (3.0Gb/s)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0Phy event counters
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Device-initiat=
ed interface power management
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0Software settings p=
reservation
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0SMART Command Trans=
port (SCT) feature set
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0SCT Long Sector Acc=
ess (AC1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0SCT LBA Segment Acc=
ess (AC2)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0SCT Error Recovery =
Control (AC3)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0SCT Features Contro=
l (AC4)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0SCT Data Tables (AC=
5)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unknown 206[12=
] (vendor specific)
> Security:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Master password revision code =3D 65534
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0supported
> =C2=A0 =C2=A0 =C2=A0 =C2=A0not =C2=A0 =C2=A0 enabled
> =C2=A0 =C2=A0 =C2=A0 =C2=A0not =C2=A0 =C2=A0 locked
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0frozen
> =C2=A0 =C2=A0 =C2=A0 =C2=A0not =C2=A0 =C2=A0 expired: security count
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0supported: enh=
anced erase
> =C2=A0 =C2=A0 =C2=A0 =C2=A024min for SECURITY ERASE UNIT. 24min for E=
NHANCED SECURITY ERASE
> UNIT.
> Checksum: correct
>
> Thanks.
>
> On Wed, 23 Dec 2009, Tejun Heo wrote:
>
>> Hello,
>>
>> On 12/22/2009 11:02 AM, fengxiangjun wrote:
>> > You are right, it's definitely timing related.
>> >
>> > I just tried capturing the failed booting message through a null m=
odem
>> > cable, but the problem goes away! It seems that I can't reproduce =
it
>> > with serial console attached.
>>
>> Hmmm... this is the second report of probing failure with SIDPR base=
d
>> hardreset. =C2=A0Can you please apply the attached patch and see whe=
ther
>> the problem is reproducible? =C2=A0And if so, please attach full boo=
t log.
>> Can you please also attach hdparm -I output of the occassionally
>> failing drive.
>>
>> Thanks.
>>
>> --
>> tejun
>>
> ---------------------------------------------------------------------=
------------------------------
> Confidentiality Notice: The information contained in this e-mail and =
any accompanying attachment(s)
> is intended only for the use of the intended recipient and may be con=
fidential and/or privileged of
> Neusoft Corporation, its subsidiaries and/or its affiliates. If any r=
eader of this communication is
> not the intended recipient, unauthorized use, forwarding, printing, =C2=
=A0storing, disclosure or copying
> is strictly prohibited, and may be unlawful.If you have received this=
 communication in error,please
> immediately notify the sender by return e-mail, and delete the origin=
al message and all copies from
> your system. Thank you.
> ---------------------------------------------------------------------=
------------------------------
>

Hey,

Could it be an idea to do a bisect for the patch that makes it break? :=
)

/Bjarke
