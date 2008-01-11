From: Andrew Ryder <tireman@shaw.ca>
Subject: Re: Sata 4726 Testing
Date: Fri, 11 Jan 2008 18:13:48 -0500
Message-ID: <4787F82C.80709@shaw.ca>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com>
 <476D16E2.1050909@shaw.ca> <47824F69.6080007@gmail.com>
 <4782A79E.5000607@shaw.ca> <4782F3DB.6000906@gmail.com>
 <47832D82.2020106@shaw.ca> <47845F91.9000705@gmail.com>
 <47859132.1000700@gmail.com> <4785521B.6070205@shaw.ca>
 <47859D1A.8010006@gmail.com> <47855F02.3010407@shaw.ca>
 <4785BD03.10809@gmail.com> <4786C42A.10403@shaw.ca>
 <47871F88.8070109@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------090009030801000401080701
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:60596 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbYALEVC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 23:21:02 -0500
Received: from pd3mr4so.prod.shaw.ca
 (pd3mr4so-qfe3.prod.shaw.ca [10.0.141.180]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUI00GNKK31BM50@l-daemon> for linux-ide@vger.kernel.org; Fri,
 11 Jan 2008 21:21:01 -0700 (MST)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
 by pd3mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JUI00587K2I4G40@pd3mr4so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Fri, 11 Jan 2008 21:21:01 -0700 (MST)
Received: from [192.168.0.2] ([70.76.194.32])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUI00BTTK2FZZ30@l-daemon> for linux-ide@vger.kernel.org; Fri,
 11 Jan 2008 21:20:42 -0700 (MST)
In-reply-to: <47871F88.8070109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090009030801000401080701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tejun,

No problem. I should be thanking you and your team for all the hard work
writing the drivers for the hardware..

I think this patch might have solved the issue. I did a quick test: warm
rebooted and turned the 4726 on and off 3 times and all disks were
successfully detected each time. I'll do a more thorough test tomorrow
or Sunday.

Thanks



Tejun Heo wrote:
> Andrew Ryder wrote:
>   
>> For the regular power on detected, are you referring to cold/warm
>> booting the system and verifying initialization or only power cycling
>> the 4726?
>>
>> Here are my test results, TestingRoutine.txt is the procedure I followed
>> and test results obtained. If I missed something, please let me know.
>>
>> >From what I could find, the problem with ata1.03 not being detected is
>> consistent with the port. In my testing, I moved the last drive to the
>> 5th port on the 4726 and the problem carried through. The issue seemed
>> to only occur when the 4726 was powered on/off, not when it was
>> unplugged and re-plugged with the power on.
>>
>> If I have some time on the weekend, I will do a test routine of several
>> hot un-plugs / re-plugs of the 4726 and see what happens.
>>     
>
> Thanks a lot for all the testing.  Can you please apply the attached
> patch and see whether things improve?
>
> Thanks.
>
>   


--------------090009030801000401080701
Content-Type: text/plain;
 name="quicktest.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="quicktest.txt"

 3.0 Gbps (SStatus 123 SControl 0)
[   64.068586] ata1.06: hard resetting link
[   64.388488] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   64.389577] ata1.00: ATA-7: ST3300831A, 3.03, max UDMA/100
[   64.389580] ata1.00: 586072368 sectors, multi 16: LBA48 
[   64.389583] ata1.00: applying bridge limits
[   64.390715] ata1.00: configured for UDMA/100
[   64.391771] ata1.01: ATA-7: ST3300831A, 3.03, max UDMA/100
[   64.391773] ata1.01: 586072368 sectors, multi 0: LBA48 
[   64.391775] ata1.01: applying bridge limits
[   64.392913] ata1.01: configured for UDMA/100
[   64.438134] ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
[   64.438137] ata1.02: 586072368 sectors, multi 0: LBA48 
[   64.438139] ata1.02: applying bridge limits
[   64.496278] ata1.02: configured for UDMA/100
[   64.539472] ata1.04: ATA-7: ST3300622A, 3.AND, max UDMA/100
[   64.539475] ata1.04: 586072368 sectors, multi 0: LBA48 
[   64.539477] ata1.04: applying bridge limits
[   64.597758] ata1.04: configured for UDMA/100
[   64.597829] ata1.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
[   64.597832] ata1.05: 640 sectors, multi 1: LBA 
[   64.597839] ata1.05: device is on DMA blacklist, disabling DMA
[   64.597929] ata1.05: configured for PIO4
[   64.597969] ata1: EH complete
[   66.675642] ata2: SATA link down (SStatus 0 SControl 0)
[   68.755011] ata3: SATA link down (SStatus 0 SControl 0)
[   70.834380] ata4: SATA link down (SStatus 0 SControl 0)
[   70.834495] scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[   70.834908] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[   70.834919] sd 1:0:0:0: [sdb] Write Protect is off
[   70.834922] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   70.834934] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.834978] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[   70.834985] sd 1:0:0:0: [sdb] Write Protect is off
[   70.834987] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   70.834998] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.835002]  sdb: sdb1
[   70.843975] sd 1:0:0:0: [sdb] Attached SCSI disk
[   70.844011] sd 1:0:0:0: Attached scsi generic sg2 type 0
[   70.844453] scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[   70.844729] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[   70.844736] sd 1:1:0:0: [sdc] Write Protect is off
[   70.844739] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   70.844750] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.844779] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[   70.844786] sd 1:1:0:0: [sdc] Write Protect is off
[   70.844788] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   70.844799] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.844802]  sdc: sdc1
[   70.863628] sd 1:1:0:0: [sdc] Attached SCSI disk
[   70.863659] sd 1:1:0:0: Attached scsi generic sg3 type 0
[   70.864129] scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[   70.864190] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[   70.864197] sd 1:2:0:0: [sdd] Write Protect is off
[   70.864200] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.864211] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.864240] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[   70.864247] sd 1:2:0:0: [sdd] Write Protect is off
[   70.864249] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.864260] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.864263]  sdd: sdd1
[   70.881739] sd 1:2:0:0: [sdd] Attached SCSI disk
[   70.881772] sd 1:2:0:0: Attached scsi generic sg4 type 0
[   70.881818] scsi 1:4:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[   70.881877] sd 1:4:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[   70.881884] sd 1:4:0:0: [sde] Write Protect is off
[   70.881886] sd 1:4:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.881897] sd 1:4:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.882646] sd 1:4:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[   70.882654] sd 1:4:0:0: [sde] Write Protect is off
[   70.882656] sd 1:4:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.882667] sd 1:4:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.882670]  sde: sde1
[   70.898341] sd 1:4:0:0: [sde] Attached SCSI disk
[   70.898375] sd 1:4:0:0: Attached scsi generic sg5 type 0
[   70.898421] scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
[   70.898480] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.898487] sd 1:5:0:0: [sdf] Write Protect is off
[   70.898490] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.898501] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.898530] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.898537] sd 1:5:0:0: [sdf] Write Protect is off
[   70.898539] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.898550] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.898553]  sdf: unknown partition table
[   70.899398] sd 1:5:0:0: [sdf] Attached SCSI disk
[   70.899430] sd 1:5:0:0: Attached scsi generic sg6 type 0
[   70.899727] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
[   70.899738] uhci_hcd 0000:00:10.0: UHCI Host Controller
[   70.899929] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
[   70.899958] uhci_hcd 0000:00:10.0: irq 21, io base 0x0000b800
[   70.900097] usb usb1: configuration #1 chosen from 1 choice
[   70.900124] hub 1-0:1.0: USB hub found
[   70.900133] hub 1-0:1.0: 2 ports detected
[   71.002471] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
[   71.002485] uhci_hcd 0000:00:10.1: UHCI Host Controller
[   71.002509] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
[   71.002532] uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c000
[   71.002652] usb usb2: configuration #1 chosen from 1 choice
[   71.002678] hub 2-0:1.0: USB hub found
[   71.002685] hub 2-0:1.0: 2 ports detected
[   71.106425] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
[   71.106439] uhci_hcd 0000:00:10.2: UHCI Host Controller
[   71.106464] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
[   71.106487] uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c400
[   71.106608] usb usb3: configuration #1 chosen from 1 choice
[   71.106632] hub 3-0:1.0: USB hub found
[   71.106640] hub 3-0:1.0: 2 ports detected
[   71.210424] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
[   71.210438] uhci_hcd 0000:00:10.3: UHCI Host Controller
[   71.210463] uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
[   71.210487] uhci_hcd 0000:00:10.3: irq 21, io base 0x0000c800
[   71.210606] usb usb4: configuration #1 chosen from 1 choice
[   71.210631] hub 4-0:1.0: USB hub found
[   71.210639] hub 4-0:1.0: 2 ports detected
[   71.314524] ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
[   71.316772] Audigy2 value: Special config.
[   71.329677] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
[   71.330044] ehci_hcd 0000:00:10.4: EHCI Host Controller
[   71.330104] ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
[   71.330152] ehci_hcd 0000:00:10.4: irq 21, io mem 0xfdf00000
[   71.338231] ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   71.338350] usb usb5: configuration #1 chosen from 1 choice
[   71.338377] hub 5-0:1.0: USB hub found
[   71.338387] hub 5-0:1.0: 8 ports detected
[   73.047330] Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
[   73.047334] Copyright (c) 1999-2006 Intel Corporation.
[   73.047376] ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
[   73.047381] PCI: Disallowing DAC for device 0000:00:0e.0
[   73.307233] e1000: 0000:00:0e.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:62:c5:46
[   73.482707] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[   73.641789] ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
[   73.641802] ReiserFS: hdb1: using ordered data mode
[   73.677157] ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   73.678508] ReiserFS: hdb1: checking transaction log (hdb1)
[   73.795920] ReiserFS: hdb1: Using r5 hash to sort names
[   73.842916] ReiserFS: hda2: found reiserfs format "3.6" with standard journal
[   73.842927] ReiserFS: hda2: using ordered data mode
[   73.847744] ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   73.849101] ReiserFS: hda2: checking transaction log (hda2)
[   73.903713] ReiserFS: hda2: Using r5 hash to sort names
[   79.570937] hda: UDMA/100 mode selected
[   79.574851] hdb: UDMA/133 mode selected
[   79.629194] hdc: UDMA/33 mode selected
[   79.647002] hdd: UDMA/33 mode selected
[   82.211327] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
[   86.444756] w83627hf: Found W83697HF chip at 0x290
[  137.853328] ata1.00: failed to read SCR 1 (Emask=0x40)
[  137.853333] ata1.01: failed to read SCR 1 (Emask=0x40)
[  137.853336] ata1.02: failed to read SCR 1 (Emask=0x40)
[  137.853338] ata1.03: failed to read SCR 1 (Emask=0x40)
[  137.853341] ata1.04: failed to read SCR 1 (Emask=0x40)
[  137.853343] ata1.05: failed to read SCR 1 (Emask=0x40)
[  137.853345] ata1.06: failed to read SCR 1 (Emask=0x40)
[  137.853349] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  137.853352] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  137.853356] ata1: SError: { 10B8B }
[  137.853360] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  137.853364] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  137.853369] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  137.853373] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  137.853378] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  137.853382] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  137.853386] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  137.853393] ata1.15: hard resetting link
[  142.944498] ata1.15: SATA link down (SStatus 1 SControl 0)
[  143.196416] ata1.15: qc timeout (cmd 0xe4)
[  143.196423] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  143.196426] ata1.15: PMP revalidation failed (errno=-5)
[  143.196428] ata1.15: retrying hardreset in 5 secs
[  148.198897] ata1.15: hard resetting link
[  153.293357] ata1.15: SATA link down (SStatus 1 SControl 0)
[  153.545275] ata1.15: qc timeout (cmd 0xe4)
[  153.545282] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  153.545284] ata1.15: PMP revalidation failed (errno=-5)
[  153.545288] ata1.15: limiting SATA link speed to 1.5 Gbps
[  153.545290] ata1.15: retrying hardreset in 5 secs
[  158.547757] ata1.15: hard resetting link
[  160.747099] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  160.747310] ata1.00: hard resetting link
[  161.067177] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  161.067180] ata1.01: hard resetting link
[  161.387081] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  161.387085] ata1.02: hard resetting link
[  161.706985] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  161.706989] ata1.03: hard resetting link
[  162.026886] ata1.03: SATA link down (SStatus 0 SControl 310)
[  162.026889] ata1.04: hard resetting link
[  162.346790] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  162.346794] ata1.05: hard resetting link
[  162.666691] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  162.666694] ata1.06: hard resetting link
[  162.986595] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  162.986705] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  162.986709] ata1.00: revalidation failed (errno=-5)
[  162.986713] ata1.15: hard resetting link
[  165.185753] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  165.185956] ata1.00: hard resetting link
[  165.505832] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  165.505836] ata1.01: hard resetting link
[  165.825734] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  165.825738] ata1.02: hard resetting link
[  166.145638] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  166.145642] ata1.03: hard resetting link
[  166.465539] ata1.03: SATA link down (SStatus 0 SControl 310)
[  166.465542] ata1.04: hard resetting link
[  166.785447] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  166.785455] ata1.05: hard resetting link
[  167.105345] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  167.105348] ata1.06: hard resetting link
[  167.425248] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  167.427459] ata1.00: configured for UDMA/100
[  167.429696] ata1.01: configured for UDMA/100
[  167.542073] ata1.02: configured for UDMA/100
[  167.650192] ata1.04: configured for UDMA/100
[  167.650302] ata1.05: device is on DMA blacklist, disabling DMA
[  167.650455] ata1.05: configured for PIO4
[  167.650733] ata1: EH complete
[  167.650759] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  167.650770] sd 1:0:0:0: [sdb] Write Protect is off
[  167.650773] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  167.650786] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  167.650801] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  167.650808] sd 1:1:0:0: [sdc] Write Protect is off
[  167.650811] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  167.650823] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  167.650836] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  167.650844] sd 1:2:0:0: [sdd] Write Protect is off
[  167.650847] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  167.650858] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  167.650871] sd 1:4:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  167.650879] sd 1:4:0:0: [sde] Write Protect is off
[  167.650882] sd 1:4:0:0: [sde] Mode Sense: 00 3a 00 00
[  167.650893] sd 1:4:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  167.650906] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  167.650914] sd 1:5:0:0: [sdf] Write Protect is off
[  167.650917] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  167.650928] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  167.650941] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  167.650948] sd 1:0:0:0: [sdb] Write Protect is off
[  167.650951] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  167.650962] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  167.650975] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  167.650982] sd 1:1:0:0: [sdc] Write Protect is off
[  167.650985] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  167.650996] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  167.651009] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  167.651016] sd 1:2:0:0: [sdd] Write Protect is off
[  167.651019] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  167.651030] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  167.651043] sd 1:4:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  167.651050] sd 1:4:0:0: [sde] Write Protect is off
[  167.651053] sd 1:4:0:0: [sde] Mode Sense: 00 3a 00 00
[  167.651064] sd 1:4:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  167.651077] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  167.651084] sd 1:5:0:0: [sdf] Write Protect is off
[  167.651087] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  167.651098] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  255.113670] ata1.00: failed to read SCR 1 (Emask=0x40)
[  255.113675] ata1.01: failed to read SCR 1 (Emask=0x40)
[  255.113679] ata1.02: failed to read SCR 1 (Emask=0x40)
[  255.113682] ata1.03: failed to read SCR 1 (Emask=0x40)
[  255.113685] ata1.04: failed to read SCR 1 (Emask=0x40)
[  255.113688] ata1.05: failed to read SCR 1 (Emask=0x40)
[  255.113691] ata1.06: failed to read SCR 1 (Emask=0x40)
[  255.113695] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  255.113698] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  255.113702] ata1: SError: { 10B8B }
[  255.113707] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  255.113712] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  255.113718] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  255.113723] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  255.113728] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  255.113733] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  255.113738] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  255.113746] ata1.15: hard resetting link
[  260.204923] ata1.15: SATA link down (SStatus 1 SControl 10)
[  260.456841] ata1.15: qc timeout (cmd 0xe4)
[  260.456849] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  260.456852] ata1.15: PMP revalidation failed (errno=-5)
[  260.456855] ata1.15: retrying hardreset in 5 secs
[  265.459323] ata1.15: hard resetting link
[  270.553782] ata1.15: SATA link down (SStatus 1 SControl 10)
[  270.805701] ata1.15: qc timeout (cmd 0xe4)
[  270.805709] ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
[  270.805712] ata1.15: PMP revalidation failed (errno=-5)
[  270.805715] ata1.15: retrying hardreset in 5 secs
[  275.808184] ata1.15: hard resetting link
[  278.007526] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  278.007739] ata1.00: hard resetting link
[  278.327605] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  278.327609] ata1.01: hard resetting link
[  278.647507] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  278.647511] ata1.02: hard resetting link
[  278.967409] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  278.967412] ata1.03: hard resetting link
[  279.287313] ata1.03: SATA link down (SStatus 0 SControl 310)
[  279.287317] ata1.04: hard resetting link
[  279.607217] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  279.607221] ata1.05: hard resetting link
[  279.927117] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  279.927120] ata1.06: hard resetting link
[  280.247021] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  280.247140] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  280.247144] ata1.00: revalidation failed (errno=-5)
[  280.247149] ata1.15: hard resetting link
[  282.446181] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  282.446476] ata1.00: hard resetting link
[  282.766257] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  282.766261] ata1.01: hard resetting link
[  283.086161] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  283.086165] ata1.02: hard resetting link
[  283.406065] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  283.406069] ata1.03: hard resetting link
[  283.725965] ata1.03: SATA link down (SStatus 0 SControl 310)
[  283.725968] ata1.04: hard resetting link
[  284.045870] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  284.045874] ata1.05: hard resetting link
[  284.365770] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  284.365774] ata1.06: hard resetting link
[  284.685674] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  284.687930] ata1.00: configured for UDMA/100
[  284.690132] ata1.01: configured for UDMA/100
[  284.690241] ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[  284.690245] ata1.02: revalidation failed (errno=-5)
[  284.690250] ata1.15: hard resetting link
[  286.888832] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  286.889036] ata1.00: hard resetting link
[  287.208910] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  287.208915] ata1.01: hard resetting link
[  287.528814] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  287.528818] ata1.02: hard resetting link
[  287.848716] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  287.848720] ata1.03: hard resetting link
[  288.168618] ata1.03: SATA link down (SStatus 0 SControl 310)
[  288.168622] ata1.04: hard resetting link
[  288.488523] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  288.488527] ata1.05: hard resetting link
[  288.808424] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  288.808427] ata1.06: hard resetting link
[  289.128328] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  289.130548] ata1.00: configured for UDMA/100
[  289.132742] ata1.01: configured for UDMA/100
[  289.227715] ata1.02: configured for UDMA/100
[  289.329614] ata1.04: configured for UDMA/100
[  289.329723] ata1.05: device is on DMA blacklist, disabling DMA
[  289.329833] ata1.05: configured for PIO4
[  289.330106] ata1: EH complete
[  289.330132] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  289.330144] sd 1:0:0:0: [sdb] Write Protect is off
[  289.330147] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  289.330160] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  289.330175] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  289.330183] sd 1:1:0:0: [sdc] Write Protect is off
[  289.330186] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  289.330197] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  289.330211] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  289.330219] sd 1:2:0:0: [sdd] Write Protect is off
[  289.330222] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  289.330233] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  289.330247] sd 1:4:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  289.330254] sd 1:4:0:0: [sde] Write Protect is off
[  289.330257] sd 1:4:0:0: [sde] Mode Sense: 00 3a 00 00
[  289.330269] sd 1:4:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  289.330282] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  289.330290] sd 1:5:0:0: [sdf] Write Protect is off
[  289.330293] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  289.330304] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  289.330317] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  289.330325] sd 1:0:0:0: [sdb] Write Protect is off
[  289.330328] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  289.330339] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  289.330352] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  289.330359] sd 1:1:0:0: [sdc] Write Protect is off
[  289.330362] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  289.330374] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  289.330386] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  289.330394] sd 1:2:0:0: [sdd] Write Protect is off
[  289.330397] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  289.330408] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  289.330421] sd 1:4:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  289.330429] sd 1:4:0:0: [sde] Write Protect is off
[  289.330431] sd 1:4:0:0: [sde] Mode Sense: 00 3a 00 00
[  289.330443] sd 1:4:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  289.330455] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  289.330463] sd 1:5:0:0: [sdf] Write Protect is off
[  289.330466] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  289.330477] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  381.529021] ata1.00: failed to read SCR 1 (Emask=0x40)
[  381.529026] ata1.01: failed to read SCR 1 (Emask=0x40)
[  381.529030] ata1.02: failed to read SCR 1 (Emask=0x40)
[  381.529033] ata1.03: failed to read SCR 1 (Emask=0x40)
[  381.529036] ata1.04: failed to read SCR 1 (Emask=0x40)
[  381.529039] ata1.05: failed to read SCR 1 (Emask=0x40)
[  381.529042] ata1.06: failed to read SCR 1 (Emask=0x40)
[  381.529047] ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
[  381.529050] ata1.15: irq_stat 0x01140010, PHY RDY changed
[  381.529054] ata1: SError: { 10B8B }
[  381.529059] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  381.529064] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  381.529069] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  381.529074] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  381.529079] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  381.529085] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  381.529090] ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  381.529097] ata1.15: hard resetting link
[  386.846507] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  386.846725] ata1.00: hard resetting link
[  387.166587] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  387.166591] ata1.01: hard resetting link
[  387.486488] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  387.486492] ata1.02: hard resetting link
[  387.806391] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  387.806395] ata1.03: hard resetting link
[  388.126293] ata1.03: SATA link down (SStatus 0 SControl 310)
[  388.126297] ata1.04: hard resetting link
[  388.446197] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  388.446201] ata1.05: hard resetting link
[  388.766097] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  388.766101] ata1.06: hard resetting link
[  389.086002] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  389.086113] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[  389.086117] ata1.00: revalidation failed (errno=-5)
[  389.086122] ata1.15: hard resetting link
[  391.285159] ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[  391.285360] ata1.00: hard resetting link
[  391.605238] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  391.605242] ata1.01: hard resetting link
[  391.925141] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  391.925145] ata1.02: hard resetting link
[  392.245044] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  392.245048] ata1.03: hard resetting link
[  392.564947] ata1.03: SATA link down (SStatus 0 SControl 310)
[  392.564950] ata1.04: hard resetting link
[  392.884850] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  392.884853] ata1.05: hard resetting link
[  393.204750] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  393.204754] ata1.06: hard resetting link
[  393.524655] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  393.526898] ata1.00: configured for UDMA/100
[  393.529077] ata1.01: configured for UDMA/100
[  393.629634] ata1.02: configured for UDMA/100
[  393.739404] ata1.04: configured for UDMA/100
[  393.739512] ata1.05: device is on DMA blacklist, disabling DMA
[  393.739622] ata1.05: configured for PIO4
[  393.739893] ata1: EH complete
[  393.739918] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  393.739929] sd 1:0:0:0: [sdb] Write Protect is off
[  393.739932] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  393.739945] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  393.739960] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  393.739968] sd 1:1:0:0: [sdc] Write Protect is off
[  393.739970] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  393.739982] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  393.739996] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  393.740004] sd 1:2:0:0: [sdd] Write Protect is off
[  393.740006] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  393.740018] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  393.740032] sd 1:4:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  393.740039] sd 1:4:0:0: [sde] Write Protect is off
[  393.740042] sd 1:4:0:0: [sde] Mode Sense: 00 3a 00 00
[  393.740054] sd 1:4:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  393.740067] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  393.740075] sd 1:5:0:0: [sdf] Write Protect is off
[  393.740078] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  393.740089] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  393.740102] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  393.740109] sd 1:0:0:0: [sdb] Write Protect is off
[  393.740112] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  393.740124] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  393.740136] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  393.740144] sd 1:1:0:0: [sdc] Write Protect is off
[  393.740147] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  393.740158] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  393.740171] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  393.740179] sd 1:2:0:0: [sdd] Write Protect is off
[  393.740182] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[  393.740193] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  393.740206] sd 1:4:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  393.740213] sd 1:4:0:0: [sde] Write Protect is off
[  393.740216] sd 1:4:0:0: [sde] Mode Sense: 00 3a 00 00
[  393.740228] sd 1:4:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  393.740240] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[  393.740248] sd 1:5:0:0: [sdf] Write Protect is off
[  393.740251] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[  393.740262] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA

--------------090009030801000401080701
Content-Type: text/plain;
 name="initialboot.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="initialboot.txt"

[    0.000000] Linux version 2.6.24-rc7 (root@BigMouth) (gcc version 4.1.2 (Gentoo 4.1.2 p1.0.1)) #3 Fri Jan 11 22:15:34 EST 2008
[    0.000000] Command line: root=/dev/sda3
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007ff30000 (usable)
[    0.000000]  BIOS-e820: 000000007ff30000 - 000000007ff40000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007ff40000 - 000000007fff0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 524080) 1 entries of 256 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP 000FA850, 0014 (r0 ACPIAM)
[    0.000000] ACPI: RSDT 7FF30000, 0030 (r1 A M I  OEMRSDT   6000517 MSFT       97)
[    0.000000] ACPI: FACP 7FF30200, 0081 (r1 A M I  OEMFACP   6000517 MSFT       97)
[    0.000000] ACPI: DSDT 7FF303F0, 38EA (r1  SK8V_ SK8V_033       33 MSFT  100000D)
[    0.000000] ACPI: FACS 7FF40000, 0040
[    0.000000] ACPI: APIC 7FF30390, 0052 (r1 A M I  OEMAPIC   6000517 MSFT       97)
[    0.000000] ACPI: OEMB 7FF40040, 003F (r1 A M I  OEMBIOS   6000517 MSFT       97)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 524080) 1 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   524080
[    0.000000] On node 0 totalpages: 523983
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 964 pages reserved
[    0.000000]   DMA zone: 2979 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7109 pages used for memmap
[    0.000000]   DMA32 zone: 512875 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:7ff80000)
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 515854
[    0.000000] Kernel command line: root=/dev/sda3
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] TSC calibrated against PM_TIMER
[   41.618216] time.c: Detected 1802.299 MHz processor.
[   41.620616] Console: colour VGA+ 80x25
[   41.620619] console [tty0] enabled
[   41.624678] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   41.626767] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   41.627141] Checking aperture...
[   41.627195] CPU 0: aperture @ f8000000 size 64 MB
[   41.646942] Memory: 2059876k/2096320k available (2288k kernel code, 35684k reserved, 1034k data, 192k init)
[   41.724181] Calibrating delay using timer specific routine.. 3608.83 BogoMIPS (lpj=7217670)
[   41.724337] Mount-cache hash table entries: 256
[   41.724500] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   41.724557] CPU: L2 Cache: 1024K (64 bytes/line)
[   41.724622] CPU: AMD Opteron(tm) Processor 144 stepping 0a
[   41.724765] ACPI: Core revision 20070126
[   41.767576] Using local APIC timer interrupts.
[   41.823100] APIC timer calibration result 12515974
[   41.823102] Detected 12.515 MHz APIC timer.
[   41.823286] net_namespace: 120 bytes
[   41.823714] NET: Registered protocol family 16
[   41.823905] ACPI: bus type pci registered
[   41.823965] PCI: Using configuration type 1
[   41.826106] ACPI: EC: Look up EC in DSDT
[   41.829621] ACPI: Interpreter enabled
[   41.829675] ACPI: (supports S0 S1 S3 S5)
[   41.829887] ACPI: Using IOAPIC for interrupt routing
[   41.836667] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   41.837405] PCI: enabled onboard AC97/MC97 devices
[   41.837705] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   41.844265] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
[   41.844787] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
[   41.845307] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
[   41.845826] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 10 11 14 15)
[   41.846345] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   41.846950] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   41.847570] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   41.848175] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
[   41.848777] Linux Plug and Play Support v0.97 (c) Adam Belay
[   41.848853] pnp: PnP ACPI init
[   41.848910] ACPI: bus type pnp registered
[   41.852287] pnp: PnP ACPI: found 14 devices
[   41.852341] ACPI: ACPI bus type pnp unregistered
[   41.852541] SCSI subsystem initialized
[   41.852682] PCI: Using ACPI for IRQ routing
[   41.852737] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   41.852810] PCI: Cannot allocate resource region 0 of device 0000:00:00.0
[   41.863211] agpgart: Detected AGP bridge 0
[   41.866722] agpgart: AGP aperture is 64M @ 0xf8000000
[   41.867159] Time: tsc clocksource has been installed.
[   41.875194] system 00:09: ioport range 0x295-0x296 has been reserved
[   41.875252] system 00:09: ioport range 0x3e1-0x3e7 has been reserved
[   41.875309] system 00:09: ioport range 0x4d0-0x4d1 has been reserved
[   41.875366] system 00:09: ioport range 0x800-0x87f has been reserved
[   41.875423] system 00:09: ioport range 0x400-0x41f has been reserved
[   41.875485] system 00:0a: iomem range 0xfec00000-0xfec00fff has been reserved
[   41.875543] system 00:0a: iomem range 0xfee00000-0xfee00fff could not be reserved
[   41.875611] system 00:0a: iomem range 0xfff80000-0xffffffff could not be reserved
[   41.875684] system 00:0d: iomem range 0x0-0x9ffff could not be reserved
[   41.875741] system 00:0d: iomem range 0xc0000-0xdffff has been reserved
[   41.875799] system 00:0d: iomem range 0xe0000-0xfffff could not be reserved
[   41.875856] system 00:0d: iomem range 0x100000-0x7ffeffff could not be reserved
[   41.875924] system 00:0d: iomem range 0x0-0x0 could not be reserved
[   41.876318] PCI: Bridge: 0000:00:01.0
[   41.876371]   IO window: a000-afff
[   41.876426]   MEM window: fc500000-fcafffff
[   41.876480]   PREFETCH window: b3e00000-f3dfffff
[   41.876552] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   41.876577] NET: Registered protocol family 2
[   41.911201] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   41.911806] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[   41.914358] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[   41.914760] TCP: Hash tables configured (established 262144 bind 65536)
[   41.914817] TCP reno registered
[   41.923814] audit: initializing netlink socket (disabled)
[   41.923877] audit(1200092274.256:1): initialized
[   41.924197] io scheduler noop registered
[   41.924251] io scheduler anticipatory registered (default)
[   41.924306] io scheduler deadline registered
[   41.924366] io scheduler cfq registered
[   41.924424] PCI: VIA PCI bridge detected. Disabling DAC.
[   41.924948] Boot video device is 0000:01:00.0
[   41.927001] Real Time Clock Driver v1.12ac
[   41.927117] Linux agpgart interface v0.102
[   41.927179] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   41.927340] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   41.927484] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   41.928134] RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
[   41.928436] loop: module loaded
[   41.928493] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   41.928550] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   41.928654] VIA8237SATA: IDE controller (0x1106:0x3149 rev 0x80) at  PCI slot 0000:00:0f.0
[   41.928736] ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
[   41.928853] VIA8237SATA: 100% native mode on irq 20
[   41.928911]     ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:pio, hdf:pio
[   41.929060]     ide3: BM-DMA at 0xd408-0xd40f, BIOS settings: hdg:pio, hdh:pio
[   41.929206] Probing IDE interface ide2...
[   42.494969] Probing IDE interface ide3...
[   43.062799] VP_IDE: IDE controller (0x1106:0x0571 rev 0x06) at  PCI slot 0000:00:0f.1
[   43.062878] ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
[   43.062985] VP_IDE: not 100% native mode: will probe irqs later
[   43.063047] VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
[   43.063117]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
[   43.063266]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
[   43.063412] Probing IDE interface ide0...
[   43.478770] hdb: Maxtor 4G160J8, ATA DISK drive
[   43.814667] hda: ST3200822A, ATA DISK drive
[   43.814763] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   43.814984] hda: UDMA/100 mode selected
[   43.815332] hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   43.815442] hdb: UDMA/133 mode selected
[   43.815625] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   43.815777] Probing IDE interface ide1...
[   44.734388] hdd: ASUS DVD-E616P2, ATAPI CD/DVD-ROM drive
[   45.518150] hdc: ASUS DRW-0402P/D, ATAPI CD/DVD-ROM drive
[   45.518322] hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   45.518389] hdc: UDMA/33 mode selected
[   45.518508] hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   45.518741] hdd: drive side 80-wire cable detection failed, limiting max speed to UDMA33
[   45.518809] hdd: UDMA/33 mode selected
[   45.519116] ide1 at 0x170-0x177,0x376 on irq 15
[   45.519350] Probing IDE interface ide2...
[   46.085878] Probing IDE interface ide3...
[   46.653726] hda: max request size: 512KiB
[   46.654211] hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63
[   46.654473] hda: cache flushes supported
[   46.654549]  hda: hda1 hda2
[   46.668350] hdb: max request size: 512KiB
[   46.675618] hdb: 320173056 sectors (163928 MB) w/2048KiB Cache, CHS=19929/255/63
[   46.675761] hdb: cache flushes not supported
[   46.675830]  hdb: hdb1
[   46.687057] hdc: ATAPI 47X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache
[   46.687340] Uniform CD-ROM driver Revision: 3.20
[   47.971389] hdd: ATAPI 48X DVD-ROM drive, 512kB Cache
[   47.982729] ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 18
[   53.191727] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
[   53.191729]         <Adaptec 29160N Ultra160 SCSI adapter>
[   53.191731]         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
[   53.191732] 
[   53.195663] scsi 0:0:0:0: Direct-Access     SEAGATE  ST318452LW       0004 PQ: 0 ANSI: 3
[   53.195737] scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
[   53.195836]  target0:0:0: Beginning Domain Validation
[   53.203996]  target0:0:0: wide asynchronous
[   53.210176]  target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
[   53.220943]  target0:0:0: Ending Domain Validation
[   53.743274] scsi 0:0:3:0: CD-ROM            YAMAHA   CRW8824S         1.00 PQ: 0 ANSI: 2
[   53.743349]  target0:0:3: Beginning Domain Validation
[   53.755769]  target0:0:3: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)
[   53.764138]  target0:0:3: Domain Validation skipping write tests
[   53.764193]  target0:0:3: Ending Domain Validation
[   56.584537] Driver 'sd' needs updating - please use bus_type methods
[   56.585434] sd 0:0:0:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
[   56.586616] sd 0:0:0:0: [sda] Write Protect is off
[   56.586670] sd 0:0:0:0: [sda] Mode Sense: a3 00 10 08
[   56.588354] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   56.589219] sd 0:0:0:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
[   56.590401] sd 0:0:0:0: [sda] Write Protect is off
[   56.590455] sd 0:0:0:0: [sda] Mode Sense: a3 00 10 08
[   56.592163] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   56.592231]  sda: sda1 sda2 sda3
[   56.596310] sd 0:0:0:0: [sda] Attached SCSI disk
[   56.596372] Driver 'sr' needs updating - please use bus_type methods
[   56.631073] sr0: scsi3-mmc drive: 24x/16x writer cd/rw xa/form2 cdda tray
[   56.631173] sr 0:0:3:0: Attached scsi CD-ROM sr0
[   56.631239] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[   56.631658] serio: i8042 KBD port at 0x60,0x64 irq 1
[   56.631715] serio: i8042 AUX port at 0x60,0x64 irq 12
[   56.631877] mice: PS/2 mouse device common for all mice
[   56.661791] input: AT Translated Set 2 keyboard as /class/input/input0
[   56.689904] TCP cubic registered
[   56.689962] NET: Registered protocol family 1
[   56.690026] NET: Registered protocol family 17
[   56.690112] NET: Registered protocol family 33
[   56.690306] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   57.086790] input: ImPS/2 Generic Wheel Mouse as /class/input/input1
[   57.213499] ReiserFS: sda3: found reiserfs format "3.6" with standard journal
[   57.213561] ReiserFS: sda3: using ordered data mode
[   57.216529] ReiserFS: sda3: journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   57.218121] ReiserFS: sda3: checking transaction log (sda3)
[   57.244588] ReiserFS: sda3: Using r5 hash to sort names
[   57.244669] VFS: Mounted root (reiserfs filesystem) readonly.
[   57.244739] Freeing unused kernel memory: 192k freed
[   59.406317] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   59.406341] sr 0:0:3:0: Attached scsi generic sg1 type 5
[   59.428553] ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 16
[   59.508971] libata version 3.00 loaded.
[   59.737302] usbcore: registered new interface driver usbfs
[   59.737335] usbcore: registered new interface driver hub
[   59.773362] usbcore: registered new device driver usb
[   59.809187] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[16]  MMIO=[fd400000-fd4007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   59.822712] USB Universal Host Controller Interface driver v3.0
[   59.823317] input: Power Button (FF) as /class/input/input2
[   59.853767] ACPI: Power Button (FF) [PWRF]
[   59.853856] input: Power Button (CM) as /class/input/input3
[   59.861345] sata_sil24 0000:00:0c.0: version 1.1
[   59.861367] ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 17
[   59.861780] PCI: Disallowing DAC for device 0000:00:0c.0
[   59.877746] ACPI: Power Button (CM) [PWRB]
[   59.877823] input: Sleep Button (CM) as /class/input/input4
[   59.882329] scsi1 : sata_sil24
[   59.896674] scsi2 : sata_sil24
[   59.909750] ACPI: Sleep Button (CM) [SLPB]
[   59.929168] scsi3 : sata_sil24
[   59.952335] scsi4 : sata_sil24
[   59.952398] ata1: SATA max UDMA/100 host m128@0xfd900000 port 0xfd800000 irq 17
[   59.952402] ata2: SATA max UDMA/100 host m128@0xfd900000 port 0xfd802000 irq 17
[   59.952406] ata3: SATA max UDMA/100 host m128@0xfd900000 port 0xfd804000 irq 17
[   59.952409] ata4: SATA max UDMA/100 host m128@0xfd900000 port 0xfd806000 irq 17
[   60.536982] input: PC Speaker as /class/input/input5
[   60.651796] Floppy drive(s): fd0 is 1.44M
[   60.669365] FDC 0 is a post-1991 82077
[   60.672110] 00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   60.672228] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   61.129412] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000059341e]
[   62.149016] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   62.149161] ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
[   62.149354] ata1.00: hard resetting link
[   62.469069] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   62.469071] ata1.01: hard resetting link
[   62.788977] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   62.788984] ata1.02: hard resetting link
[   63.108875] ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   63.108878] ata1.03: hard resetting link
[   63.428780] ata1.03: SATA link down (SStatus 0 SControl 320)
[   63.428783] ata1.04: hard resetting link
[   63.748685] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   63.748692] ata1.05: hard resetting link
[   64.068583] ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   64.068586] ata1.06: hard resetting link
[   64.388488] ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   64.389577] ata1.00: ATA-7: ST3300831A, 3.03, max UDMA/100
[   64.389580] ata1.00: 586072368 sectors, multi 16: LBA48 
[   64.389583] ata1.00: applying bridge limits
[   64.390715] ata1.00: configured for UDMA/100
[   64.391771] ata1.01: ATA-7: ST3300831A, 3.03, max UDMA/100
[   64.391773] ata1.01: 586072368 sectors, multi 0: LBA48 
[   64.391775] ata1.01: applying bridge limits
[   64.392913] ata1.01: configured for UDMA/100
[   64.438134] ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
[   64.438137] ata1.02: 586072368 sectors, multi 0: LBA48 
[   64.438139] ata1.02: applying bridge limits
[   64.496278] ata1.02: configured for UDMA/100
[   64.539472] ata1.04: ATA-7: ST3300622A, 3.AND, max UDMA/100
[   64.539475] ata1.04: 586072368 sectors, multi 0: LBA48 
[   64.539477] ata1.04: applying bridge limits
[   64.597758] ata1.04: configured for UDMA/100
[   64.597829] ata1.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
[   64.597832] ata1.05: 640 sectors, multi 1: LBA 
[   64.597839] ata1.05: device is on DMA blacklist, disabling DMA
[   64.597929] ata1.05: configured for PIO4
[   64.597969] ata1: EH complete
[   66.675642] ata2: SATA link down (SStatus 0 SControl 0)
[   68.755011] ata3: SATA link down (SStatus 0 SControl 0)
[   70.834380] ata4: SATA link down (SStatus 0 SControl 0)
[   70.834495] scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[   70.834908] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[   70.834919] sd 1:0:0:0: [sdb] Write Protect is off
[   70.834922] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   70.834934] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.834978] sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[   70.834985] sd 1:0:0:0: [sdb] Write Protect is off
[   70.834987] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   70.834998] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.835002]  sdb: sdb1
[   70.843975] sd 1:0:0:0: [sdb] Attached SCSI disk
[   70.844011] sd 1:0:0:0: Attached scsi generic sg2 type 0
[   70.844453] scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
[   70.844729] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[   70.844736] sd 1:1:0:0: [sdc] Write Protect is off
[   70.844739] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   70.844750] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.844779] sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[   70.844786] sd 1:1:0:0: [sdc] Write Protect is off
[   70.844788] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   70.844799] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.844802]  sdc: sdc1
[   70.863628] sd 1:1:0:0: [sdc] Attached SCSI disk
[   70.863659] sd 1:1:0:0: Attached scsi generic sg3 type 0
[   70.864129] scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[   70.864190] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[   70.864197] sd 1:2:0:0: [sdd] Write Protect is off
[   70.864200] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.864211] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.864240] sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[   70.864247] sd 1:2:0:0: [sdd] Write Protect is off
[   70.864249] sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[   70.864260] sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.864263]  sdd: sdd1
[   70.881739] sd 1:2:0:0: [sdd] Attached SCSI disk
[   70.881772] sd 1:2:0:0: Attached scsi generic sg4 type 0
[   70.881818] scsi 1:4:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
[   70.881877] sd 1:4:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[   70.881884] sd 1:4:0:0: [sde] Write Protect is off
[   70.881886] sd 1:4:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.881897] sd 1:4:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.882646] sd 1:4:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[   70.882654] sd 1:4:0:0: [sde] Write Protect is off
[   70.882656] sd 1:4:0:0: [sde] Mode Sense: 00 3a 00 00
[   70.882667] sd 1:4:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   70.882670]  sde: sde1
[   70.898341] sd 1:4:0:0: [sde] Attached SCSI disk
[   70.898375] sd 1:4:0:0: Attached scsi generic sg5 type 0
[   70.898421] scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
[   70.898480] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.898487] sd 1:5:0:0: [sdf] Write Protect is off
[   70.898490] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.898501] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.898530] sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
[   70.898537] sd 1:5:0:0: [sdf] Write Protect is off
[   70.898539] sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
[   70.898550] sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   70.898553]  sdf: unknown partition table
[   70.899398] sd 1:5:0:0: [sdf] Attached SCSI disk
[   70.899430] sd 1:5:0:0: Attached scsi generic sg6 type 0
[   70.899727] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
[   70.899738] uhci_hcd 0000:00:10.0: UHCI Host Controller
[   70.899929] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
[   70.899958] uhci_hcd 0000:00:10.0: irq 21, io base 0x0000b800
[   70.900097] usb usb1: configuration #1 chosen from 1 choice
[   70.900124] hub 1-0:1.0: USB hub found
[   70.900133] hub 1-0:1.0: 2 ports detected
[   71.002471] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
[   71.002485] uhci_hcd 0000:00:10.1: UHCI Host Controller
[   71.002509] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
[   71.002532] uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c000
[   71.002652] usb usb2: configuration #1 chosen from 1 choice
[   71.002678] hub 2-0:1.0: USB hub found
[   71.002685] hub 2-0:1.0: 2 ports detected
[   71.106425] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
[   71.106439] uhci_hcd 0000:00:10.2: UHCI Host Controller
[   71.106464] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
[   71.106487] uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c400
[   71.106608] usb usb3: configuration #1 chosen from 1 choice
[   71.106632] hub 3-0:1.0: USB hub found
[   71.106640] hub 3-0:1.0: 2 ports detected
[   71.210424] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
[   71.210438] uhci_hcd 0000:00:10.3: UHCI Host Controller
[   71.210463] uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
[   71.210487] uhci_hcd 0000:00:10.3: irq 21, io base 0x0000c800
[   71.210606] usb usb4: configuration #1 chosen from 1 choice
[   71.210631] hub 4-0:1.0: USB hub found
[   71.210639] hub 4-0:1.0: 2 ports detected
[   71.314524] ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
[   71.316772] Audigy2 value: Special config.
[   71.329677] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
[   71.330044] ehci_hcd 0000:00:10.4: EHCI Host Controller
[   71.330104] ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
[   71.330152] ehci_hcd 0000:00:10.4: irq 21, io mem 0xfdf00000
[   71.338231] ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   71.338350] usb usb5: configuration #1 chosen from 1 choice
[   71.338377] hub 5-0:1.0: USB hub found
[   71.338387] hub 5-0:1.0: 8 ports detected
[   73.047330] Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
[   73.047334] Copyright (c) 1999-2006 Intel Corporation.
[   73.047376] ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
[   73.047381] PCI: Disallowing DAC for device 0000:00:0e.0
[   73.307233] e1000: 0000:00:0e.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:62:c5:46
[   73.482707] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[   73.641789] ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
[   73.641802] ReiserFS: hdb1: using ordered data mode
[   73.677157] ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   73.678508] ReiserFS: hdb1: checking transaction log (hdb1)
[   73.795920] ReiserFS: hdb1: Using r5 hash to sort names
[   73.842916] ReiserFS: hda2: found reiserfs format "3.6" with standard journal
[   73.842927] ReiserFS: hda2: using ordered data mode
[   73.847744] ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   73.849101] ReiserFS: hda2: checking transaction log (hda2)
[   73.903713] ReiserFS: hda2: Using r5 hash to sort names

--------------090009030801000401080701--
