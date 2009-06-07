From: Raz <raziebe@gmail.com>
Subject: Re: Can Promise corrupt ?
Date: Sun, 7 Jun 2009 22:04:32 +0300
Message-ID: <5d96567b0906071204g1f409922u79e40f63ed850b3f@mail.gmail.com>
References: <1243282523.6337.4.camel@raz> <85ABFDC4641C4847BA6088F2982EFD8F025FD0AD@nonamew.ptu.promise.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:52300 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244AbZFGTEw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jun 2009 15:04:52 -0400
Received: by bwz9 with SMTP id 9so2612688bwz.37
        for <linux-ide@vger.kernel.org>; Sun, 07 Jun 2009 12:04:52 -0700 (PDT)
In-Reply-To: <85ABFDC4641C4847BA6088F2982EFD8F025FD0AD@nonamew.ptu.promise.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ed Lin - PTU <ed.lin@promise.com>
Cc: Promise_Linux <Promise_Linux@promise.com>, linux-ide@vger.kernel.org

thank you Ed for your reply.
How do I get the firmware log ? How do I get the driver's log ?
/var/log/messages supplied nothing but these cli messages.


2009/6/6 Ed Lin - PTU <ed.lin@promise.com>:
> Hello Raz,
>
> Below is the reply from firmware maintain engineer.

> Basically it will help us to diagnose the problem if you have firmware log.
>
> Also it may be better to update firmware if possible, since you are using
> old firmware. We have updates and fixes in newer firmware. You can find
> the SR2.2 firmware update(1.3.0.37 ) at the download section of Promise
> web site. You may also check the update for other components(BIOS,
> driver etc.)
>
> The links are here, please check.
> http://www.promise.com/support/download/download2_eng.asp?productId=156&category=all&os=100&go=GO
> http://www.promise.com/upload/Support/Firmware/SuperTrak_EX_SATA_Series_Firmware_SR2.2.zip
>
> Thanks,
> Ed Lin
>
>
>>       From customer explain, it seem both port 3 and port 8 happened
>>unplug although port 8 plugged in later, that cause linux soft raid5
>>offline. But why port 3 and port 8 unplugged happened, there maybe many
>>reason, we need Shasta event log, if we can get firmware log,
>>it's better to
>>judge the reason.
>>       By the way, customer is using very old firmware. The
>>latest version
>>of channel firmware is B1.6.70.38.
>>
>
>
>
>
>
>
>
>>-----Original Message-----
>>From: raz ben yehuda [mailto:raziebe@gmail.com]
>>Sent: 2009年5月25日 13:15
>>To: Ed Lin - PTU
>>Cc: Promise_Linux; linux-ide@vger.kernel.org
>>Subject: Can Promise corrupt ?
>>
>>
>>Ed Hello
>>First thank for your help. ( "invalid tag..." ,I am still invistigating
>>this matter).
>>One of my system is composed from a software linux raid055 as follows.
>>raid0:   md3
>>raid5:  md1 md2.
>>I am using 2.6.17,disks are JBOD in two promise cards ( 8350 ). 8
>>logical drives in each card.
>>After over 2 years, md1 went degraded due to an IO error. After
>>rebuilding , the raid550 file system was corrupted.
>>Log is a bit messy because of the problematic disk naming of kernel vs
>>udev.
>>
>>I am not sure this is a linux problem because:
>>
>>1) BIOS version is different in each card. while both cards left the
>>factory as bios version 2.9.0.22.
>>       How can that be ?
>>
>>2) One of the Luns changed its SCSI address from 6 to 7. I'll explain:
>>    sdg was the disk the went down. its address was :0:0:6:0. and it's
>>position in the raid was 6.
>>    after a reboot, the user defines a logical jbod over the
>>new disk.so
>>sdg is not the sdg anymore but sdp.
>>   so we should be getting raid mapping:  0 1 2 3 4 5 7.
>>   but raid was: 0 1 2 3 4 5 6
>>   scsi address 0:0:6:0 decided to be disk raid number 7 while scsi
>>address 0:0:7:0 decided to be disk raid 6.
>>   This situation caused my system to rebuild badly and it is entirely
>>corrupted.
>>   The way only was for this to happen is if IOs for disk 6 were
>>directed to disk 7, and one of these IOs was
>>   the raid5's superblock with raid disk number 6 on it.
>>
>>   Is there a known issue with two promise cards in JBOD in these
>>firmwares ?
>>
>>3) For some unknown reason, while hot-removing sdg the linux
>>raid, I got
>>these messages:
>>    Feb 18 08:14:45 bbg11pd11 cli: [1031] Battery cannot be detected
>>    Feb 18 08:14:45 bbg11pd11 cli: [257] Disk 3 unplugged
>>    Feb 18 08:14:45 bbg11pd11 cli: [512] Logical drive "JBOD on port 03
>>(00)" goes offline
>>    Feb 18 08:14:45 bbg11pd11 cli: [257] Disk 8 unplugged
>>    Feb 18 08:14:45 bbg11pd11 cli: [512] Logical drive "JBOD on port 08
>>(00)" goes offline
>>    Feb 18 08:14:45 bbg11pd11 cli: [256] Disk 8 plugged in
>>    Feb 18 08:14:45 bbg11pd11 cli: [1031] Battery cannot be detected
>>    Feb 18 08:14:45 bbg11pd11 [5970186.214000] md: unbind<sdg1>
>><-- we hot removed 0:0:6:0 from raid.
>>    Feb 18 08:14:45 bbg11pd11 [5970186.221000] md: export_rdev(sdg1)
>>
>>   3.1) disk 8 is 0:0:7:0 , why did it decide to remove ?
>>   3.2) disk 3 was never in degradation.
>>
>># ===================== File: /proc/mdstat =====================
>>Personalities : [raid5] [raid4] [raid1] [raid0]
>>md3 : active raid0 md1[0] md2[1]
>>      6823647232 blocks 1024k chunks
>>
>>md2 : active raid5 sdh1[0] sdo1[7] sdn1[6] sdm1[5] sdl1[4] sdk1[3]
>>sdj1[2] sdi1[1]
>>      3418684416 blocks level 5, 1024k chunk, algorithm 2 [8/8]
>>[UUUUUUUU]
>>
>>md1 : active raid5 sdp1[7] sda2[0] sdg1[6] sdf1[5] sde1[4] sdd1[3]
>>sdc1[2] sdb2[1]
>>      3404964864 blocks level 5, 1024k chunk, algorithm 2 [8/8]
>>[UUUUUUUU]     <--- sdp kernel name for sdg, mapping 0:0:6:0. so
>>  it should be getting id [6] and sdg is id [7] not [6].
>>
>>md0 : active raid1 sda1[0] sdb1[1]
>>      1959808 blocks [2/2] [UU]
>>
>>unused devices: <none>
>>
>>
>>
>>
>>System information is in XXXXX :
>>
>>
>>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
>>XXXXXXXXXXXXXXXXXXXXXXXXXXX
>>lshw output:
>>
>>bbg11pd11
>>    description: System
>>    product: empty
>>    vendor: empty
>>    version: empty
>>    serial: empty
>>    width: 32 bits
>>    capabilities: smbios-2.34 dmi-2.34
>>    configuration: boot=oem-specific chassis=server
>>  *-core
>>       description: Motherboard
>>       product: S2892
>>       vendor: TYAN Computer Corporation
>>       physical id: 1
>>       version: empty
>>       serial: empty
>>       slot: 8
>>     *-firmware
>>          description: BIOS
>>          vendor: Phoenix Technologies Ltd.
>>          physical id: 0
>>          version: 2003Q2 (12/04/2006)
>>          size: 104KB
>>          capacity: 960KB
>>          capabilities: pci pnp upgrade shadowing escd cdboot
>>bootselect
>>edd int13floppy360 int13floppy1200 int13floppy720 int13floppy2880
>>int5printscreen int9keyboard int14serial int17printer int10video acpi
>>usb
>>     *-cpu:0
>>          description: CPU
>>          product: AMD Opteron(tm) Processor 248
>>          vendor: Advanced Micro Devices [AMD]
>>          physical id: 4
>>          bus info: cpu@0
>>          version: 15.5.1
>>          slot: CPU0-Socket 940
>>          size: 2200MHz
>>          capacity: 3GHz
>>          width: 64 bits
>>          clock: 200MHz
>>          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce
>>cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2
>>syscall nx mmxext fxsr_opt x86-64 3dnowext 3dnow pni lahf_lm ts fid vid
>>ttp
>>        *-cache:0
>>             description: L1 cache
>>             physical id: 6
>>             slot: H0 L1 Cache
>>             size: 128KB
>>             capabilities: asynchronous internal write-back
>>        *-cache:1
>>             description: L2 cache
>>             physical id: 7
>>             slot: H0 L2 Cache
>>             size: 1MB
>>             capacity: 1MB
>>             capabilities: synchronous internal write-through unified
>>     *-cpu:1
>>          description: CPU
>>          product: AMD Opteron(tm) Processor 248
>>          vendor: Advanced Micro Devices [AMD]
>>          physical id: 5
>>          bus info: cpu@1
>>          version: 15.5.1
>>          slot: CPU1-Socket 940
>>          size: 2200MHz
>>          capacity: 3GHz
>>          width: 64 bits
>>          clock: 200MHz
>>          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce
>>cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2
>>syscall nx mmxext fxsr_opt x86-64 3dnowext 3dnow pni lahf_lm ts fid vid
>>ttp
>>        *-cache:0
>>             description: L1 cache
>>             physical id: 8
>>             slot: H1 L1 Cache
>>             size: 128KB
>>             capabilities: asynchronous internal write-back
>>        *-cache:1
>>             description: L2 cache
>>             physical id: 9
>>             slot: H1 L2 Cache
>>             size: 1MB
>>             capacity: 1MB
>>             capabilities: synchronous internal write-through unified
>>     *-memory:0
>>          description: System Memory
>>          physical id: 3
>>          slot: System board or motherboard
>>          size: 4GB
>>        *-bank:0
>>             description: DIMM DRAM Synchronous
>>             physical id: 0
>>             slot: C0_DIMM0
>>             size: 1GB
>>             width: 64 bits
>>        *-bank:1
>>             description: DIMM DRAM Synchronous
>>             physical id: 1
>>             slot: C0_DIMM1
>>             size: 1GB
>>             width: 64 bits
>>        *-bank:2
>>             description: DIMM DRAM [empty]
>>             physical id: 2
>>             slot: C0_DIMM2
>>        *-bank:3
>>             description: DIMM DRAM [empty]
>>             physical id: 3
>>             slot: C0_DIMM3
>>        *-bank:4
>>             description: DIMM DRAM Synchronous
>>             physical id: 4
>>             slot: C0_DIMM0
>>             size: 1GB
>>             width: 64 bits
>>        *-bank:5
>>             description: DIMM DRAM Synchronous
>>             physical id: 5
>>             slot: C1_DIMM1
>>             size: 1GB
>>             width: 64 bits
>>        *-bank:6
>>             description: DIMM DRAM [empty]
>>             physical id: 6
>>             slot: C1_DIMM2
>>        *-bank:7
>>             description: DIMM DRAM [empty]
>>             physical id: 7
>>             slot: C1_DIMM3
>>     *-memory:1 UNCLAIMED
>>          description: Memory controller
>>          product: CK804 Memory Controller
>>          vendor: nVidia Corporation
>>          physical id: 7
>>          bus info: pci@0000:00:00.0
>>          version: a3
>>          width: 32 bits
>>          clock: 66MHz (15.2ns)
>>          capabilities: ht bus_master cap_list
>>          configuration: latency=0
>>     *-isa
>>          description: ISA bridge
>>          product: CK804 ISA Bridge
>>          vendor: nVidia Corporation
>>          physical id: 1
>>          bus info: pci@0000:00:01.0
>>          version: a3
>>          width: 32 bits
>>          clock: 66MHz
>>          capabilities: isa bus_master
>>          configuration: latency=0
>>     *-serial
>>          description: SMBus
>>          product: CK804 SMBus
>>          vendor: nVidia Corporation
>>          physical id: 1.1
>>          bus info: pci@0000:00:01.1
>>          version: a2
>>          width: 32 bits
>>          clock: 66MHz
>>          capabilities: pm cap_list
>>          configuration: driver=nForce2_smbus latency=0 maxlatency=1
>>mingnt=3 module=i2c_nforce2
>>     *-usb UNCLAIMED
>>          description: USB Controller
>>          product: CK804 USB Controller
>>          vendor: nVidia Corporation
>>          physical id: 2
>>          bus info: pci@0000:00:02.0
>>          version: a2
>>          width: 32 bits
>>          clock: 66MHz
>>          capabilities: pm ohci bus_master cap_list
>>          configuration: latency=0 maxlatency=1 mingnt=3
>>     *-ide UNCLAIMED
>>          description: IDE interface
>>          product: CK804 IDE
>>          vendor: nVidia Corporation
>>          physical id: 6
>>          bus info: pci@0000:00:06.0
>>          version: f2
>>          width: 32 bits
>>          clock: 66MHz
>>          capabilities: ide pm bus_master cap_list
>>          configuration: latency=0 maxlatency=1 mingnt=3
>>     *-pci:0
>>          description: PCI bridge
>>          product: CK804 PCI Bridge
>>          vendor: nVidia Corporation
>>          physical id: 9
>>          bus info: pci@0000:00:09.0
>>          version: a2
>>          width: 32 bits
>>          clock: 66MHz
>>          capabilities: pci subtractive_decode bus_master
>>        *-display
>>             description: VGA compatible controller
>>             product: Rage XL
>>             vendor: ATI Technologies Inc
>>             physical id: 6
>>             bus info: pci@0000:01:06.0
>>             version: 27
>>             width: 32 bits
>>             clock: 33MHz
>>             capabilities: pm vga bus_master cap_list
>>             configuration: latency=66 mingnt=8
>>        *-network UNCLAIMED
>>             description: Ethernet controller
>>             product: 82557/8/9 [Ethernet Pro 100]
>>             vendor: Intel Corporation
>>             physical id: 8
>>             bus info: pci@0000:01:08.0
>>             version: 10
>>             width: 32 bits
>>             clock: 33MHz
>>             capabilities: pm bus_master cap_list
>>             configuration: latency=66 maxlatency=56 mingnt=8
>>     *-pci:1
>>          description: PCI bridge
>>          product: CK804 PCIE Bridge
>>          vendor: nVidia Corporation
>>          physical id: 100
>>          bus info: pci@0000:00:0d.0
>>          version: a3
>>          width: 32 bits
>>          clock: 33MHz
>>          capabilities: pci pm msi ht pciexpress normal_decode
>>bus_master cap_list
>>          configuration: driver=pcieport-driver
>>        *-pci:0
>>             description: PCI bridge
>>             product: 80333 Segment-A PCI Express-to-PCI Express Bridge
>>             vendor: Intel Corporation
>>             physical id: 0
>>             bus info: pci@0000:02:00.0
>>             version: 00
>>             width: 32 bits
>>             clock: 33MHz
>>             capabilities: pci pciexpress msi pm pcix normal_decode
>>bus_master cap_list
>>           *-storage
>>                description: RAID bus controller
>>                product: 80333 [SuperTrak EX8350/EX16350], 80331
>>[SuperTrak EX8300/EX16300]
>>                vendor: Promise Technology, Inc.
>>                physical id: e
>>                bus info: pci@0000:03:0e.0
>>                logical name: scsi0
>>                version: 00
>>                width: 32 bits
>>                clock: 66MHz
>>                capabilities: storage pm msi pcix bus_master cap_list
>>scsi-host
>>                configuration: driver=stex latency=160 mingnt=144
>>module=stex
>>              *-disk:0
>>                   description: SCSI Disk
>>                   product: 1+0 JBOD
>>                   vendor: Promise
>>                   physical id: 0.0.0
>>                   bus info: scsi@0:0.0.0
>>                   logical name: /dev/sda
>>                   version: 1.10
>>                   size: 465GB
>>                   capabilities: partitioned partitioned:dos
>>                   configuration: ansiversion=2
>>                 *-volume:0
>>                      description: Linux raid autodetect partition
>>                      physical id: 1
>>                      bus info: scsi@0:0.0.0,1
>>                      logical name: /dev/sda1
>>                      capacity: 1913MB
>>                      capabilities: primary multi
>>                 *-volume:1
>>                      description: Linux raid autodetect partition
>>                      physical id: 2
>>                      bus info: scsi@0:0.0.0,2
>>                      logical name: /dev/sda2
>>                      capacity: 463GB
>>                      capabilities: primary multi
>>              *-disk:1
>>                   description: SCSI Disk
>>                   product: 1+0 JBOD
>>                   vendor: Promise
>>                   physical id: 0.1.0
>>                   bus info: scsi@0:0.1.0
>>                   logical name: /dev/sdb
>>                   version: 1.10
>>                   size: 465GB
>>                   capabilities: partitioned partitioned:dos
>>                   configuration: ansiversion=2
>>                 *-volume:0
>>                      description: Linux raid autodetect partition
>>                      physical id: 1
>>                      bus info: scsi@0:0.1.0,1
>>                      logical name: /dev/sdb1
>>                      capacity: 1913MB
>>                      capabilities: primary multi
>>                 *-volume:1
>>                      description: Linux raid autodetect partition
>>                      physical id: 2
>>                      bus info: scsi@0:0.1.0,2
>>                      logical name: /dev/sdb2
>>                      capacity: 463GB
>>                      capabilities: primary multi
>>              *-disk:2
>>                   description: SCSI Disk
>>                   product: 1+0 JBOD
>>                   vendor: Promise
>>                   physical id: 0.2.0
>>                   bus info: scsi@0:0.2.0
>>                   logical name: /dev/sdc
>>                   version: 1.10
>>                   size: 465GB
>>                   capabilities: partitioned partitioned:dos
>>                   configuration: ansiversion=2
>>                 *-volume
>>                      description: Linux raid autodetect partition
>>                      physical id: 1
>>                      bus info: scsi@0:0.2.0,1
>>                      logical name: /dev/sdc1
>>                      capacity: 465GB
>>                      capabilities: primary multi
>>              *-disk:3
>>                   description: SCSI Disk
>>                   product: 1+0 JBOD
>>                   vendor: Promise
>>                   physical id: 0.3.0
>>                   bus info: scsi@0:0.3.0
>>                   logical name: /dev/sdd
>>                   version: 1.10
>>                   size: 465GB
>>                   capabilities: partitioned partitioned:dos
>>                   configuration: ansiversion=2
>>                 *-volume
>>                      description: Linux raid autodetect partition
>>                      physical id: 1
>>                      bus info: scsi@0:0.3.0,1
>>                      logical name: /dev/sdd1
>>                      capacity: 465GB
>>                      capabilities: primary multi
>>              *-disk:4
>>                   description: SCSI Disk
>>                   product: 1+0 JBOD
>>                   vendor: Promise
>>                   physical id: 0.4.0
>>                   bus info: scsi@0:0.4.0
>>                   logical name: /dev/sde
>>                   version: 1.10
>>                   size: 465GB
>>                   capabilities: partitioned partitioned:dos
>>                   configuration: ansiversion=2
>>                 *-volume
>>                      description: Linux raid autodetect partition
>>                      physical id: 1
>>                      bus info: scsi@0:0.4.0,1
>>                      logical name: /dev/sde1
>>                      capacity: 465GB
>>                      capabilities: primary multi
>>              *-disk:5
>>                   description: SCSI Disk
>>                   product: 1+0 JBOD
>>                   vendor: Promise
>>                   physical id: 0.5.0
>>                   bus info: scsi@0:0.5.0
>>                   logical name: /dev/sdf
>>                   version: 1.10
>>                   size: 465GB
>>                   capabilities: partitioned partitioned:dos
>>                   configuration: ansiversion=2
>>                 *-volume
>>                      description: Linux raid autodetect partition
>>                      physical id: 1
>>                      bus info: scsi@0:0.5.0,1
>>                      logical name: /dev/sdf1
>>                      capacity: 465GB
>>                      capabilities: primary multi
>>              *-disk:6
>>                   description: SCSI Disk
>>                   product: 1+0 JBOD
>>                   vendor: Promise
>>                   physical id: 0.7.0
>>                   bus info: scsi@0:0.7.0
>>                   logical name: /dev/sdh
>>                   version: 1.10
>>                   size: 465GB
>>                   capabilities: partitioned partitioned:dos
>>                   configuration: ansiversion=2
>>                 *-volume
>>                      description: Linux raid autodetect partition
>>                      physical id: 1
>>                      bus info: scsi@0:0.7.0,1
>>                      logical name: /dev/sdh1
>>                      capacity: 465GB
>>                      capabilities: primary multi
>>              *-processor UNCLAIMED
>>                   description: SCSI Processor
>>                   product: RAID Console
>>                   vendor: Promise
>>                   physical id: 0.10.0
>>                   bus info: scsi@0:0.16.0
>>                   version: 1.00
>>                   configuration: ansiversion=3
>>              *-disk:7
>>                   description: SCSI Disk
>>                   product: 1+0 JBOD
>>                   vendor: Promise
>>                   physical id: 0.6.0
>>                   bus info: scsi@0:0.6.0
>>                   logical name: /dev/sdg
>>                   version: 1.10
>>                   size: 465GB
>>                   capabilities: partitioned partitioned:dos
>>                   configuration: ansiversion=2
>>                 *-volume
>>                      description: Linux raid autodetect partition
>>                      physical id: 1
>>                      bus info: scsi@0:0.6.0,1
>>                      logical name: /dev/sdg1
>>                      capacity: 465GB
>>                      capabilities: primary multi
>>        *-pci:1
>>             description: PCI bridge
>>             product: 80333 Segment-B PCI Express-to-PCI Express Bridge
>>             vendor: Intel Corporation
>>             physical id: 0.2
>>             bus info: pci@0000:02:00.2
>>             version: 00
>>             width: 32 bits
>>             clock: 33MHz
>>             capabilities: pci pciexpress msi pm pcix normal_decode
>>bus_master cap_list
>>     *-pci:2
>>          description: PCI bridge
>>          product: CK804 PCIE Bridge
>>          vendor: nVidia Corporation
>>          physical id: e
>>          bus info: pci@0000:00:0e.0
>>          version: a3
>>          width: 32 bits
>>          clock: 33MHz
>>          capabilities: pci pm msi ht pciexpress normal_decode
>>bus_master cap_list
>>          configuration: driver=pcieport-driver
>>        *-pci:0
>>             description: PCI bridge
>>             product: 80333 Segment-A PCI Express-to-PCI Express Bridge
>>             vendor: Intel Corporation
>>             physical id: 0
>>             bus info: pci@0000:05:00.0
>>             version: 00
>>             width: 32 bits
>>             clock: 33MHz
>>             capabilities: pci pciexpress msi pm pcix normal_decode
>>bus_master cap_list
>>           *-storage
>>                description: RAID bus controller
>>                product: 80333 [SuperTrak EX8350/EX16350], 80331
>>[SuperTrak EX8300/EX16300]
>>                vendor: Promise Technology, Inc.
>>                physical id: e
>>                bus info: pci@0000:06:0e.0
>>                logical name: scsi1
>>                version: 00
>>                width: 32 bits
>>                clock: 66MHz
>>                capabilities: storage pm msi pcix bus_master cap_list
>>scsi-host
>>                configuration: driver=stex latency=96 mingnt=144
>>module=stex
>>              *-disk:0
>>                   description: SCSI Disk
>>                   product: 1+0 JBOD
>>                   vendor: Promise
>>                   physical id: 0.0.0
>>                   bus info: scsi@1:0.0.0
>>                   logical name: /dev/sdi
>>                   version: 1.10
>>                   size: 465GB
>>                   capabilities: partitioned partitioned:dos
>>                   configuration: ansiversion=2
>>                 *-volume
>>                      description: Linux raid autodetect partition
>>                      physical id: 1
>>                      bus info: scsi@1:0.0.0,1
>>                      logical name: /dev/sdi1
>>                      capacity: 465GB
>>                      capabilities: primary multi
>>              *-disk:1
>>                   description: SCSI Disk
>>                   product: 1+0 JBOD
>>                   vendor: Promise
>>                   physical id: 0.1.0
>>                   bus info: scsi@1:0.1.0
>>                   logical name: /dev/sdj
>>                   version: 1.10
>>                   size: 465GB
>>                   capabilities: partitioned partitioned:dos
>>                   configuration: ansiversion=2
>>                 *-volume
>>                      description: Linux raid autodetect partition
>>                      physical id: 1
>>                      bus info: scsi@1:0.1.0,1
>>                      logical name: /dev/sdj1
>>                      capacity: 465GB
>>                      capabilities: primary multi
>>              *-disk:2
>>                   description: SCSI Disk
>>                   product: 1+0 JBOD
>>                   vendor: Promise
>>                   physical id: 0.2.0
>>                   bus info: scsi@1:0.2.0
>>                   logical name: /dev/sdk
>>                   version: 1.10
>>                   size: 465GB
>>                   capabilities: partitioned partitioned:dos
>>                   configuration: ansiversion=2
>>                 *-volume
>>                      description: Linux raid autodetect partition
>>                      physical id: 1
>>                      bus info: scsi@1:0.2.0,1
>>                      logical name: /dev/sdk1
>>                      capacity: 465GB
>>                      capabilities: primary multi
>>              *-disk:3
>>                   description: SCSI Disk
>>                   product: 1+0 JBOD
>>                   vendor: Promise
>>                   physical id: 0.3.0
>>                   bus info: scsi@1:0.3.0
>>                   logical name: /dev/sdl
>>                   version: 1.10
>>                   size: 465GB
>>                   capabilities: partitioned partitioned:dos
>>                   configuration: ansiversion=2
>>                 *-volume
>>                      description: Linux raid autodetect partition
>>                      physical id: 1
>>                      bus info: scsi@1:0.3.0,1
>>                      logical name: /dev/sdl1
>>                      capacity: 465GB
>>                      capabilities: primary multi
>>              *-disk:4
>>                   description: SCSI Disk
>>                   product: 1+0 JBOD
>>                   vendor: Promise
>>                   physical id: 0.4.0
>>                   bus info: scsi@1:0.4.0
>>                   logical name: /dev/sdm
>>                   version: 1.10
>>                   size: 465GB
>>                   capabilities: partitioned partitioned:dos
>>                   configuration: ansiversion=2
>>                 *-volume
>>                      description: Linux raid autodetect partition
>>                      physical id: 1
>>                      bus info: scsi@1:0.4.0,1
>>                      logical name: /dev/sdm1
>>                      capacity: 465GB
>>                      capabilities: primary multi
>>              *-disk:5
>>                   description: SCSI Disk
>>                   product: 1+0 JBOD
>>                   vendor: Promise
>>                   physical id: 0.5.0
>>                   bus info: scsi@1:0.5.0
>>                   logical name: /dev/sdn
>>                   version: 1.10
>>                   size: 465GB
>>                   capabilities: partitioned partitioned:dos
>>                   configuration: ansiversion=2
>>                 *-volume
>>                      description: Linux raid autodetect partition
>>                      physical id: 1
>>                      bus info: scsi@1:0.5.0,1
>>                      logical name: /dev/sdn1
>>                      capacity: 465GB
>>                      capabilities: primary multi
>>              *-disk:6
>>                   description: SCSI Disk
>>                   product: 1+0 JBOD
>>                   vendor: Promise
>>                   physical id: 0.6.0
>>                   bus info: scsi@1:0.6.0
>>                   logical name: /dev/sdo
>>                   version: 1.10
>>                   size: 465GB
>>                   capabilities: partitioned partitioned:dos
>>                   configuration: ansiversion=2
>>                 *-volume
>>                      description: Linux raid autodetect partition
>>                      physical id: 1
>>                      bus info: scsi@1:0.6.0,1
>>                      logical name: /dev/sdo1
>>                      capacity: 465GB
>>                      capabilities: primary multi
>>              *-disk:7
>>                   description: SCSI Disk
>>                   product: 1+0 JBOD
>>                   vendor: Promise
>>                   physical id: 0.7.0
>>                   bus info: scsi@1:0.7.0
>>                   logical name: /dev/sdp
>>                   version: 1.10
>>                   size: 465GB
>>                   capabilities: partitioned partitioned:dos
>>                   configuration: ansiversion=2
>>                 *-volume
>>                      description: Linux raid autodetect partition
>>                      physical id: 1
>>                      bus info: scsi@1:0.7.0,1
>>                      logical name: /dev/sdp1
>>                      capacity: 465GB
>>                      capabilities: primary multi
>>              *-processor UNCLAIMED
>>                   description: SCSI Processor
>>                   product: RAID Console
>>                   vendor: Promise
>>                   physical id: 0.10.0
>>                   bus info: scsi@1:0.16.0
>>                   version: 1.00
>>                   configuration: ansiversion=3
>>        *-pci:1
>>             description: PCI bridge
>>             product: 80333 Segment-B PCI Express-to-PCI Express Bridge
>>             vendor: Intel Corporation
>>             physical id: 0.2
>>             bus info: pci@0000:05:00.2
>>             version: 00
>>             width: 32 bits
>>             clock: 33MHz
>>             capabilities: pci pciexpress msi pm pcix normal_decode
>>bus_master cap_list
>>     *-pci:3
>>          description: Host bridge
>>          product: K8 [Athlon64/Opteron] HyperTransport Technology
>>Configuration
>>          vendor: Advanced Micro Devices [AMD]
>>          physical id: 101
>>          bus info: pci@0000:00:18.0
>>          version: 00
>>          width: 32 bits
>>          clock: 33MHz
>>     *-pci:4
>>          description: Host bridge
>>          product: K8 [Athlon64/Opteron] Address Map
>>          vendor: Advanced Micro Devices [AMD]
>>          physical id: 102
>>          bus info: pci@0000:00:18.1
>>          version: 00
>>          width: 32 bits
>>          clock: 33MHz
>>     *-pci:5
>>          description: Host bridge
>>          product: K8 [Athlon64/Opteron] DRAM Controller
>>          vendor: Advanced Micro Devices [AMD]
>>          physical id: 103
>>          bus info: pci@0000:00:18.2
>>          version: 00
>>          width: 32 bits
>>          clock: 33MHz
>>     *-pci:6
>>          description: Host bridge
>>          product: K8 [Athlon64/Opteron] Miscellaneous Control
>>          vendor: Advanced Micro Devices [AMD]
>>          physical id: 104
>>          bus info: pci@0000:00:18.3
>>          version: 00
>>          width: 32 bits
>>          clock: 33MHz
>>     *-pci:7
>>          description: Host bridge
>>          product: K8 [Athlon64/Opteron] HyperTransport Technology
>>Configuration
>>          vendor: Advanced Micro Devices [AMD]
>>          physical id: 105
>>          bus info: pci@0000:00:19.0
>>          version: 00
>>          width: 32 bits
>>          clock: 33MHz
>>     *-pci:8
>>          description: Host bridge
>>          product: K8 [Athlon64/Opteron] Address Map
>>          vendor: Advanced Micro Devices [AMD]
>>          physical id: 106
>>          bus info: pci@0000:00:19.1
>>          version: 00
>>          width: 32 bits
>>          clock: 33MHz
>>     *-pci:9
>>          description: Host bridge
>>          product: K8 [Athlon64/Opteron] DRAM Controller
>>          vendor: Advanced Micro Devices [AMD]
>>          physical id: 107
>>          bus info: pci@0000:00:19.2
>>          version: 00
>>          width: 32 bits
>>          clock: 33MHz
>>     *-pci:10
>>          description: Host bridge
>>          product: K8 [Athlon64/Opteron] Miscellaneous Control
>>          vendor: Advanced Micro Devices [AMD]
>>          physical id: 108
>>          bus info: pci@0000:00:19.3
>>          version: 00
>>          width: 32 bits
>>          clock: 33MHz
>>     *-pci:11
>>          description: PCI bridge
>>          product: AMD-8131 PCI-X Bridge
>>          vendor: Advanced Micro Devices [AMD]
>>          physical id: a
>>          bus info: pci@0000:18:0a.0
>>          version: 13
>>          width: 32 bits
>>          clock: 66MHz
>>          capabilities: pci pcix ht normal_decode bus_master cap_list
>>        *-pci:0
>>             description: PCI bridge
>>             product: PCI-X to PCI-X Bridge
>>             vendor: IBM
>>             physical id: 2
>>             bus info: pci@0000:19:02.0
>>             version: 03
>>             width: 32 bits
>>             clock: 66MHz
>>             capabilities: pci pcix pm normal_decode
>>bus_master cap_list
>>           *-network:0
>>                description: Ethernet interface
>>                product: 82546GB Gigabit Ethernet Controller
>>                vendor: Intel Corporation
>>                physical id: 4
>>                bus info: pci@0000:1a:04.0
>>                logical name: eth2
>>                version: 03
>>                serial: 00:e0:ed:0a:95:44
>>                size: 1GB/s
>>                capacity: 1GB/s
>>                width: 64 bits
>>                clock: 66MHz
>>                capabilities: pm pcix msi bus_master cap_list ethernet
>>physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
>>                configuration: autonegotiation=on broadcast=yes
>>driver=e1000 driverversion=7.0.33-k2 duplex=full firmware=N/A
>>ip=10.5.124.11 latency=64 link=yes mingnt=255 module=e1000
>>multicast=yes
>>port=twisted pair speed=1GB/s
>>           *-network:1 DISABLED
>>                description: Ethernet interface
>>                product: 82546GB Gigabit Ethernet Controller
>>                vendor: Intel Corporation
>>                physical id: 4.1
>>                bus info: pci@0000:1a:04.1
>>                logical name: eth3
>>                version: 03
>>                serial: 00:e0:ed:0a:95:45
>>                capacity: 1GB/s
>>                width: 64 bits
>>                clock: 66MHz
>>                capabilities: pm pcix msi bus_master cap_list ethernet
>>physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
>>                configuration: autonegotiation=on broadcast=yes
>>driver=e1000 driverversion=7.0.33-k2 firmware=N/A latency=64 link=no
>>mingnt=255 module=e1000 multicast=yes port=twisted pair
>>           *-network:2 DISABLED
>>                description: Ethernet interface
>>                product: 82546GB Gigabit Ethernet Controller
>>                vendor: Intel Corporation
>>                physical id: 6
>>                bus info: pci@0000:1a:06.0
>>                logical name: eth4
>>                version: 03
>>                serial: 00:e0:ed:0a:95:46
>>                capacity: 1GB/s
>>                width: 64 bits
>>                clock: 66MHz
>>                capabilities: pm pcix msi bus_master cap_list ethernet
>>physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
>>                configuration: autonegotiation=on broadcast=yes
>>driver=e1000 driverversion=7.0.33-k2 firmware=N/A latency=64 link=no
>>mingnt=255 module=e1000 multicast=yes port=twisted pair
>>           *-network:3 DISABLED
>>                description: Ethernet interface
>>                product: 82546GB Gigabit Ethernet Controller
>>                vendor: Intel Corporation
>>                physical id: 6.1
>>                bus info: pci@0000:1a:06.1
>>                logical name: eth5
>>                version: 03
>>                serial: 00:e0:ed:0a:95:47
>>                capacity: 1GB/s
>>                width: 64 bits
>>                clock: 66MHz
>>                capabilities: pm pcix msi bus_master cap_list ethernet
>>physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
>>                configuration: autonegotiation=on broadcast=yes
>>driver=e1000 driverversion=7.0.33-k2 firmware=N/A latency=64 link=no
>>mingnt=255 module=e1000 multicast=yes port=twisted pair
>>        *-pci:1
>>             description: PCI bridge
>>             product: PCI-X to PCI-X Bridge
>>             vendor: IBM
>>             physical id: 3
>>             bus info: pci@0000:19:03.0
>>             version: 03
>>             width: 32 bits
>>             clock: 66MHz
>>             capabilities: pci pcix pm normal_decode
>>bus_master cap_list
>>           *-network:0 DISABLED
>>                description: Ethernet interface
>>                product: 82546GB Gigabit Ethernet Controller
>>                vendor: Intel Corporation
>>                physical id: 4
>>                bus info: pci@0000:1b:04.0
>>                logical name: eth6
>>                version: 03
>>                serial: 00:e0:ed:0a:95:70
>>                capacity: 1GB/s
>>                width: 64 bits
>>                clock: 66MHz
>>                capabilities: pm pcix msi bus_master cap_list ethernet
>>physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
>>                configuration: autonegotiation=on broadcast=yes
>>driver=e1000 driverversion=7.0.33-k2 firmware=N/A latency=64 link=no
>>mingnt=255 module=e1000 multicast=yes port=twisted pair
>>           *-network:1 DISABLED
>>                description: Ethernet interface
>>                product: 82546GB Gigabit Ethernet Controller
>>                vendor: Intel Corporation
>>                physical id: 4.1
>>                bus info: pci@0000:1b:04.1
>>                logical name: eth7
>>                version: 03
>>                serial: 00:e0:ed:0a:95:71
>>                capacity: 1GB/s
>>                width: 64 bits
>>                clock: 66MHz
>>                capabilities: pm pcix msi bus_master cap_list ethernet
>>physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
>>                configuration: autonegotiation=on broadcast=yes
>>driver=e1000 driverversion=7.0.33-k2 firmware=N/A latency=64 link=no
>>mingnt=255 module=e1000 multicast=yes port=twisted pair
>>           *-network:2 DISABLED
>>                description: Ethernet interface
>>                product: 82546GB Gigabit Ethernet Controller
>>                vendor: Intel Corporation
>>                physical id: 6
>>                bus info: pci@0000:1b:06.0
>>                logical name: eth8
>>                version: 03
>>                serial: 00:e0:ed:0a:95:72
>>                capacity: 1GB/s
>>                width: 64 bits
>>                clock: 66MHz
>>                capabilities: pm pcix msi bus_master cap_list ethernet
>>physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
>>                configuration: autonegotiation=on broadcast=yes
>>driver=e1000 driverversion=7.0.33-k2 firmware=N/A latency=64 link=no
>>mingnt=255 module=e1000 multicast=yes port=twisted pair
>>           *-network:3 DISABLED
>>                description: Ethernet interface
>>                product: 82546GB Gigabit Ethernet Controller
>>                vendor: Intel Corporation
>>                physical id: 6.1
>>                bus info: pci@0000:1b:06.1
>>                logical name: eth9
>>                version: 03
>>                serial: 00:e0:ed:0a:95:73
>>                capacity: 1GB/s
>>                width: 64 bits
>>                clock: 66MHz
>>                capabilities: pm pcix msi bus_master cap_list ethernet
>>physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
>>                configuration: autonegotiation=on broadcast=yes
>>driver=e1000 driverversion=7.0.33-k2 firmware=N/A latency=64 link=no
>>mingnt=255 module=e1000 multicast=yes port=twisted pair
>>     *-system:0 UNCLAIMED
>>          description: PIC
>>          product: AMD-8131 PCI-X IOAPIC
>>          vendor: Advanced Micro Devices [AMD]
>>          physical id: a.1
>>          bus info: pci@0000:18:0a.1
>>          version: 01
>>          width: 64 bits
>>          clock: 33MHz
>>          capabilities: io-apic bus_master
>>          configuration: latency=0
>>     *-pci:12
>>          description: PCI bridge
>>          product: AMD-8131 PCI-X Bridge
>>          vendor: Advanced Micro Devices [AMD]
>>          physical id: b
>>          bus info: pci@0000:18:0b.0
>>          version: 13
>>          width: 32 bits
>>          clock: 66MHz
>>          capabilities: pci pcix ht normal_decode bus_master cap_list
>>        *-network:0
>>             description: Ethernet interface
>>             product: NetXtreme BCM5704 Gigabit Ethernet
>>             vendor: Broadcom Corporation
>>             physical id: 9
>>             bus info: pci@0000:1c:09.0
>>             logical name: eth0
>>             version: 10
>>             serial: 00:e0:81:44:7e:48
>>             size: 1GB/s
>>             capacity: 1GB/s
>>             width: 64 bits
>>             clock: 66MHz
>>             capabilities: pcix pm vpd msi bus_master cap_list ethernet
>>physical mii 10bt 10bt-fd 100bt 100bt-fd 1000bt 1000bt-fd
>>autonegotiation
>>             configuration: autonegotiation=on broadcast=yes driver=tg3
>>driverversion=3.59 duplex=full firmware=5704-v3.19 ip=10.31.233.11
>>latency=64 link=yes mingnt=64 module=tg3 multicast=yes
>>port=twisted pair
>>speed=1GB/s
>>        *-network:1 DISABLED
>>             description: Ethernet interface
>>             product: NetXtreme BCM5704 Gigabit Ethernet
>>             vendor: Broadcom Corporation
>>             physical id: 9.1
>>             bus info: pci@0000:1c:09.1
>>             logical name: eth1
>>             version: 10
>>             serial: 00:e0:81:44:7e:49
>>             capacity: 1GB/s
>>             width: 64 bits
>>             clock: 66MHz
>>             capabilities: pcix pm vpd msi bus_master cap_list ethernet
>>physical mii 10bt 10bt-fd 100bt 100bt-fd 1000bt 1000bt-fd
>>autonegotiation
>>             configuration: autonegotiation=on broadcast=yes driver=tg3
>>driverversion=3.59 duplex=half firmware=5704-v3.19 latency=64 link=no
>>mingnt=64 module=tg3 multicast=yes port=twisted pair
>>     *-system:1 UNCLAIMED
>>          description: PIC
>>          product: AMD-8131 PCI-X IOAPIC
>>          vendor: Advanced Micro Devices [AMD]
>>          physical id: b.1
>>          bus info: pci@0000:18:0b.1
>>          version: 01
>>          width: 64 bits
>>          clock: 33MHz
>>          capabilities: io-apic bus_master
>>          configuration: latency=0
>>  *-ide
>>       description: IDE Channel 0
>>       physical id: 0
>>       bus info: ide@0
>>       logical name: ide0
>>     *-disk
>>          description: ATA Disk
>>          product: M-Systems iDOC V1.12
>>          physical id: 0
>>          bus info: ide@0.0
>>          logical name: /dev/hda
>>          version: 060424
>>          serial: 64659400014
>>          size: 250MB
>>          capacity: 250MB
>>          capabilities: ata dma lba iordy partitioned partitioned:dos
>>        *-volume
>>             description: Linux filesystem partition
>>             physical id: 1
>>             bus info: ide@0.0,1
>>             logical name: /dev/hda1
>>             capacity: 249MB
>>             capabilities: primary
>>  *-network DISABLED
>>       description: Ethernet interface
>>       physical id: 2
>>       logical name: dummy0
>>       serial: 1e:5d:2b:a6:3a:3e
>>       capabilities: ethernet physical
>>       configuration: broadcast=yes
>># -------------------- Ended: /usr/sbin/lshw, rc=[0]
>>--------------------
>>
>>
>>##############
>>## Drives : ##
>>##############
>>
>>Disk /dev/hda: 262 MB, 262144000 bytes
>>16 heads, 32 sectors/track, 1000 cylinders
>>Units = cylinders of 512 * 512 = 262144 bytes
>>
>>   Device Boot      Start         End      Blocks   Id  System
>>/dev/hda1               1        1000      255984   83  Linux
>>
>>Disk /dev/sda: 500.1 GB, 500107862016 bytes
>>255 heads, 63 sectors/track, 60801 cylinders
>>Units = cylinders of 16065 * 512 = 8225280 bytes
>>
>>   Device Boot      Start         End      Blocks   Id  System
>>/dev/sda1               1         244     1959898+  fd  Linux raid
>>autodetect
>>/dev/sda2             245       60801   486424102+  fd  Linux raid
>>autodetect
>>
>>Disk /dev/sdb: 500.1 GB, 500107862016 bytes
>>255 heads, 63 sectors/track, 60801 cylinders
>>Units = cylinders of 16065 * 512 = 8225280 bytes
>>
>>   Device Boot      Start         End      Blocks   Id  System
>>/dev/sdb1               1         244     1959898+  fd  Linux raid
>>autodetect
>>/dev/sdb2             245       60801   486424102+  fd  Linux raid
>>autodetect
>>
>>Disk /dev/sdc: 500.1 GB, 500107862016 bytes
>>255 heads, 63 sectors/track, 60801 cylinders
>>Units = cylinders of 16065 * 512 = 8225280 bytes
>>
>>   Device Boot      Start         End      Blocks   Id  System
>>/dev/sdc1               1       60801   488384001   fd  Linux raid
>>autodetect
>>
>>Disk /dev/sdd: 500.1 GB, 500107862016 bytes
>>255 heads, 63 sectors/track, 60801 cylinders
>>Units = cylinders of 16065 * 512 = 8225280 bytes
>>
>>   Device Boot      Start         End      Blocks   Id  System
>>/dev/sdd1               1       60801   488384001   fd  Linux raid
>>autodetect
>>
>>Disk /dev/sde: 500.1 GB, 500107862016 bytes
>>255 heads, 63 sectors/track, 60801 cylinders
>>Units = cylinders of 16065 * 512 = 8225280 bytes
>>
>>   Device Boot      Start         End      Blocks   Id  System
>>/dev/sde1               1       60801   488384001   fd  Linux raid
>>autodetect
>>
>>Disk /dev/sdf: 500.1 GB, 500107862016 bytes
>>255 heads, 63 sectors/track, 60801 cylinders
>>Units = cylinders of 16065 * 512 = 8225280 bytes
>>
>>   Device Boot      Start         End      Blocks   Id  System
>>/dev/sdf1               1       60801   488384001   fd  Linux raid
>>autodetect
>>
>>Disk /dev/sdg: 500.1 GB, 500107862016 bytes
>>255 heads, 63 sectors/track, 60801 cylinders
>>Units = cylinders of 16065 * 512 = 8225280 bytes
>>
>>   Device Boot      Start         End      Blocks   Id  System
>>/dev/sdg1               1       60801   488384001   fd  Linux raid
>>autodetect
>>
>>Disk /dev/sdh: 500.1 GB, 500107862016 bytes
>>255 heads, 63 sectors/track, 60801 cylinders
>>Units = cylinders of 16065 * 512 = 8225280 bytes
>>
>>   Device Boot      Start         End      Blocks   Id  System
>>/dev/sdh1               1       60801   488384001   fd  Linux raid
>>autodetect
>>
>>Disk /dev/sdi: 500.1 GB, 500107862016 bytes
>>255 heads, 63 sectors/track, 60801 cylinders
>>Units = cylinders of 16065 * 512 = 8225280 bytes
>>
>>   Device Boot      Start         End      Blocks   Id  System
>>/dev/sdi1               1       60801   488384001   fd  Linux raid
>>autodetect
>>
>>Disk /dev/sdj: 500.1 GB, 500107862016 bytes
>>255 heads, 63 sectors/track, 60801 cylinders
>>Units = cylinders of 16065 * 512 = 8225280 bytes
>>
>>   Device Boot      Start         End      Blocks   Id  System
>>/dev/sdj1               1       60801   488384001   fd  Linux raid
>>autodetect
>>
>>Disk /dev/sdk: 500.1 GB, 500107862016 bytes
>>255 heads, 63 sectors/track, 60801 cylinders
>>Units = cylinders of 16065 * 512 = 8225280 bytes
>>
>>   Device Boot      Start         End      Blocks   Id  System
>>/dev/sdk1               1       60801   488384001   fd  Linux raid
>>autodetect
>>
>>Disk /dev/sdl: 500.1 GB, 500107862016 bytes
>>255 heads, 63 sectors/track, 60801 cylinders
>>Units = cylinders of 16065 * 512 = 8225280 bytes
>>
>>   Device Boot      Start         End      Blocks   Id  System
>>/dev/sdl1               1       60801   488384001   fd  Linux raid
>>autodetect
>>
>>Disk /dev/sdm: 500.1 GB, 500107862016 bytes
>>255 heads, 63 sectors/track, 60801 cylinders
>>Units = cylinders of 16065 * 512 = 8225280 bytes
>>
>>   Device Boot      Start         End      Blocks   Id  System
>>/dev/sdm1               1       60801   488384001   fd  Linux raid
>>autodetect
>>
>>Disk /dev/sdn: 500.1 GB, 500107862016 bytes
>>255 heads, 63 sectors/track, 60801 cylinders
>>Units = cylinders of 16065 * 512 = 8225280 bytes
>>
>>   Device Boot      Start         End      Blocks   Id  System
>>/dev/sdn1               1       60801   488384001   fd  Linux raid
>>autodetect
>>
>>Disk /dev/sdo: 500.1 GB, 500107862016 bytes
>>255 heads, 63 sectors/track, 60801 cylinders
>>Units = cylinders of 16065 * 512 = 8225280 bytes
>>
>>   Device Boot      Start         End      Blocks   Id  System
>>/dev/sdo1               1       60801   488384001   fd  Linux raid
>>autodetect
>>
>>Disk /dev/sdp: 500.1 GB, 500107862016 bytes
>>255 heads, 63 sectors/track, 60801 cylinders
>>Units = cylinders of 16065 * 512 = 8225280 bytes
>>
>>   Device Boot      Start         End      Blocks   Id  System
>>/dev/sdp1               1       60801   488384001   fd  Linux raid
>>autodetect
>>
>>
>># ===================== File: /proc/cmdline =====================
>>ro root=/dev/hda1 console=tty console=ttyS0,57600n8 mem=5242880K
>># --------------------- End of file: /proc/cmdline
>>---------------------
>>
>>
>># ===================== File: /proc/cpuinfo =====================
>>processor      : 0
>>vendor_id      : AuthenticAMD
>>cpu family     : 15
>>model          : 37
>>model name     : AMD Opteron(tm) Processor 248
>>stepping       : 1
>>cpu MHz                : 2210.327
>>cache size     : 1024 KB
>>fdiv_bug       : no
>>hlt_bug                : no
>>f00f_bug       : no
>>coma_bug       : no
>>fpu            : yes
>>fpu_exception  : yes
>>cpuid level    : 1
>>wp             : yes
>>flags          : fpu vme de pse tsc msr pae mce cx8 apic sep
>>mtrr pge mca cmov
>>pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt lm
>>3dnowext 3dnow pni lahf_lm ts fid vid ttp
>>bogomips       : 4423.44
>>
>>processor      : 1
>>vendor_id      : AuthenticAMD
>>cpu family     : 15
>>model          : 37
>>model name     : AMD Opteron(tm) Processor 248
>>stepping       : 1
>>cpu MHz                : 2210.327
>>cache size     : 1024 KB
>>fdiv_bug       : no
>>hlt_bug                : no
>>f00f_bug       : no
>>coma_bug       : no
>>fpu            : yes
>>fpu_exception  : yes
>>cpuid level    : 1
>>wp             : yes
>>flags          : fpu vme de pse tsc msr pae mce cx8 apic sep
>>mtrr pge mca cmov
>>pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt lm
>>3dnowext 3dnow pni lahf_lm ts fid vid ttp
>>bogomips       : 4419.81
>>
>># --------------------- End of file: /proc/cpuinfo
>>---------------------
>>
>>
>># ===================== File: /proc/meminfo =====================
>>MemTotal:      3107024 kB
>>MemFree:         68368 kB
>>Buffers:        275700 kB
>>Cached:          27512 kB
>>SwapCached:          0 kB
>>Active:        2455520 kB
>>Inactive:       259444 kB
>>HighTotal:     2227328 kB
>>HighFree:        59956 kB
>>LowTotal:       879696 kB
>>LowFree:          8412 kB
>>SwapTotal:           0 kB
>>SwapFree:            0 kB
>>Dirty:             204 kB
>>Writeback:           0 kB
>>Mapped:        2418644 kB
>>Slab:            50228 kB
>>CommitLimit:   1553512 kB
>>Committed_AS:  2470732 kB
>>PageTables:       2676 kB
>>VmallocTotal:   114680 kB
>>VmallocUsed:      2244 kB
>>VmallocChunk:   111728 kB
>># --------------------- End of file: /proc/meminfo
>>---------------------
>>
>>
>># ===================== File: /proc/scsi/scsi =====================
>>Attached devices:
>>Host: scsi0 Channel: 00 Id: 00 Lun: 00
>>  Vendor: Promise  Model:  1+0 JBOD        Rev: 1.10
>>  Type:   Direct-Access                    ANSI SCSI revision: 02
>>Host: scsi0 Channel: 00 Id: 01 Lun: 00
>>  Vendor: Promise  Model:  1+0 JBOD        Rev: 1.10
>>  Type:   Direct-Access                    ANSI SCSI revision: 02
>>Host: scsi0 Channel: 00 Id: 02 Lun: 00
>>  Vendor: Promise  Model:  1+0 JBOD        Rev: 1.10
>>  Type:   Direct-Access                    ANSI SCSI revision: 02
>>Host: scsi0 Channel: 00 Id: 03 Lun: 00
>>  Vendor: Promise  Model:  1+0 JBOD        Rev: 1.10
>>  Type:   Direct-Access                    ANSI SCSI revision: 02
>>Host: scsi0 Channel: 00 Id: 04 Lun: 00
>>  Vendor: Promise  Model:  1+0 JBOD        Rev: 1.10
>>  Type:   Direct-Access                    ANSI SCSI revision: 02
>>Host: scsi0 Channel: 00 Id: 05 Lun: 00
>>  Vendor: Promise  Model:  1+0 JBOD        Rev: 1.10
>>  Type:   Direct-Access                    ANSI SCSI revision: 02
>>Host: scsi0 Channel: 00 Id: 07 Lun: 00
>>  Vendor: Promise  Model:  1+0 JBOD        Rev: 1.10
>>  Type:   Direct-Access                    ANSI SCSI revision: 02
>>Host: scsi0 Channel: 00 Id: 16 Lun: 00
>>  Vendor: Promise  Model: RAID Console     Rev: 1.00
>>  Type:   Processor                        ANSI SCSI revision: 03
>>Host: scsi1 Channel: 00 Id: 00 Lun: 00
>>  Vendor: Promise  Model:  1+0 JBOD        Rev: 1.10
>>  Type:   Direct-Access                    ANSI SCSI revision: 02
>>Host: scsi1 Channel: 00 Id: 01 Lun: 00
>>  Vendor: Promise  Model:  1+0 JBOD        Rev: 1.10
>>  Type:   Direct-Access                    ANSI SCSI revision: 02
>>Host: scsi1 Channel: 00 Id: 02 Lun: 00
>>  Vendor: Promise  Model:  1+0 JBOD        Rev: 1.10
>>  Type:   Direct-Access                    ANSI SCSI revision: 02
>>Host: scsi1 Channel: 00 Id: 03 Lun: 00
>>  Vendor: Promise  Model:  1+0 JBOD        Rev: 1.10
>>  Type:   Direct-Access                    ANSI SCSI revision: 02
>>Host: scsi1 Channel: 00 Id: 04 Lun: 00
>>  Vendor: Promise  Model:  1+0 JBOD        Rev: 1.10
>>  Type:   Direct-Access                    ANSI SCSI revision: 02
>>Host: scsi1 Channel: 00 Id: 05 Lun: 00
>>  Vendor: Promise  Model:  1+0 JBOD        Rev: 1.10
>>  Type:   Direct-Access                    ANSI SCSI revision: 02
>>Host: scsi1 Channel: 00 Id: 06 Lun: 00
>>  Vendor: Promise  Model:  1+0 JBOD        Rev: 1.10
>>  Type:   Direct-Access                    ANSI SCSI revision: 02
>>Host: scsi1 Channel: 00 Id: 07 Lun: 00
>>  Vendor: Promise  Model:  1+0 JBOD        Rev: 1.10
>>  Type:   Direct-Access                    ANSI SCSI revision: 02
>>Host: scsi1 Channel: 00 Id: 16 Lun: 00
>>  Vendor: Promise  Model: RAID Console     Rev: 1.00
>>  Type:   Processor                        ANSI SCSI revision: 03
>>Host: scsi0 Channel: 00 Id: 06 Lun: 00
>>  Vendor: Promise  Model:  1+0 JBOD        Rev: 1.10
>>  Type:   Direct-Access                    ANSI SCSI revision: 02
>># --------------------- End of file: /proc/scsi/scsi
>>---------------------
>>
>>
>>
>># ++++++++++++++++++++ Start: cli phydrv ++++++++++++++++++++
>>ID CH         Size                  Model                Serial
>>F/W
>> 1  0  476940.02MB        HDS725050KLA360        KRVN67ZAJ98WUF
>>K2AOAD1A
>> 2  1  476940.02MB        HDS725050KLA360        KRVN67ZAJ97RAF
>>K2AOAD1A
>> 3  2  476940.02MB        HDS725050KLA360        KRVN67ZAJ9DWGF
>>K2AOAD1A
>> 4  3  476940.02MB        HDS725050KLA360        KRVN67ZAJ9HDVF
>>K2AOAD1A
>> 5  4  476940.02MB        HDS725050KLA360        KRVN67ZAJ9DWZF
>>K2AOAD1A
>> 6  5  476940.02MB        HDS725050KLA360        KRVN67ZAJ9DSZF
>>K2AOAD1A
>> 7  6  476940.02MB        HDS725050KLA360        KRVP67ZBGUUUMF
>>K2AOAD1A
>> 8  7  476940.02MB        HDS725050KLA360        KRVN67ZAJ9DV3F
>>K2AOAD1A
>># -------------------- Ended: cli phydrv, rc=[0] --------------------
>>
>>
>># ++++++++++++++++++++ Start: cli ctrl -v ++++++++++++++++++++
>>******************************
>>Controller ID : 0
>>BIOs Version : 0.0.0.0
>>Driver Version : 2.9.0.18
>>IRQ : 16
>>Logical slot number : 14
>>Bus master base : 0
>>BIOs memory start : 0
>>BIOs memory range : 64
>>Base address ATA : 0xdf000000
>>Base address XOR : 0x0
>>Base address SEQ : 0x0
>>Base address MMIO : 0x0
>>Base address SDRAM : 0x0
>>Memory type : ECC
>>Memory size : 128 MB
>>Maximum extents supported in each disk : 8
>>Number of disks : 8
>>Number of arrays : 8
>>Number of enclosure : 0
>>Battery installed : No
>>Rebuild rate : 10
>>Synchronization rate : 10
>>Migration rate : 10
>>Initialization rate : 10
>>Media patrol rate : 10
>>Smart check polling interval : 10
>>Enclosure polling interval : 10
>>Smart check : Disable
>>Auto rebuild : Enable
>>Rebuild policy : Disable
>>Max port supported in each controller : 8
>>Firmware version : 1.3.0.10
>>******************************
>>Controller ID : 1
>>BIOs Version : 2.9.0.22
>>Driver Version : 2.9.0.18
>>IRQ : 17
>>Logical slot number : 14
>>Bus master base : 0
>>BIOs memory start : 0
>>BIOs memory range : 64
>>Base address ATA : 0xdf100000
>>Base address XOR : 0x0
>>Base address SEQ : 0x0
>>Base address MMIO : 0x0
>>Base address SDRAM : 0x0
>>Memory type : ECC
>>Memory size : 128 MB
>>Maximum extents supported in each disk : 8
>>Number of disks : 8
>>Number of arrays : 8
>>Number of enclosure : 0
>>Battery installed : No
>>Rebuild rate : 10
>>Synchronization rate : 10
>>Migration rate : 10
>>Initialization rate : 10
>>Media patrol rate : 10
>>Smart check polling interval : 10
>>Enclosure polling interval : 10
>>Smart check : Disable
>>Auto rebuild : Enable
>>Rebuild policy : Disable
>>Max port supported in each controller : 8
>>Firmware version : 1.3.0.10
>># -------------------- Ended: cli ctrl -v, rc=[0] --------------------
>>
>>
>># ++++++++++++++++++++ Start: cli event ++++++++++++++++++++
>>No event!
>># -------------------- Ended: cli event, rc=[0] --------------------
>>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
>>XXXXXXXXXXXXXXXXXXXXXXXXXXX
>>
>>
>>
>>
>>
>>
>>
>
