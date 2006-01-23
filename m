From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: sata_sis on Ubuntu 5.10
Date: Mon, 23 Jan 2006 22:15:08 +0100
Message-ID: <43D5475C.1030007@gmx.net>
References: <43D3F143.9000401@bammers.net> <58cb370e0601230547i2ca5f99bpdcca0fc3c215ac5e@mail.gmail.com> <43D542AD.40905@bammers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.21]:12770 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030197AbWAWVMC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2006 16:12:02 -0500
In-Reply-To: <43D542AD.40905@bammers.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Bamford <chris@bammers.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, bcollins@ubuntu.com, linux-ide@vger.kernel.org, touch@sis.com

Hello Chris,

please try the live-CD Kanotix 2005-04 (http://kanotix.com). This CD
includes the actual sata_sis driver.
It is Debian based. I have tested the sata_sis driver using this CD.

regards
Uwe Koziolek


Chris Bamford schrieb:

> Hi Bartlomiej,
>
> Thanks for the response!  I attach a file containing (I hope) all the
> answers to your questions.
> Please shout if you need more.
>
> Thanks,
>
> - Chris
>
> Bartlomiej Zolnierkiewicz wrote:
>
>> On 1/22/06, Chris Bamford <chris@bammers.net> wrote:
>>  
>>
>>> Hi Uwe,
>>>
>>> I have been unsuccessfully trying to get Linux to work with my SATA
>>> disk
>>> on my ASUS Vintage AE-1 barebone machine.
>>>
>>> I have posted to the ASUS support site (see
>>> http://vip.asus.com/eservice/techmailstatus.aspx?ID=WTM200601212130302557),
>>>
>>> and am still waiting for a reply.
>>> For more background on the problem, please see the attached message
>>> which I sent to the ubuntu-users mailing list - which did not produce
>>> any answers.
>>>   
>>
>>
>> Thread is here:
>> https://lists.ubuntu.com/archives/ubuntu-users/2006-January/063781.html
>>
>>  
>>
>>> The BIOS can see the SATA disk, but Linux does not!
>>> If I type "lsmod | grep -i ata" it returns nothing (no 'ata' drivers
>>> loaded). If I type 'locate sata_sis', it finds 2 copies, so I assume it
>>> should be OK if I load the drivers with modprobe:
>>>
>>>    mobprobe sat_sis
>>>    modprobe ata
>>>
>>> "lsmod | grep -i ata" now shows them loaded, but what do I do next? 
>>> the
>>> devices /dev/sd* are not present, so I cannot access the disk. Am I
>>> missing a step?
>>>   
>>
>>
>> Don't know, you didn't send output of lsmod command.
>>
>> Does loading sata_sis module produces any messages?
>>
>>  
>>
>>> I tried to build the driver from the sources provided on the CD with
>>> the
>>> machine, but it would not build (filesystem layout differences between
>>> Fedora and Debian??).
>>>
>>> Anyway, please help!
>>>
>>> Any pointers/info/etc would be gratefully received.
>>>   
>>
>>
>> What kernel version are you using?
>> What is the lspci -vvv output?
>>
>> AFAICS:
>>
>> * Ubuntu 5.10 is based on kernel 2.6.12.6
>> * SiS 182 support was added in kernel 2.6.14
>>
>> Ben, any suggestion?
>>
>> Thanks,
>> Bartlomiej
>>  
>>
>
>------------------------------------------------------------------------
>
>Script started on Mon 23 Jan 2006 20:34:45 GMT
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# lsmod | grep -i ata
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# lsmod 
>Module                  Size  Used by
>rfcomm                 34972  0 
>l2cap                  22404  5 rfcomm
>bluetooth              43012  4 rfcomm,l2cap
>cpufreq_userspace       4444  0 
>cpufreq_stats           5124  0 
>freq_table              4484  1 cpufreq_stats
>cpufreq_powersave       1920  0 
>cpufreq_ondemand        5916  0 
>cpufreq_conservative     6820  0 
>video                  16004  0 
>tc1100_wmi              6916  0 
>sony_acpi               5516  0 
>pcc_acpi               11392  0 
>hotkey                  9508  0 
>dev_acpi               11396  0 
>i2c_acpi_ec             5760  0 
>i2c_core               19728  1 i2c_acpi_ec
>button                  6672  0 
>battery                 9604  0 
>container               4608  0 
>ac                      4996  0 
>ipv6                  217408  8 
>af_packet              20232  2 
>tsdev                   7616  0 
>floppy                 52692  0 
>pcspkr                  3652  0 
>rtc                    11832  0 
>snd_intel8x0           30144  0 
>snd_ac97_codec         72188  1 snd_intel8x0
>snd_pcm_oss            46368  0 
>snd_mixer_oss          16128  1 snd_pcm_oss
>snd_pcm                78344  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
>snd_timer              21764  1 snd_pcm
>snd                    48644  6 snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
>soundcore               9184  1 snd
>snd_page_alloc         10120  2 snd_intel8x0,snd_pcm
>shpchp                 80612  0 
>pci_hotplug            24628  1 shpchp
>sis_agp                 8452  1 
>agpgart                32328  1 sis_agp
>dm_mod                 50364  1 
>evdev                   9088  0 
>psmouse                26116  0 
>mousedev               10912  0 
>parport_pc             31812  1 
>lp                     11460  0 
>parport                32072  2 parport_pc,lp
>md                     40656  0 
>ext3                  115976  1 
>jbd                    48536  1 ext3
>thermal                13192  0 
>processor              23100  1 thermal
>fan                     4740  0 
>usbhid                 30688  0 
>3c59x                  37544  0 
>mii                     5248  1 3c59x
>ehci_hcd               29448  0 
>ohci_hcd               18564  0 
>usbcore               104316  4 usbhid,ehci_hcd,ohci_hcd
>ide_cd                 36996  0 
>cdrom                  33952  1 ide_cd
>ide_disk               16128  3 
>ide_generic             1664  0 
>sis5513                14472  2 
>ide_core              125268  4 ide_cd,ide_disk,ide_generic,sis5513
>unix                   24624  64 
>vesafb                  8088  0 
>capability              5000  0 
>commoncap               6784  1 capability
>vga16fb                12232  1 
>vgastate                8320  1 vga16fb
>softcursor              2432  2 vesafb,vga16fb
>cfbimgblt               2944  2 vesafb,vga16fb
>cfbfillrect             3840  2 vesafb,vga16fb
>cfbcopyarea             4480  2 vesafb,vga16fb
>fbcon                  34176  72 
>tileblit                2560  1 fbcon
>font                    8448  1 fbcon
>bitblit                 5248  1 fbcon
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# tail -2 /var/log/messages
>Jan 23 20:34:18 localhost kernel: [4294755.955000] Bluetooth: RFCOMM socket layer initialized
>Jan 23 20:34:18 localhost kernel: [4294755.955000] Bluetooth: RFCOMM TTY layer initialized
>root@ubuntu:~# date
>Mon Jan 23 20:35:51 GMT 2006
>root@ubuntu:~# locate sata_sis
>/lib/modules/2.6.12-9-386/kernel/drivers/scsi/sata_sis.ko
>/lib/modules/2.6.12-10-386/kernel/drivers/scsi/sata_sis.ko
>/usr/src/kernel-source-2.6.11/drivers/scsi/sata_sis.c
>/home/chris/Desktop/sis18x_2.6.10_1.00.00/sata_sis.c
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# modprobe sata_sis
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# tail -2 /var/log/messages
>Jan 23 20:34:18 localhost kernel: [4294755.955000] Bluetooth: RFCOMM TTY layer initialized
>Jan 23 20:36:35 localhost kernel: [4294892.460000] SCSI subsystem initialized
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# lsmod | grep -i ata
>sata_sis                7552  0 
>libata                 47876  1 sata_sis
>scsi_mod              124872  1 libata
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# ls -l /dev/sd*
>ls: /dev/sd*: No such file or directory
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# cat /proc/version
>Linux version 2.6.12-10-386 (buildd@rothera) (gcc version 3.4.5 20050809 (prerelease) (Ubuntu 3.4.4-6ubuntu8)) #1 Mon Jan 16 17:18:08 UTC 2006
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# lspci -vvv
>0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 760/M760 Host (rev 03)
>	Subsystem: Asustek Computer, Inc.: Unknown device 8159
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
>	Latency: 64
>	Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=64M]
>	Capabilities: [a0] AGP version 3.0
>		Status: RQ=32 Iso- ArqSz=2 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3+ Rate=x4,x8
>		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
>	Capabilities: [d0] #08 [0120]
>	Capabilities: [f0] #08 [8000]
>
>0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SG86C202 (prog-if 00 [Normal decode])
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 64
>	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>	I/O behind bridge: 0000c000-0000cfff
>	Memory behind bridge: fbf00000-fbffffff
>	Prefetchable memory behind bridge: e8000000-f3ffffff
>	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
>
>0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS965 [MuTIOL Media IO] (rev 48)
>	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 0
>
>0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 01) (prog-if 80 [Master])
>	Subsystem: Asustek Computer, Inc.: Unknown device 8139
>	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 128
>	Region 0: I/O ports at <unassigned>
>	Region 1: I/O ports at <unassigned>
>	Region 2: I/O ports at <unassigned>
>	Region 3: I/O ports at <unassigned>
>	Region 4: I/O ports at ffa0 [size=16]
>	Capabilities: [58] Power Management version 2
>		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
>		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
>0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
>	Subsystem: Asustek Computer, Inc.: Unknown device 810d
>	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 64 (13000ns min, 2750ns max)
>	Interrupt: pin C routed to IRQ 18
>	Region 0: I/O ports at b800 [size=256]
>	Region 1: I/O ports at b400 [size=128]
>	Capabilities: [48] Power Management version 2
>		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
>		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
>0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
>	Subsystem: Asustek Computer, Inc.: Unknown device 8139
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 64 (20000ns max)
>	Interrupt: pin A routed to IRQ 20
>	Region 0: Memory at fbefc000 (32-bit, non-prefetchable) [size=4K]
>
>0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
>	Subsystem: Asustek Computer, Inc.: Unknown device 8139
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 64 (20000ns max)
>	Interrupt: pin B routed to IRQ 21
>	Region 0: Memory at fbefd000 (32-bit, non-prefetchable) [size=4K]
>
>0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
>	Subsystem: Asustek Computer, Inc.: Unknown device 8139
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 64 (20000ns max)
>	Interrupt: pin C routed to IRQ 22
>	Region 0: Memory at fbefe000 (32-bit, non-prefetchable) [size=4K]
>
>0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller (prog-if 20 [EHCI])
>	Subsystem: Asustek Computer, Inc.: Unknown device 8139
>	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 64 (20000ns max)
>	Interrupt: pin D routed to IRQ 23
>	Region 0: Memory at fbeff000 (32-bit, non-prefetchable) [size=4K]
>	Capabilities: [50] Power Management version 2
>		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
>0000:00:04.0 Ethernet controller: Silicon Integrated Systems [SiS]: Unknown device 0190
>	Subsystem: Asustek Computer, Inc.: Unknown device 8139
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 0
>	Interrupt: pin A routed to IRQ 5
>	Region 0: Memory at fbefbc00 (32-bit, non-prefetchable) [size=128]
>	Region 1: I/O ports at b000 [size=128]
>	Capabilities: [40] Power Management version 2
>		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
>		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
>
>0000:00:05.0 IDE interface: Silicon Integrated Systems [SiS]: Unknown device 0182 (rev 01) (prog-if 85 [Master SecO PriO])
>	Subsystem: Asustek Computer, Inc.: Unknown device 8139
>	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 64
>	Interrupt: pin A routed to IRQ 10
>	Region 0: I/O ports at a800 [size=8]
>	Region 1: I/O ports at a400 [size=4]
>	Region 2: I/O ports at a000 [size=8]
>	Region 3: I/O ports at 9800 [size=4]
>	Region 4: I/O ports at 9400 [size=16]
>	Region 5: I/O ports at 9000 [size=128]
>	Capabilities: [58] Power Management version 2
>		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
>		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
>0000:00:06.0 PCI bridge: Silicon Integrated Systems [SiS]: Unknown device 000a (prog-if 00 [Normal decode])
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 0, Cache Line Size: 0x10 (64 bytes)
>	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>	I/O behind bridge: 0000d000-0000dfff
>	Memory behind bridge: fff00000-000fffff
>	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
>	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
>	Capabilities: [f4] Power Management version 2
>		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
>0000:00:07.0 PCI bridge: Silicon Integrated Systems [SiS]: Unknown device 000a (prog-if 00 [Normal decode])
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 0, Cache Line Size: 0x10 (64 bytes)
>	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>	I/O behind bridge: 0000e000-0000efff
>	Memory behind bridge: fff00000-000fffff
>	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
>	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
>	Capabilities: [f4] Power Management version 2
>		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
>0000:00:09.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Latency: 64 (750ns min, 2000ns max)
>	Interrupt: pin A routed to IRQ 16
>	Region 0: I/O ports at 8800 [size=64]
>	Expansion ROM at fbee0000 [disabled] [size=64K]
>
>0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
>	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	Capabilities: [80] #08 [2101]
>
>0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
>	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
>	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
>	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 661FX/M661FX/M661MX/741/M741/760/M760 PCI/AGP (prog-if 00 [VGA])
>	Subsystem: Asustek Computer, Inc.: Unknown device 8159
>	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>	BIST result: 00
>	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
>	Region 1: Memory at fbfe0000 (32-bit, non-prefetchable) [size=128K]
>	Region 2: I/O ports at c800 [size=128]
>	Capabilities: [40] Power Management version 2
>		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>	Capabilities: [50] AGP version 3.0
>		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3+ Rate=x4,x8
>		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
>
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>root@ubuntu:~# 
>Script done on Mon 23 Jan 2006 20:39:43 GMT
>  
>

