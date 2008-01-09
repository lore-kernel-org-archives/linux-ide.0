From: Andrew Ryder <tireman@shaw.ca>
Subject: Re: Sata 4726 Testing
Date: Wed, 09 Jan 2008 18:55:46 -0500
Message-ID: <47855F02.3010407@shaw.ca>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com>
 <476D16E2.1050909@shaw.ca> <47824F69.6080007@gmail.com>
 <4782A79E.5000607@shaw.ca> <4782F3DB.6000906@gmail.com>
 <47832D82.2020106@shaw.ca> <47845F91.9000705@gmail.com>
 <47859132.1000700@gmail.com> <4785521B.6070205@shaw.ca>
 <47859D1A.8010006@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------070901050307070705060705
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:42269 "EHLO
	pd3mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbYAJFFZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jan 2008 00:05:25 -0500
Received: from pd2mr2so.prod.shaw.ca
 (pd2mr2so-qfe3.prod.shaw.ca [10.0.141.109]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUE00L3ZWQKPB80@l-daemon> for linux-ide@vger.kernel.org; Wed,
 09 Jan 2008 22:03:56 -0700 (MST)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
 by pd2mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JUE001XBWOICL20@pd2mr2so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Wed, 09 Jan 2008 22:03:57 -0700 (MST)
Received: from [192.168.0.2] ([70.76.194.32])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUE00GK0WOCIO10@l-daemon> for linux-ide@vger.kernel.org; Wed,
 09 Jan 2008 22:02:41 -0700 (MST)
In-reply-to: <47859D1A.8010006@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070901050307070705060705
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This might be of interest.. I had turned the drive off for about 20
minutes, then turned it back on. ata1.03 is now partially there, it is
recognized as a device, but of 0MB in size.

All of this is done with the 4726 turned on..

Bootlog11.txt -> I unplugged the 4726, waited 10 seconds, and plugged it
into the second port on the 3124. All 4 drives are there.

Bootlog12.txt -> I unplugged the 4726 again, waited 10 seconds, plugged
it back into the first (original) port, and ata1.03 is back..

Bootlog13.txt -> I powered the 4726 off, waited 10 seconds, turned it
back on. The same drive is missing now.

Bootlog14.txt -> I unplugged, waited 10 seconds, and re-plugged the 4726
into the same port (first eSATA port) and now ata1.03 is recognized and
accessible.


I'll make sure to turn on the timestamping for you tomorrow. Would want
me to redo this testing so you can have the timestamps also?

Thanks


Tejun Heo wrote:
> Andrew Ryder wrote:
>   
>> Tejun,
>>
>> I rebooted with the 4726 online during bootup, verified everything was
>> there by re-formatting the fs on each drive. I powered off the 4726 for
>> approx 15 seconds, turned it back on, and repeated the power on/off
>> again about 1 minute later.
>>
>> The first 3 drives are accessible, but the 4th drive on ata1.03 failed
>> to be recognized.
>>     
>
> Hmmm... That's interesting.  The fourth drive seemed to have gone out
> for lunch.  If you can, does connecting the drive to another port (be it
> PMP port or not) without removing power make the drive work again?  If
> you can't do that, does removing the drive and re-plugging revives it?
> Please try to determine who went out for lunch - the PMP port or the
> drive.  Also, can you please turn on CONFIG_PRINTK_TIME so that I can
> tell what's happening when?
>
> Thanks.
>
>   


--------------070901050307070705060705
Content-Type: text/plain;
 name="Bootlog11.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Bootlog11.txt"

6>hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c400
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.3: irq 21, io base 0x0000c800
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
Audigy2 value: Special config.
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:10.4: irq 21, io mem 0xfdf00000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Disallowing DAC for device 0000:00:0e.0
e1000: 0000:00:0e.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:62:c5:46
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
ReiserFS: hdb1: using ordered data mode
ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdb1: checking transaction log (hdb1)
ReiserFS: hdb1: Using r5 hash to sort names
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
hda: UDMA/100 mode selected
hdb: UDMA/133 mode selected
hdc: UDMA/33 mode selected
hdd: UDMA/33 mode selected
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
w83627hf: Found W83697HF chip at 0x290
ata1.00: failed to read SCR 1 (Emask=0x40)
ata1.01: failed to read SCR 1 (Emask=0x40)
ata1.02: failed to read SCR 1 (Emask=0x40)
ata1.03: failed to read SCR 1 (Emask=0x40)
ata1.04: failed to read SCR 1 (Emask=0x40)
ata1.05: failed to read SCR 1 (Emask=0x40)
ata1.06: failed to read SCR 1 (Emask=0x40)
ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x90000 action 0xa frozen
ata1.15: irq_stat 0x01b40090, PHY RDY changed
ata1: SError: { PHYRdyChg 10B8B }
ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 0)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 0)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: limiting SATA link speed to 1.5 Gbps
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 310)
ata1.05: hard resetting link
ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
ata1.06: hard resetting link
ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.00: revalidation failed (errno=-5)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.01: revalidation failed (errno=-5)
ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.02: revalidation failed (errno=-5)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.03: revalidation failed (errno=-5)
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: failed to recover some devices, retrying in 5 secs
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
ata1.02: configured for UDMA/100
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.03: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.03: revalidation failed (errno=-5)
ata1.03: disabled
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1: EH complete
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdf] Write Protect is off
sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdf] Write Protect is off
sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
ata1.03: detaching (SCSI 1:3:0:0)
sd 1:3:0:0: [sde] Synchronizing SCSI cache
sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
sd 1:3:0:0: [sde] Stopping disk
sd 1:3:0:0: [sde] START_STOP FAILED
sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
ata1.00: failed to read SCR 1 (Emask=0x40)
ata1.01: failed to read SCR 1 (Emask=0x40)
ata1.02: failed to read SCR 1 (Emask=0x40)
ata1.03: failed to read SCR 1 (Emask=0x40)
ata1.04: failed to read SCR 1 (Emask=0x40)
ata1.05: failed to read SCR 1 (Emask=0x40)
ata1.06: failed to read SCR 1 (Emask=0x40)
ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
ata1.15: irq_stat 0x01940090, PHY RDY changed
ata1: SError: { 10B8B }
ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 310)
ata1.05: hard resetting link
ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
ata1.06: hard resetting link
ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.00: revalidation failed (errno=-5)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.01: revalidation failed (errno=-5)
ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.02: revalidation failed (errno=-5)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: failed to recover some devices, retrying in 5 secs
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
ata1.02: configured for UDMA/100
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1: EH complete
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdf] Write Protect is off
sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdf] Write Protect is off
sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
ata1.00: failed to read SCR 1 (Emask=0x40)
ata1.01: failed to read SCR 1 (Emask=0x40)
ata1.02: failed to read SCR 1 (Emask=0x40)
ata1.03: failed to read SCR 1 (Emask=0x40)
ata1.04: failed to read SCR 1 (Emask=0x40)
ata1.05: failed to read SCR 1 (Emask=0x40)
ata1.06: failed to read SCR 1 (Emask=0x40)
ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
ata1.15: irq_stat 0x01140010, PHY RDY changed
ata1: SError: { 10B8B }
ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: failed to recover PMP after 5 tries, giving up
ata1.15: Port Multiplier detaching
ata1.00: disabled
ata1.01: disabled
ata1.02: disabled
ata1.05: disabled
ata1.00: disabled
ata1: hard resetting link
ata1: SATA link down (SStatus 1 SControl 0)
ata1: EH complete
ata1.00: detaching (SCSI 1:0:0:0)
sd 1:0:0:0: [sdb] Synchronizing SCSI cache
sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
sd 1:0:0:0: [sdb] Stopping disk
sd 1:0:0:0: [sdb] START_STOP FAILED
sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
ata1.01: detaching (SCSI 1:1:0:0)
sd 1:1:0:0: [sdc] Synchronizing SCSI cache
sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
sd 1:1:0:0: [sdc] Stopping disk
sd 1:1:0:0: [sdc] START_STOP FAILED
sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
ata1.02: detaching (SCSI 1:2:0:0)
sd 1:2:0:0: [sdd] Synchronizing SCSI cache
sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
sd 1:2:0:0: [sdd] Stopping disk
sd 1:2:0:0: [sdd] START_STOP FAILED
sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
ata1.05: detaching (SCSI 1:5:0:0)
sd 1:5:0:0: [sdf] Stopping disk
sd 1:5:0:0: [sdf] START_STOP FAILED
sd 1:5:0:0: [sdf] Result: hostbyte=0x04 driverbyte=0x00
ata1: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xa frozen
ata1: irq_stat 0x00a40080, device exchanged
ata1: SError: { PHYRdyChg }
ata1: hard resetting link
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 320)
ata1.05: hard resetting link
ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.06: hard resetting link
ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
ata1.05: 640 sectors, multi 1: LBA 
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: failed to recover some devices, retrying in 5 secs
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.00: ATA-7: ST3300831A, 3.03, max UDMA/100
ata1.00: 586072368 sectors, multi 0: LBA48 
ata1.00: applying bridge limits
ata1.00: configured for UDMA/100
ata1.01: ATA-7: ST3300831A, 3.03, max UDMA/100
ata1.01: 586072368 sectors, multi 0: LBA48 
ata1.01: applying bridge limits
ata1.01: configured for UDMA/100
ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata1.02: 586072368 sectors, multi 0: LBA48 
ata1.02: applying bridge limits
ata1.02: configured for UDMA/100
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
ata1.02: configured for UDMA/100
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1: EH complete
scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 1:0:0:0: Attached scsi generic sg2 type 0
scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1
sd 1:1:0:0: [sdc] Attached SCSI disk
sd 1:1:0:0: Attached scsi generic sg3 type 0
scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1
sd 1:2:0:0: [sdd] Attached SCSI disk
sd 1:2:0:0: Attached scsi generic sg4 type 0
scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sde] Write Protect is off
sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sde] Write Protect is off
sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sde: unknown partition table
sd 1:5:0:0: [sde] Attached SCSI disk
sd 1:5:0:0: Attached scsi generic sg5 type 0
ata1.00: failed to read SCR 1 (Emask=0x40)
ata1.01: failed to read SCR 1 (Emask=0x40)
ata1.02: failed to read SCR 1 (Emask=0x40)
ata1.03: failed to read SCR 1 (Emask=0x40)
ata1.04: failed to read SCR 1 (Emask=0x40)
ata1.05: failed to read SCR 1 (Emask=0x40)
ata1.06: failed to read SCR 1 (Emask=0x40)
ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x40d0000 action 0xa frozen
ata1.15: irq_stat 0x01b40090, PHY RDY changed
ata1: SError: { PHYRdyChg CommWake 10B8B DevExch }
ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 0)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 0)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: limiting SATA link speed to 1.5 Gbps
ata1.15: retrying hardreset in 5 secs
ata2: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xa frozen
ata2: irq_stat 0x00a40080, device exchanged
ata2: SError: { PHYRdyChg }
ata2: hard resetting link
ata1.15: hard resetting link
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata2.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
ata2.00: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 10)
ata2.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata2.01: hard resetting link
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata2.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.02: hard resetting link
ata2.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.03: hard resetting link
ata2.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.04: hard resetting link
ata2.04: SATA link down (SStatus 0 SControl 320)
ata2.05: hard resetting link
ata2.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata2.06: hard resetting link
ata2.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata2.00: ATA-7: ST3300831A, 3.03, max UDMA/100
ata2.00: 586072368 sectors, multi 0: LBA48 
ata2.00: applying bridge limits
ata2.00: configured for UDMA/100
ata2.01: ATA-7: ST3300831A, 3.03, max UDMA/100
ata2.01: 586072368 sectors, multi 0: LBA48 
ata2.01: applying bridge limits
ata2.01: configured for UDMA/100
ata2.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata2.02: 586072368 sectors, multi 0: LBA48 
ata2.02: applying bridge limits
ata2.02: configured for UDMA/100
ata2.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata2.03: 586072368 sectors, multi 0: LBA48 
ata2.03: applying bridge limits
ata2.03: configured for UDMA/100
ata2.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
ata2.05: 640 sectors, multi 1: LBA 
ata2.05: device is on DMA blacklist, disabling DMA
ata2.05: configured for PIO4
ata2: EH complete
scsi 2:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdf] 586072368 512-byte hardware sectors (300069 MB)
sd 2:0:0:0: [sdf] Write Protect is off
sd 2:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sdf] 586072368 512-byte hardware sectors (300069 MB)
sd 2:0:0:0: [sdf] Write Protect is off
sd 2:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdf: sdf1
sd 2:0:0:0: [sdf] Attached SCSI disk
sd 2:0:0:0: Attached scsi generic sg6 type 0
scsi 2:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 2:1:0:0: [sdg] 586072368 512-byte hardware sectors (300069 MB)
sd 2:1:0:0: [sdg] Write Protect is off
sd 2:1:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 2:1:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:1:0:0: [sdg] 586072368 512-byte hardware sectors (300069 MB)
sd 2:1:0:0: [sdg] Write Protect is off
sd 2:1:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 2:1:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdg: sdg1
sd 2:1:0:0: [sdg] Attached SCSI disk
sd 2:1:0:0: Attached scsi generic sg7 type 0
scsi 2:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 2:2:0:0: [sdh] 586072368 512-byte hardware sectors (300069 MB)
sd 2:2:0:0: [sdh] Write Protect is off
sd 2:2:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 2:2:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:2:0:0: [sdh] 586072368 512-byte hardware sectors (300069 MB)
sd 2:2:0:0: [sdh] Write Protect is off
sd 2:2:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 2:2:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdh: sdh1
sd 2:2:0:0: [sdh] Attached SCSI disk
sd 2:2:0:0: Attached scsi generic sg8 type 0
scsi 2:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 2:3:0:0: [sdi] 586072368 512-byte hardware sectors (300069 MB)
sd 2:3:0:0: [sdi] Write Protect is off
sd 2:3:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 2:3:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:3:0:0: [sdi] 586072368 512-byte hardware sectors (300069 MB)
sd 2:3:0:0: [sdi] Write Protect is off
sd 2:3:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 2:3:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdi: sdi1
sd 2:3:0:0: [sdi] Attached SCSI disk
sd 2:3:0:0: Attached scsi generic sg9 type 0
scsi 2:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
sd 2:5:0:0: [sdj] 640 512-byte hardware sectors (0 MB)
sd 2:5:0:0: [sdj] Write Protect is off
sd 2:5:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 2:5:0:0: [sdj] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 2:5:0:0: [sdj] 640 512-byte hardware sectors (0 MB)
sd 2:5:0:0: [sdj] Write Protect is off
sd 2:5:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 2:5:0:0: [sdj] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdj: unknown partition table
sd 2:5:0:0: [sdj] Attached SCSI disk
sd 2:5:0:0: Attached scsi generic sg10 type 0
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: failed to recover PMP after 5 tries, giving up
ata1.15: Port Multiplier detaching
ata1.00: disabled
ata1.01: disabled
ata1.02: disabled
ata1.05: disabled
ata1.00: disabled
ata1: hard resetting link
ata1: SATA link down (SStatus 0 SControl 0)
ata1: EH complete
ata1.00: detaching (SCSI 1:0:0:0)
sd 1:0:0:0: [sdb] Synchronizing SCSI cache
sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
sd 1:0:0:0: [sdb] Stopping disk
sd 1:0:0:0: [sdb] START_STOP FAILED
sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
ata1.01: detaching (SCSI 1:1:0:0)
sd 1:1:0:0: [sdc] Synchronizing SCSI cache
sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
sd 1:1:0:0: [sdc] Stopping disk
sd 1:1:0:0: [sdc] START_STOP FAILED
sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
ata1.02: detaching (SCSI 1:2:0:0)
sd 1:2:0:0: [sdd] Synchronizing SCSI cache
sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
sd 1:2:0:0: [sdd] Stopping disk
sd 1:2:0:0: [sdd] START_STOP FAILED
sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
ata1.05: detaching (SCSI 1:5:0:0)
sd 1:5:0:0: [sde] Stopping disk
sd 1:5:0:0: [sde] START_STOP FAILED
sd 1:5:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00

--------------070901050307070705060705
Content-Type: text/plain;
 name="Bootlog12.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Bootlog12.txt"

 1:3:0:0: [sde] Synchronizing SCSI cache
sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
sd 1:3:0:0: [sde] Stopping disk
sd 1:3:0:0: [sde] START_STOP FAILED
sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
ata1.00: failed to read SCR 1 (Emask=0x40)
ata1.01: failed to read SCR 1 (Emask=0x40)
ata1.02: failed to read SCR 1 (Emask=0x40)
ata1.03: failed to read SCR 1 (Emask=0x40)
ata1.04: failed to read SCR 1 (Emask=0x40)
ata1.05: failed to read SCR 1 (Emask=0x40)
ata1.06: failed to read SCR 1 (Emask=0x40)
ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
ata1.15: irq_stat 0x01940090, PHY RDY changed
ata1: SError: { 10B8B }
ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 310)
ata1.05: hard resetting link
ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
ata1.06: hard resetting link
ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.00: revalidation failed (errno=-5)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.01: revalidation failed (errno=-5)
ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.02: revalidation failed (errno=-5)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: failed to recover some devices, retrying in 5 secs
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
ata1.02: configured for UDMA/100
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1: EH complete
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdf] Write Protect is off
sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdf] Write Protect is off
sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
ata1.00: failed to read SCR 1 (Emask=0x40)
ata1.01: failed to read SCR 1 (Emask=0x40)
ata1.02: failed to read SCR 1 (Emask=0x40)
ata1.03: failed to read SCR 1 (Emask=0x40)
ata1.04: failed to read SCR 1 (Emask=0x40)
ata1.05: failed to read SCR 1 (Emask=0x40)
ata1.06: failed to read SCR 1 (Emask=0x40)
ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
ata1.15: irq_stat 0x01140010, PHY RDY changed
ata1: SError: { 10B8B }
ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: failed to recover PMP after 5 tries, giving up
ata1.15: Port Multiplier detaching
ata1.00: disabled
ata1.01: disabled
ata1.02: disabled
ata1.05: disabled
ata1.00: disabled
ata1: hard resetting link
ata1: SATA link down (SStatus 1 SControl 0)
ata1: EH complete
ata1.00: detaching (SCSI 1:0:0:0)
sd 1:0:0:0: [sdb] Synchronizing SCSI cache
sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
sd 1:0:0:0: [sdb] Stopping disk
sd 1:0:0:0: [sdb] START_STOP FAILED
sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
ata1.01: detaching (SCSI 1:1:0:0)
sd 1:1:0:0: [sdc] Synchronizing SCSI cache
sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
sd 1:1:0:0: [sdc] Stopping disk
sd 1:1:0:0: [sdc] START_STOP FAILED
sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
ata1.02: detaching (SCSI 1:2:0:0)
sd 1:2:0:0: [sdd] Synchronizing SCSI cache
sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
sd 1:2:0:0: [sdd] Stopping disk
sd 1:2:0:0: [sdd] START_STOP FAILED
sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
ata1.05: detaching (SCSI 1:5:0:0)
sd 1:5:0:0: [sdf] Stopping disk
sd 1:5:0:0: [sdf] START_STOP FAILED
sd 1:5:0:0: [sdf] Result: hostbyte=0x04 driverbyte=0x00
ata1: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xa frozen
ata1: irq_stat 0x00a40080, device exchanged
ata1: SError: { PHYRdyChg }
ata1: hard resetting link
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 320)
ata1.05: hard resetting link
ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.06: hard resetting link
ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
ata1.05: 640 sectors, multi 1: LBA 
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: failed to recover some devices, retrying in 5 secs
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.00: ATA-7: ST3300831A, 3.03, max UDMA/100
ata1.00: 586072368 sectors, multi 0: LBA48 
ata1.00: applying bridge limits
ata1.00: configured for UDMA/100
ata1.01: ATA-7: ST3300831A, 3.03, max UDMA/100
ata1.01: 586072368 sectors, multi 0: LBA48 
ata1.01: applying bridge limits
ata1.01: configured for UDMA/100
ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata1.02: 586072368 sectors, multi 0: LBA48 
ata1.02: applying bridge limits
ata1.02: configured for UDMA/100
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
ata1.02: configured for UDMA/100
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1: EH complete
scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 1:0:0:0: Attached scsi generic sg2 type 0
scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1
sd 1:1:0:0: [sdc] Attached SCSI disk
sd 1:1:0:0: Attached scsi generic sg3 type 0
scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1
sd 1:2:0:0: [sdd] Attached SCSI disk
sd 1:2:0:0: Attached scsi generic sg4 type 0
scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sde] Write Protect is off
sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sde] Write Protect is off
sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sde: unknown partition table
sd 1:5:0:0: [sde] Attached SCSI disk
sd 1:5:0:0: Attached scsi generic sg5 type 0
ata1.00: failed to read SCR 1 (Emask=0x40)
ata1.01: failed to read SCR 1 (Emask=0x40)
ata1.02: failed to read SCR 1 (Emask=0x40)
ata1.03: failed to read SCR 1 (Emask=0x40)
ata1.04: failed to read SCR 1 (Emask=0x40)
ata1.05: failed to read SCR 1 (Emask=0x40)
ata1.06: failed to read SCR 1 (Emask=0x40)
ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x40d0000 action 0xa frozen
ata1.15: irq_stat 0x01b40090, PHY RDY changed
ata1: SError: { PHYRdyChg CommWake 10B8B DevExch }
ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 0)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 0)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: limiting SATA link speed to 1.5 Gbps
ata1.15: retrying hardreset in 5 secs
ata2: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xa frozen
ata2: irq_stat 0x00a40080, device exchanged
ata2: SError: { PHYRdyChg }
ata2: hard resetting link
ata1.15: hard resetting link
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata2.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
ata2.00: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 10)
ata2.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata2.01: hard resetting link
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata2.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.02: hard resetting link
ata2.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.03: hard resetting link
ata2.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.04: hard resetting link
ata2.04: SATA link down (SStatus 0 SControl 320)
ata2.05: hard resetting link
ata2.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata2.06: hard resetting link
ata2.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata2.00: ATA-7: ST3300831A, 3.03, max UDMA/100
ata2.00: 586072368 sectors, multi 0: LBA48 
ata2.00: applying bridge limits
ata2.00: configured for UDMA/100
ata2.01: ATA-7: ST3300831A, 3.03, max UDMA/100
ata2.01: 586072368 sectors, multi 0: LBA48 
ata2.01: applying bridge limits
ata2.01: configured for UDMA/100
ata2.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata2.02: 586072368 sectors, multi 0: LBA48 
ata2.02: applying bridge limits
ata2.02: configured for UDMA/100
ata2.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata2.03: 586072368 sectors, multi 0: LBA48 
ata2.03: applying bridge limits
ata2.03: configured for UDMA/100
ata2.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
ata2.05: 640 sectors, multi 1: LBA 
ata2.05: device is on DMA blacklist, disabling DMA
ata2.05: configured for PIO4
ata2: EH complete
scsi 2:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdf] 586072368 512-byte hardware sectors (300069 MB)
sd 2:0:0:0: [sdf] Write Protect is off
sd 2:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sdf] 586072368 512-byte hardware sectors (300069 MB)
sd 2:0:0:0: [sdf] Write Protect is off
sd 2:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdf: sdf1
sd 2:0:0:0: [sdf] Attached SCSI disk
sd 2:0:0:0: Attached scsi generic sg6 type 0
scsi 2:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 2:1:0:0: [sdg] 586072368 512-byte hardware sectors (300069 MB)
sd 2:1:0:0: [sdg] Write Protect is off
sd 2:1:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 2:1:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:1:0:0: [sdg] 586072368 512-byte hardware sectors (300069 MB)
sd 2:1:0:0: [sdg] Write Protect is off
sd 2:1:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 2:1:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdg: sdg1
sd 2:1:0:0: [sdg] Attached SCSI disk
sd 2:1:0:0: Attached scsi generic sg7 type 0
scsi 2:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 2:2:0:0: [sdh] 586072368 512-byte hardware sectors (300069 MB)
sd 2:2:0:0: [sdh] Write Protect is off
sd 2:2:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 2:2:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:2:0:0: [sdh] 586072368 512-byte hardware sectors (300069 MB)
sd 2:2:0:0: [sdh] Write Protect is off
sd 2:2:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 2:2:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdh: sdh1
sd 2:2:0:0: [sdh] Attached SCSI disk
sd 2:2:0:0: Attached scsi generic sg8 type 0
scsi 2:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 2:3:0:0: [sdi] 586072368 512-byte hardware sectors (300069 MB)
sd 2:3:0:0: [sdi] Write Protect is off
sd 2:3:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 2:3:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:3:0:0: [sdi] 586072368 512-byte hardware sectors (300069 MB)
sd 2:3:0:0: [sdi] Write Protect is off
sd 2:3:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 2:3:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdi: sdi1
sd 2:3:0:0: [sdi] Attached SCSI disk
sd 2:3:0:0: Attached scsi generic sg9 type 0
scsi 2:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
sd 2:5:0:0: [sdj] 640 512-byte hardware sectors (0 MB)
sd 2:5:0:0: [sdj] Write Protect is off
sd 2:5:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 2:5:0:0: [sdj] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 2:5:0:0: [sdj] 640 512-byte hardware sectors (0 MB)
sd 2:5:0:0: [sdj] Write Protect is off
sd 2:5:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 2:5:0:0: [sdj] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdj: unknown partition table
sd 2:5:0:0: [sdj] Attached SCSI disk
sd 2:5:0:0: Attached scsi generic sg10 type 0
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: failed to recover PMP after 5 tries, giving up
ata1.15: Port Multiplier detaching
ata1.00: disabled
ata1.01: disabled
ata1.02: disabled
ata1.05: disabled
ata1.00: disabled
ata1: hard resetting link
ata1: SATA link down (SStatus 0 SControl 0)
ata1: EH complete
ata1.00: detaching (SCSI 1:0:0:0)
sd 1:0:0:0: [sdb] Synchronizing SCSI cache
sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
sd 1:0:0:0: [sdb] Stopping disk
sd 1:0:0:0: [sdb] START_STOP FAILED
sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
ata1.01: detaching (SCSI 1:1:0:0)
sd 1:1:0:0: [sdc] Synchronizing SCSI cache
sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
sd 1:1:0:0: [sdc] Stopping disk
sd 1:1:0:0: [sdc] START_STOP FAILED
sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
ata1.02: detaching (SCSI 1:2:0:0)
sd 1:2:0:0: [sdd] Synchronizing SCSI cache
sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
sd 1:2:0:0: [sdd] Stopping disk
sd 1:2:0:0: [sdd] START_STOP FAILED
sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
ata1.05: detaching (SCSI 1:5:0:0)
sd 1:5:0:0: [sde] Stopping disk
sd 1:5:0:0: [sde] START_STOP FAILED
sd 1:5:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
ata2.00: failed to read SCR 1 (Emask=0x40)
ata2.01: failed to read SCR 1 (Emask=0x40)
ata2.02: failed to read SCR 1 (Emask=0x40)
ata2.03: failed to read SCR 1 (Emask=0x40)
ata2.04: failed to read SCR 1 (Emask=0x40)
ata2.05: failed to read SCR 1 (Emask=0x40)
ata2.06: failed to read SCR 1 (Emask=0x40)
ata2.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
ata2.15: irq_stat 0x01940090, PHY RDY changed
ata2: SError: { 10B8B }
ata2.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.15: hard resetting link
ata2.15: SATA link down (SStatus 0 SControl 0)
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2.15: PMP revalidation failed (errno=-5)
ata2.15: retrying hardreset in 5 secs
ata2.15: hard resetting link
ata2.15: SATA link down (SStatus 0 SControl 0)
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2.15: PMP revalidation failed (errno=-5)
ata2.15: limiting SATA link speed to 1.5 Gbps
ata2.15: retrying hardreset in 5 secs
ata1: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xa frozen
ata1: irq_stat 0x00a40080, device exchanged
ata1: SError: { PHYRdyChg }
ata1: hard resetting link
ata2.15: hard resetting link
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: hard resetting link
ata2.15: SATA link down (SStatus 0 SControl 10)
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.03: hard resetting link
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2.15: PMP revalidation failed (errno=-5)
ata2.15: retrying hardreset in 5 secs
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 320)
ata1.05: hard resetting link
ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.06: hard resetting link
ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.00: ATA-7: ST3300831A, 3.03, max UDMA/100
ata1.00: 586072368 sectors, multi 0: LBA48 
ata1.00: applying bridge limits
ata1.00: configured for UDMA/100
ata1.01: ATA-7: ST3300831A, 3.03, max UDMA/100
ata1.01: 586072368 sectors, multi 0: LBA48 
ata1.01: applying bridge limits
ata1.01: configured for UDMA/100
ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata1.02: 586072368 sectors, multi 0: LBA48 
ata1.02: applying bridge limits
ata1.02: configured for UDMA/100
ata1.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata1.03: 586072368 sectors, multi 0: LBA48 
ata1.03: applying bridge limits
ata1.03: configured for UDMA/100
ata1.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
ata1.05: 640 sectors, multi 1: LBA 
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: EH complete
scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 1:0:0:0: Attached scsi generic sg2 type 0
scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1
sd 1:1:0:0: [sdc] Attached SCSI disk
sd 1:1:0:0: Attached scsi generic sg3 type 0
scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1
sd 1:2:0:0: [sdd] Attached SCSI disk
sd 1:2:0:0: Attached scsi generic sg4 type 0
scsi 1:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
sd 1:3:0:0: [sde] Write Protect is off
sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
sd 1:3:0:0: [sde] Write Protect is off
sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sde: sde1
sd 1:3:0:0: [sde] Attached SCSI disk
sd 1:3:0:0: Attached scsi generic sg5 type 0
scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
sd 1:5:0:0: [sdk] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdk] Write Protect is off
sd 1:5:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdk] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdk] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdk] Write Protect is off
sd 1:5:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdk] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdk: unknown partition table
sd 1:5:0:0: [sdk] Attached SCSI disk
sd 1:5:0:0: Attached scsi generic sg11 type 0
ata2.15: hard resetting link
ata2.15: SATA link down (SStatus 0 SControl 10)
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2.15: PMP revalidation failed (errno=-5)
ata2.15: retrying hardreset in 5 secs
ata2.15: hard resetting link
ata2.15: SATA link down (SStatus 0 SControl 10)
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2.15: PMP revalidation failed (errno=-5)
ata2.15: failed to recover PMP after 5 tries, giving up
ata2.15: Port Multiplier detaching
ata2.00: disabled
ata2.01: disabled
ata2.02: disabled
ata2.03: disabled
ata2.05: disabled
ata2.00: disabled
ata2: hard resetting link
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH complete
ata2.00: detaching (SCSI 2:0:0:0)
sd 2:0:0:0: [sdf] Synchronizing SCSI cache
sd 2:0:0:0: [sdf] Result: hostbyte=0x04 driverbyte=0x00
sd 2:0:0:0: [sdf] Stopping disk
sd 2:0:0:0: [sdf] START_STOP FAILED
sd 2:0:0:0: [sdf] Result: hostbyte=0x04 driverbyte=0x00
ata2.01: detaching (SCSI 2:1:0:0)
sd 2:1:0:0: [sdg] Synchronizing SCSI cache
sd 2:1:0:0: [sdg] Result: hostbyte=0x04 driverbyte=0x00
sd 2:1:0:0: [sdg] Stopping disk
sd 2:1:0:0: [sdg] START_STOP FAILED
sd 2:1:0:0: [sdg] Result: hostbyte=0x04 driverbyte=0x00
ata2.02: detaching (SCSI 2:2:0:0)
sd 2:2:0:0: [sdh] Synchronizing SCSI cache
sd 2:2:0:0: [sdh] Result: hostbyte=0x04 driverbyte=0x00
sd 2:2:0:0: [sdh] Stopping disk
sd 2:2:0:0: [sdh] START_STOP FAILED
sd 2:2:0:0: [sdh] Result: hostbyte=0x04 driverbyte=0x00
ata2.03: detaching (SCSI 2:3:0:0)
sd 2:3:0:0: [sdi] Synchronizing SCSI cache
sd 2:3:0:0: [sdi] Result: hostbyte=0x04 driverbyte=0x00
sd 2:3:0:0: [sdi] Stopping disk
sd 2:3:0:0: [sdi] START_STOP FAILED
sd 2:3:0:0: [sdi] Result: hostbyte=0x04 driverbyte=0x00
ata2.05: detaching (SCSI 2:5:0:0)
sd 2:5:0:0: [sdj] Stopping disk
sd 2:5:0:0: [sdj] START_STOP FAILED
sd 2:5:0:0: [sdj] Result: hostbyte=0x04 driverbyte=0x00

--------------070901050307070705060705
Content-Type: text/plain;
 name="Bootlog13.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Bootlog13.txt"

6 frozen
ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: failed to recover PMP after 5 tries, giving up
ata1.15: Port Multiplier detaching
ata1.00: disabled
ata1.01: disabled
ata1.02: disabled
ata1.05: disabled
ata1.00: disabled
ata1: hard resetting link
ata1: SATA link down (SStatus 1 SControl 0)
ata1: EH complete
ata1.00: detaching (SCSI 1:0:0:0)
sd 1:0:0:0: [sdb] Synchronizing SCSI cache
sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
sd 1:0:0:0: [sdb] Stopping disk
sd 1:0:0:0: [sdb] START_STOP FAILED
sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
ata1.01: detaching (SCSI 1:1:0:0)
sd 1:1:0:0: [sdc] Synchronizing SCSI cache
sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
sd 1:1:0:0: [sdc] Stopping disk
sd 1:1:0:0: [sdc] START_STOP FAILED
sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
ata1.02: detaching (SCSI 1:2:0:0)
sd 1:2:0:0: [sdd] Synchronizing SCSI cache
sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
sd 1:2:0:0: [sdd] Stopping disk
sd 1:2:0:0: [sdd] START_STOP FAILED
sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
ata1.05: detaching (SCSI 1:5:0:0)
sd 1:5:0:0: [sdf] Stopping disk
sd 1:5:0:0: [sdf] START_STOP FAILED
sd 1:5:0:0: [sdf] Result: hostbyte=0x04 driverbyte=0x00
ata1: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xa frozen
ata1: irq_stat 0x00a40080, device exchanged
ata1: SError: { PHYRdyChg }
ata1: hard resetting link
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 320)
ata1.05: hard resetting link
ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.06: hard resetting link
ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
ata1.05: 640 sectors, multi 1: LBA 
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: failed to recover some devices, retrying in 5 secs
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.00: ATA-7: ST3300831A, 3.03, max UDMA/100
ata1.00: 586072368 sectors, multi 0: LBA48 
ata1.00: applying bridge limits
ata1.00: configured for UDMA/100
ata1.01: ATA-7: ST3300831A, 3.03, max UDMA/100
ata1.01: 586072368 sectors, multi 0: LBA48 
ata1.01: applying bridge limits
ata1.01: configured for UDMA/100
ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata1.02: 586072368 sectors, multi 0: LBA48 
ata1.02: applying bridge limits
ata1.02: configured for UDMA/100
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
ata1.02: configured for UDMA/100
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1: EH complete
scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 1:0:0:0: Attached scsi generic sg2 type 0
scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1
sd 1:1:0:0: [sdc] Attached SCSI disk
sd 1:1:0:0: Attached scsi generic sg3 type 0
scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1
sd 1:2:0:0: [sdd] Attached SCSI disk
sd 1:2:0:0: Attached scsi generic sg4 type 0
scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sde] Write Protect is off
sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sde] Write Protect is off
sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sde: unknown partition table
sd 1:5:0:0: [sde] Attached SCSI disk
sd 1:5:0:0: Attached scsi generic sg5 type 0
ata1.00: failed to read SCR 1 (Emask=0x40)
ata1.01: failed to read SCR 1 (Emask=0x40)
ata1.02: failed to read SCR 1 (Emask=0x40)
ata1.03: failed to read SCR 1 (Emask=0x40)
ata1.04: failed to read SCR 1 (Emask=0x40)
ata1.05: failed to read SCR 1 (Emask=0x40)
ata1.06: failed to read SCR 1 (Emask=0x40)
ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x40d0000 action 0xa frozen
ata1.15: irq_stat 0x01b40090, PHY RDY changed
ata1: SError: { PHYRdyChg CommWake 10B8B DevExch }
ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 0)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 0)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: limiting SATA link speed to 1.5 Gbps
ata1.15: retrying hardreset in 5 secs
ata2: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xa frozen
ata2: irq_stat 0x00a40080, device exchanged
ata2: SError: { PHYRdyChg }
ata2: hard resetting link
ata1.15: hard resetting link
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata2.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
ata2.00: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 10)
ata2.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata2.01: hard resetting link
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata2.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.02: hard resetting link
ata2.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.03: hard resetting link
ata2.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.04: hard resetting link
ata2.04: SATA link down (SStatus 0 SControl 320)
ata2.05: hard resetting link
ata2.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata2.06: hard resetting link
ata2.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata2.00: ATA-7: ST3300831A, 3.03, max UDMA/100
ata2.00: 586072368 sectors, multi 0: LBA48 
ata2.00: applying bridge limits
ata2.00: configured for UDMA/100
ata2.01: ATA-7: ST3300831A, 3.03, max UDMA/100
ata2.01: 586072368 sectors, multi 0: LBA48 
ata2.01: applying bridge limits
ata2.01: configured for UDMA/100
ata2.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata2.02: 586072368 sectors, multi 0: LBA48 
ata2.02: applying bridge limits
ata2.02: configured for UDMA/100
ata2.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata2.03: 586072368 sectors, multi 0: LBA48 
ata2.03: applying bridge limits
ata2.03: configured for UDMA/100
ata2.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
ata2.05: 640 sectors, multi 1: LBA 
ata2.05: device is on DMA blacklist, disabling DMA
ata2.05: configured for PIO4
ata2: EH complete
scsi 2:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdf] 586072368 512-byte hardware sectors (300069 MB)
sd 2:0:0:0: [sdf] Write Protect is off
sd 2:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sdf] 586072368 512-byte hardware sectors (300069 MB)
sd 2:0:0:0: [sdf] Write Protect is off
sd 2:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdf: sdf1
sd 2:0:0:0: [sdf] Attached SCSI disk
sd 2:0:0:0: Attached scsi generic sg6 type 0
scsi 2:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 2:1:0:0: [sdg] 586072368 512-byte hardware sectors (300069 MB)
sd 2:1:0:0: [sdg] Write Protect is off
sd 2:1:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 2:1:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:1:0:0: [sdg] 586072368 512-byte hardware sectors (300069 MB)
sd 2:1:0:0: [sdg] Write Protect is off
sd 2:1:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 2:1:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdg: sdg1
sd 2:1:0:0: [sdg] Attached SCSI disk
sd 2:1:0:0: Attached scsi generic sg7 type 0
scsi 2:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 2:2:0:0: [sdh] 586072368 512-byte hardware sectors (300069 MB)
sd 2:2:0:0: [sdh] Write Protect is off
sd 2:2:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 2:2:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:2:0:0: [sdh] 586072368 512-byte hardware sectors (300069 MB)
sd 2:2:0:0: [sdh] Write Protect is off
sd 2:2:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 2:2:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdh: sdh1
sd 2:2:0:0: [sdh] Attached SCSI disk
sd 2:2:0:0: Attached scsi generic sg8 type 0
scsi 2:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 2:3:0:0: [sdi] 586072368 512-byte hardware sectors (300069 MB)
sd 2:3:0:0: [sdi] Write Protect is off
sd 2:3:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 2:3:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:3:0:0: [sdi] 586072368 512-byte hardware sectors (300069 MB)
sd 2:3:0:0: [sdi] Write Protect is off
sd 2:3:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 2:3:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdi: sdi1
sd 2:3:0:0: [sdi] Attached SCSI disk
sd 2:3:0:0: Attached scsi generic sg9 type 0
scsi 2:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
sd 2:5:0:0: [sdj] 640 512-byte hardware sectors (0 MB)
sd 2:5:0:0: [sdj] Write Protect is off
sd 2:5:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 2:5:0:0: [sdj] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 2:5:0:0: [sdj] 640 512-byte hardware sectors (0 MB)
sd 2:5:0:0: [sdj] Write Protect is off
sd 2:5:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 2:5:0:0: [sdj] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdj: unknown partition table
sd 2:5:0:0: [sdj] Attached SCSI disk
sd 2:5:0:0: Attached scsi generic sg10 type 0
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: failed to recover PMP after 5 tries, giving up
ata1.15: Port Multiplier detaching
ata1.00: disabled
ata1.01: disabled
ata1.02: disabled
ata1.05: disabled
ata1.00: disabled
ata1: hard resetting link
ata1: SATA link down (SStatus 0 SControl 0)
ata1: EH complete
ata1.00: detaching (SCSI 1:0:0:0)
sd 1:0:0:0: [sdb] Synchronizing SCSI cache
sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
sd 1:0:0:0: [sdb] Stopping disk
sd 1:0:0:0: [sdb] START_STOP FAILED
sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
ata1.01: detaching (SCSI 1:1:0:0)
sd 1:1:0:0: [sdc] Synchronizing SCSI cache
sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
sd 1:1:0:0: [sdc] Stopping disk
sd 1:1:0:0: [sdc] START_STOP FAILED
sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
ata1.02: detaching (SCSI 1:2:0:0)
sd 1:2:0:0: [sdd] Synchronizing SCSI cache
sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
sd 1:2:0:0: [sdd] Stopping disk
sd 1:2:0:0: [sdd] START_STOP FAILED
sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
ata1.05: detaching (SCSI 1:5:0:0)
sd 1:5:0:0: [sde] Stopping disk
sd 1:5:0:0: [sde] START_STOP FAILED
sd 1:5:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
ata2.00: failed to read SCR 1 (Emask=0x40)
ata2.01: failed to read SCR 1 (Emask=0x40)
ata2.02: failed to read SCR 1 (Emask=0x40)
ata2.03: failed to read SCR 1 (Emask=0x40)
ata2.04: failed to read SCR 1 (Emask=0x40)
ata2.05: failed to read SCR 1 (Emask=0x40)
ata2.06: failed to read SCR 1 (Emask=0x40)
ata2.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
ata2.15: irq_stat 0x01940090, PHY RDY changed
ata2: SError: { 10B8B }
ata2.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.15: hard resetting link
ata2.15: SATA link down (SStatus 0 SControl 0)
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2.15: PMP revalidation failed (errno=-5)
ata2.15: retrying hardreset in 5 secs
ata2.15: hard resetting link
ata2.15: SATA link down (SStatus 0 SControl 0)
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2.15: PMP revalidation failed (errno=-5)
ata2.15: limiting SATA link speed to 1.5 Gbps
ata2.15: retrying hardreset in 5 secs
ata1: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xa frozen
ata1: irq_stat 0x00a40080, device exchanged
ata1: SError: { PHYRdyChg }
ata1: hard resetting link
ata2.15: hard resetting link
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: hard resetting link
ata2.15: SATA link down (SStatus 0 SControl 10)
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.03: hard resetting link
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2.15: PMP revalidation failed (errno=-5)
ata2.15: retrying hardreset in 5 secs
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 320)
ata1.05: hard resetting link
ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.06: hard resetting link
ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.00: ATA-7: ST3300831A, 3.03, max UDMA/100
ata1.00: 586072368 sectors, multi 0: LBA48 
ata1.00: applying bridge limits
ata1.00: configured for UDMA/100
ata1.01: ATA-7: ST3300831A, 3.03, max UDMA/100
ata1.01: 586072368 sectors, multi 0: LBA48 
ata1.01: applying bridge limits
ata1.01: configured for UDMA/100
ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata1.02: 586072368 sectors, multi 0: LBA48 
ata1.02: applying bridge limits
ata1.02: configured for UDMA/100
ata1.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata1.03: 586072368 sectors, multi 0: LBA48 
ata1.03: applying bridge limits
ata1.03: configured for UDMA/100
ata1.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
ata1.05: 640 sectors, multi 1: LBA 
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: EH complete
scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 1:0:0:0: Attached scsi generic sg2 type 0
scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1
sd 1:1:0:0: [sdc] Attached SCSI disk
sd 1:1:0:0: Attached scsi generic sg3 type 0
scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1
sd 1:2:0:0: [sdd] Attached SCSI disk
sd 1:2:0:0: Attached scsi generic sg4 type 0
scsi 1:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
sd 1:3:0:0: [sde] Write Protect is off
sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
sd 1:3:0:0: [sde] Write Protect is off
sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sde: sde1
sd 1:3:0:0: [sde] Attached SCSI disk
sd 1:3:0:0: Attached scsi generic sg5 type 0
scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
sd 1:5:0:0: [sdk] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdk] Write Protect is off
sd 1:5:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdk] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdk] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdk] Write Protect is off
sd 1:5:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdk] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdk: unknown partition table
sd 1:5:0:0: [sdk] Attached SCSI disk
sd 1:5:0:0: Attached scsi generic sg11 type 0
ata2.15: hard resetting link
ata2.15: SATA link down (SStatus 0 SControl 10)
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2.15: PMP revalidation failed (errno=-5)
ata2.15: retrying hardreset in 5 secs
ata2.15: hard resetting link
ata2.15: SATA link down (SStatus 0 SControl 10)
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2.15: PMP revalidation failed (errno=-5)
ata2.15: failed to recover PMP after 5 tries, giving up
ata2.15: Port Multiplier detaching
ata2.00: disabled
ata2.01: disabled
ata2.02: disabled
ata2.03: disabled
ata2.05: disabled
ata2.00: disabled
ata2: hard resetting link
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH complete
ata2.00: detaching (SCSI 2:0:0:0)
sd 2:0:0:0: [sdf] Synchronizing SCSI cache
sd 2:0:0:0: [sdf] Result: hostbyte=0x04 driverbyte=0x00
sd 2:0:0:0: [sdf] Stopping disk
sd 2:0:0:0: [sdf] START_STOP FAILED
sd 2:0:0:0: [sdf] Result: hostbyte=0x04 driverbyte=0x00
ata2.01: detaching (SCSI 2:1:0:0)
sd 2:1:0:0: [sdg] Synchronizing SCSI cache
sd 2:1:0:0: [sdg] Result: hostbyte=0x04 driverbyte=0x00
sd 2:1:0:0: [sdg] Stopping disk
sd 2:1:0:0: [sdg] START_STOP FAILED
sd 2:1:0:0: [sdg] Result: hostbyte=0x04 driverbyte=0x00
ata2.02: detaching (SCSI 2:2:0:0)
sd 2:2:0:0: [sdh] Synchronizing SCSI cache
sd 2:2:0:0: [sdh] Result: hostbyte=0x04 driverbyte=0x00
sd 2:2:0:0: [sdh] Stopping disk
sd 2:2:0:0: [sdh] START_STOP FAILED
sd 2:2:0:0: [sdh] Result: hostbyte=0x04 driverbyte=0x00
ata2.03: detaching (SCSI 2:3:0:0)
sd 2:3:0:0: [sdi] Synchronizing SCSI cache
sd 2:3:0:0: [sdi] Result: hostbyte=0x04 driverbyte=0x00
sd 2:3:0:0: [sdi] Stopping disk
sd 2:3:0:0: [sdi] START_STOP FAILED
sd 2:3:0:0: [sdi] Result: hostbyte=0x04 driverbyte=0x00
ata2.05: detaching (SCSI 2:5:0:0)
sd 2:5:0:0: [sdj] Stopping disk
sd 2:5:0:0: [sdj] START_STOP FAILED
sd 2:5:0:0: [sdj] Result: hostbyte=0x04 driverbyte=0x00
ata1.00: failed to read SCR 1 (Emask=0x40)
ata1.01: failed to read SCR 1 (Emask=0x40)
ata1.02: failed to read SCR 1 (Emask=0x40)
ata1.03: failed to read SCR 1 (Emask=0x40)
ata1.04: failed to read SCR 1 (Emask=0x40)
ata1.05: failed to read SCR 1 (Emask=0x40)
ata1.06: failed to read SCR 1 (Emask=0x40)
ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
ata1.15: irq_stat 0x01140010, PHY RDY changed
ata1: SError: { 10B8B }
ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 0)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 0)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: limiting SATA link speed to 1.5 Gbps
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 310)
ata1.05: hard resetting link
ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
ata1.06: hard resetting link
ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.00: revalidation failed (errno=-5)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.01: revalidation failed (errno=-5)
ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.02: revalidation failed (errno=-5)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.03: revalidation failed (errno=-5)
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: failed to recover some devices, retrying in 5 secs
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
ata1.02: configured for UDMA/100
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.03: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.03: revalidation failed (errno=-5)
ata1.03: disabled
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1: EH complete
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdk] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdk] Write Protect is off
sd 1:5:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdk] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdk] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdk] Write Protect is off
sd 1:5:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdk] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
ata1.03: detaching (SCSI 1:3:0:0)
sd 1:3:0:0: [sde] Synchronizing SCSI cache
sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
sd 1:3:0:0: [sde] Stopping disk
sd 1:3:0:0: [sde] START_STOP FAILED
sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00

--------------070901050307070705060705
Content-Type: text/plain;
 name="Bootlog14.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Bootlog14.txt"

1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
ata1.02: configured for UDMA/100
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1: EH complete
scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 1:0:0:0: Attached scsi generic sg2 type 0
scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1
sd 1:1:0:0: [sdc] Attached SCSI disk
sd 1:1:0:0: Attached scsi generic sg3 type 0
scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1
sd 1:2:0:0: [sdd] Attached SCSI disk
sd 1:2:0:0: Attached scsi generic sg4 type 0
scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sde] Write Protect is off
sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sde] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sde] Write Protect is off
sd 1:5:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sde] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sde: unknown partition table
sd 1:5:0:0: [sde] Attached SCSI disk
sd 1:5:0:0: Attached scsi generic sg5 type 0
ata1.00: failed to read SCR 1 (Emask=0x40)
ata1.01: failed to read SCR 1 (Emask=0x40)
ata1.02: failed to read SCR 1 (Emask=0x40)
ata1.03: failed to read SCR 1 (Emask=0x40)
ata1.04: failed to read SCR 1 (Emask=0x40)
ata1.05: failed to read SCR 1 (Emask=0x40)
ata1.06: failed to read SCR 1 (Emask=0x40)
ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x40d0000 action 0xa frozen
ata1.15: irq_stat 0x01b40090, PHY RDY changed
ata1: SError: { PHYRdyChg CommWake 10B8B DevExch }
ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 0)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 0)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: limiting SATA link speed to 1.5 Gbps
ata1.15: retrying hardreset in 5 secs
ata2: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xa frozen
ata2: irq_stat 0x00a40080, device exchanged
ata2: SError: { PHYRdyChg }
ata2: hard resetting link
ata1.15: hard resetting link
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata2.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
ata2.00: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 10)
ata2.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata2.01: hard resetting link
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata2.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.02: hard resetting link
ata2.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.03: hard resetting link
ata2.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.04: hard resetting link
ata2.04: SATA link down (SStatus 0 SControl 320)
ata2.05: hard resetting link
ata2.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata2.06: hard resetting link
ata2.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata2.00: ATA-7: ST3300831A, 3.03, max UDMA/100
ata2.00: 586072368 sectors, multi 0: LBA48 
ata2.00: applying bridge limits
ata2.00: configured for UDMA/100
ata2.01: ATA-7: ST3300831A, 3.03, max UDMA/100
ata2.01: 586072368 sectors, multi 0: LBA48 
ata2.01: applying bridge limits
ata2.01: configured for UDMA/100
ata2.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata2.02: 586072368 sectors, multi 0: LBA48 
ata2.02: applying bridge limits
ata2.02: configured for UDMA/100
ata2.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata2.03: 586072368 sectors, multi 0: LBA48 
ata2.03: applying bridge limits
ata2.03: configured for UDMA/100
ata2.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
ata2.05: 640 sectors, multi 1: LBA 
ata2.05: device is on DMA blacklist, disabling DMA
ata2.05: configured for PIO4
ata2: EH complete
scsi 2:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdf] 586072368 512-byte hardware sectors (300069 MB)
sd 2:0:0:0: [sdf] Write Protect is off
sd 2:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sdf] 586072368 512-byte hardware sectors (300069 MB)
sd 2:0:0:0: [sdf] Write Protect is off
sd 2:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdf: sdf1
sd 2:0:0:0: [sdf] Attached SCSI disk
sd 2:0:0:0: Attached scsi generic sg6 type 0
scsi 2:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 2:1:0:0: [sdg] 586072368 512-byte hardware sectors (300069 MB)
sd 2:1:0:0: [sdg] Write Protect is off
sd 2:1:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 2:1:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:1:0:0: [sdg] 586072368 512-byte hardware sectors (300069 MB)
sd 2:1:0:0: [sdg] Write Protect is off
sd 2:1:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 2:1:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdg: sdg1
sd 2:1:0:0: [sdg] Attached SCSI disk
sd 2:1:0:0: Attached scsi generic sg7 type 0
scsi 2:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 2:2:0:0: [sdh] 586072368 512-byte hardware sectors (300069 MB)
sd 2:2:0:0: [sdh] Write Protect is off
sd 2:2:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 2:2:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:2:0:0: [sdh] 586072368 512-byte hardware sectors (300069 MB)
sd 2:2:0:0: [sdh] Write Protect is off
sd 2:2:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 2:2:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdh: sdh1
sd 2:2:0:0: [sdh] Attached SCSI disk
sd 2:2:0:0: Attached scsi generic sg8 type 0
scsi 2:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 2:3:0:0: [sdi] 586072368 512-byte hardware sectors (300069 MB)
sd 2:3:0:0: [sdi] Write Protect is off
sd 2:3:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 2:3:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:3:0:0: [sdi] 586072368 512-byte hardware sectors (300069 MB)
sd 2:3:0:0: [sdi] Write Protect is off
sd 2:3:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 2:3:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdi: sdi1
sd 2:3:0:0: [sdi] Attached SCSI disk
sd 2:3:0:0: Attached scsi generic sg9 type 0
scsi 2:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
sd 2:5:0:0: [sdj] 640 512-byte hardware sectors (0 MB)
sd 2:5:0:0: [sdj] Write Protect is off
sd 2:5:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 2:5:0:0: [sdj] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 2:5:0:0: [sdj] 640 512-byte hardware sectors (0 MB)
sd 2:5:0:0: [sdj] Write Protect is off
sd 2:5:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 2:5:0:0: [sdj] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdj: unknown partition table
sd 2:5:0:0: [sdj] Attached SCSI disk
sd 2:5:0:0: Attached scsi generic sg10 type 0
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: failed to recover PMP after 5 tries, giving up
ata1.15: Port Multiplier detaching
ata1.00: disabled
ata1.01: disabled
ata1.02: disabled
ata1.05: disabled
ata1.00: disabled
ata1: hard resetting link
ata1: SATA link down (SStatus 0 SControl 0)
ata1: EH complete
ata1.00: detaching (SCSI 1:0:0:0)
sd 1:0:0:0: [sdb] Synchronizing SCSI cache
sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
sd 1:0:0:0: [sdb] Stopping disk
sd 1:0:0:0: [sdb] START_STOP FAILED
sd 1:0:0:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
ata1.01: detaching (SCSI 1:1:0:0)
sd 1:1:0:0: [sdc] Synchronizing SCSI cache
sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
sd 1:1:0:0: [sdc] Stopping disk
sd 1:1:0:0: [sdc] START_STOP FAILED
sd 1:1:0:0: [sdc] Result: hostbyte=0x04 driverbyte=0x00
ata1.02: detaching (SCSI 1:2:0:0)
sd 1:2:0:0: [sdd] Synchronizing SCSI cache
sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
sd 1:2:0:0: [sdd] Stopping disk
sd 1:2:0:0: [sdd] START_STOP FAILED
sd 1:2:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
ata1.05: detaching (SCSI 1:5:0:0)
sd 1:5:0:0: [sde] Stopping disk
sd 1:5:0:0: [sde] START_STOP FAILED
sd 1:5:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
ata2.00: failed to read SCR 1 (Emask=0x40)
ata2.01: failed to read SCR 1 (Emask=0x40)
ata2.02: failed to read SCR 1 (Emask=0x40)
ata2.03: failed to read SCR 1 (Emask=0x40)
ata2.04: failed to read SCR 1 (Emask=0x40)
ata2.05: failed to read SCR 1 (Emask=0x40)
ata2.06: failed to read SCR 1 (Emask=0x40)
ata2.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
ata2.15: irq_stat 0x01940090, PHY RDY changed
ata2: SError: { 10B8B }
ata2.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.15: hard resetting link
ata2.15: SATA link down (SStatus 0 SControl 0)
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2.15: PMP revalidation failed (errno=-5)
ata2.15: retrying hardreset in 5 secs
ata2.15: hard resetting link
ata2.15: SATA link down (SStatus 0 SControl 0)
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2.15: PMP revalidation failed (errno=-5)
ata2.15: limiting SATA link speed to 1.5 Gbps
ata2.15: retrying hardreset in 5 secs
ata1: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xa frozen
ata1: irq_stat 0x00a40080, device exchanged
ata1: SError: { PHYRdyChg }
ata1: hard resetting link
ata2.15: hard resetting link
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: hard resetting link
ata2.15: SATA link down (SStatus 0 SControl 10)
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.03: hard resetting link
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2.15: PMP revalidation failed (errno=-5)
ata2.15: retrying hardreset in 5 secs
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 320)
ata1.05: hard resetting link
ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.06: hard resetting link
ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.00: ATA-7: ST3300831A, 3.03, max UDMA/100
ata1.00: 586072368 sectors, multi 0: LBA48 
ata1.00: applying bridge limits
ata1.00: configured for UDMA/100
ata1.01: ATA-7: ST3300831A, 3.03, max UDMA/100
ata1.01: 586072368 sectors, multi 0: LBA48 
ata1.01: applying bridge limits
ata1.01: configured for UDMA/100
ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata1.02: 586072368 sectors, multi 0: LBA48 
ata1.02: applying bridge limits
ata1.02: configured for UDMA/100
ata1.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata1.03: 586072368 sectors, multi 0: LBA48 
ata1.03: applying bridge limits
ata1.03: configured for UDMA/100
ata1.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
ata1.05: 640 sectors, multi 1: LBA 
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: EH complete
scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 1:0:0:0: Attached scsi generic sg2 type 0
scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1
sd 1:1:0:0: [sdc] Attached SCSI disk
sd 1:1:0:0: Attached scsi generic sg3 type 0
scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1
sd 1:2:0:0: [sdd] Attached SCSI disk
sd 1:2:0:0: Attached scsi generic sg4 type 0
scsi 1:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
sd 1:3:0:0: [sde] Write Protect is off
sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
sd 1:3:0:0: [sde] Write Protect is off
sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sde: sde1
sd 1:3:0:0: [sde] Attached SCSI disk
sd 1:3:0:0: Attached scsi generic sg5 type 0
scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
sd 1:5:0:0: [sdk] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdk] Write Protect is off
sd 1:5:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdk] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdk] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdk] Write Protect is off
sd 1:5:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdk] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdk: unknown partition table
sd 1:5:0:0: [sdk] Attached SCSI disk
sd 1:5:0:0: Attached scsi generic sg11 type 0
ata2.15: hard resetting link
ata2.15: SATA link down (SStatus 0 SControl 10)
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2.15: PMP revalidation failed (errno=-5)
ata2.15: retrying hardreset in 5 secs
ata2.15: hard resetting link
ata2.15: SATA link down (SStatus 0 SControl 10)
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2.15: PMP revalidation failed (errno=-5)
ata2.15: failed to recover PMP after 5 tries, giving up
ata2.15: Port Multiplier detaching
ata2.00: disabled
ata2.01: disabled
ata2.02: disabled
ata2.03: disabled
ata2.05: disabled
ata2.00: disabled
ata2: hard resetting link
ata2: SATA link down (SStatus 0 SControl 0)
ata2: EH complete
ata2.00: detaching (SCSI 2:0:0:0)
sd 2:0:0:0: [sdf] Synchronizing SCSI cache
sd 2:0:0:0: [sdf] Result: hostbyte=0x04 driverbyte=0x00
sd 2:0:0:0: [sdf] Stopping disk
sd 2:0:0:0: [sdf] START_STOP FAILED
sd 2:0:0:0: [sdf] Result: hostbyte=0x04 driverbyte=0x00
ata2.01: detaching (SCSI 2:1:0:0)
sd 2:1:0:0: [sdg] Synchronizing SCSI cache
sd 2:1:0:0: [sdg] Result: hostbyte=0x04 driverbyte=0x00
sd 2:1:0:0: [sdg] Stopping disk
sd 2:1:0:0: [sdg] START_STOP FAILED
sd 2:1:0:0: [sdg] Result: hostbyte=0x04 driverbyte=0x00
ata2.02: detaching (SCSI 2:2:0:0)
sd 2:2:0:0: [sdh] Synchronizing SCSI cache
sd 2:2:0:0: [sdh] Result: hostbyte=0x04 driverbyte=0x00
sd 2:2:0:0: [sdh] Stopping disk
sd 2:2:0:0: [sdh] START_STOP FAILED
sd 2:2:0:0: [sdh] Result: hostbyte=0x04 driverbyte=0x00
ata2.03: detaching (SCSI 2:3:0:0)
sd 2:3:0:0: [sdi] Synchronizing SCSI cache
sd 2:3:0:0: [sdi] Result: hostbyte=0x04 driverbyte=0x00
sd 2:3:0:0: [sdi] Stopping disk
sd 2:3:0:0: [sdi] START_STOP FAILED
sd 2:3:0:0: [sdi] Result: hostbyte=0x04 driverbyte=0x00
ata2.05: detaching (SCSI 2:5:0:0)
sd 2:5:0:0: [sdj] Stopping disk
sd 2:5:0:0: [sdj] START_STOP FAILED
sd 2:5:0:0: [sdj] Result: hostbyte=0x04 driverbyte=0x00
ata1.00: failed to read SCR 1 (Emask=0x40)
ata1.01: failed to read SCR 1 (Emask=0x40)
ata1.02: failed to read SCR 1 (Emask=0x40)
ata1.03: failed to read SCR 1 (Emask=0x40)
ata1.04: failed to read SCR 1 (Emask=0x40)
ata1.05: failed to read SCR 1 (Emask=0x40)
ata1.06: failed to read SCR 1 (Emask=0x40)
ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
ata1.15: irq_stat 0x01140010, PHY RDY changed
ata1: SError: { 10B8B }
ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 0)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 0)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: limiting SATA link speed to 1.5 Gbps
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 310)
ata1.05: hard resetting link
ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
ata1.06: hard resetting link
ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.00: revalidation failed (errno=-5)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.01: revalidation failed (errno=-5)
ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.02: revalidation failed (errno=-5)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.03: revalidation failed (errno=-5)
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: failed to recover some devices, retrying in 5 secs
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
ata1.02: configured for UDMA/100
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.03: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.03: revalidation failed (errno=-5)
ata1.03: disabled
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1: EH complete
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdk] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdk] Write Protect is off
sd 1:5:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdk] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdk] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdk] Write Protect is off
sd 1:5:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdk] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
ata1.03: detaching (SCSI 1:3:0:0)
sd 1:3:0:0: [sde] Synchronizing SCSI cache
sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
sd 1:3:0:0: [sde] Stopping disk
sd 1:3:0:0: [sde] START_STOP FAILED
sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
ata1.00: failed to read SCR 1 (Emask=0x40)
ata1.01: failed to read SCR 1 (Emask=0x40)
ata1.02: failed to read SCR 1 (Emask=0x40)
ata1.03: failed to read SCR 1 (Emask=0x40)
ata1.04: failed to read SCR 1 (Emask=0x40)
ata1.05: failed to read SCR 1 (Emask=0x40)
ata1.06: failed to read SCR 1 (Emask=0x40)
ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
ata1.15: irq_stat 0x01940090, PHY RDY changed
ata1: SError: { 10B8B }
ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 0 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 310)
ata1.05: hard resetting link
ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
ata1.06: hard resetting link
ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
ata1.02: configured for UDMA/100
ata1.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata1.03: 586072368 sectors, multi 0: LBA48 
ata1.03: applying bridge limits
ata1.03: configured for UDMA/100
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: EH complete
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdk] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdk] Write Protect is off
sd 1:5:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdk] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdk] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdk] Write Protect is off
sd 1:5:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdk] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
scsi 1:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
sd 1:3:0:0: [sde] Write Protect is off
sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
sd 1:3:0:0: [sde] Write Protect is off
sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sde: sde1
sd 1:3:0:0: [sde] Attached SCSI disk
sd 1:3:0:0: Attached scsi generic sg5 type 0

--------------070901050307070705060705--
