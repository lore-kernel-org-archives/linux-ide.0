From: Mike Hokenson <kernel+marvell@gozer.org>
Subject: Marvell 88SE6121 PATA in 2.6.25 (ahci)
Date: Sun, 4 May 2008 23:55:37 -0500
Message-ID: <20080505045537.GA24381@gozer.dminteractive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gozer.dminteractive.com ([66.18.16.178]:37170 "EHLO
	gozer.dminteractive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbYEEFDs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 May 2008 01:03:48 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi list,

I just noticed my Marvell 88SE6121 PATA controller isn't working in
2.6.25. pata_marvell.c is more or less untouched (removal of a return
in a void), but drivers/ata/ahci.c had some changes:

!       { PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },        /* 6121 */

        /*
         * Temporary Marvell 6145 hack: PATA port presence
         * is asserted through the standard AHCI port
         * presence register, as bit 4 (counting from 0)
         */
        if (hpriv->flags & AHCI_HFLAG_MV_PATA) {
!               if (pdev->device == 0x6121)
!                       mv = 0x3;
!               else
!                       mv = 0xf;
                dev_printk(KERN_ERR, &pdev->dev,
                           "MV_AHCI HACK: port_map %x -> %x\n",
                           port_map,
                           port_map & mv);

                port_map &= mv;
        }

I'm using AHCI for an Intel ICH controller which runs two SATA hard
drives and one SATA DVD drive.

My dmesg used to look like this:

ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:03:00.0 to 64
scsi6 : pata_marvell
scsi7 : pata_marvell
ata7: PATA max UDMA/100 cmd 0xcc00 ctl 0xc880 bmdma 0xc400 irq 10
ata8: PATA max UDMA/133 cmd 0xc800 ctl 0xc480 bmdma 0xc408 irq 10
BAR5:00:02 01:7F 02:22 03:CA 04:00 05:00 06:00 07:00 08:00 09:00 0A:00 0B:00 0C:07 0D:00 0E:00 0F:00 
ata7.00: ATAPI: DVD RW DRU-820A, 1.0c, max UDMA/66
ata7.00: configured for UDMA/66
BAR5:00:02 01:7F 02:22 03:CA 04:00 05:00 06:00 07:00 08:00 09:00 0A:00 0B:00 0C:07 0D:00 0E:00 0F:00 
scsi 6:0:0:0: CD-ROM            SONY     DVD RW DRU-820A  1.0c PQ: 0 ANSI: 5
sr1: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
sr 6:0:0:0: Attached scsi CD-ROM sr1
sr 6:0:0:0: Attached scsi generic sg3 type 5

and now looks like this:

ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ahci 0000:03:00.0: controller can't do NCQ, turning off CAP_NCQ
ahci 0000:03:00.0: MV_AHCI HACK: port_map 7 -> 3
ahci 0000:03:00.0: AHCI 0001.0000 32 slots 3 ports 3 Gbps 0x3 impl IDE mode
ahci 0000:03:00.0: flags: 64bit stag led pmp slum part 
PCI: Setting latency timer of device 0000:03:00.0 to 64
scsi6 : ahci
scsi7 : ahci
ata7: SATA max UDMA/133 abar m1024@0xfe9ffc00 port 0xfe9ffd00 irq 16
ata8: SATA max UDMA/133 abar m1024@0xfe9ffc00 port 0xfe9ffd80 irq 16
ata9: DUMMY
ata7: SATA link down (SStatus 0 SControl 300)
ata8: SATA link down (SStatus 0 SControl 300)

So, I guess the AHCI driver has taken over for the PATA controller,
but something must not be right... The controller doesn't see link
and the drive doesn't show up anywhere, but the BIOS sees it fine.

Any ideas? Should I disable PATA_MARVELL?

Thanks,

Mike
