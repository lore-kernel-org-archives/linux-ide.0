From: Thomas Evans <evans02472@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Fri, 25 Jan 2008 12:28:40 -0500
Message-ID: <479A1C48.1070209@gmail.com>
References: <4794459C.3090200@gmail.com> <4796DC44.6010100@gmail.com>	 <864c1e490801231622n806b465g88a3f0448b5d8f29@mail.gmail.com>	 <4797ECF3.5000306@gmail.com>	 <864c1e490801231823v3e9cf61ds2a0d553ed5b61fb2@mail.gmail.com>	 <4797F8D0.6060302@gmail.com>	 <864c1e490801231939k6008bc95tf40565a8ef6f430d@mail.gmail.com>	 <47980B71.3000408@gmail.com>	 <864c1e490801240707x31ff53b1s3d72032968e1bcbc@mail.gmail.com>	 <4798AA88.5080107@gmail.com> <864c1e490801240840q5423a1beuf9b4b3a43416db2b@mail.gmail.com> <4798C617.10601@gmail.com> <4798CA71.20707@gmail.com> <4798CC90.4040707@gmail.com> <4798CCDF.9070305@gmail.com> <4798CE10.2050005@gmail.com> <4798D4A2.7030303@gmail.com> <47991AD9.6050804@gmail.com> <47993686.5040405@gmail.com> <479939E3.4020307@gmail.com> <47997BD3.2060100@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060101050005050503040605"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:13099 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbYAYR2t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jan 2008 12:28:49 -0500
Received: by wr-out-0506.google.com with SMTP id c49so459991wra.1
        for <linux-ide@vger.kernel.org>; Fri, 25 Jan 2008 09:28:48 -0800 (PST)
In-Reply-To: <47997BD3.2060100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jay.Estabrook@hp.com
Cc: evans02472@gmail.com

This is a multi-part message in MIME format.
--------------060101050005050503040605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

added some more printk's based on what I saw -
maybe some issue with the dma port?

...tom


Thomas Evans wrote:
> Tejun (and all) -
>
> I've attached a log from my machine marked up with a few extra printk's.
> I did add the ssleep() you suggested off line - made no difference.
>
> I'll be happy to add more prinks in places that I did not ...


--------------060101050005050503040605
Content-Type: text/plain;
 name="dmesg-alpha-tpe2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-alpha-tpe2"

kobject sata_sil24: registering. parent: <NULL>, set: module
kobject holders: registering. parent: sata_sil24, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject_uevent_env
fill_kobj_path: path = '/module/sata_sil24'
kobject notes: registering. parent: sata_sil24, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
bus pci: add driver sata_sil24
kobject sata_sil24: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/pci/drivers/sata_sil24'
pci: Matched Device 0000:00:07.0 with Driver sata_sil24
pci: Probing driver sata_sil24 with device 0000:00:07.0
sata_sil24 0000:00:07.0: version 1.1
sata_sil24 0000:00:07.0: init_one ->pcim_enable_device
sata_sil24 0000:00:07.0: init_one ->pcim_iomap_regions
sata_sil24 0000:00:07.0: init_one ->pcim_iomap_regions
sata_sil24 0000:00:07.0: init_one -> IRQ-loss PCI-X Errata.
sata_sil24 0000:00:07.0: readl(iomap[SIL24_HOST_BAR] + HOST_CTRL) = 0110000F
sata_sil24 0000:00:07.0: Clearing completion IRQ loss on PCI-X errata fix
sata_sil24 0000:00:07.0: init_one -> allocate and fill host
ata4294967295: init_one
ata4294967295: init_one
ata4294967295: init_one
ata4294967295: init_one
sata_sil24 0000:00:07.0: init_one -> setting 64 bit DMA
sata_sil24 0000:00:07.0: init_one -> sil24_init_controller
ata4294967295: sil24_config_port - STD WOC
ata4294967295: sil24_config_port - STD WOC
ata4294967295: sil24_config_port - STD WOC
ata4294967295: sil24_config_port - STD WOC
sata_sil24 0000:00:07.0: init_one -> setting master
PCI: Enabling bus mastering for device 0000:00:07.0
sata_sil24 0000:00:07.0: init_one -> ata_host_activate
scsi54 : sata_sil24
DEV: registering device: ID = 'host54'
kobject host54: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host54'
kobject host54: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host54'
class_uevent - name = host54
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host54'
scsi55 : sata_sil24
DEV: registering device: ID = 'host55'
kobject host55: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host55'
kobject host55: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host55'
class_uevent - name = host55
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host55'
scsi56 : sata_sil24
DEV: registering device: ID = 'host56'
kobject host56: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host56'
kobject host56: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host56'
class_uevent - name = host56
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host56'
scsi57 : sata_sil24
DEV: registering device: ID = 'host57'
kobject host57: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host57'
kobject host57: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host57'
class_uevent - name = host57
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host57'
ata5: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa0000 irq 31
ata6: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa2000 irq 31
ata7: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa4000 irq 31
ata8: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa6000 irq 31
ata5: sil24_init_port - no PMP?
ata5: ata_eh_recover - 1
ata5: ata_eh_recover - 2 re-enable link?
ata5.00: ata_eh_recover - 3
ata5.00: ata_eh_recover - 5
ata5.00: ata_eh_recover - 6
ata5.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata5: ata_eh_recover - 8a prep for EH
ata5: ata_eh_recover - reset
ata5: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata5: ata_eh_recover -> ata_eh_reset

ata5: hard resetting link
ata5: hardreset - 1!
ata5: hardreset - 2!
ata5: hardreset - 3!
ata5: hardreset - 4!
ata5: hardreset - 4a!
ata5: hardreset - 5!
ata5: hardreset - 6!
ata5: hardreset - 7 - ret -EAGAIN!
ata5: PHYS - something is attached.
ata5: sil24_init_port - no PMP?
ata5: sil24_exec_polled_cmd irq_enabled = 00000000
ata5: sil24_exec_polled_cmd paddr  HI:00000000  LO:81A00000
ata5: sil24_exec_polled_cmd irq_stat = 00B60000
ata5: sil24_exec_polled_cmd cleared IRQs
ata5: sil24_exec_polled_cmd forcing port into known state.
ata5: sil24_init_port - no PMP?
ata5: sil24_exec_polled_cmd sil24_init_port = -EIO (port IRQ error)
ata5: softreset failed (SRST command error) (-5)
ata5: reset failed (errno=-5), retrying in 7 secs
ata5: hard resetting link
ata5: hardreset - 1!
ata5: hardreset - 2!
ata5: hardreset - 3!
ata5: hardreset - 4!
ata5: hardreset - 4a!
ata5: hardreset - 5!
ata5: hardreset - 6!
ata5: hardreset - 7 - ret -EAGAIN!
ata5: PHYS - something is attached.
ata5: sil24_init_port - no PMP?
ata5: sil24_exec_polled_cmd irq_enabled = 00000000
ata5: sil24_exec_polled_cmd paddr  HI:00000000  LO:81A00000
ata5: sil24_exec_polled_cmd irq_stat = 00B60000
ata5: sil24_exec_polled_cmd cleared IRQs
ata5: sil24_exec_polled_cmd forcing port into known state.
ata5: sil24_init_port - no PMP?
ata5: sil24_exec_polled_cmd sil24_init_port = -EIO (port IRQ error)
ata5: softreset failed (SRST command error) (-5)
ata5: reset failed (errno=-5), retrying in 7 secs
ata5: hard resetting link
ata5: hardreset - 1!
ata5: hardreset - 2!
ata5: hardreset - 3!
ata5: hardreset - 4!
ata5: hardreset - 4a!
ata5: hardreset - 5!
ata5: hardreset - 6!
ata5: hardreset - 7 - ret -EAGAIN!
ata5: PHYS - something is attached.
ata5: sil24_init_port - no PMP?
ata5: sil24_exec_polled_cmd irq_enabled = 00000000
ata5: sil24_exec_polled_cmd paddr  HI:00000000  LO:81A00000
ata5: sil24_exec_polled_cmd irq_stat = 00B60000
ata5: sil24_exec_polled_cmd cleared IRQs
ata5: sil24_exec_polled_cmd forcing port into known state.
ata5: sil24_init_port - no PMP?
ata5: sil24_exec_polled_cmd sil24_init_port = -EIO (port IRQ error)
ata5: softreset failed (SRST command error) (-5)
ata5: reset failed (errno=-5), retrying in 32 secs
ata5: hard resetting link
ata5: hardreset - 1!
ata5: hardreset - 2!
ata5: hardreset - 3!
ata5: hardreset - 4!
ata5: hardreset - 4a!
ata5: hardreset - 5!
ata5: hardreset - 6!
ata5: hardreset - 7 - ret -EAGAIN!
ata5: PHYS - something is attached.
ata5: sil24_init_port - no PMP?
ata5: sil24_exec_polled_cmd irq_enabled = 00000000
ata5: sil24_exec_polled_cmd paddr  HI:00000000  LO:81A00000
ata5: sil24_exec_polled_cmd irq_stat = 00B60000
ata5: sil24_exec_polled_cmd cleared IRQs
ata5: sil24_exec_polled_cmd forcing port into known state.
ata5: sil24_init_port - no PMP?
ata5: sil24_exec_polled_cmd sil24_init_port = -EIO (port IRQ error)
ata5: softreset failed (SRST command error) (-5)
ata5: reset failed, giving up
ata6: sil24_init_port - no PMP?
ata6: ata_eh_recover - 1
ata6: ata_eh_recover - 2 re-enable link?
ata6.00: ata_eh_recover - 3
ata6.00: ata_eh_recover - 5
ata6.00: ata_eh_recover - 6
ata6.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata6: ata_eh_recover - 8a prep for EH
ata6: ata_eh_recover - reset
ata6: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata6: ata_eh_recover -> ata_eh_reset

ata6: hard resetting link
ata6: hardreset - 1!
ata6: hardreset - 2!
ata6: hardreset - 3!
ata6: hardreset - 4!
ata6: hardreset - 4a!
ata6: hardreset - 5!
ata6: hardreset - 6!
ata6: hardreset - 7 - ret -EAGAIN!
ata6: PHYS - no device
ata6: SATA link down (SStatus 0 SControl 0)
ata6: ata_eh_recover -> thawing

ata6: ata_eh_recover -> revalidate_and_attach
ata_eh_recover -> link okay?!
ata7: sil24_init_port - no PMP?
ata7: ata_eh_recover - 1
ata7: ata_eh_recover - 2 re-enable link?
ata7.00: ata_eh_recover - 3
ata7.00: ata_eh_recover - 5
ata7.00: ata_eh_recover - 6
ata7.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata7: ata_eh_recover - 8a prep for EH
ata7: ata_eh_recover - reset
ata7: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata7: ata_eh_recover -> ata_eh_reset

ata7: hard resetting link
ata7: hardreset - 1!
ata7: hardreset - 2!
ata7: hardreset - 3!
ata7: hardreset - 4!
ata7: hardreset - 4a!
ata7: hardreset - 5!
ata7: hardreset - 6!
ata7: hardreset - 7 - ret -EAGAIN!
ata7: PHYS - no device
ata7: SATA link down (SStatus 0 SControl 0)
ata7: ata_eh_recover -> thawing

ata7: ata_eh_recover -> revalidate_and_attach
ata_eh_recover -> link okay?!
ata8: sil24_init_port - no PMP?
ata8: ata_eh_recover - 1
ata8: ata_eh_recover - 2 re-enable link?
ata8.00: ata_eh_recover - 3
ata8.00: ata_eh_recover - 5
ata8.00: ata_eh_recover - 6
ata8.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata8: ata_eh_recover - 8a prep for EH
ata8: ata_eh_recover - reset
ata8: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata8: ata_eh_recover -> ata_eh_reset

ata8: hard resetting link
ata8: hardreset - 1!
ata8: hardreset - 2!
ata8: hardreset - 3!
ata8: hardreset - 4!
ata8: hardreset - 4a!
ata8: hardreset - 5!
ata8: hardreset - 6!
ata8: hardreset - 7 - ret -EAGAIN!
ata8: PHYS - no device
ata8: SATA link down (SStatus 0 SControl 0)
ata8: ata_eh_recover -> thawing

ata8: ata_eh_recover -> revalidate_and_attach
ata_eh_recover -> link okay?!
bound device '0000:00:07.0' to driver 'sata_sil24'
pci: Bound Device 0000:00:07.0 to Driver sata_sil24
kobject drivers: registering. parent: sata_sil24, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
ata5: sil24_init_port - no PMP?
ata5: ata_eh_recover - 1
ata5: ata_eh_recover - 2 re-enable link?
ata5.00: ata_eh_recover - 3
ata5.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata5: ata_eh_recover - 8a prep for EH
ata5: ata_eh_recover - no reset
ata5: ata_eh_recover - ATA_DEV_UNKNOWN
ata6: sil24_init_port - no PMP?
ata6: ata_eh_recover - 1
ata6: ata_eh_recover - 2 re-enable link?
ata6.00: ata_eh_recover - 3
ata6.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata6: ata_eh_recover - 8a prep for EH
ata6: ata_eh_recover - no reset
ata6: ata_eh_recover - ATA_DEV_UNKNOWN
ata6: ata_eh_recover -> revalidate_and_attach
ata6: attemping to enable power management!
ata_eh_recover -> link okay?!
ata7: sil24_init_port - no PMP?
ata7: ata_eh_recover - 1
ata7: ata_eh_recover - 2 re-enable link?
ata7.00: ata_eh_recover - 3
ata7.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata7: ata_eh_recover - 8a prep for EH
ata7: ata_eh_recover - no reset
ata7: ata_eh_recover - ATA_DEV_UNKNOWN
ata7: ata_eh_recover -> revalidate_and_attach
ata7: attemping to enable power management!
ata_eh_recover -> link okay?!
ata8: sil24_init_port - no PMP?
ata8: ata_eh_recover - 1
ata8: ata_eh_recover - 2 re-enable link?
ata8.00: ata_eh_recover - 3
ata8.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata8: ata_eh_recover - 8a prep for EH
ata8: ata_eh_recover - no reset
ata8: ata_eh_recover - ATA_DEV_UNKNOWN
ata8: ata_eh_recover -> revalidate_and_attach
ata8: attemping to enable power management!
ata_eh_recover -> link okay?!
ata5: ata_eh_recover -> revalidate_and_attach
ata5: attemping to enable power management!
ata_eh_recover -> link okay?!



0000:00:05.0 ISA bridge [0601]: Contaq Microsystems 82c693 [1080:c693]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 80 10 93 c6 07 00 80 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:05.1 IDE interface [0101]: Contaq Microsystems 82c693 [1080:c693] (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 14
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4 [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: I/O ports at 9000 [size=16]
00: 80 10 93 c6 05 00 80 02 00 80 01 01 00 00 80 00
10: f1 01 00 00 f5 03 00 00 00 00 00 00 00 00 00 00
20: 01 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0e 01 00 00

0000:00:05.2 IDE interface [0101]: Contaq Microsystems 82c693 [1080:c693] (prog-if 00 [])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 15
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4 [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: Memory at 09a80000 (32-bit, non-prefetchable) [disabled] [size=64K]
00: 80 10 93 c6 05 00 80 02 00 00 01 01 00 00 80 00
10: 71 01 00 00 75 03 00 00 00 00 00 00 00 00 00 00
20: 00 00 a8 09 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0f 02 00 00

0000:00:05.3 USB Controller [0c03]: Contaq Microsystems 82c693 [1080:c693] (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 09aa8000 (32-bit, non-prefetchable) [size=4K]
00: 80 10 93 c6 07 00 80 02 00 10 03 0c 08 f8 80 00
10: 00 80 aa 09 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

0000:00:07.0 Mass storage controller [0180]: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller [1095:3124] (rev 02)
	Subsystem: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller [1095:3124]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 240, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 31
	Region 0: Memory at 09aa9000 (64-bit, non-prefetchable) [size=128]
	Region 2: Memory at 09aa0000 (64-bit, non-prefetchable) [size=32K]
	Region 4: I/O ports at 9010 [size=16]
	Expansion ROM at 09a00000 [disabled] [size=512K]
	Capabilities: [64] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO+ RBC=512 OST=12
		Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=12 DMCRS=128 RSCEM- 266MHz- 533MHz-
	Capabilities: [54] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
00: 95 10 24 31 87 00 b0 82 02 00 80 01 10 f0 00 00
10: 04 90 aa 09 00 00 00 00 04 00 aa 09 00 00 00 00
20: 11 90 00 00 00 00 00 00 00 00 00 00 95 10 24 31
30: 00 00 90 01 64 00 00 00 00 00 00 00 1f 01 00 00

0000:00:08.0 PCI bridge [0604]: Digital Equipment Corporation DECchip 21152 [1011:0024] (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=255
	I/O behind bridge: 00008000-00008fff
	Memory behind bridge: 09800000-098fffff
	Prefetchable memory behind bridge: 0000000009900000-00000000099fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
00: 11 10 24 00 07 00 90 02 03 00 04 06 10 ff 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 ff 81 81 80 02
20: 80 09 80 09 91 09 91 09 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 03 00

0000:00:09.0 VGA compatible controller [0300]: S3 Inc. 86c764/765 [Trio32/64/64V+] [5333:8811] (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at 09000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at 09a90000 [disabled] [size=64K]
00: 33 53 11 88 03 00 00 02 00 00 00 03 00 00 00 00
10: 00 00 00 09 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 99 01 00 00 00 00 00 00 00 00 17 01 00 00

0000:01:00.0 SCSI storage controller [0100]: LSI Logic / Symbios Logic 53c875 [1000:000f] (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (4250ns min, 16000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 27
	Region 0: I/O ports at 8000 [size=256]
	Region 1: Memory at 09802000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at 09800000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 09940000 [disabled] [size=64K]
00: 00 10 0f 00 17 00 00 02 04 00 00 01 10 ff 00 00
10: 01 80 00 00 00 20 80 09 00 00 80 09 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 84 01 00 00 00 00 00 00 00 00 1b 01 11 40

0000:01:01.0 SCSI storage controller [0100]: LSI Logic / Symbios Logic 53c875 [1000:000f] (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (4250ns min, 16000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 26
	Region 0: I/O ports at 8400 [size=256]
	Region 1: Memory at 09803000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at 09801000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 09950000 [disabled] [size=64K]
00: 00 10 0f 00 17 00 00 02 04 00 00 01 10 ff 00 00
10: 01 84 00 00 00 30 80 09 00 10 80 09 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 85 01 00 00 00 00 00 00 00 00 1a 01 11 40

0000:01:02.0 Ethernet controller [0200]: Digital Equipment Corporation DECchip 21140 [FasterNet] [1011:0009] (rev 22)
	Subsystem: Digital Equipment Corporation Unknown device [1011:500a]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (5000ns min, 10000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 25
	Region 0: I/O ports at 8800 [size=128]
	Region 1: Memory at 09804000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 09900000 [disabled] [size=256K]
00: 11 10 09 00 07 00 80 02 22 00 00 02 10 ff 00 00
10: 01 88 00 00 00 40 80 09 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 10 0a 50
30: 00 00 80 01 00 00 00 00 00 00 00 00 19 01 14 28

0001:02:08.0 RAID bus controller [0104]: VIA Technologies, Inc. VT6421 IDE RAID Controller [1106:3249] (rev 50)
	Subsystem: VIA Technologies, Inc. VT6421 IDE RAID Controller [1106:3249]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 240
	Interrupt: pin A routed to IRQ 43
	Region 0: I/O ports at 200008820 [size=16]
	Region 1: I/O ports at 200008830 [size=16]
	Region 2: I/O ports at 200008840 [size=16]
	Region 3: I/O ports at 200008850 [size=16]
	Region 4: I/O ports at 200008800 [size=32]
	Region 5: I/O ports at 200008000 [size=256]
	Expansion ROM at 209000000 [disabled] [size=64K]
	Capabilities: [e0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 49 32 07 00 90 02 50 00 04 01 00 f0 00 00
10: 21 88 00 00 31 88 00 00 41 88 00 00 51 88 00 00
20: 01 88 00 00 01 80 00 00 00 00 00 00 06 11 49 32
30: 00 00 00 01 e0 00 00 00 00 00 00 00 2b 01 00 00

0001:02:09.0 Ethernet controller [0200]: VIA Technologies, Inc. VT6120/VT6121/VT6122 Gigabit Ethernet Adapter [1106:3119] (rev 01)
	Subsystem: ZyXEL Communication Corporation Unknown device [187e:3302]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 39
	Region 0: I/O ports at 200008400 [size=256]
	Region 1: Memory at 209010000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D3 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 19 31 03 00 30 02 01 00 00 02 10 f8 00 00
10: 01 84 00 00 00 00 01 09 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 7e 18 02 33
30: 00 00 00 00 50 00 00 00 00 00 00 00 27 01 03 08


--------------060101050005050503040605--
