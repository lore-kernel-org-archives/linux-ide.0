From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: 2.6.21-rc3-git4 ata1.00: qc timeout (cmd 0xef) (crashdump kernel)
Date: Fri, 9 Mar 2007 17:57:32 +0100
Message-ID: <6bffcb0e0703090857r14eda34bj92f3fd1d0008edb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:52525 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767409AbXCIQ5j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 11:57:39 -0500
Received: by wr-out-0506.google.com with SMTP id 71so1376062wri
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 08:57:38 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Hi Jeff,

I've got some problems with my SATA controller on crashdump kernel.

Calling initcall 0xc1916081: fc_transport_init+0x0/0x35()
Calling initcall 0xc19160b6: init_sd+0x0/0xbc()
Calling initcall 0xc19161ec: piix_init+0x0/0x27()
ata_piix 0000:00:1f.2: version 2.10
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> Link [LNKC] -> GSI 5 (level,
low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x0001cc00 ctl 0x0001c882 bmdma 0x0001c400 irq 5
ata2: SATA max UDMA/133 cmd 0x0001c800 ctl 0x0001c482 bmdma 0x0001c408 irq 5
scsi0 : ata_piix
PM: Adding info for No Bus:host0
ata1.00: ATA-7: ST3160811AS, 3.AAE, max UDMA/133
ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: qc timeout (cmd 0xef)
ata1.00: failed to set xfermode (err_mask=0x4)
ata1: failed to recover some devices, retrying in 5 secs
ata1.00: qc timeout (cmd 0xef)
ata1.00: failed to set xfermode (err_mask=0x4)
ata1.00: limiting speed to UDMA/133:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1.00: qc timeout (cmd 0xef)
ata1.00: failed to set xfermode (err_mask=0x4)
ata1.00: disabled
scsi1 : ata_piix
PM: Adding info for No Bus:host1
ata2.00: ATA-7: Maxtor 6Y200M0, YAR51BW0, max UDMA/133
ata2.00: 398297088 sectors, multi 16: LBA48

/sbin/lspci  -vvv
00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA
Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: ASUSTeK Computer Inc. P4P800 SE Mainboard
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at cc00 [size=8]
        Region 1: I/O ports at c880 [size=4]
        Region 2: I/O ports at c800 [size=8]
        Region 3: I/O ports at c480 [size=4]
        Region 4: I/O ports at c400 [size=16]

http://www.stardust.webpages.pl/files/tbf/bitis-gabonica/2.6.21-rc3-git4-kdump/console.log
http://www.stardust.webpages.pl/files/tbf/bitis-gabonica/2.6.21-rc3-git4-kdump/git-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group (PL)
(http://www.stardust.webpages.pl/ltg/)
LTG - Linux Testers Group (EN)
(http://www.stardust.webpages.pl/linux_testers_group_en/)
