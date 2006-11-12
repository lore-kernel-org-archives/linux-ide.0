From: aaltoset@cs.helsinki.fi
Subject: AHCI detection issues
Date: Sun, 12 Nov 2006 13:23:06 +0200 (EET)
Message-ID: <BMKOaDGU.1163330585.9395520.aaltoset@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from courier.cs.helsinki.fi ([128.214.9.1]:51879 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1755055AbWKLLXH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Nov 2006 06:23:07 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org


Hello,

I recently upgraded my system and I have an Asus P5W DH Deluxe
motherboard. It has an Intel ICH7 chipset where the second SATA
connector is used for a Sil4723 hardware RAID device. The Sil4723 has
two SATA ports using the shared ICH7 port.

I have one Seagate Barracuda 7200.10 SATA drive connected to the first
ICH7 port but the Linux kernel falsely detects another drive on ata2,
which I believe to be on the Sil4723. With 2.6.17 this isn't a big
problem, it just appears in dmesg but doesn't cause any problems.
However, with 2.6.18 and later, the non-existent drive takes painfully
long to detect and this appears in dmesg:

[   36.577431] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   66.506384] ata2.00: qc timeout (cmd 0xec)
[   66.506389] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[   74.340464] ata2: port is slow to respond, please be patient
[   97.249998] ata2: port failed to respond (30 secs)
[   97.250030] ata2: COMRESET failed (device not ready)
[   97.250061] ata2: hardreset failed, retrying in 5 secs
[  103.108459] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  103.108517] ata2.00: ATA-6, max UDMA/133, 640 sectors: LBA
[  103.108520] ata2.00: ata2: dev 0 multi count 1
[  103.108589] ata2.00: configured for UDMA/133

Here is the output of hdparm -I /dev/sdb (on kernel 2.6.17 since I
currently don't have a newer kernel that would boot at all)

ATA device, with non-removable media
        Model Number:       Config  Disk
        Serial Number:      0000000__________0_A
        Firmware Revision:  RGL10364
Standards:
        Used: ATA/ATAPI-6 T13 1410D revision 2
        Supported: 6 5 4
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:        640
        device size with M = 1024*1024:        8063 MBytes
        device size with M = 1000*1000:        8455 MBytes (8 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Standby timer values: spec'd by Standard, no device specific
minimum
        R/W multiple sector transfer: Max = 1   Current = 1
        Recommended acoustic management value: 192, current value: 254
        DMA: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 udma4 udma5
*udma6 (?)
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
                Power Management feature set
                Write cache
                Look-ahead
                Power-Up In Standby feature set
                SET_FEATURES required to spinup after power up
           *    Mandatory FLUSH_CACHE
           *    unknown 76[0]
           *    Host-initiated interface power management
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase

I'd prefer a newer kernel than 2.6.17 since the JMicron controller on
the motherboard has serious issues with it. I am using Ubuntu Edgy which
has some JMicron patches backported but if I access my PATA disks on the
controller causes a hard lock almost instantly, with no errors in the
logs. I have also tried the libata-tj-2.6.18.1-20061020 patchset, but
then I get these errors and the system won't boot:

ata1.01: revalidation failed (errno=-5)     (appears three times)
ata1.00 failed to set xfermode (err_mask=0x40)

I wonder if these are known issues?
