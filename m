From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: IO_PAGE_FAULT from SATA card during boot
Date: Sun, 30 Jan 2011 09:37:26 -0600
Message-ID: <AANLkTim7+9WVVJAjbj4pNMB9OKVmf2B+XNQ+exDt9_Tm@mail.gmail.com>
References: <20110129112456.GA13204@arachsys.com>
	<4D44433F.1040607@gmail.com>
	<20110130015442.GB13204@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39853 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab1A3Ph1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Jan 2011 10:37:27 -0500
Received: by iyj18 with SMTP id 18so4094094iyj.19
        for <linux-ide@vger.kernel.org>; Sun, 30 Jan 2011 07:37:26 -0800 (PST)
In-Reply-To: <20110130015442.GB13204@arachsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Webb <chris.webb@elastichosts.com>
Cc: linux-ide@vger.kernel.org

On Sat, Jan 29, 2011 at 7:54 PM, Chris Webb <chris.webb@elastichosts.co=
m> wrote:
> Robert Hancock <hancockrwd@gmail.com> writes:
>
>> On 01/29/2011 05:24 AM, Chris Webb wrote:
>> >I have several Supermicro H8DGT-HF motherboards (BIOS version 1.1) =
with Star
>> >Tech PEXSAT32 PCI Express SATA cards attached, and am seeing an
>> >IO_PAGE_FAULT during boot corresponding to this card:
>> >
>> > =A0 IO_PAGE_FAULT device=3D03:00.1 domain=3D0x0000 address=3D0x000=
00000000403c0 flags=3D0x0050]
>>
>> What's that device 03:00.1? The AHCI controller itself seems to be
>> 03:00.0. Can you post the lspci -v output? Though it could be that
>> maybe the IOMMU can't tell functions on the same device apart, not
>> sure.
>
> Thanks for the reply. Sure, no problem---here's the lspci -v output i=
n full:
>

=2E..

> 03:00.0 Class 0106: Device 1b4b:9123 (rev 11) (prog-if 01)
> =A0 =A0 =A0 =A0Subsystem: Device 18ab:9115
> =A0 =A0 =A0 =A0Flags: bus master, fast devsel, latency 0, IRQ 41
> =A0 =A0 =A0 =A0I/O ports at d800 [size=3D8]
> =A0 =A0 =A0 =A0I/O ports at d400 [size=3D4]
> =A0 =A0 =A0 =A0I/O ports at e800 [size=3D8]
> =A0 =A0 =A0 =A0I/O ports at e400 [size=3D4]
> =A0 =A0 =A0 =A0I/O ports at e000 [size=3D16]
> =A0 =A0 =A0 =A0Memory at febef800 (32-bit, non-prefetchable) [size=3D=
2K]
> =A0 =A0 =A0 =A0Expansion ROM at febf0000 [disabled] [size=3D64K]
> =A0 =A0 =A0 =A0Capabilities: [40] Power Management version 3
> =A0 =A0 =A0 =A0Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- =
64bit-
> =A0 =A0 =A0 =A0Capabilities: [70] Express Legacy Endpoint, MSI 00
> =A0 =A0 =A0 =A0Capabilities: [100] Advanced Error Reporting
> =A0 =A0 =A0 =A0Kernel driver in use: ahci

Hmm, so that 03:00.1 device doesn't seem to show up at all? I think
that these Marvell 9123 cards have a PATA controller integrated as
well, maybe that has something to do with the issue?
