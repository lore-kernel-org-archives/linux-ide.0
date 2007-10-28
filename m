From: Jo Lodewyckx <jo.lodewyckx@edpnet.be>
Subject: Re: [PATCH 3/3] sata_inic162x: finally, driver for initio 162x SATA
 controllers
Date: Sun, 28 Oct 2007 11:23:07 +0100
Message-ID: <4724630B.9090405@edpnet.be>
References: <6403454.272891193414331004.JavaMail.nabble@isper.nabble.com> <47225535.2040404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmailproxy02.edpnet.net ([212.71.1.195]:38566 "EHLO
	lmailproxy02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbXJ1LfA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Oct 2007 07:35:00 -0400
In-Reply-To: <47225535.2040404@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz

Tejun Heo,

Here's the output of lspci -nnvvv:

03:00.0 SATA controller [0106]: Initio Corporation Unknown device 
[1101:1622] (rev 02) (prog-if 00 [Vendor specific])
        Subsystem: Initio Corporation Unknown device [1101:1626]
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 4000 [size=256]
        Region 1: Memory at 40000000 (32-bit, non-prefetchable) [size=4K]
        [virtual] Expansion ROM at 30000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

yours sincerely,

Jo Lodewyckx

Tejun Heo schreef:
> Hello,
>
> jo.lodewyckx@edpnet.be wrote:
>> When probing the module I did get an error and after some google fun, 
>> I stumbled upon you as being the
>> driving force behind this driver. This is the error I'm getting:
>> sata_inic162x 0000:03:00.0: version 0.2
>> PCI: Enabling device 0000:03:00.0 (0000 -> 0003)
>> ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [C0C3] -> GSI 10 (level, 
>> low) -> IRQ 10
>> ACPI: PCI interrupt for device 0000:03:00.0 disabled
>> sata_inic162x: probe of 0000:03:00.0 failed with error -22
>>
>> Some more sysinfo:
>> Linux sip 2.6.22-gentoo-r8 #8 SMP PREEMPT Mon Oct 22 19:49:47 CEST 
>> 2007 i686 Intel(R) Pentium(R) M processor 1500MHz GenuineIntel GNU/Linux
>>
>> hopefully you can help me out on this one. I would be glad to act as 
>> "alpha/beta tester" for your driver :)
>
> 1. Please cc linux-ide@vger.kernel.org and 
> linux-pci@atrey.karlin.mff.cuni.cz
>
> 2. Post the result of "lspci -nnvvv".
>
> 3. Please note that sata_inic162x driver is only in half-working state 
> and virtually useless because it doesn't support LBA48 (drives bigger 
> than 128G).  I need more info to fix this problem but the vendor isn't 
> willing and I don't have time to find it out by trial-and-error.
>
> Thanks.
>

