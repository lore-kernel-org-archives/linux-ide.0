From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Subject: Re: HighPoint 374 ide problems with 2.4-kernels
Date: Wed, 29 Oct 2003 20:11:57 +0200 (EET)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <56315.192.168.9.10.1067451117.squirrel@ncircle.nullnet.fi>
References: <48850.192.168.9.10.1066566298.squirrel@ncircle.nullnet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ncircle.nullnet.fi ([62.236.96.207]:2524 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S261276AbTJ2SMB
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Oct 2003 13:12:01 -0500
Received: from ncircle.nullnet.fi (localhost.localdomain [127.0.0.1])
	by ncircle.nullnet.fi (Postfix) with SMTP id C261C1CEC860
	for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2003 20:11:57 +0200 (EET)
In-Reply-To: <48850.192.168.9.10.1066566298.squirrel@ncircle.nullnet.fi>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi,

I haven't received any replies to my question about HPT374 ide-problems
but I'd still like to ask an additional question related to PCI-device
latencies
and if they might affect my problem.

I have received some (working) test results done with older model of Epox
motherboard (KT333-chipset) and it seems that the configured
PCI-latency for the HPT374-chip is double compared to the
default on my newer KT400 based epox mb.

Does the latency difference from 64 --> 120 make any sense
and/or difference in the dreaded DMA-hang problem discussed
a week ago on linux kernel-list ? Anyone ?

Regards,
Tomi Orava

Working mb (KT333) :
00:0e.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
>         Subsystem: Triones Technologies, Inc.: Unknown device 0001
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (2000ns min, 2000ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 17
>         Region 0: I/O ports at a800 [size=8]
>         Region 1: I/O ports at ac00 [size=4]
>         Region 2: I/O ports at b000 [size=8]
>         Region 3: I/O ports at b400 [size=4]
>         Region 4: I/O ports at b800 [size=256]
>         Expansion ROM at <unassigned> [disabled] [size=128K]
>         Capabilities: [60] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Non working mb:
00:0e.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at a800 [size=8]
        Region 1: I/O ports at ac00 [size=4]
        Region 2: I/O ports at b000 [size=8]
        Region 3: I/O ports at b400 [size=4]
        Region 4: I/O ports at b800 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


