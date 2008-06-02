From: JR Wilbert <jr.wilbert@gmail.com>
Subject: Re: Port Multiplier drives not always all found on cold plug
Date: Mon, 2 Jun 2008 03:38:16 +0000 (UTC)
Message-ID: <loom.20080602T033723-77@post.gmane.org>
References: <482DB79F.2030204@rtr.ca> <482DBA62.4020209@rtr.ca> <482DBC5C.3020904@rtr.ca> <482DC41F.9080901@rtr.ca> <482DCD1F.4090503@rtr.ca> <482EE9E1.5000805@gmail.com> <482F16AB.1040003@rtr.ca> <482F1B5C.2000006@gmail.com> <482F2F1C.9030102@rtr.ca> <482FBD41.7020604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:40135 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438AbYFBDkH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Jun 2008 23:40:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1K30tu-0007Js-6w
	for linux-ide@vger.kernel.org; Mon, 02 Jun 2008 03:40:02 +0000
Received: from static-71-251-65-16.tampfl.fios.verizon.net ([71.251.65.16])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 02 Jun 2008 03:40:02 +0000
Received: from jr.wilbert by static-71-251-65-16.tampfl.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 02 Jun 2008 03:40:02 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Forgive me if I am posting off topic or in the wrong place. 

I am also experiencing the same problem but with sata_sil24 running  Fedora Core
9  with kernel 2.6.25.3-18.fc9.i686.  And I think you are right about it not
being contained with sata_mv  

On cold boot with all drives in the array the system fails to see any drives. If
 I boot without the drives I can connect them , up to 3 drives. 


If do  rmmod sata_sil24 && modprobe sata_sil24 with 3 out of 4 drives connected. 
And it takes some time to load sata_sil24 

If I am wrong for posting here please let me know.  If I can help in anyway also
let me know. 


Thank you



Here is some logs / info about what I have 

/**
 * output of lshal  of SIlcon Image 3124 
 *
udi = '/org/freedesktop/Hal/devices/pci_1095_3124'
  info.linux.driver = 'sata_sil24'  (string)
  info.parent = '/org/freedesktop/Hal/devices/pci_8086_244e'  (string)
  info.product = 'SiI 3124 PCI-X Serial ATA Controller'  (string)
  info.subsystem = 'pci'  (string)
  info.udi = '/org/freedesktop/Hal/devices/pci_1095_3124'  (string)
  info.vendor = 'Silicon Image, Inc.'  (string)
  linux.hotplug_type = 2  (0x2)  (int)
  linux.subsystem = 'pci'  (string)
  linux.sysfs_path = '/sys/devices/pci0000:00/0000:00:1e.0/0000:01:07.0'  (string)
  pci.device_class = 1  (0x1)  (int)
  pci.device_protocol = 0  (0x0)  (int)
  pci.device_subclass = 128  (0x80)  (int)
  pci.linux.sysfs_path = '/sys/devices/pci0000:00/0000:00:1e.0/0000:01:07.0' 
(string)
  pci.product = 'SiI 3124 PCI-X Serial ATA Controller'  (string)
  pci.product_id = 12580  (0x3124)  (int)
  pci.subsys_product = 'SiI 3124 PCI-X Serial ATA Controller'  (string)
  pci.subsys_product_id = 12580  (0x3124)  (int)
  pci.subsys_vendor = 'Silicon Image, Inc.'  (string)
  pci.subsys_vendor_id = 4245  (0x1095)  (int)
  pci.vendor = 'Silicon Image, Inc.'  (string)
  pci.vendor_id = 4245  (0x1095)  (int)
 *
 */


/**
 * output of mod reload 
[root@localhost ~]# rmmod sata_sil24 && time modprobe sata_sil24 

real    1m16.232s
user    0m0.020s
sys     0m0.019s
 *
 */



/**
 * dmesg of ata 
 *
scsi14 : sata_sil24
scsi15 : sata_sil24
scsi16 : sata_sil24
scsi17 : sata_sil24
ata15: SATA max UDMA/100 host m128@0xfdfffc00 port 0xfdff0000 irq 9
ata16: SATA max UDMA/100 host m128@0xfdfffc00 port 0xfdff2000 irq 9
ata17: SATA max UDMA/100 host m128@0xfdfffc00 port 0xfdff4000 irq 9
ata18: SATA max UDMA/100 host m128@0xfdfffc00 port 0xfdff6000 irq 9
ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
ata15.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
ata15.00: hard resetting link
ata15.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata15.01: hard resetting link
ata15.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata15.02: hard resetting link
ata15.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata15.03: hard resetting link
ata15.03: SATA link down (SStatus 0 SControl 310)
ata15.04: hard resetting link
ata15.04: softreset failed (SRST command error)
ata15.04: reset failed (errno=-5), retrying in 10 secs
ata15.04: hard resetting link
ata15.04: failed to read SCR 2 (Emask=0x40)
ata15.04: failed to read SCR 2 (Emask=0x40)
ata15.04: COMRESET failed (errno=-5)
ata15.04: failed to read SCR 0 (Emask=0x40)
ata15.04: reset failed, giving up
ata15.15: hard resetting link
ata15.15: softreset failed (SRST command error)
ata15.15: reset failed (errno=-5), retrying in 8 secs
ata15.15: hard resetting link
ata15.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
ata15.00: hard resetting link
ata15.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata15.01: hard resetting link
ata15.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata15.02: hard resetting link
ata15.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata15.03: hard resetting link
ata15.03: SATA link down (SStatus 0 SControl 310)
ata15.04: hard resetting link
ata15.04: softreset failed (SRST command error)
ata15.04: reset failed (errno=-5), retrying in 10 secs
ata15.04: hard resetting link
ata15.04: failed to read SCR 2 (Emask=0x40)
ata15.04: failed to read SCR 2 (Emask=0x40)
ata15.04: COMRESET failed (errno=-5)
ata15.04: failed to read SCR 0 (Emask=0x40)
ata15.04: reset failed, giving up
ata15.15: hard resetting link
ata15: controller in dubious state, performing PORT_RST
ata15.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
ata15.00: hard resetting link
ata15.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata15.01: hard resetting link
ata15.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata15.02: hard resetting link
ata15.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata15.03: hard resetting link
ata15.03: SATA link down (SStatus 0 SControl 310)
ata15.04: hard resetting link
ata15.04: softreset failed (SRST command error)
ata15.04: reset failed (errno=-5), retrying in 10 secs
ata15.04: hard resetting link
ata15.04: failed to read SCR 2 (Emask=0x40)
ata15.04: failed to read SCR 2 (Emask=0x40)
ata15.04: COMRESET failed (errno=-5)
ata15.04: failed to read SCR 0 (Emask=0x40)
ata15.04: reset failed, giving up
ata15.04: failed to recover link after 3 tries, disabling
ata15: failed to recover PMP, retrying in 5 secs
ata15.15: hard resetting link
ata15.15: softreset failed (SRST command error)
ata15.15: reset failed (errno=-5), retrying in 8 secs
ata15.15: hard resetting link
ata15.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
ata15.00: hard resetting link
ata15.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata15.01: hard resetting link
ata15.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata15.02: hard resetting link
ata15.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata15.03: hard resetting link
ata15.03: SATA link down (SStatus 0 SControl 310)
ata15.05: hard resetting link
ata15.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata15.00: ATA-8: WDC WD7500AACS-00ZJB0, 01.01B01, max UDMA/133
ata15.00: 1465149168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata15.00: configured for UDMA/100
ata15.01: ATA-8: WDC WD7500AACS-00ZJB0, 01.01B01, max UDMA/133
ata15.01: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata15.01: configured for UDMA/100
ata15.02: ATA-8: WDC WD7500AACS-00ZJB0, 01.01B01, max UDMA/133
ata15.02: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata15.02: configured for UDMA/100
ata15.00: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x1 t4
ata15.00: irq_stat 0x00060002, failed to transmit command FIS
ata15.00: configured for UDMA/100
ata15: EH complete
ata16: SATA link down (SStatus 0 SControl 0)
ata17: SATA link down (SStatus 0 SControl 0)
ata18: SATA link down (SStatus 0 SControl 0)
scsi 14:0:0:0: Direct-Access     ATA      WDC WD7500AACS-0 01.0 PQ: 0 ANSI: 5
sd 14:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
sd 14:0:0:0: [sdb] Write Protect is off
sd 14:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 14:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
sd 14:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
sd 14:0:0:0: [sdb] Write Protect is off
sd 14:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 14:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
 sdb: sdb1
sd 14:0:0:0: [sdb] Attached SCSI disk
sd 14:0:0:0: Attached scsi generic sg2 type 0
scsi 14:1:0:0: Direct-Access     ATA      WDC WD7500AACS-0 01.0 PQ: 0 ANSI: 5
sd 14:1:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
sd 14:1:0:0: [sdc] Write Protect is off
sd 14:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 14:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
sd 14:1:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
sd 14:1:0:0: [sdc] Write Protect is off
sd 14:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 14:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
 sdc: sdc1
sd 14:1:0:0: [sdc] Attached SCSI disk
sd 14:1:0:0: Attached scsi generic sg3 type 0
scsi 14:2:0:0: Direct-Access     ATA      WDC WD7500AACS-0 01.0 PQ: 0 ANSI: 5
sd 14:2:0:0: [sdd] 1465149168 512-byte hardware sectors (750156 MB)
sd 14:2:0:0: [sdd] Write Protect is off
sd 14:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 14:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
sd 14:2:0:0: [sdd] 1465149168 512-byte hardware sectors (750156 MB)
sd 14:2:0:0: [sdd] Write Protect is off
sd 14:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 14:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
 sdd: sdd1
sd 14:2:0:0: [sdd] Attached SCSI disk
sd 14:2:0:0: Attached scsi generic sg4 type 0

*/










