From: Gary Hade <garyhade@us.ibm.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Tue, 19 Dec 2006 19:29:41 -0800
Message-ID: <20061220032941.GA8903@us.ibm.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:53897 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964840AbWLTD3p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2006 22:29:45 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBK3ThvS023959
	for <linux-ide@vger.kernel.org>; Tue, 19 Dec 2006 22:29:43 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kBK3ThLl520296
	for <linux-ide@vger.kernel.org>; Tue, 19 Dec 2006 20:29:43 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kBK3TgPp011023
	for <linux-ide@vger.kernel.org>; Tue, 19 Dec 2006 20:29:43 -0700
Content-Disposition: inline
In-Reply-To: <4588877D.1000400@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com

On Wed, Dec 20, 2006 at 09:44:45AM +0900, Tejun Heo wrote:
> Kovid Goyal wrote:
> > Hi,
> >
> > I'm having problems booting from a SATA disk with 2.6.19.
> > Grub loads fine, but when the kernel boots, it *sometimes* ends up with
> > VFS: Cannot open root device "sda5" or unknown-block(0,0).
> >
> > This issue appears to be identical with the one reported in
> > http://lkml.org/lkml/2006/10/19/327 except that 2.6.19 did not fix it for me.
> > In fact, it made it worse. The timeouts reported in that thread are still
> > present and with 2.6.19 the fraction of unsuccessful boots has increased from
> > 30% to 80%. I often have to reboot my machine 3 times in a row before it
> > succeeds. I have tried both vanilla 2.6.19 and gentoo-sources-2.6.19-r1
> >
> > To summarize: My machine stalls for nearly a minute on all boots and the root
> > filesystem fails to mount on 80% of the boots. This problem first manifested
> > itself when I switched to 2.6.18 and has become worse with 2.6.19.
> >
> > The controller:
> > 00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA
> > Controller (rev 03)
> >
> > I don't know how to get the logs from an unsuccessful boot. Here is
> > an extract from the logs of a successful boot (in which the timeout is
> > present):
> 
> Does goving back to 2.6.17 fix the problem?  Also, please report the
> result of 'smartctl -d ata -a /dev/sdX' where sdX is the problematic drive.

We have been seeing what might be the same problem on an 
IBM Intellistation M30 Pro which contains the same SATA controller.

I have been debugging and trying to better understand the problem
before posting my findings and possible fix but after noticing this 
message today and then seeing the "SRST failed (status 0xFF)" messages
included in Kovid's original message I think I should share what I 
have found so far.

In our case the SRST failures are associated with a Quantum GoVault
removable hard drive device.  We have also noticed that failure is
dependent on cable placement e.g. after encoutering the failure a
reversal of the ports to which the hard drive and GoVault cables
are connected will cause the problem to disappear.

The above SRST failure message was from this code in libata-core.c.

        /* Before we perform post reset processing we want to see if
         * the bus shows 0xFF because the odd clown forgets the D7
         * pulldown resistor.
         */
        if (ata_check_status(ap) == 0xFF) {
                ata_port_printk(ap, KERN_ERR, "SRST failed (status 0xFF)\n");
                return AC_ERR_OTHER;
        }

I noticed that Tejun recently provided a "libata: handle 0xff status 
properly" patch that is now in mainline that improves this code
  re: http://marc.theaimsgroup.com/?l=linux-ide&m=116038642105802&w=2
but I found that the check still failed but more silently and with no 
retries.

I decided to try increasing the delay that preceeds the above 
check [ msleep(150); ] and found that a change from 150ms to 
1000ms caused the problem to disappear. 

I then replaced the msleep(150); with:
    {
        int i, ms = 5;
        msleep(ms);
        ata_port_printk(ap, KERN_INFO, "status @ %d ms: 0x%x\n",
                                        ms, ata_check_status(ap));
        for (i = 1; i <= 20; i++) {
            ms += 50;
            msleep(50);
            ata_port_printk(ap, KERN_INFO, "status @ %d ms: 0x%x\n",
                                            ms, ata_check_status(ap));
        }
    }

Output for two cable placement configurations (0xFF check failure 
and 0xFF check success) are included below.  Note that there are 
cable placement configurations for both the hard drive and 
GoVault where the initial status is 0xff. i.e. both transition 
from 0xff to 0x7f when BSY bit is cleared but it is taking MUCH 
longer for the GoVault (600-700ms for GoVault and <5ms for 
hard drive).  It does not appear that the 0xff starting status
is device specific.

So, it appears that we have a situation with this SATA controller 
where a 0xFF status is not an accurate indication that there is
no device.  

Although the 150ms to 1000ms delay increase works for the GoVault 
device I am not sure if it is the best long term fix for the problem.

Gary

-- 
Gary Hade
IBM Linux Technology Center
503-578-4503  IBM T/L: 775-4503
garyhade@us.ibm.com
http://www.ibm.com/linux/ltc

================================================
Falied 0xFF check cable placement configuration
================================================
libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x20C0 ctl 0x20BA bmdma 0x2090 irq 225
ata2: SATA max UDMA/133 cmd 0x20B0 ctl 0x20A6 bmdma 0x2098 irq 225
scsi0 : ata_piix
ata1: status @ 5 ms: 0xff
ata1: status @ 55 ms: 0xff
ata1: status @ 105 ms: 0xff
ata1: status @ 155 ms: 0xff
ata1: status @ 205 ms: 0xff
ata1: status @ 255 ms: 0xff
ata1: status @ 305 ms: 0xff
ata1: status @ 355 ms: 0xff
ata1: status @ 405 ms: 0xff
ata1: status @ 455 ms: 0xff
ata1: status @ 505 ms: 0xff
ata1: status @ 555 ms: 0xff
ata1: status @ 605 ms: 0xff
ata1: status @ 655 ms: 0x7f
ata1: status @ 705 ms: 0x7f
ata1: status @ 755 ms: 0x7f
ata1: status @ 805 ms: 0x7f
ata1: status @ 855 ms: 0x7f
ata1: status @ 905 ms: 0x7f
ata1: status @ 955 ms: 0x7f
ata1: status @ 1005 ms: 0x7f
ATA: abnormal status 0x7F on port 0x20C7
ATA: abnormal status 0x7F on port 0x20C7
ata1.01: ATAPI, max UDMA/66
ata1.01: configured for UDMA/66
scsi1 : ata_piix
ata2: status @ 5 ms: 0x50
ata2: status @ 55 ms: 0x50
ata2: status @ 105 ms: 0x50
ata2: status @ 155 ms: 0x50
ata2: status @ 205 ms: 0x50
ata2: status @ 255 ms: 0x50
ata2: status @ 305 ms: 0x50
ata2: status @ 355 ms: 0x50
ata2: status @ 405 ms: 0x50
ata2: status @ 455 ms: 0x50
ata2: status @ 505 ms: 0x50
ata2: status @ 555 ms: 0x50
ata2: status @ 605 ms: 0x50
ata2: status @ 655 ms: 0x50
ata2: status @ 705 ms: 0x50
ata2: status @ 755 ms: 0x50
ata2: status @ 805 ms: 0x50
ata2: status @ 855 ms: 0x50
ata2: status @ 905 ms: 0x50
ata2: status @ 955 ms: 0x50
ata2: status @ 1005 ms: 0x50
ata2.00: ATA-7, max UDMA/133, 156312576 sectors: LBA
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
  Vendor: IBM       Model: GoVault           Rev: 008F
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156300464 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 74 00 00
sda: cache data unavailable
sda: assuming drive cache: write through
SCSI device sda: 156300464 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 74 00 00
sda: cache data unavailable
sda: assuming drive cache: write through
 sda: sda1 sda2 sda3
sd 0:0:1:0: Attached scsi removable disk sda
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 156312576 512-byte hdwr sectors (80032 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 156312576 512-byte hdwr sectors (80032 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb11 sdb12 >
sd 1:0:0:0: Attached scsi disk sdb
==========================================================

===================================================
Successful 0xFF check cable placement configuration
===================================================
libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x20C0 ctl 0x20BA bmdma 0x2090 irq 225
ata2: SATA max UDMA/133 cmd 0x20B0 ctl 0x20A6 bmdma 0x2098 irq 225
scsi0 : ata_piix
ata1: status @ 5 ms: 0x7f
ata1: status @ 55 ms: 0x7f
ata1: status @ 105 ms: 0x7f
ata1: status @ 155 ms: 0x7f
ata1: status @ 205 ms: 0x7f
ata1: status @ 255 ms: 0x7f
ata1: status @ 305 ms: 0x7f
ata1: status @ 355 ms: 0x7f
ata1: status @ 405 ms: 0x7f
ata1: status @ 455 ms: 0x7f
ata1: status @ 505 ms: 0x7f
ata1: status @ 555 ms: 0x7f
ata1: status @ 605 ms: 0x7f
ata1: status @ 655 ms: 0x7f
ata1: status @ 705 ms: 0x7f
ata1: status @ 755 ms: 0x7f
ata1: status @ 805 ms: 0x7f
ata1: status @ 855 ms: 0x7f
ata1: status @ 905 ms: 0x7f
ata1: status @ 955 ms: 0x7f
ata1: status @ 1005 ms: 0x7f
ATA: abnormal status 0x7F on port 0x20C7
ATA: abnormal status 0x7F on port 0x20C7
ata1.01: ATA-7, max UDMA/133, 156312576 sectors: LBA
ata1.01: ata1: dev 1 multi count 16
ata1.01: configured for UDMA/133
scsi1 : ata_piix
ata2: status @ 5 ms: 0xd0
ata2: status @ 55 ms: 0xd0
ata2: status @ 105 ms: 0xd0
ata2: status @ 155 ms: 0xd0
ata2: status @ 205 ms: 0xd0
ata2: status @ 255 ms: 0xd0
ata2: status @ 305 ms: 0xd0
ata2: status @ 355 ms: 0xd0
ata2: status @ 405 ms: 0xd0
ata2: status @ 455 ms: 0xd0
ata2: status @ 505 ms: 0xd0
ata2: status @ 555 ms: 0xd0
ata2: status @ 605 ms: 0xd0
ata2: status @ 655 ms: 0x0
ata2: status @ 705 ms: 0x0
ata2: status @ 755 ms: 0x0
ata2: status @ 805 ms: 0x0
ata2: status @ 855 ms: 0x0
ata2: status @ 905 ms: 0x0
ata2: status @ 955 ms: 0x0
ata2: status @ 1005 ms: 0x0
ata2.00: ATAPI, max UDMA/66
ata2.00: configured for UDMA/66
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 >
sd 0:0:1:0: Attached scsi disk sda
  Vendor: IBM       Model: GoVault           Rev: 008F
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 156300464 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 74 00 00
sdb: cache data unavailable
sdb: assuming drive cache: write through
SCSI device sdb: 156300464 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 74 00 00
sdb: cache data unavailable
sdb: assuming drive cache: write through
 sdb: sdb1 sdb2 sdb3
sd 1:0:0:0: Attached scsi removable disk sdb
==========================================================

