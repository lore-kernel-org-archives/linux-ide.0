From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Still having problems with sata_promise on all late kernels -
 shutdown too - BISECTED
Date: Wed, 15 Aug 2007 20:18:07 +0400
Message-ID: <46C3273F.1070306@wasp.net.au>
References: <46C11BBE.6010802@wasp.net.au> <46C1316F.4010906@wasp.net.au> <46C1DB92.7080806@wasp.net.au> <46C2B046.7060708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:47372 "EHLO wasp.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757834AbXHOQSS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 12:18:18 -0400
In-Reply-To: <46C2B046.7060708@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Brad Campbell wrote:
>> Brad Campbell wrote:
>>
>>> http://www.fnarfbargle.com/CIMG1029.JPG (I have posted this screen
>>> shot previously. It's still doing exactly the same thing on both boxes).
>>>
>> git-bisect shows up this commit as the guilty party. I can't just revert
>> it on a recent tree though.
>> Will investigate further.
> 
> Weird.  Does 'hdparm -y /dev/sdX' work?

Very interesting indeed..

for i in /dev/sd* ; do echo $i ; hdparm -y $i ; done

sda-sdh worked fine.. sdi locked the box.

So it's dying on the 3rd or 4th controller.

Now that I think about it, on the other side of the git bisect I probably only heard 8 clicks as the 
kernel shut down the 1st 8 drives, then the remainder powered off when the machine powered off.
So even prior to this it was probably only shutting down the 1st 8 drives properly.

brad@storage1:~$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:09.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 12)
00:0b.0 Mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
00:0d.0 Mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
00:0e.0 Mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master 
IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller 
(rev 60)
00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem Controller (rev 80)
00:13.0 Mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 315PRO PCI/AGP VGA Display Adapter

[   46.624922] sata_promise 0000:00:0b.0: version 2.07
[   46.624937] ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 17
[   46.641073] scsi0 : sata_promise
[   46.641301] scsi1 : sata_promise
[   46.641471] scsi2 : sata_promise
[   46.648281] scsi3 : sata_promise
[   46.654924] ata1: SATA max UDMA/133 cmd 0xf8816200 ctl 0xf8816238 bmdma 0x00000000 irq 0
[   46.661784] ata2: SATA max UDMA/133 cmd 0xf8816280 ctl 0xf88162b8 bmdma 0x00000000 irq 0
[   46.668432] ata3: SATA max UDMA/133 cmd 0xf8816300 ctl 0xf8816338 bmdma 0x00000000 irq 0
[   46.674895] ata4: SATA max UDMA/133 cmd 0xf8816380 ctl 0xf88163b8 bmdma 0x00000000 irq 0
[   47.170019] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   47.190471] ata1.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[   47.197090] ata1.00: ATA-7: Maxtor 7Y250M0, YAR511W0, max UDMA/133
[   47.203704] ata1.00: 490234752 sectors, multi 0: LBA48
[   47.230410] ata1.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[   47.237100] ata1.00: configured for UDMA/133
[   47.729427] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   47.749866] ata2.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[   47.756760] ata2.00: ATA-7: Maxtor 7Y250M0, YAR511W0, max UDMA/133
[   47.763727] ata2.00: 490234752 sectors, multi 0: LBA48
[   47.789820] ata2.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[   47.796966] ata2.00: configured for UDMA/133
[   48.288835] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   48.309277] ata3.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[   48.316381] ata3.00: ATA-7: Maxtor 7Y250M0, YAR511W0, max UDMA/133
[   48.323494] ata3.00: 490234752 sectors, multi 0: LBA48
[   48.349233] ata3.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[   48.356411] ata3.00: configured for UDMA/133
[   48.848245] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   48.868684] ata4.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[   48.875960] ata4.00: ATA-7: Maxtor 7Y250M0, YAR511W0, max UDMA/133
[   48.883230] ata4.00: 490234752 sectors, multi 0: LBA48
[   48.908634] ata4.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[   48.916000] ata4.00: configured for UDMA/133
[   48.923402] scsi 0:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   48.931040] sd 0:0:0:0: [sda] 490234752 512-byte hardware sectors (251000 MB)
[   48.938540] sd 0:0:0:0: [sda] Write Protect is off
[   48.945849] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   48.945865] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   48.953425] sd 0:0:0:0: [sda] 490234752 512-byte hardware sectors (251000 MB)
[   48.960907] sd 0:0:0:0: [sda] Write Protect is off
[   48.968251] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   48.968265] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   48.975808]  sda: unknown partition table
[   55.984630] sd 0:0:0:0: [sda] Attached SCSI disk
[   55.992218] scsi 1:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   55.999870] sd 1:0:0:0: [sdb] 490234752 512-byte hardware sectors (251000 MB)
[   56.007421] sd 1:0:0:0: [sdb] Write Protect is off
[   56.015029] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   56.015045] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   56.023013] sd 1:0:0:0: [sdb] 490234752 512-byte hardware sectors (251000 MB)
[   56.031098] sd 1:0:0:0: [sdb] Write Protect is off
[   56.039005] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   56.039019] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   56.047244]  sdb: unknown partition table
[   63.431266] sd 1:0:0:0: [sdb] Attached SCSI disk
[   63.439764] scsi 2:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   63.448337] sd 2:0:0:0: [sdc] 490234752 512-byte hardware sectors (251000 MB)
[   63.456799] sd 2:0:0:0: [sdc] Write Protect is off
[   63.465117] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   63.465133] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   63.473672] sd 2:0:0:0: [sdc] 490234752 512-byte hardware sectors (251000 MB)
[   63.482133] sd 2:0:0:0: [sdc] Write Protect is off
[   63.490472] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   63.490486] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   63.498998]  sdc: unknown partition table
[   70.770909] sd 2:0:0:0: [sdc] Attached SCSI disk
[   70.779326] scsi 3:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   70.787888] sd 3:0:0:0: [sdd] 490234752 512-byte hardware sectors (251000 MB)
[   70.796358] sd 3:0:0:0: [sdd] Write Protect is off
[   70.804686] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.804700] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.813235] sd 3:0:0:0: [sdd] 490234752 512-byte hardware sectors (251000 MB)
[   70.821679] sd 3:0:0:0: [sdd] Write Protect is off
[   70.829976] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.829991] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.838476]  sdd: unknown partition table
[   78.098488] sd 3:0:0:0: [sdd] Attached SCSI disk
[   78.106864] ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 18
[   78.127345] scsi4 : sata_promise
[   78.135687] scsi5 : sata_promise
[   78.143830] scsi6 : sata_promise
[   78.151848] scsi7 : sata_promise
[   78.159669] ata5: SATA max UDMA/133 cmd 0xf881e200 ctl 0xf881e238 bmdma 0x00000000 irq 0
[   78.167664] ata6: SATA max UDMA/133 cmd 0xf881e280 ctl 0xf881e2b8 bmdma 0x00000000 irq 0
[   78.175472] ata7: SATA max UDMA/133 cmd 0xf881e300 ctl 0xf881e338 bmdma 0x00000000 irq 0
[   78.183099] ata8: SATA max UDMA/133 cmd 0xf881e380 ctl 0xf881e3b8 bmdma 0x00000000 irq 0
[   78.676722] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   78.697172] ata5.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[   78.704683] ata5.00: ATA-7: Maxtor 7Y250M0, YAR511W0, max UDMA/133
[   78.712191] ata5.00: 490234752 sectors, multi 0: LBA48
[   78.737112] ata5.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[   78.744592] ata5.00: configured for UDMA/133
[   79.236129] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   79.256570] ata6.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[   79.264101] ata6.00: ATA-7: Maxtor 7Y250M0, YAR511W0, max UDMA/133
[   79.271619] ata6.00: 490234752 sectors, multi 0: LBA48
[   79.296521] ata6.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[   79.304040] ata6.00: configured for UDMA/133
[   79.795538] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   79.815978] ata7.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[   79.823495] ata7.00: ATA-7: Maxtor 7Y250M0, YAR511W0, max UDMA/133
[   79.831032] ata7.00: 490234752 sectors, multi 0: LBA48
[   79.855930] ata7.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[   79.863472] ata7.00: configured for UDMA/133
[   80.354946] ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   80.375384] ata8.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[   80.382952] ata8.00: ATA-7: Maxtor 7Y250M0, YAR511W0, max UDMA/133
[   80.390513] ata8.00: 490234752 sectors, multi 0: LBA48
[   80.415342] ata8.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[   80.422877] ata8.00: configured for UDMA/133
[   80.430470] scsi 4:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   80.438232] sd 4:0:0:0: [sde] 490234752 512-byte hardware sectors (251000 MB)
[   80.445848] sd 4:0:0:0: [sde] Write Protect is off
[   80.453366] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
[   80.453383] sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   80.461109] sd 4:0:0:0: [sde] 490234752 512-byte hardware sectors (251000 MB)
[   80.468723] sd 4:0:0:0: [sde] Write Protect is off
[   80.476237] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
[   80.476252] sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   80.483922]  sde: unknown partition table
[   87.806745] sd 4:0:0:0: [sde] Attached SCSI disk
[   87.814366] scsi 5:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   87.822071] sd 5:0:0:0: [sdf] 490234752 512-byte hardware sectors (251000 MB)
[   87.829682] sd 5:0:0:0: [sdf] Write Protect is off
[   87.837329] sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[   87.837344] sd 5:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   87.845348] sd 5:0:0:0: [sdf] 490234752 512-byte hardware sectors (251000 MB)
[   87.853458] sd 5:0:0:0: [sdf] Write Protect is off
[   87.861397] sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[   87.861412] sd 5:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   87.869672]  sdf: unknown partition table
[   95.284548] sd 5:0:0:0: [sdf] Attached SCSI disk
[   95.293075] scsi 6:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[   95.301680] sd 6:0:0:0: [sdg] 490234752 512-byte hardware sectors (251000 MB)
[   95.310178] sd 6:0:0:0: [sdg] Write Protect is off
[   95.318525] sd 6:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[   95.318539] sd 6:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   95.327110] sd 6:0:0:0: [sdg] 490234752 512-byte hardware sectors (251000 MB)
[   95.335614] sd 6:0:0:0: [sdg] Write Protect is off
[   95.343981] sd 6:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[   95.343995] sd 6:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   95.352533]  sdg: unknown partition table
[  102.740714] sd 6:0:0:0: [sdg] Attached SCSI disk
[  102.749171] scsi 7:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[  102.757758] sd 7:0:0:0: [sdh] 490234752 512-byte hardware sectors (251000 MB)
[  102.766256] sd 7:0:0:0: [sdh] Write Protect is off
[  102.774610] sd 7:0:0:0: [sdh] Mode Sense: 00 3a 00 00
[  102.774626] sd 7:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  102.783186] sd 7:0:0:0: [sdh] 490234752 512-byte hardware sectors (251000 MB)
[  102.791650] sd 7:0:0:0: [sdh] Write Protect is off
[  102.799970] sd 7:0:0:0: [sdh] Mode Sense: 00 3a 00 00
[  102.799984] sd 7:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  102.808492]  sdh: unknown partition table
[  110.116127] sd 7:0:0:0: [sdh] Attached SCSI disk
[  110.124553] ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 17 (level, low) -> IRQ 19
[  110.143509] scsi8 : sata_promise
[  110.151883] scsi9 : sata_promise
[  110.160052] scsi10 : sata_promise
[  110.168136] scsi11 : sata_promise
[  110.176031] ata9: SATA max UDMA/133 cmd 0xf8820200 ctl 0xf8820238 bmdma 0x00000000 irq 0
[  110.184099] ata10: SATA max UDMA/133 cmd 0xf8820280 ctl 0xf88202b8 bmdma 0x00000000 irq 0
[  110.192172] ata11: SATA max UDMA/133 cmd 0xf8820300 ctl 0xf8820338 bmdma 0x00000000 irq 0
[  110.200062] ata12: SATA max UDMA/133 cmd 0xf8820380 ctl 0xf88203b8 bmdma 0x00000000 irq 0
[  110.692889] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  110.713389] ata9.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[  110.721175] ata9.00: ATA-7: Maxtor 7Y250M0, YAR511W0, max UDMA/133
[  110.728956] ata9.00: 490234752 sectors, multi 0: LBA48
[  110.753329] ata9.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[  110.761077] ata9.00: configured for UDMA/133
[  111.252296] ata10: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  111.272785] ata10.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[  111.280580] ata10.00: ATA-7: Maxtor 7Y250M0, YAR511W0, max UDMA/133
[  111.288370] ata10.00: 490234752 sectors, multi 0: LBA48
[  111.312741] ata10.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[  111.320533] ata10.00: configured for UDMA/133
[  111.811705] ata11: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  111.832188] ata11.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[  111.839981] ata11.00: ATA-7: Maxtor 7Y250M0, YAR511W0, max UDMA/133
[  111.847786] ata11.00: 490234752 sectors, multi 0: LBA48
[  111.872156] ata11.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[  111.879951] ata11.00: configured for UDMA/133
[  112.371114] ata12: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  112.391607] ata12.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[  112.399417] ata12.00: ATA-7: Maxtor 7Y250M0, YAR511W0, max UDMA/133
[  112.407218] ata12.00: 490234752 sectors, multi 0: LBA48
[  112.431552] ata12.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[  112.439320] ata12.00: configured for UDMA/133
[  112.447134] scsi 8:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[  112.455125] sd 8:0:0:0: [sdi] 490234752 512-byte hardware sectors (251000 MB)
[  112.462964] sd 8:0:0:0: [sdi] Write Protect is off
[  112.470702] sd 8:0:0:0: [sdi] Mode Sense: 00 3a 00 00
[  112.470717] sd 8:0:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.478673] sd 8:0:0:0: [sdi] 490234752 512-byte hardware sectors (251000 MB)
[  112.486513] sd 8:0:0:0: [sdi] Write Protect is off
[  112.494254] sd 8:0:0:0: [sdi] Mode Sense: 00 3a 00 00
[  112.494268] sd 8:0:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.502167]  sdi: unknown partition table
[  112.529588] sd 8:0:0:0: [sdi] Attached SCSI disk
[  112.537413] scsi 9:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[  112.545323] sd 9:0:0:0: [sdj] 490234752 512-byte hardware sectors (251000 MB)
[  112.553145] sd 9:0:0:0: [sdj] Write Protect is off
[  112.561007] sd 9:0:0:0: [sdj] Mode Sense: 00 3a 00 00
[  112.561021] sd 9:0:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.569190] sd 9:0:0:0: [sdj] 490234752 512-byte hardware sectors (251000 MB)
[  112.577468] sd 9:0:0:0: [sdj] Write Protect is off
[  112.585577] sd 9:0:0:0: [sdj] Mode Sense: 00 3a 00 00
[  112.585591] sd 9:0:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.593829]  sdj: unknown partition table
[  112.617892] sd 9:0:0:0: [sdj] Attached SCSI disk
[  112.626370] scsi 10:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[  112.634936] sd 10:0:0:0: [sdk] 490234752 512-byte hardware sectors (251000 MB)
[  112.643405] sd 10:0:0:0: [sdk] Write Protect is off
[  112.651729] sd 10:0:0:0: [sdk] Mode Sense: 00 3a 00 00
[  112.651744] sd 10:0:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.660296] sd 10:0:0:0: [sdk] 490234752 512-byte hardware sectors (251000 MB)
[  112.668776] sd 10:0:0:0: [sdk] Write Protect is off
[  112.677116] sd 10:0:0:0: [sdk] Mode Sense: 00 3a 00 00
[  112.677136] sd 10:0:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.685648]  sdk: unknown partition table
[  112.717384] sd 10:0:0:0: [sdk] Attached SCSI disk
[  112.725810] scsi 11:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[  112.734392] sd 11:0:0:0: [sdl] 490234752 512-byte hardware sectors (251000 MB)
[  112.742893] sd 11:0:0:0: [sdl] Write Protect is off
[  112.751255] sd 11:0:0:0: [sdl] Mode Sense: 00 3a 00 00
[  112.751269] sd 11:0:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.759834] sd 11:0:0:0: [sdl] 490234752 512-byte hardware sectors (251000 MB)
[  112.768308] sd 11:0:0:0: [sdl] Write Protect is off
[  112.776644] sd 11:0:0:0: [sdl] Mode Sense: 00 3a 00 00
[  112.776657] sd 11:0:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  112.785186]  sdl: unknown partition table
[  112.815809] sd 11:0:0:0: [sdl] Attached SCSI disk
[  112.824267] ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 18 (level, low) -> IRQ 16
[  112.850639] scsi12 : sata_promise
[  112.859064] scsi13 : sata_promise
[  112.867290] scsi14 : sata_promise
[  112.875389] scsi15 : sata_promise
[  112.883301] ata13: SATA max UDMA/133 cmd 0xf8822200 ctl 0xf8822238 bmdma 0x00000000 irq 0
[  112.891386] ata14: SATA max UDMA/133 cmd 0xf8822280 ctl 0xf88222b8 bmdma 0x00000000 irq 0
[  112.899281] ata15: SATA max UDMA/133 cmd 0xf8822300 ctl 0xf8822338 bmdma 0x00000000 irq 0
[  112.906993] ata16: SATA max UDMA/133 cmd 0xf8822380 ctl 0xf88223b8 bmdma 0x00000000 irq 0
[  113.400028] ata13: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  113.420538] ata13.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[  113.428125] ata13.00: ATA-7: Maxtor 7Y250M0, YAR511W0, max UDMA/133
[  113.435704] ata13.00: 490234752 sectors, multi 0: LBA48
[  113.460465] ata13.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[  113.468012] ata13.00: configured for UDMA/133
[  113.959436] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  113.979922] ata14.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[  113.987525] ata14.00: ATA-7: Maxtor 7Y250M0, YAR511W0, max UDMA/133
[  113.995118] ata14.00: 490234752 sectors, multi 0: LBA48
[  114.019875] ata14.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[  114.027476] ata14.00: configured for UDMA/133
[  114.518843] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  114.539331] ata15.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[  114.546918] ata15.00: ATA-7: Maxtor 7Y250M0, YAR511W0, max UDMA/133
[  114.554531] ata15.00: 490234752 sectors, multi 0: LBA48
[  114.579302] ata15.00: ata_hpa_resize 1: sectors = 490234752, hpa_sectors = 490234752
[  114.586895] ata15.00: configured for UDMA/133
[  114.918403] ata16: SATA link down (SStatus 0 SControl 0)
[  114.926018] scsi 12:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[  114.933755] sd 12:0:0:0: [sdm] 490234752 512-byte hardware sectors (251000 MB)
[  114.941420] sd 12:0:0:0: [sdm] Write Protect is off
[  114.948955] sd 12:0:0:0: [sdm] Mode Sense: 00 3a 00 00
[  114.948971] sd 12:0:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  114.956622] sd 12:0:0:0: [sdm] 490234752 512-byte hardware sectors (251000 MB)
[  114.964258] sd 12:0:0:0: [sdm] Write Protect is off
[  114.971763] sd 12:0:0:0: [sdm] Mode Sense: 00 3a 00 00
[  114.971777] sd 12:0:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  114.979404]  sdm: unknown partition table
[  115.004878] sd 12:0:0:0: [sdm] Attached SCSI disk
[  115.012514] scsi 13:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[  115.020224] sd 13:0:0:0: [sdn] 490234752 512-byte hardware sectors (251000 MB)
[  115.027883] sd 13:0:0:0: [sdn] Write Protect is off
[  115.035414] sd 13:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[  115.035430] sd 13:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  115.043070] sd 13:0:0:0: [sdn] 490234752 512-byte hardware sectors (251000 MB)
[  115.050705] sd 13:0:0:0: [sdn] Write Protect is off
[  115.058187] sd 13:0:0:0: [sdn] Mode Sense: 00 3a 00 00
[  115.058200] sd 13:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  115.065817]  sdn: unknown partition table
[  115.092809] sd 13:0:0:0: [sdn] Attached SCSI disk
[  115.100723] scsi 14:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
[  115.108931] sd 14:0:0:0: [sdo] 490234752 512-byte hardware sectors (251000 MB)
[  115.117005] sd 14:0:0:0: [sdo] Write Protect is off
[  115.125124] sd 14:0:0:0: [sdo] Mode Sense: 00 3a 00 00
[  115.125139] sd 14:0:0:0: [sdo] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  115.133606] sd 14:0:0:0: [sdo] 490234752 512-byte hardware sectors (251000 MB)
[  115.142171] sd 14:0:0:0: [sdo] Write Protect is off
[  115.150580] sd 14:0:0:0: [sdo] Mode Sense: 00 3a 00 00
[  115.150595] sd 14:0:0:0: [sdo] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  115.159136]  sdo: unknown partition table
[  115.185583] sd 14:0:0:0: [sdo] Attached SCSI disk
[  115.194181] pata_via 0000:00:0f.1: version 0.3.1
[  115.194253] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 20
[  115.202806] ehci_hcd 0000:00:10.4: EHCI Host Controller
[  115.211316] ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
