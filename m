From: Thomas Evans <evans02472@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Fri, 25 Jan 2008 01:04:03 -0500
Message-ID: <47997BD3.2060100@gmail.com>
References: <4794459C.3090200@gmail.com> <4796DC44.6010100@gmail.com>	 <864c1e490801231622n806b465g88a3f0448b5d8f29@mail.gmail.com>	 <4797ECF3.5000306@gmail.com>	 <864c1e490801231823v3e9cf61ds2a0d553ed5b61fb2@mail.gmail.com>	 <4797F8D0.6060302@gmail.com>	 <864c1e490801231939k6008bc95tf40565a8ef6f430d@mail.gmail.com>	 <47980B71.3000408@gmail.com>	 <864c1e490801240707x31ff53b1s3d72032968e1bcbc@mail.gmail.com>	 <4798AA88.5080107@gmail.com> <864c1e490801240840q5423a1beuf9b4b3a43416db2b@mail.gmail.com> <4798C617.10601@gmail.com> <4798CA71.20707@gmail.com> <4798CC90.4040707@gmail.com> <4798CCDF.9070305@gmail.com> <4798CE10.2050005@gmail.com> <4798D4A2.7030303@gmail.com> <47991AD9.6050804@gmail.com> <47993686.5040405@gmail.com> <479939E3.4020307@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090203000703010401050700"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:30802 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYAYGEL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jan 2008 01:04:11 -0500
Received: by an-out-0708.google.com with SMTP id d31so124441and.103
        for <linux-ide@vger.kernel.org>; Thu, 24 Jan 2008 22:04:10 -0800 (PST)
In-Reply-To: <479939E3.4020307@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090203000703010401050700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun (and all) -

I've attached a log from my machine marked up with a few extra printk's.
I did add the ssleep() you suggested off line - made no difference.

I'll be happy to add more prinks in places that I did not ...

...tom


the working log (visible then):
[4194022.295042] ata6: SATA max UDMA/100 host m128@0x9aa9000 port 
0x9aa4000 irq 31
[4194022.295042] ata7: SATA max UDMA/100 host m128@0x9aa9000 port 
0x9aa6000 irq 31
[4194024.462033] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[4194024.462033] ata4.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 
ports, feat 0x1/0x9
[4194024.463009] ata4.00: hard resetting link
[4194024.770626] ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)

Now insetad, I see:
ata1: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa0000 irq 31
ata2: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa2000 irq 31
ata3: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa4000 irq 31
ata4: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa6000 irq 31
ata1: ata_eh_recover - 1
ata1: ata_eh_recover - 2 re-enable link?
ata1.00: ata_eh_recover - 3
ata1.00: ata_eh_recover - 5
ata1.00: ata_eh_recover - 6
ata1.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata1: ata_eh_recover - 8a prep for EH
ata1: ata_eh_recover - reset
ata1: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata1: ata_eh_recover -> ata_eh_reset


Tejun Heo wrote:
> Thomas Evans wrote:
>   
>> I'm gonna throw a bunch of printfk's around to see what happens as well.
>>     
>
> Great, please don't forget to cc linux-ide when reporting result.
>
>   


--------------090203000703010401050700
Content-Type: text/plain;
 name="dmesg-alpha-tpe1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-alpha-tpe1"

obj_path: path = '/class/spi_transport/target0:0:13'
class_uevent - name = target0:0:13
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:13'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:13'
class_uevent - name = target0:0:13
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:13'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target0:0:13: cleaning up
device class 'target0:0:13': release.
kobject target0:0:13: cleaning up
DEV: registering device: ID = 'target0:0:14'
kobject target0:0:14: registering. parent: host0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target0:0:14'
kobject target0:0:14: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:14'
class_uevent - name = target0:0:14
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:14'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:14'
class_uevent - name = target0:0:14
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:14'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target0:0:14: cleaning up
device class 'target0:0:14': release.
kobject target0:0:14: cleaning up
DEV: registering device: ID = 'target0:0:15'
kobject target0:0:15: registering. parent: host0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target0:0:15'
kobject target0:0:15: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:15'
class_uevent - name = target0:0:15
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:15'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:15'
class_uevent - name = target0:0:15
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:15'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target0:0:15: cleaning up
device class 'target0:0:15': release.
kobject target0:0:15: cleaning up
bound device '0000:01:00.0' to driver 'sym53c8xx'
pci: Bound Device 0000:01:00.0 to Driver sym53c8xx
pci: Matched Device 0000:01:01.0 with Driver sym53c8xx
pci: Probing driver sym53c8xx with device 0000:01:01.0
PCI: Enabling Mem-Wr-Inval for device 0000:01:01.0
sym1: <875> rev 0x4 at pci 0000:01:01.0 irq 26
sym1: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: SCSI BUS has been reset.
scsi1 : sym-2.2.3
DEV: registering device: ID = 'host1'
kobject host1: registering. parent: 0000:01:01.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host1'
kobject host1: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host1'
class_uevent - name = host1
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1'
CLASS: registering class device: ID = 'host1'
kobject host1: registering. parent: spi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_host/host1'
class_uevent - name = host1
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1'
DEV: registering device: ID = 'target1:0:0'
kobject target1:0:0: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:0'
kobject target1:0:0: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:0'
class_uevent - name = target1:0:0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:0'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:0'
class_uevent - name = target1:0:0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:0'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:0: cleaning up
device class 'target1:0:0': release.
kobject target1:0:0: cleaning up
DEV: registering device: ID = 'target1:0:1'
kobject target1:0:1: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:1'
kobject target1:0:1: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:1'
class_uevent - name = target1:0:1
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1'
scsi 1:0:1:0: Direct-Access     FUJITSU  MAJ3091MP        5508 PQ: 0 ANSI: 4
 target1:0:1: tagged command queuing enabled, command queue depth 16.
 target1:0:1: Beginning Domain Validation
 target1:0:1: asynchronous
 target1:0:1: wide asynchronous
 target1:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)
 target1:0:1: Domain Validation skipping write tests
 target1:0:1: Ending Domain Validation
DEV: registering device: ID = '1:0:1:0'
kobject 1:0:1:0: registering. parent: target1:0:1, set: devices
bus scsi: add device 1:0:1:0
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
CLASS: registering class device: ID = '1:0:1:0'
kobject 1:0:1:0: registering. parent: scsi_device, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_device/1:0:1:0'
class_uevent - name = 1:0:1:0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
DEV: registering device: ID = 'target1:0:2'
kobject target1:0:2: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:2'
kobject target1:0:2: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:2'
class_uevent - name = target1:0:2
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:2'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:2'
class_uevent - name = target1:0:2
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:2'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:2: cleaning up
device class 'target1:0:2': release.
kobject target1:0:2: cleaning up
DEV: registering device: ID = 'target1:0:3'
kobject target1:0:3: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:3'
kobject target1:0:3: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:3'
class_uevent - name = target1:0:3
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:3'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:3'
class_uevent - name = target1:0:3
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:3'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:3: cleaning up
device class 'target1:0:3': release.
kobject target1:0:3: cleaning up
DEV: registering device: ID = 'target1:0:4'
kobject target1:0:4: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:4'
kobject target1:0:4: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:4'
class_uevent - name = target1:0:4
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:4'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:4'
class_uevent - name = target1:0:4
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:4'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:4: cleaning up
device class 'target1:0:4': release.
kobject target1:0:4: cleaning up
DEV: registering device: ID = 'target1:0:5'
kobject target1:0:5: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:5'
kobject target1:0:5: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:5'
class_uevent - name = target1:0:5
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:5'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:5'
class_uevent - name = target1:0:5
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:5'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:5: cleaning up
device class 'target1:0:5': release.
kobject target1:0:5: cleaning up
DEV: registering device: ID = 'target1:0:6'
kobject target1:0:6: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:6'
kobject target1:0:6: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:6'
class_uevent - name = target1:0:6
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:6'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:6'
class_uevent - name = target1:0:6
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:6'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:6: cleaning up
device class 'target1:0:6': release.
kobject target1:0:6: cleaning up
DEV: registering device: ID = 'target1:0:8'
kobject target1:0:8: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:8'
kobject target1:0:8: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:8'
class_uevent - name = target1:0:8
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:8'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:8'
class_uevent - name = target1:0:8
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:8'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:8: cleaning up
device class 'target1:0:8': release.
kobject target1:0:8: cleaning up
DEV: registering device: ID = 'target1:0:9'
kobject target1:0:9: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:9'
kobject target1:0:9: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:9'
class_uevent - name = target1:0:9
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:9'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:9'
class_uevent - name = target1:0:9
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:9'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:9: cleaning up
device class 'target1:0:9': release.
kobject target1:0:9: cleaning up
DEV: registering device: ID = 'target1:0:10'
kobject target1:0:10: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:10'
kobject target1:0:10: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:10'
class_uevent - name = target1:0:10
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:10'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:10'
class_uevent - name = target1:0:10
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:10'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:10: cleaning up
device class 'target1:0:10': release.
kobject target1:0:10: cleaning up
DEV: registering device: ID = 'target1:0:11'
kobject target1:0:11: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:11'
kobject target1:0:11: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:11'
class_uevent - name = target1:0:11
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:11'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:11'
class_uevent - name = target1:0:11
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:11'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:11: cleaning up
device class 'target1:0:11': release.
kobject target1:0:11: cleaning up
DEV: registering device: ID = 'target1:0:12'
kobject target1:0:12: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:12'
kobject target1:0:12: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:12'
class_uevent - name = target1:0:12
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:12'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:12'
class_uevent - name = target1:0:12
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:12'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:12: cleaning up
device class 'target1:0:12': release.
kobject target1:0:12: cleaning up
DEV: registering device: ID = 'target1:0:13'
kobject target1:0:13: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:13'
kobject target1:0:13: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:13'
class_uevent - name = target1:0:13
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:13'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:13'
class_uevent - name = target1:0:13
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:13'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:13: cleaning up
device class 'target1:0:13': release.
kobject target1:0:13: cleaning up
DEV: registering device: ID = 'target1:0:14'
kobject target1:0:14: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:14'
kobject target1:0:14: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:14'
class_uevent - name = target1:0:14
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:14'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:14'
class_uevent - name = target1:0:14
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:14'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:14: cleaning up
device class 'target1:0:14': release.
kobject target1:0:14: cleaning up
DEV: registering device: ID = 'target1:0:15'
kobject target1:0:15: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:15'
kobject target1:0:15: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:15'
class_uevent - name = target1:0:15
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:15'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:15'
class_uevent - name = target1:0:15
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:15'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:15: cleaning up
device class 'target1:0:15': release.
kobject target1:0:15: cleaning up
bound device '0000:01:01.0' to driver 'sym53c8xx'
pci: Bound Device 0000:01:01.0 to Driver sym53c8xx
kobject drivers: registering. parent: sym53c8xx, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
device class 'scsi_disk': registering
kobject scsi_disk: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_disk'
Driver 'sd' needs updating - please use bus_type methods
bus scsi: add driver sd
kobject sd: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/scsi/drivers/sd'
scsi: Matched Device 0:0:4:0 with Driver sd
scsi: Probing driver sd with device 0:0:4:0
scsi: Matched Device 1:0:1:0 with Driver sd
scsi: Probing driver sd with device 1:0:1:0
CLASS: registering class device: ID = '1:0:1:0'
kobject 1:0:1:0: registering. parent: scsi_disk, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_disk/1:0:1:0'
class_uevent - name = 1:0:1:0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
sd 1:0:1:0: [sda] 17783239 512-byte hardware sectors (9105 MB)
sd 1:0:1:0: [sda] Write Protect is off
sd 1:0:1:0: [sda] Mode Sense: ab 00 10 08
sd 1:0:1:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
kobject sda: registering. parent: <NULL>, set: block
kobject holders: registering. parent: sda, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject slaves: registering. parent: sda, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
sd 1:0:1:0: [sda] 17783239 512-byte hardware sectors (9105 MB)
sd 1:0:1:0: [sda] Write Protect is off
sd 1:0:1:0: [sda] Mode Sense: ab 00 10 08
sd 1:0:1:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
 sda: sda1 sda2 sda3 sda4
kobject sda1: registering. parent: sda, set: <NULL>
kobject holders: registering. parent: sda1, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject sda2: registering. parent: sda, set: <NULL>
kobject holders: registering. parent: sda2, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject sda3: registering. parent: sda, set: <NULL>
kobject holders: registering. parent: sda3, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject sda4: registering. parent: sda, set: <NULL>
kobject holders: registering. parent: sda4, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject_uevent_env
fill_kobj_path: path = '/block/sda'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda/sda1'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda/sda2'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda/sda3'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda/sda4'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject queue: registering. parent: sda, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject iosched: registering. parent: queue, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
sd 1:0:1:0: [sda] Attached SCSI disk
bound device '1:0:1:0' to driver 'sd'
scsi: Bound Device 1:0:1:0 to Driver sd
Driver 'sr' needs updating - please use bus_type methods
bus scsi: add driver sr
kobject sr: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/scsi/drivers/sr'
scsi: Matched Device 0:0:4:0 with Driver sr
scsi: Probing driver sr with device 0:0:4:0
bus platform: add driver i8042
kobject i8042: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/platform/drivers/i8042'
Registering platform device 'i8042'. Parent at platform
DEV: registering device: ID = 'i8042'
kobject i8042: registering. parent: platform, set: devices
bus platform: add device i8042
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/i8042'
platform: Matched Device i8042 with Driver i8042
platform: Probing driver i8042 with device i8042
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
bound device 'i8042' to driver 'i8042'
platform: Bound Device i8042 to Driver i8042
DEV: registering device: ID = 'mice'
kobject mice: registering. parent: input, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/input/mice'
DEV: registering device: ID = 'serio0'
kobject serio0: registering. parent: i8042, set: devices
bus serio: add device serio0
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/i8042/serio0'
DEV: registering device: ID = 'psaux'
kobject psaux: registering. parent: misc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/misc/psaux'
DEV: registering device: ID = 'serio1'
kobject serio1: registering. parent: i8042, set: devices
bus serio: add device serio1
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/i8042/serio1'
mice: PS/2 mouse device common for all mice
bus serio: add driver atkbd
kobject atkbd: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/serio/drivers/atkbd'
kobject drivers: registering. parent: atkbd, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
serio: Matched Device serio0 with Driver atkbd
serio: Probing driver atkbd with device serio0
bus serio: add driver psmouse
kobject psmouse: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/serio/drivers/psmouse'
DEV: registering device: ID = 'input0'
kobject input0: registering. parent: input, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/input/input0'
fill_kobj_path: path = '/devices/platform/i8042/serio0'
fill_kobj_path: path = '/class/input/input0'
input: AT Raw Set 2 keyboard as /class/input/input0
bound device 'serio0' to driver 'atkbd'
serio: Bound Device serio0 to Driver atkbd
serio: Matched Device serio1 with Driver atkbd
serio: Probing driver atkbd with device serio1
atkbd.c: keyboard reset failed on isa0060/serio1
kobject <NULL>: cleaning up
kobject drivers: registering. parent: psmouse, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
oprofile: using alpha/ev6 performance monitoring.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
driver_probe_done: probe_count = 0
serio: Matched Device serio1 with Driver psmouse
serio: Probing driver psmouse with device serio1
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kobject <NULL>: cleaning up
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sda3: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 65099
ext3_orphan_cleanup: deleting unreferenced inode 82477
ext3_orphan_cleanup: deleting unreferenced inode 82709
ext3_orphan_cleanup: deleting unreferenced inode 82935
EXT3-fs: sda3: 4 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 160k freed
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
DEV: Unregistering device. ID = 'vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject vcs1: cleaning up
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject vcsa1: cleaning up
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
DEV: Unregistering device. ID = 'vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject vcs1: cleaning up
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject vcsa1: cleaning up
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
DEV: Unregistering device. ID = 'vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject vcs1: cleaning up
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject vcsa1: cleaning up
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
DEV: Unregistering device. ID = 'vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject vcs1: cleaning up
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject vcsa1: cleaning up
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
DEV: Unregistering device. ID = 'vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject vcs1: cleaning up
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject vcsa1: cleaning up
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/block/fd0'
fill_kobj_path: path = '/devices/platform/floppy.0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda/sda1'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda/sda2'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda/sda3'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda/sda4'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/class/input/input0'
fill_kobj_path: path = '/devices/platform/i8042/serio0'
kobject_uevent_env
fill_kobj_path: path = '/class/input/mice'
kobject_uevent_env
fill_kobj_path: path = '/class/iscsi_transport/qla4xxx'
class_uevent - name = qla4xxx
kobject_uevent_env
fill_kobj_path: path = '/class/mem/full'
kobject_uevent_env
fill_kobj_path: path = '/class/mem/kmem'
kobject_uevent_env
fill_kobj_path: path = '/class/mem/kmsg'
kobject_uevent_env
fill_kobj_path: path = '/class/mem/mem'
kobject_uevent_env
fill_kobj_path: path = '/class/mem/null'
kobject_uevent_env
fill_kobj_path: path = '/class/mem/port'
kobject_uevent_env
fill_kobj_path: path = '/class/mem/random'
kobject_uevent_env
fill_kobj_path: path = '/class/mem/urandom'
kobject_uevent_env
fill_kobj_path: path = '/class/mem/zero'
kobject_uevent_env
fill_kobj_path: path = '/class/misc/psaux'
kobject_uevent_env
fill_kobj_path: path = '/class/misc/rtc'
kobject_uevent_env
fill_kobj_path: path = '/class/net/eth0'
fill_kobj_path: path = '/devices/pci0001:02/0001:02:09.0'
kobject_uevent_env
fill_kobj_path: path = '/class/net/eth1'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:02.0'
kobject_uevent_env
fill_kobj_path: path = '/class/net/lo'
kobject_uevent_env
fill_kobj_path: path = '/class/pci_bus/0000:00'
class_uevent - name = 0000:00
kobject_uevent_env
fill_kobj_path: path = '/class/pci_bus/0000:01'
class_uevent - name = 0000:01
kobject_uevent_env
fill_kobj_path: path = '/class/pci_bus/0001:02'
class_uevent - name = 0001:02
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_device/0:0:4:0'
class_uevent - name = 0:0:4:0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_device/1:0:1:0'
class_uevent - name = 1:0:1:0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_disk/1:0:1:0'
class_uevent - name = 1:0:1:0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host0'
class_uevent - name = host0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host1'
class_uevent - name = host1
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1'
kobject_uevent_env
fill_kobj_path: path = '/class/spi_host/host0'
class_uevent - name = host0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0'
kobject_uevent_env
fill_kobj_path: path = '/class/spi_host/host1'
class_uevent - name = host1
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1'
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:4'
class_uevent - name = target0:0:4
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4'
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:1'
class_uevent - name = target1:0:1
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/console'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptmx'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyaa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyab'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyac'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyad'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyae'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyaf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyba'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptybb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptybc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptybd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptybe'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptybf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyca'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptycb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptycc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptycd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyce'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptycf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyda'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptydb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptydc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptydd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyde'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptydf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyea'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyeb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyec'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyed'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyee'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyef'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptypa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptypb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptypc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptypd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptype'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptypf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqe'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyra'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyrb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyrc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyrd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyre'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyrf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptysa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptysb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptysc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptysd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyse'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptysf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyta'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptytb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptytc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptytd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyte'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptytf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyua'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyub'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyuc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyud'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyue'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyuf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyva'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyvb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyvc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyvd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyve'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyvf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywe'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxe'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyya'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyyb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyyc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyyd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyye'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyyf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyza'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyzb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyzc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyzd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyze'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyzf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty10'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty11'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty12'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty13'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty14'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty15'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty16'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty17'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty18'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty19'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty20'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty21'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty22'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty23'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty24'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty25'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty26'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty27'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty28'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty29'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty30'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty31'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty32'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty33'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty34'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty35'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty36'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty37'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty38'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty39'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty40'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty41'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty42'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty43'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty44'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty45'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty46'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty47'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty48'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty49'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty50'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty51'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty52'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty53'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty54'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty55'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty56'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty57'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty58'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty59'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty60'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty61'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty62'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty63'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyS0'
fill_kobj_path: path = '/devices/platform/serial8250'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyS1'
fill_kobj_path: path = '/devices/platform/serial8250'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyS2'
fill_kobj_path: path = '/devices/platform/serial8250'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyS3'
fill_kobj_path: path = '/devices/platform/serial8250'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyaa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyab'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyac'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyad'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyae'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyaf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyba'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttybb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttybc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttybd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttybe'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttybf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyca'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttycb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttycc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttycd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyce'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttycf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyda'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttydb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttydc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttydd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyde'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttydf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyea'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyeb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyec'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyed'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyee'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyef'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttypa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttypb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttypc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttypd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttype'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttypf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqe'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyra'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyrb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyrc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyrd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyre'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyrf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttysa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttysb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttysc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttysd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyse'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttysf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyta'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttytb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttytc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttytd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyte'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttytf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyua'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyub'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyuc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyud'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyue'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyuf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyva'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyvb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyvc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyvd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyve'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyvf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywe'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxe'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyya'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyyb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyyc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyyd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyye'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyyf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyza'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyzb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyzc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyzd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyze'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyzf'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vtconsole/vtcon0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.1'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.2'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.3'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:02.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:09.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0001:02/0001:02:08.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0001:02/0001:02:09.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/floppy.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/i8042'
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/i8042/serio0'
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/i8042/serio1'
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/pcspkr'
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/serial8250'
DEVICE: renaming 'eth0' to 'eth0_rename'
fill_kobj_path: path = '/class/net/eth0'
kobject_uevent_env
fill_kobj_path: path = '/class/net/eth0_rename'
fill_kobj_path: path = '/devices/pci0001:02/0001:02:09.0'
DEVICE: renaming 'eth1' to 'eth0'
fill_kobj_path: path = '/class/net/eth1'
kobject_uevent_env
fill_kobj_path: path = '/class/net/eth0'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:02.0'
DEVICE: renaming 'eth0_rename' to 'eth1'
fill_kobj_path: path = '/class/net/eth0_rename'
kobject_uevent_env
fill_kobj_path: path = '/class/net/eth1'
fill_kobj_path: path = '/devices/pci0001:02/0001:02:09.0'
kobject 65534: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/65534'
kobject st: registering. parent: <NULL>, set: module
kobject holders: registering. parent: st, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject_uevent_env
fill_kobj_path: path = '/module/st'
kobject notes: registering. parent: st, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
st: Version 20070203, fixed bufsize 32768, s/g segs 256
device class 'scsi_tape': registering
kobject scsi_tape: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape'
Driver 'st' needs updating - please use bus_type methods
bus scsi: add driver st
kobject st: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/scsi/drivers/st'
scsi: Matched Device 0:0:4:0 with Driver st
scsi: Probing driver st with device 0:0:4:0
CLASS: registering class device: ID = 'st0'
kobject st0: registering. parent: scsi_tape, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape/st0'
class_uevent - name = st0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
class_device_create_uevent called for st0
CLASS: registering class device: ID = 'nst0'
kobject nst0: registering. parent: scsi_tape, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape/nst0'
class_uevent - name = nst0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
class_device_create_uevent called for nst0
CLASS: registering class device: ID = 'st0l'
kobject st0l: registering. parent: scsi_tape, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape/st0l'
class_uevent - name = st0l
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
class_device_create_uevent called for st0l
CLASS: registering class device: ID = 'nst0l'
kobject nst0l: registering. parent: scsi_tape, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape/nst0l'
class_uevent - name = nst0l
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
class_device_create_uevent called for nst0l
CLASS: registering class device: ID = 'st0m'
kobject st0m: registering. parent: scsi_tape, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape/st0m'
class_uevent - name = st0m
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
class_device_create_uevent called for st0m
CLASS: registering class device: ID = 'nst0m'
kobject nst0m: registering. parent: scsi_tape, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape/nst0m'
class_uevent - name = nst0m
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
class_device_create_uevent called for nst0m
CLASS: registering class device: ID = 'st0a'
kobject st0a: registering. parent: scsi_tape, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape/st0a'
class_uevent - name = st0a
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
class_device_create_uevent called for st0a
CLASS: registering class device: ID = 'nst0a'
kobject nst0a: registering. parent: scsi_tape, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape/nst0a'
class_uevent - name = nst0a
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
class_device_create_uevent called for nst0a
st 0:0:4:0: Attached scsi tape st0
st 0:0:4:0: st0: try direct i/o: yes (alignment 512 B)
bound device '0:0:4:0' to driver 'st'
scsi: Bound Device 0:0:4:0 to Driver st
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/65534'
kobject 65534: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/65534'
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/65534'
Adding 1976560k swap on /dev/sda4.  Priority:-1 extents:1 across:1976560k
EXT3 FS on sda3, internal journal
kobject libata: registering. parent: <NULL>, set: module
kobject holders: registering. parent: libata, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject_uevent_env
fill_kobj_path: path = '/module/libata'
kobject notes: registering. parent: libata, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
libata version 3.00 loaded.
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
scsi2 : sata_sil24
DEV: registering device: ID = 'host2'
kobject host2: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host2'
kobject host2: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host2'
class_uevent - name = host2
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host2'
scsi3 : sata_sil24
DEV: registering device: ID = 'host3'
kobject host3: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host3'
kobject host3: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host3'
class_uevent - name = host3
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host3'
scsi4 : sata_sil24
DEV: registering device: ID = 'host4'
kobject host4: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host4'
kobject host4: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host4'
class_uevent - name = host4
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host4'
scsi5 : sata_sil24
DEV: registering device: ID = 'host5'
kobject host5: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host5'
kobject host5: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host5'
class_uevent - name = host5
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host5'
ata1: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa0000 irq 31
ata2: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa2000 irq 31
ata3: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa4000 irq 31
ata4: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa6000 irq 31
ata1: ata_eh_recover - 1
ata1: ata_eh_recover - 2 re-enable link?
ata1.00: ata_eh_recover - 3
ata1.00: ata_eh_recover - 5
ata1.00: ata_eh_recover - 6
ata1.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata1: ata_eh_recover - 8a prep for EH
ata1: ata_eh_recover - reset
ata1: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata1: ata_eh_recover -> ata_eh_reset

ata1: hard resetting link
ata1: hardreset - 1!
ata1: hardreset - 2!
ata1: hardreset - 3!
ata1: hardreset - 4!
ata1: hardreset - 4a!
ata1: hardreset - 5!
ata1: hardreset - 6!
ata1: hardreset - 7 - ret -EAGAIN!
ata1: softreset failed (SRST command error) (-5)
ata1: reset failed (errno=-5), retrying in 7 secs
ata1: hard resetting link
ata1: hardreset - 1!
ata1: hardreset - 2!
ata1: hardreset - 3!
ata1: hardreset - 4!
ata1: hardreset - 4a!
ata1: hardreset - 5!
ata1: hardreset - 6!
ata1: hardreset - 7 - ret -EAGAIN!
ata1: softreset failed (SRST command error) (-5)
ata1: reset failed (errno=-5), retrying in 7 secs
ata1: hard resetting link
ata1: hardreset - 1!
ata1: hardreset - 2!
ata1: hardreset - 3!
ata1: hardreset - 4!
ata1: hardreset - 4a!
ata1: hardreset - 5!
ata1: hardreset - 6!
ata1: hardreset - 7 - ret -EAGAIN!
ata1: softreset failed (SRST command error) (-5)
ata1: reset failed (errno=-5), retrying in 32 secs
ata1: limiting SATA link speed to 1.5 Gbps
ata1: hard resetting link
ata1: hardreset - 1!
ata1: hardreset - 2!
ata1: hardreset - 3!
ata1: hardreset - 4!
ata1: hardreset - 4a!
ata1: hardreset - 5!
ata1: hardreset - 6!
ata1: hardreset - 7 - ret -EAGAIN!
ata1: softreset failed (SRST command error) (-5)
ata1: reset failed, giving up
ata2: ata_eh_recover - 1
ata2: ata_eh_recover - 2 re-enable link?
ata2.00: ata_eh_recover - 3
ata2.00: ata_eh_recover - 5
ata2.00: ata_eh_recover - 6
ata2.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata2: ata_eh_recover - 8a prep for EH
ata2: ata_eh_recover - reset
ata2: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata2: ata_eh_recover -> ata_eh_reset

ata2: hard resetting link
ata2: hardreset - 1!
ata2: hardreset - 2!
ata2: hardreset - 3!
ata2: hardreset - 4!
ata2: hardreset - 4a!
ata2: hardreset - 5!
ata2: hardreset - 6!
ata2: hardreset - 7 - ret -EAGAIN!
ata2: PHYS - no device
ata2: SATA link down (SStatus 0 SControl 0)
ata2: ata_eh_recover -> thawing

ata2: ata_eh_recover -> revalidate_and_attach
ata_eh_recover -> link okay?!
ata3: ata_eh_recover - 1
ata3: ata_eh_recover - 2 re-enable link?
ata3.00: ata_eh_recover - 3
ata3.00: ata_eh_recover - 5
ata3.00: ata_eh_recover - 6
ata3.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata3: ata_eh_recover - 8a prep for EH
ata3: ata_eh_recover - reset
ata3: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata3: ata_eh_recover -> ata_eh_reset

ata3: hard resetting link
ata3: hardreset - 1!
ata3: hardreset - 2!
ata3: hardreset - 3!
ata3: hardreset - 4!
ata3: hardreset - 4a!
ata3: hardreset - 5!
ata3: hardreset - 6!
ata3: hardreset - 7 - ret -EAGAIN!
ata3: PHYS - no device
ata3: SATA link down (SStatus 0 SControl 0)
ata3: ata_eh_recover -> thawing

ata3: ata_eh_recover -> revalidate_and_attach
ata_eh_recover -> link okay?!
ata4: ata_eh_recover - 1
ata4: ata_eh_recover - 2 re-enable link?
ata4.00: ata_eh_recover - 3
ata4.00: ata_eh_recover - 5
ata4.00: ata_eh_recover - 6
ata4.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata4: ata_eh_recover - 8a prep for EH
ata4: ata_eh_recover - reset
ata4: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata4: ata_eh_recover -> ata_eh_reset

ata4: hard resetting link
ata4: hardreset - 1!
ata4: hardreset - 2!
ata4: hardreset - 3!
ata4: hardreset - 4!
ata4: hardreset - 4a!
ata4: hardreset - 5!
ata4: hardreset - 6!
ata4: hardreset - 7 - ret -EAGAIN!
ata4: PHYS - no device
ata4: SATA link down (SStatus 0 SControl 0)
ata4: ata_eh_recover -> thawing

ata4: ata_eh_recover -> revalidate_and_attach
ata_eh_recover -> link okay?!
bound device '0000:00:07.0' to driver 'sata_sil24'
ata1: ata_eh_recover - 1
ata1: ata_eh_recover - 2 re-enable link?
ata1.00: ata_eh_recover - 3
ata1.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata1: ata_eh_recover - 8a prep for EH
ata1: ata_eh_recover - no reset
ata1: ata_eh_recover - ATA_DEV_UNKNOWN
ata1: ata_eh_recover -> revalidate_and_attach
ata1: attemping to enable power management!
ata_eh_recover -> link okay?!
ata2: ata_eh_recover - 1
ata2: ata_eh_recover - 2 re-enable link?
ata2.00: ata_eh_recover - 3
ata2.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata2: ata_eh_recover - 8a prep for EH
ata2: ata_eh_recover - no reset
ata2: ata_eh_recover - ATA_DEV_UNKNOWN
ata2: ata_eh_recover -> revalidate_and_attach
ata2: attemping to enable power management!
ata_eh_recover -> link okay?!
pci: Bound Device 0000:00:07.0 to Driver sata_sil24
kobject drivers: registering. parent: sata_sil24, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
ata3: ata_eh_recover - 1
ata3: ata_eh_recover - 2 re-enable link?
ata3.00: ata_eh_recover - 3
ata3.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata3: ata_eh_recover - 8a prep for EH
ata3: ata_eh_recover - no reset
ata3: ata_eh_recover - ATA_DEV_UNKNOWN
ata3: ata_eh_recover -> revalidate_and_attach
ata3: attemping to enable power management!
ata_eh_recover -> link okay?!
ata4: ata_eh_recover - 1
ata4: ata_eh_recover - 2 re-enable link?
ata4.00: ata_eh_recover - 3
ata4.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata4: ata_eh_recover - 8a prep for EH
ata4: ata_eh_recover - no reset
ata4: ata_eh_recover - ATA_DEV_UNKNOWN
ata4: ata_eh_recover -> revalidate_and_attach
ata4: attemping to enable power management!
ata_eh_recover -> link okay?!
eth0: Setting full-duplex based on MII#5 link partner capability of c5e1.
kobject 1: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/1'
DEV: registering device: ID = 'vcs2'
kobject vcs2: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs2'
DEV: registering device: ID = 'vcsa2'
kobject vcsa2: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa2'
DEV: Unregistering device. ID = 'vcs2'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs2'
kobject vcs2: cleaning up
device_create_release called for vcs2
DEV: Unregistering device. ID = 'vcsa2'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa2'
kobject vcsa2: cleaning up
device_create_release called for vcsa2
DEV: registering device: ID = 'vcs3'
kobject vcs3: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs3'
DEV: registering device: ID = 'vcsa3'
kobject vcsa3: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa3'
DEV: Unregistering device. ID = 'vcs3'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs3'
kobject vcs3: cleaning up
device_create_release called for vcs3
DEV: Unregistering device. ID = 'vcsa3'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa3'
kobject vcsa3: cleaning up
device_create_release called for vcsa3
DEV: registering device: ID = 'vcs4'
kobject vcs4: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs4'
DEV: registering device: ID = 'vcsa4'
kobject vcsa4: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa4'
DEV: Unregistering device. ID = 'vcs4'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs4'
kobject vcs4: cleaning up
device_create_release called for vcs4
DEV: Unregistering device. ID = 'vcsa4'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa4'
kobject vcsa4: cleaning up
device_create_release called for vcsa4
DEV: registering device: ID = 'vcs5'
kobject vcs5: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs5'
DEV: registering device: ID = 'vcsa5'
kobject vcsa5: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa5'
DEV: Unregistering device. ID = 'vcs5'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs5'
kobject vcs5: cleaning up
device_create_release called for vcs5
DEV: Unregistering device. ID = 'vcsa5'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa5'
kobject vcsa5: cleaning up
device_create_release called for vcsa5
DEV: registering device: ID = 'vcs2'
kobject vcs2: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs2'
DEV: registering device: ID = 'vcsa2'
kobject vcsa2: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa2'
DEV: Unregistering device. ID = 'vcs2'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs2'
kobject vcs2: cleaning up
device_create_release called for vcs2
DEV: Unregistering device. ID = 'vcsa2'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa2'
kobject vcsa2: cleaning up
device_create_release called for vcsa2
DEV: registering device: ID = 'vcs3'
kobject vcs3: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs3'
DEV: registering device: ID = 'vcsa3'
kobject vcsa3: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa3'
DEV: Unregistering device. ID = 'vcs3'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs3'
kobject vcs3: cleaning up
device_create_release called for vcs3
DEV: Unregistering device. ID = 'vcsa3'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa3'
kobject vcsa3: cleaning up
device_create_release called for vcsa3
DEV: registering device: ID = 'vcs4'
kobject vcs4: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs4'
DEV: registering device: ID = 'vcsa4'
kobject vcsa4: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa4'
DEV: Unregistering device. ID = 'vcs4'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs4'
kobject vcs4: cleaning up
device_create_release called for vcs4
DEV: Unregistering device. ID = 'vcsa4'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa4'
kobject vcsa4: cleaning up
device_create_release called for vcsa4
DEV: registering device: ID = 'vcs5'
kobject vcs5: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs5'
DEV: registering device: ID = 'vcsa5'
kobject vcsa5: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa5'
DEV: Unregistering device. ID = 'vcs5'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs5'
kobject vcs5: cleaning up
device_create_release called for vcs5
DEV: Unregistering device. ID = 'vcsa5'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa5'
kobject vcsa5: cleaning up
device_create_release called for vcsa5
DEV: registering device: ID = 'vcs6'
kobject vcs6: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs6'
DEV: registering device: ID = 'vcsa6'
kobject vcsa6: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa6'
DEV: Unregistering device. ID = 'vcs6'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs6'
kobject vcs6: cleaning up
device_create_release called for vcs6
DEV: Unregistering device. ID = 'vcsa6'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa6'
kobject vcsa6: cleaning up
device_create_release called for vcsa6
DEV: Unregistering device. ID = 'vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject vcs1: cleaning up
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject vcsa1: cleaning up
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
DEV: Unregistering device. ID = 'vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject vcs1: cleaning up
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject vcsa1: cleaning up
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
DEV: Unregistering device. ID = 'vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject vcs1: cleaning up
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject vcsa1: cleaning up
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
DEV: Unregistering device. ID = 'vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject vcs1: cleaning up
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject vcsa1: cleaning up
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
ndbd(6248): unaligned trap at 000000012025652c: 00000001203f00b5 28 1
ndbd(6248): unaligned trap at 0000000120256538: 00000001203f00b5 2c 2
ndbd(6248): unaligned trap at 000000012025652c: 00000001203f00b5 28 1
ndbd(6248): unaligned trap at 0000000120256538: 00000001203f00b5 2c 2
kobject 106: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/106'
kobject 114: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/114'
kobject 115: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/115'
dbus-daemon(6408): unaligned trap at 000000012003aef4: 000000011f959331 28 3
dbus-daemon(6408): unaligned trap at 000000012003af14: 000000011f959331 2c 3
dbus-daemon(6408): unaligned trap at 000000012003aef4: 000000011f959331 28 3
dbus-daemon(6408): unaligned trap at 000000012003af14: 000000011f959331 2c 3
kobject 104: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/104'
kobject 65534: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/65534'
kobject 111: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/111'
kobject 110: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/110'
device eth0 entered promiscuous mode
dbus-daemon(6408): unaligned trap at 000000012003aef4: 000000011f959331 28 3
dbus-daemon(6408): unaligned trap at 000000012003af14: 000000011f959331 2c 3
dbus-daemon(6408): unaligned trap at 000000012003aef4: 000000011f959331 28 3
dbus-daemon(6408): unaligned trap at 000000012003af14: 000000011f959331 2c 3
DEV: Unregistering device. ID = 'vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject vcs1: cleaning up
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject vcsa1: cleaning up
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
DEV: registering device: ID = 'vcs2'
kobject vcs2: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs2'
DEV: registering device: ID = 'vcsa2'
kobject vcsa2: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa2'
DEV: registering device: ID = 'vcs4'
kobject vcs4: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs4'
DEV: registering device: ID = 'vcsa4'
kobject vcsa4: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa4'
DEV: registering device: ID = 'vcs3'
kobject vcs3: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs3'
DEV: registering device: ID = 'vcsa3'
kobject vcsa3: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa3'
DEV: registering device: ID = 'vcs5'
kobject vcs5: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs5'
DEV: registering device: ID = 'vcsa5'
kobject vcsa5: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa5'
DEV: registering device: ID = 'vcs6'
kobject vcs6: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs6'
DEV: registering device: ID = 'vcsa6'
kobject vcsa6: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa6'
dbus-daemon(6408): unaligned trap at 000000012003aef4: 000000011f9592f1 28 3
dbus-daemon(6408): unaligned trap at 000000012003af14: 000000011f9592f1 2c 3
dbus-daemon(6408): unaligned trap at 000000012003aef4: 000000011f9592f1 28 3
dbus-daemon(6408): unaligned trap at 000000012003af14: 000000011f9592f1 2c 3
kobject 33: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/33'
kobject 102: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/102'
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/102'
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/110'
kobject 1000: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/1000'
kobject 102: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/102'
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/1000'
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/102'
kobject 101: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/101'
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/101'
bus pci: remove driver sata_sil24
CLASS: Unregistering class device. ID = 'host2'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host2'
class_uevent - name = host2
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host2'
kobject host2: cleaning up
device class 'host2': release.
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: Unregistering class device. ID = 'host3'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host3'
class_uevent - name = host3
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host3'
kobject host3: cleaning up
device class 'host3': release.
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: Unregistering class device. ID = 'host4'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host4'
class_uevent - name = host4
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host4'
kobject host4: cleaning up
device class 'host4': release.
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: Unregistering class device. ID = 'host5'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host5'
class_uevent - name = host5
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host5'
kobject host5: cleaning up
device class 'host5': release.
kobject_uevent_env
kobject filter function caused the event to drop!
kobject host2: cleaning up
kobject host3: cleaning up
kobject host4: cleaning up
kobject host5: cleaning up
kobject sata_sil24: unregistering
kobject_uevent_env
fill_kobj_path: path = '/bus/pci/drivers/sata_sil24'
kobject sata_sil24: cleaning up
kobject drivers: unregistering
kobject_uevent_env
kobject filter function caused the event to drop!
kobject drivers: cleaning up
kobject holders: unregistering
kobject_uevent_env
kobject filter function caused the event to drop!
kobject holders: cleaning up
kobject sata_sil24: unregistering
kobject_uevent_env
fill_kobj_path: path = '/module/sata_sil24'
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
PCI: Enabling bus mastering for device 0000:00:07.0
scsi6 : sata_sil24
DEV: registering device: ID = 'host6'
kobject host6: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host6'
kobject host6: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host6'
class_uevent - name = host6
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host6'
scsi7 : sata_sil24
DEV: registering device: ID = 'host7'
kobject host7: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host7'
kobject host7: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host7'
class_uevent - name = host7
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host7'
scsi8 : sata_sil24
DEV: registering device: ID = 'host8'
kobject host8: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host8'
kobject host8: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host8'
class_uevent - name = host8
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host8'
scsi9 : sata_sil24
DEV: registering device: ID = 'host9'
kobject host9: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host9'
kobject host9: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host9'
class_uevent - name = host9
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host9'
ata5: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa0000 irq 31
ata6: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa2000 irq 31
ata7: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa4000 irq 31
ata8: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa6000 irq 31
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
ata5: softreset failed (SRST command error) (-5)
ata5: reset failed, giving up
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
ata5: ata_eh_recover - 1
ata5: ata_eh_recover - 2 re-enable link?
ata5.00: ata_eh_recover - 3
ata5.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata5: ata_eh_recover - 8a prep for EH
ata5: ata_eh_recover - no reset
ata5: ata_eh_recover - ATA_DEV_UNKNOWN
ata5: ata_eh_recover -> revalidate_and_attach
ata5: attemping to enable power management!
ata_eh_recover -> link okay?!
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
ata7: ata_eh_recover - 1
ata7: ata_eh_recover - 2 re-enable link?
ata7.00: ata_eh_recover - 3
ata7.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata7: ata_eh_recover - 8a prep for EH
ata7: ata_eh_recover - no reset
ata7: ata_eh_recover - ATA_DEV_UNKNOWN
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
ata7: ata_eh_recover -> revalidate_and_attach
ata7: attemping to enable power management!
ata_eh_recover -> link okay?!
bus pci: remove driver sata_sil24
CLASS: Unregistering class device. ID = 'host6'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host6'
class_uevent - name = host6
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host6'
kobject host6: cleaning up
device class 'host6': release.
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: Unregistering class device. ID = 'host7'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host7'
class_uevent - name = host7
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host7'
kobject host7: cleaning up
device class 'host7': release.
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: Unregistering class device. ID = 'host8'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host8'
class_uevent - name = host8
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host8'
kobject host8: cleaning up
device class 'host8': release.
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: Unregistering class device. ID = 'host9'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host9'
class_uevent - name = host9
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host9'
kobject host9: cleaning up
device class 'host9': release.
kobject_uevent_env
kobject filter function caused the event to drop!
kobject host6: cleaning up
kobject host7: cleaning up
kobject host8: cleaning up
kobject host9: cleaning up
kobject sata_sil24: unregistering
kobject_uevent_env
fill_kobj_path: path = '/bus/pci/drivers/sata_sil24'
kobject sata_sil24: cleaning up
kobject drivers: unregistering
kobject_uevent_env
kobject filter function caused the event to drop!
kobject drivers: cleaning up
kobject holders: unregistering
kobject_uevent_env
kobject filter function caused the event to drop!
kobject holders: cleaning up
kobject sata_sil24: unregistering
kobject_uevent_env
fill_kobj_path: path = '/module/sata_sil24'
kobject holders: unregistering
kobject_uevent_env
kobject filter function caused the event to drop!
kobject holders: cleaning up
kobject libata: unregistering
kobject_uevent_env
fill_kobj_path: path = '/module/libata'
kobject libata: registering. parent: <NULL>, set: module
kobject holders: registering. parent: libata, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject_uevent_env
fill_kobj_path: path = '/module/libata'
kobject notes: registering. parent: libata, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
libata version 3.00 loaded.
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
PCI: Enabling bus mastering for device 0000:00:07.0
scsi10 : sata_sil24
DEV: registering device: ID = 'host10'
kobject host10: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host10'
kobject host10: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host10'
class_uevent - name = host10
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host10'
scsi11 : sata_sil24
DEV: registering device: ID = 'host11'
kobject host11: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host11'
kobject host11: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host11'
class_uevent - name = host11
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host11'
scsi12 : sata_sil24
DEV: registering device: ID = 'host12'
kobject host12: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host12'
kobject host12: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host12'
class_uevent - name = host12
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host12'
scsi13 : sata_sil24
DEV: registering device: ID = 'host13'
kobject host13: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host13'
kobject host13: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host13'
class_uevent - name = host13
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host13'
ata1: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa0000 irq 31
ata2: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa2000 irq 31
ata3: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa4000 irq 31
ata4: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa6000 irq 31
ata1: ata_eh_recover - 1
ata1: ata_eh_recover - 2 re-enable link?
ata1.00: ata_eh_recover - 3
ata1.00: ata_eh_recover - 5
ata1.00: ata_eh_recover - 6
ata1.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata1: ata_eh_recover - 8a prep for EH
ata1: ata_eh_recover - reset
ata1: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata1: ata_eh_recover -> ata_eh_reset

ata1: hard resetting link
ata1: hardreset - 1!
ata1: hardreset - 2!
ata1: hardreset - 3!
ata1: hardreset - 4!
ata1: hardreset - 4a!
ata1: hardreset - 5!
ata1: hardreset - 6!
ata1: hardreset - 7 - ret -EAGAIN!
ata1: softreset failed (SRST command error) (-5)
ata1: reset failed (errno=-5), retrying in 7 secs
ata1: hard resetting link
ata1: hardreset - 1!
ata1: hardreset - 2!
ata1: hardreset - 3!
ata1: hardreset - 4!
ata1: hardreset - 4a!
ata1: hardreset - 5!
ata1: hardreset - 6!
ata1: hardreset - 7 - ret -EAGAIN!
ata1: softreset failed (SRST command error) (-5)
ata1: reset failed (errno=-5), retrying in 7 secs
ata1: hard resetting link
ata1: hardreset - 1!
ata1: hardreset - 2!
ata1: hardreset - 3!
ata1: hardreset - 4!
ata1: hardreset - 4a!
ata1: hardreset - 5!
ata1: hardreset - 6!
ata1: hardreset - 7 - ret -EAGAIN!
ata1: softreset failed (SRST command error) (-5)
ata1: reset failed (errno=-5), retrying in 32 secs
ata1: hard resetting link
ata1: hardreset - 1!
ata1: hardreset - 2!
ata1: hardreset - 3!
ata1: hardreset - 4!
ata1: hardreset - 4a!
ata1: hardreset - 5!
ata1: hardreset - 6!
ata1: hardreset - 7 - ret -EAGAIN!
ata1: softreset failed (SRST command error) (-5)
ata1: reset failed, giving up
ata2: ata_eh_recover - 1
ata2: ata_eh_recover - 2 re-enable link?
ata2.00: ata_eh_recover - 3
ata2.00: ata_eh_recover - 5
ata2.00: ata_eh_recover - 6
ata2.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata2: ata_eh_recover - 8a prep for EH
ata2: ata_eh_recover - reset
ata2: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata2: ata_eh_recover -> ata_eh_reset

ata2: hard resetting link
ata2: hardreset - 1!
ata2: hardreset - 2!
ata2: hardreset - 3!
ata2: hardreset - 4!
ata2: hardreset - 4a!
ata2: hardreset - 5!
ata2: hardreset - 6!
ata2: hardreset - 7 - ret -EAGAIN!
ata2: PHYS - no device
ata2: SATA link down (SStatus 0 SControl 0)
ata2: ata_eh_recover -> thawing

ata2: ata_eh_recover -> revalidate_and_attach
ata_eh_recover -> link okay?!
ata3: ata_eh_recover - 1
ata3: ata_eh_recover - 2 re-enable link?
ata3.00: ata_eh_recover - 3
ata3.00: ata_eh_recover - 5
ata3.00: ata_eh_recover - 6
ata3.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata3: ata_eh_recover - 8a prep for EH
ata3: ata_eh_recover - reset
ata3: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata3: ata_eh_recover -> ata_eh_reset

ata3: hard resetting link
ata3: hardreset - 1!
ata3: hardreset - 2!
ata3: hardreset - 3!
ata3: hardreset - 4!
ata3: hardreset - 4a!
ata3: hardreset - 5!
ata3: hardreset - 6!
ata3: hardreset - 7 - ret -EAGAIN!
ata3: PHYS - no device
ata3: SATA link down (SStatus 0 SControl 0)
ata3: ata_eh_recover -> thawing

ata3: ata_eh_recover -> revalidate_and_attach
ata_eh_recover -> link okay?!
ata4: ata_eh_recover - 1
ata4: ata_eh_recover - 2 re-enable link?
ata4.00: ata_eh_recover - 3
ata4.00: ata_eh_recover - 5
ata4.00: ata_eh_recover - 6
ata4.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata4: ata_eh_recover - 8a prep for EH
ata4: ata_eh_recover - reset
ata4: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata4: ata_eh_recover -> ata_eh_reset

ata4: hard resetting link
ata4: hardreset - 1!
ata4: hardreset - 2!
ata4: hardreset - 3!
ata4: hardreset - 4!
ata4: hardreset - 4a!
ata4: hardreset - 5!
ata4: hardreset - 6!
ata4: hardreset - 7 - ret -EAGAIN!
ata4: PHYS - no device
ata4: SATA link down (SStatus 0 SControl 0)
ata4: ata_eh_recover -> thawing

ata4: ata_eh_recover -> revalidate_and_attach
ata_eh_recover -> link okay?!
bound device '0000:00:07.0' to driver 'sata_sil24'
pci: Bound Device 0000:00:07.0 to Driver sata_sil24
kobject drivers: registering. parent: sata_sil24, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
ata1: ata_eh_recover - 1
ata1: ata_eh_recover - 2 re-enable link?
ata1.00: ata_eh_recover - 3
ata1.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata1: ata_eh_recover - 8a prep for EH
ata1: ata_eh_recover - no reset
ata1: ata_eh_recover - ATA_DEV_UNKNOWN
ata1: ata_eh_recover -> revalidate_and_attach
ata1: attemping to enable power management!
ata_eh_recover -> link okay?!
ata2: ata_eh_recover - 1
ata2: ata_eh_recover - 2 re-enable link?
ata2.00: ata_eh_recover - 3
ata2.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata2: ata_eh_recover - 8a prep for EH
ata2: ata_eh_recover - no reset
ata2: ata_eh_recover - ATA_DEV_UNKNOWN
ata2: ata_eh_recover -> revalidate_and_attach
ata2: attemping to enable power management!
ata_eh_recover -> link okay?!
ata3: ata_eh_recover - 1
ata3: ata_eh_recover - 2 re-enable link?
ata3.00: ata_eh_recover - 3
ata3.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata3: ata_eh_recover - 8a prep for EH
ata3: ata_eh_recover - no reset
ata3: ata_eh_recover - ATA_DEV_UNKNOWN
ata3: ata_eh_recover -> revalidate_and_attach
ata3: attemping to enable power management!
ata_eh_recover -> link okay?!
ata4: ata_eh_recover - 1
ata4: ata_eh_recover - 2 re-enable link?
ata4.00: ata_eh_recover - 3
ata4.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata4: ata_eh_recover - 8a prep for EH
ata4: ata_eh_recover - no reset
ata4: ata_eh_recover - ATA_DEV_UNKNOWN
ata4: ata_eh_recover -> revalidate_and_attach
ata4: attemping to enable power management!
ata_eh_recover -> link okay?!

--------------090203000703010401050700--
