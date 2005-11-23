From: Tejun <htejun@gmail.com>
Subject: Re: Kernel bug #5047 - sata_sil  w/ seagate drives
Date: Wed, 23 Nov 2005 17:53:53 +0900
Message-ID: <43842E21.4090703@gmail.com>
References: <F6215E23-92E3-4E7A-A5C9-B69E6422EE5B@smythco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:52539 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030371AbVKWIyD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Nov 2005 03:54:03 -0500
Received: by zproxy.gmail.com with SMTP id 14so231603nzn
        for <linux-ide@vger.kernel.org>; Wed, 23 Nov 2005 00:54:03 -0800 (PST)
In-Reply-To: <F6215E23-92E3-4E7A-A5C9-B69E6422EE5B@smythco.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephan Arrington <sarrington@smythco.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello, Stephan.

Stephan Arrington wrote:
> Hello,
> 
> I am also experiencing this behavior with sata_sil and large seagate  
> drives.
> Under heavy activity this bug surfaces (as mentioned in #5047) and it  
> requires a reboot to fix.
> 
> Would adding the drive's firmware to the sil_blacklist [] be a  possible 
> workaround?
> 
> I am using kernel version 2.6.12-5.
> 
> 
> 
> ///
>  Vendor: ATA       Model: ST3300831AS       Rev: 3.02
> ///
> 
> ///
> 00:0d.0 RAID bus controller: Silicon Image, Inc. SiI 3114 [SATALink/ 
> SATARaid] Serial ATA Controller (rev 02)
>         Subsystem: Silicon Image, Inc. SiI 3114 SATARaid Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium  
>  >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32, Cache Line Size 08
>         Interrupt: pin A routed to IRQ 12
>         Region 0: I/O ports at ac00 [size=8]
>         Region 1: I/O ports at b000 [size=4]
>         Region 2: I/O ports at b400 [size=8]
>         Region 3: I/O ports at b800 [size=4]
>         Region 4: I/O ports at bc00 [size=16]
>         Region 5: Memory at e3047000 (32-bit, non-prefetchable)  [size=1K]
>         Capabilities: [60] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME 
> (D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
> ///
> 

Both your controller and drive are NOT the ones with m15w quirk.  My 
first suspects are bad cabling and/or bad controller.  Is the controller 
on board? or is it a discrete card?  Can you verify that earlier kernel 
doesn't show the error?  Do you happen to have another harddrive (maybe 
from a different manufacturer) which can be hooked to the controller and 
tested?

AFAICS, your problem doesn't seem to be m15w related.  In the past, we 
saw some cheap/flakey 3112 controllers which fail from time to time. 
libata sometimes fails to recover from such failures.  This might be 
what you're seeing.

-- 
tejun
