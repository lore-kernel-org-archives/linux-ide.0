From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Sat, 31 Jan 2009 17:42:52 +0300
Message-ID: <4984636C.8050609@ru.mvista.com>
References: <20090131122500.f6817013.cjsthompson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:35313 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752155AbZAaOm5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 Jan 2009 09:42:57 -0500
In-Reply-To: <20090131122500.f6817013.cjsthompson@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Christoph .J Thompson" <cjsthompson@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Christoph .J Thompson wrote:

>> Hm, looks like your CF drive is rather advanced
>> and might be supporting UltraDMA (and your CF slot
>> supports DMA). Care to post the output of 'hdparm -i /dev/hda'? 
>>     
>
> /dev/hda:                                                                       
>                                                                                 
>  Model=HMS360604D5CF00, FwRev=DP3OC40D, SerialNo=DNP450B4YHR2EA                 
>  Config={ HardSect NotMFM Removeable DTR>10Mbs nonMagnetic }                    
>  RawCHS=5952/16/63, TrkSize=32256, SectSize=512, ECCbytes=4                     
>  BuffType=DualPortCache, BuffSize=128kB, MaxMultSect=32, MultSect=off           
>  CurCHS=5952/16/63, CurSects=5999616, LBA=yes, LBAsects=5999616                 
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}               
>  PIO modes:  pio0 pio1 pio2 pio3 pio4                                           
>  DMA modes:  mdma0 mdma1 mdma2                                                  
>  UDMA modes: udma0 udma1 *udma2                                                 
>  AdvancedPM=yes: mode=0x60 (96) WriteCache=disabled                             
>  Drive conforms to: ATA/ATAPI-4 published, ANSI INCITS 317-1998:  ATA/ATAPI-1,24
>                                                                                 
>  * signifies the current active mode
>
>   

   Could you please post the output of 'hdparm --Istdout /dev/hda' too 
(we are now in need of more CF identify data)?

> That's the output for my Hitachi Microdrive on the ALIX.2d3. It's using UDMA although I'm not using the pata_cs5536 driver since this Microdrive shows up as /dev/hda.
>   

   So you're using ide-pci-generic or Bart's new driver?

> I'm having problems booting a kernel with pata_cs5536 on this box:
>   

[...]

> [    1.326604] Driver 'sd' needs updating - please use bus_type methods
> [    1.346086] scsi0 : pata_cs5536
> [    1.356079] scsi1 : pata_cs5536
> [    1.365962] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
> [    1.386924] ata2: DUMMY
>   

   Dummy yourself. :-)

> [    1.570678] ata1.00: CFA: HMS360604D5CF00, DP3OC40D, max UDMA/33
>   

   So even the current broken code manages to recognize it as CF... it 
would be espcially interesting to see the raw identify data.

> [    1.588766] ata1.00: 5999616 sectors, multi 0: LBA 
> [    1.646824] ata1.00: configured for UDMA/33
> [    1.659803] scsi 0:0:0:0: Direct-Access     ATA      HMS360604D5CF00  DP3O PQ: 0 ANSI: 5
> [    1.684813] sd 0:0:0:0: [sda] 5999616 512-byte hardware sectors: (3.07 GB/2.86 GiB)
> [    1.707902] sd 0:0:0:0: [sda] Write Protect is off
> [    1.722482] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [    1.750365] sd 0:0:0:0: [sda] 5999616 512-byte hardware sectors: (3.07 GB/2.86 GiB)
> [    1.773459] sd 0:0:0:0: [sda] Write Protect is off
> [    1.788001] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [    1.815452]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 >
> [    2.217848] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [    2.235380] PNP: No PS/2 controller found. Probing ports directly.
> [    2.254873] i8042.c: No controller found.
> [    2.267240] mice: PS/2 mouse device common for all mice
> [    2.283134] cpuidle: using governor ladder
> [    2.295520] cpuidle: using governor menu
> [    2.310323] Using IPI Shortcut mode
> [    2.322395] VFS: Cannot open root device "LABEL=root" or unknown-block(0,0)
>   

   Tried specifying the root device explicitly?

MBR, Sergei


