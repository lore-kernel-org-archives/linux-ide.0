From: "Christoph .J Thompson" <cjsthompson@gmail.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Sat, 31 Jan 2009 17:27:46 +0100
Message-ID: <20090131172746.f9b02ca5.cjsthompson@gmail.com>
References: <20090131122500.f6817013.cjsthompson@gmail.com>
	<4984636C.8050609@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:50488 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbZAaQ3o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Jan 2009 11:29:44 -0500
Received: by nf-out-0910.google.com with SMTP id d3so143598nfc.21
        for <linux-ide@vger.kernel.org>; Sat, 31 Jan 2009 08:29:42 -0800 (PST)
In-Reply-To: <4984636C.8050609@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Sat, 31 Jan 2009 17:42:52 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Hello.
>
>    Could you please post the output of 'hdparm --Istdout /dev/hda' too 
> (we are now in need of more CF identify data)?  

With the pata_cs5536 driver:

/dev/sda:
848a 1740 0000 0010 7e00 0200 003f 005b
8c00 0000 2020 2020 2020 444e 5034 3530
4234 5948 5232 4541 0003 0100 0004 4450
334f 4334 3044 484d 5333 3630 3630 3444
3543 4630 3020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8020
0000 0f00 0000 0200 0000 0007 1740 0010
003f 8c00 005b 0100 8c00 005b 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
001e 0012 7068 500c 4000 7048 100c 4000
0407 0000 0000 4060 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0002 0000 0111 0000 0000 0000 0000
0000 0000 0064 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 8c3f 1111 0000 0000 04b0 0001
8100 8001 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

With AMD_IDE:

/dev/hda:
848a 1740 0000 0010 7e00 0200 003f 005b
8c00 0000 2020 2020 2020 444e 5034 3530
4234 5948 5232 4541 0003 0100 0004 4450
334f 4334 3044 484d 5333 3630 3630 3444
3543 4630 3020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8020
0000 0f00 0000 0200 0000 0007 1740 0010
003f 8c00 005b 0100 8c00 005b 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
001e 0012 7068 500c 4000 7068 100c 4000
0407 0000 0000 4060 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 000b 0000 0111 0000 0000 0000 0000
0000 0000 0064 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 8c3f 1111 0000 0000 04b0 0001
8100 8001 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

Does it matter if that was dumped while pata_cs5536 was in use? If yes, I'll just reboot to the Slackware kernel and provide you with another dump.

>    So you're using ide-pci-generic or Bart's new driver?

I guess it's not ide-pci-generic but I could be wrong

00:0f.2 IDE interface: Advanced Micro Devices [AMD] CS5536 [Geode companion] IDE (rev 01) )
        Subsystem: Advanced Micro Devices [AMD] CS5536 [Geode companion] IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort--
        Latency: 248, Cache Line Size: 32 bytes
        Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size]
        Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size]
        Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size]
        Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size]
        Region 4: I/O ports at ff00 [size=16]
        Kernel driver in use: AMD_IDE
        Kernel modules: pata_cs5536, pata_amd


> > [    1.326604] Driver 'sd' needs updating - please use bus_type methods
> > [    1.346086] scsi0 : pata_cs5536
> > [    1.356079] scsi1 : pata_cs5536
> > [    1.365962] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
> > [    1.386924] ata2: DUMMY
> >   
> 
>    Dummy yourself. :-)

I think that in addition to the Compact Flash interface there's a normal IDE connector on the ALIX.2d3 as well.

> > [    1.570678] ata1.00: CFA: HMS360604D5CF00, DP3OC40D, max UDMA/33
> >   
> 
>    So even the current broken code manages to recognize it as CF... it 
> would be espcially interesting to see the raw identify data.

If you need anything more just let me know.


-- 
Christoph .J Thompson <cjsthompson@gmail.com>
