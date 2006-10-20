From: "Andrew Lyon" <andrew.lyon@gmail.com>
Subject: Re: Problems writing with Samsung SH-W163A SATA CD/DVDRW
Date: Fri, 20 Oct 2006 11:21:15 +0100
Message-ID: <f4527be0610200321w672fc66yddbacf2615ce7e4c@mail.gmail.com>
References: <f4527be0610180219q6e5d316fif4c0b8c8a4d389c9@mail.gmail.com>
	 <20061020082409.GH13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:50592 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751629AbWJTKVR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Oct 2006 06:21:17 -0400
Received: by ug-out-1314.google.com with SMTP id o38so707900ugd
        for <linux-ide@vger.kernel.org>; Fri, 20 Oct 2006 03:21:15 -0700 (PDT)
In-Reply-To: <20061020082409.GH13677@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: justin@jmicron.com, linux-ide@vger.kernel.org

> [Adding Justin Tsai, Hi!]
>
> On Wed, Oct 18, 2006 at 10:19:49AM +0100, Andrew Lyon wrote:
> > Hi,
> >
> > I have a Samsung SH-W163A SATA CD/DVDRW connected to jmicron
> > 20360/20363 onboard sata controller on Gigabyte GA-965P-DS3, running
> > kernel 2.6.18 with sr_mod loaded I can mount recorded/original disks
> > and read them, but if I try to burn a cd or dvd using cdrecord, and
> > somtimes when mounting media I get loads of errors in dmesg and the
> > burn fails.
> >
> > Info from cdrecord dev=3DATAPI:0,0,0 -checkdrive:
> >
> > Cdrecord-ProDVD-Clone 2.01.01a10 (i686-pc-linux-gnu) Copyright (C)
> > 1995-2006 J=C3=B6rg Schilling
> > scsidev: 'ATAPI:0,0,0'
> > devname: 'ATAPI'
> > scsibus: 0 target: 0 lun: 0
> > Warning: Using ATA Packet interface.
> > Warning: The related Linux kernel interface code seems to be unmaintained.
> > Warning: There is absolutely NO DMA, operations thus are slow.
> > Using libscg version 'schily-0.8'.
> > Device type    : Removable CD-ROM
> > Version        : 5
> > Response Format: 2
> > Capabilities   :
> > Vendor_info    : 'TSSTcorp'
> > Identifikation : 'CD/DVDW SH-W163A'
> > Revision       : 'TS01'
> > Device seems to be: Generic mmc2 DVD-R/DVD-RW.
> > Using generic SCSI-3/mmc-2 DVD-R/DVD-RW driver (mmc_dvd).
> > Driver flags   : DVD MMC-3 SWABAUDIO BURNFREE
> > Supported modes: PACKET SAO
> >
> [--snip--]
> > ahci 0000:03:00.0: version 2.0
> > ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 19 (level, low) -> IRQ 17
> > PCI: Setting latency timer of device 0000:03:00.0 to 64
> > ahci 0000:03:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mod=
> > e
> > ahci 0000:03:00.0: flags: 64bit ncq pm led clo pmp pio slum part
> > ata1: SATA max UDMA/133 cmd 0xF8CD4100 ctl 0x0 bmdma 0x0 irq 17
> > ata2: SATA max UDMA/133 cmd 0xF8CD4180 ctl 0x0 bmdma 0x0 irq 17
> > scsi0 : ahci
> > ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > ata1.00: ATA-7, max UDMA/133, 145223999 sectors: LBA48 NCQ (depth 0/32)
> > ata1.00: ata1: dev 0 multi count 0
> > ata1.00: configured for UDMA/133
> > scsi1 : ahci
> > ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > ata2.00: ATAPI, max UDMA/33
> > ata2.00: applying bridge limits
> > ata2.00: configured for UDMA/33
> >  Vendor: ATA       Model: WDC WD740ADFD-00  Rev: 20.0
> >  Type:   Direct-Access                      ANSI SCSI revision: 05
> >  Vendor: TSSTcorp  Model: CD/DVDW SH-W163A  Rev: TS01
> >  Type:   CD-ROM                             ANSI SCSI revision: 05
> [--snip--]
> > If I try to record a dvd using cdrecord or any other app it will start
> > the process and then fail saying that the drive is not ready, and
> > there are loads of errors in dmesg:
> >
> >
> > ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> > ata2.00: (irq_stat 0x48000000, interface fatal error)
> > ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x54 (ATA bus error)
> > ata2: soft resetting port
> > ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > ata2.00: configured for UDMA/33
> > ata2: EH complete
> > ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> > ata2.00: (irq_stat 0x48000000, interface fatal error)
> > ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x54 (ATA bus error)
> > ata2: soft resetting port
> > ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > ata2.00: configured for UDMA/33
> > ata2: EH complete
> [--the same repeats--]
>
> Actually, my 20360 + PX-716SA combination is worse.  It shows the same
> behavior during device detection.
>
> ====
>
> # lspci -nnxxxvvvs 03:00.0
> 03:00.0 SATA controller [0106]: JMicron Technologies, Inc. JMicron 20360/20363 A
> HCI Controller [197b:2360] (rev 03) (prog-if 01 [AHCI 1.0])
>         Subsystem: JMicron Technologies, Inc. JMicron 20360/20363 AHCI Controlle
> r [197b:2360]
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
> ping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>         Latency: 0, Cache Line Size: 16 bytes
>         Interrupt: pin A routed to IRQ 17
>         Region 0: I/O ports at d800 [size=8]
>         Region 1: I/O ports at d400 [size=4]
>         Region 2: I/O ports at d000 [size=8]
>         Region 3: I/O ports at c800 [size=4]
>         Region 4: I/O ports at c400 [size=16]
>         Region 5: Memory at deffe000 (32-bit, non-prefetchable) [size=8K]
>         Capabilities: [68] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
> +,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [50] Express Legacy Endpoint IRQ 1
>                 Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
>                 Device: Latency L0s <64ns, L1 <1us
>                 Device: AtnBtn- AtnInd- PwrInd-
>                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                 Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 1
>                 Link: Latency L0s <1us, L1 <16us
>                 Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
>                 Link: Speed 2.5Gb/s, Width x1
> 00: 7b 19 60 23 07 00 10 00 03 01 06 01 04 00 00 00
> 10: 01 d8 00 00 01 d4 00 00 01 d0 00 00 01 c8 00 00
> 20: 01 c4 00 00 00 e0 ff de 00 00 00 00 7b 19 60 23
> 30: 00 00 00 00 68 00 00 00 00 00 00 00 0b 01 00 00
> 40: b1 a1 02 00 08 08 ff e0 20 00 00 21 00 00 00 00
> 50: 10 00 11 02 00 00 00 00 00 20 0c 00 11 44 02 01
> 60: 40 00 11 10 00 00 00 00 01 50 02 40 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 a0 01 0a 00 0f aa 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00
> c0: c3 8b 38 00 03 45 02 00 53 00 00 00 0f a0 a6 00
> d0: 18 00 00 80 01 00 00 10 41 00 eb 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 18 35 9c c2 01 a0 00 84
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> ====
>
> dmesg follows.
>
> [  121.978072] ata1: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action 0x2 fro
> zen
> [  121.985535] ata1: (irq_stat 0x00000040, connection status changed)
> [  122.500426] ata1: waiting for device to spin up (8 secs)
> [  130.683159] ata1: soft resetting port
> [  130.854900] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  131.015978] ata1.00: ATAPI, max UDMA/66
> [  131.019870] ata1.00: applying bridge limits
> [  131.179713] ata1.00: configured for UDMA/66
> [  131.183961] ata1: EH complete
> [  131.187701] scsi 0:0:0:0: CD-ROM            PLEXTOR  DVDR   PX-716A   1.09 PQ
> : 0 ANSI: 5
> [  131.196111] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> [  131.203222] ata1.00: (irq_stat 0x48000000, interface fatal error)
> [  131.209368] ata1.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x64 (ATA bus er
> ror)
> [  131.525798] ata1: soft resetting port
> [  131.697535] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  132.014347] ata1.00: configured for UDMA/66
> [  132.018600] ata1: EH complete
> [  132.022359] sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
> [  132.029325] sr 0:0:0:0: Attached scsi CD-ROM sr0
> [  132.029443] sr 0:0:0:0: Attached scsi generic sg0 type 5
> [  132.052247] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> [  132.059354] ata1.00: (irq_stat 0x48000000, interface fatal error)
> [  132.065498] ata1.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x24 (ATA bus er
> ror)
> [  132.384402] ata1: soft resetting port
> [  132.556142] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  132.872944] ata1.00: configured for UDMA/66
> [  132.877193] ata1: EH complete
> [--repeats--]
> [  138.703220] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> [  138.710317] ata1.00: (irq_stat 0x48000000, interface fatal error)
> [  138.716460] ata1.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x54 (ATA bus er
> ror)
> [  139.033621] ata1: soft resetting port
> [  139.205361] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [  139.522142] ata1.00: configured for PIO2
> [  139.526138] ata1: EH complete
>
> Justin, this seems very similar to the problem which occurs when PMP
> is attached.  This one is very reproducible too.  Just boot up
> libata-dev#upstream and connect PX716-SA.  Any ideas?
>
> Thanks.
>
> --
> tejun
>

I dont suppose the recent email to linux-ide with subject "libata: fix
ATA passthrough handling for ATAPI devices" might help resolve this?
these are atapi devices and we are using libata after all..

Andy
