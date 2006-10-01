From: "Joe Jin" <lkmaillist@gmail.com>
Subject: Re: [PATCH] libata: skip reset on bus not a device
Date: Sun, 1 Oct 2006 09:49:06 +0800
Message-ID: <215036450609301849h64551749uf6b4a3e48c57fe15@mail.gmail.com>
References: <215036450609292206pd16c7cxa1c5c77ee52c050e@mail.gmail.com>
	 <451E7BD2.7020002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:19869 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751384AbWJABtH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 21:49:07 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1342216wxc
        for <linux-ide@vger.kernel.org>; Sat, 30 Sep 2006 18:49:06 -0700 (PDT)
In-Reply-To: <451E7BD2.7020002@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

> # lspci -nvvvxxx -s 00:1f.

00:1f.0 Class 0601: 8086:27b8 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: <available only to root>
00: 86 80 b8 27 07 01 10 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 Class 0101: 8086:27df (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: 1028:01ad
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 169
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at ffa0 [size=16]
00: 86 80 df 27 05 00 88 02 01 8a 01 01 00 00 00 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

00:1f.2 Class 0101: 8086:27c0 (rev 01) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: 1028:01ad
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 217
        Region 0: I/O ports at fe00 [size=8]
        Region 1: I/O ports at fe10 [size=4]
        Region 2: I/O ports at fe20 [size=8]
        Region 3: I/O ports at fe30 [size=4]
        Region 4: I/O ports at fea0 [size=16]
        Capabilities: <available only to root>
00: 86 80 c0 27 07 00 b0 02 01 8f 01 01 00 00 00 00
10: 01 fe 00 00 11 fe 00 00 21 fe 00 00 31 fe 00 00
20: a1 fe 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 70 00 00 00 00 00 00 00 05 03 00 00

00:1f.3 Class 0c05: 8086:27da (rev 01)
        Subsystem: 1028:01ad
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 177
        Region 4: I/O ports at e8a0 [size=32]
00: 86 80 da 27 01 01 80 02 01 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 e8 00 00 00 00 00 00 00 00 00 00 28 10 ad 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00

>
> Hmmm... Not really.  The controller shouldn't report BSY for empty
> channel.  There's a notable exception where PATA pins aren't properly
> pulled resulting in 0xff status on empty channels.  IDE handles the case
> specially but libata doesn't yet.  Can you try the attached patch?
>

it still  occured after apply the patch :(

-Joe
