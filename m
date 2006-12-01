From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.18 - AHCI detection pauses excessively
Date: Fri, 01 Dec 2006 22:59:07 +0900
Message-ID: <4570352B.9000704@gmail.com>
References: <4557B7D2.2050004@gmail.com> <455B0BD7.20108@gmail.com> <455B5ADF.2040503@gmail.com> <20061127033550.GB11250@htj.dyndns.org> <456AA89C.909@gmail.com> <456D4B17.4080503@gmail.com> <456DD70D.1050808@gmail.com> <456FD4CB.8020608@gmail.com> <45702F9A.5020406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:3227 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S936501AbWLAN7Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Dec 2006 08:59:24 -0500
Received: by wr-out-0506.google.com with SMTP id i7so1194630wra
        for <linux-ide@vger.kernel.org>; Fri, 01 Dec 2006 05:59:21 -0800 (PST)
In-Reply-To: <45702F9A.5020406@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Berck E. Nash" <flyboy@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Berck E. Nash wrote:
> Hrm.  It's not a Silicon Image chip, or at least doesn't claim to be:

Yeap, the controller is ich ahci but I'm pretty sure there's a PMP chip
connected to one of them.  Look for 4723 in the following page.

http://www.asus.com/products4.aspx?modelmenu=2&model=1198&l1=3&l2=11&l3=248

> 00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family)
> Serial ATA Storage Controller AHCI (rev 01) (prog-if 01 [AHCI 1.0])
>         Subsystem: ASUSTeK Computer Inc. Unknown device 2606
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 316
>         Region 0: I/O ports at e400 [size=8]
>         Region 1: I/O ports at e080 [size=4]
>         Region 2: I/O ports at e000 [size=8]
>         Region 3: I/O ports at dc00 [size=4]
>         Region 4: I/O ports at d880 [size=16]
>         Region 5: Memory at febfb800 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
> Queue=0/0 Enable+
>                 Address: fee0300c  Data: 4179
>         Capabilities: [70] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> And, remember, this behavior started in 2.6.18 and didn't exist in
> 2.6.17.  Would it help if I narrowed down which patch caused it?

Yeah, that's probably because we're now using IRQ-driven PIO for
IDENTIFY, so we're often slower at detecting IDENTIFY failure.  We're
planning to go back to polling IDENTIFY.  Anyways, the problem here is
that the 4723 is emulating ATA device for configuration but it isn't
doing it quite right.  I'll ask SIMG about it.

-- 
tejun
