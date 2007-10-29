From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/3] sata_inic162x: finally, driver for initio 162x SATA
 controllers
Date: Mon, 29 Oct 2007 12:24:30 +0900
Message-ID: <4725526E.2020008@gmail.com>
References: <6403454.272891193414331004.JavaMail.nabble@isper.nabble.com> <47225535.2040404@gmail.com> <4724630B.9090405@edpnet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:12569 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbXJ2DYi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Oct 2007 23:24:38 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1935386wah
        for <linux-ide@vger.kernel.org>; Sun, 28 Oct 2007 20:24:37 -0700 (PDT)
In-Reply-To: <4724630B.9090405@edpnet.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jo Lodewyckx <jo.lodewyckx@edpnet.be>
Cc: linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz

Jo Lodewyckx wrote:
> Tejun Heo,
> 
> Here's the output of lspci -nnvvv:
> 
> 03:00.0 SATA controller [0106]: Initio Corporation Unknown device
> [1101:1622] (rev 02) (prog-if 00 [Vendor specific])
>        Subsystem: Initio Corporation Unknown device [1101:1626]
>        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>        Interrupt: pin A routed to IRQ 10
>        Region 0: I/O ports at 4000 [size=256]
>        Region 1: Memory at 40000000 (32-bit, non-prefetchable) [size=4K]
>        [virtual] Expansion ROM at 30000000 [disabled] [size=128K]
>        Capabilities: [dc] Power Management version 2
>                Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1+,D2+,D3hot+,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Thanks, please also post the result of "cat /proc/ioports" and "cat
/proc/iomem".

-- 
tejun
