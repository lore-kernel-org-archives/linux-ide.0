From: "Berck E. Nash" <flyboy@gmail.com>
Subject: libata Intel PIIX/ICH fails to detect both PATA drives, spews ACPI
 errors
Date: Fri, 01 Dec 2006 09:19:36 -0700
Message-ID: <45705618.2020608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:28801 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S935227AbWLAQTk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Dec 2006 11:19:40 -0500
Received: by py-out-1112.google.com with SMTP id a29so1838351pyi
        for <linux-ide@vger.kernel.org>; Fri, 01 Dec 2006 08:19:39 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Testing the new libata ICH PATA drivers.  There's one PATA port on this
chip, and I've got two optical drives connected to it.  The master drive
fails to detect.  The slave detects and works properly.


00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc. Unknown device 8179
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at 01f0 [size=8]
        Region 1: I/O ports at 03f4 [size=1]
        Region 2: I/O ports at 0170 [size=8]
        Region 3: I/O ports at 0374 [size=1]
        Region 4: I/O ports at ffa0 [size=16]


[  128.400965] ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0
irq 14
[  128.407976] ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFFA8
irq 15
[  128.414982] scsi5 : ata_piix
[  128.723123] ACPI Error (dsopcode-0481): Attempt to CreateField of
length zero [20060707]
[  128.731348] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.IDE0.RATA] (Node ffff810001ff74d0), AE_AML_OPERAND_VALUE
[  128.743887] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.IDE0.CHN0.DRV0._GTF] (Node ffff810001ff7830),
AE_AML_OPERAND_VALUE
[  128.757290] ata5.00: ATAPI, max UDMA/33
[  128.915451] ACPI Error (dsopcode-0481): Attempt to CreateField of
length zero [20060707]
[  128.923670] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.IDE0.RATA] (Node ffff810001ff74d0), AE_AML_OPERAND_VALUE
[  128.936209] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.IDE0.CHN0.DRV0._GTF] (Node ffff810001ff7830),
AE_AML_OPERAND_VALUE
[  128.949614] ata5.01: ATAPI, max UDMA/33
[  158.925558] ata5.00: qc timeout (cmd 0xef)
[  158.929692] ata5.00: failed to set xfermode (err_mask=0x4)
[  158.935207] ata5.00: limiting speed to UDMA/25
[  158.939682] ata5: failed to recover some devices, retrying in 5 secs
[  164.247317] ACPI Error (dsopcode-0481): Attempt to CreateField of
length zero [20060707]
[  164.255540] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.IDE0.RATA] (Node ffff810001ff74d0), AE_AML_OPERAND_VALUE
[  164.268079] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.IDE0.CHN0.DRV0._GTF] (Node ffff810001ff7830),
AE_AML_OPERAND_VALUE
[  164.433250] ACPI Error (dsopcode-0481): Attempt to CreateField of
length zero [20060707]
[  164.441472] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.IDE0.RATA] (Node ffff810001ff74d0), AE_AML_OPERAND_VALUE
[  164.454010] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.IDE0.CHN0.DRV0._GTF] (Node ffff810001ff7830),
AE_AML_OPERAND_VALUE
[  194.440214] ata5.00: qc timeout (cmd 0xef)
[  194.444350] ata5.00: failed to set xfermode (err_mask=0x4)
[  194.455118] ata5.00: limiting speed to PIO0
[  194.459336] ata5: failed to recover some devices, retrying in 5 secs
[  199.766792] ACPI Error (dsopcode-0481): Attempt to CreateField of
length zero [20060707]
[  199.775020] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.IDE0.RATA] (Node ffff810001ff74d0), AE_AML_OPERAND_VALUE
[  199.787558] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.IDE0.CHN0.DRV0._GTF] (Node ffff810001ff7830),
AE_AML_OPERAND_VALUE
[  199.952400] ACPI Error (dsopcode-0481): Attempt to CreateField of
length zero [20060707]
[  199.960624] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.IDE0.RATA] (Node ffff810001ff74d0), AE_AML_OPERAND_VALUE
[  199.973161] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.IDE0.CHN0.DRV0._GTF] (Node ffff810001ff7830),
AE_AML_OPERAND_VALUE
[  229.958667] ata5.00: qc timeout (cmd 0xef)
[  229.962801] ata5.00: failed to set xfermode (err_mask=0x4)
[  229.968322] ata5.00: disabled
[  229.971325] ata5: failed to recover some devices, retrying in 5 secs
[  234.974450] ata5.01: failed to set xfermode (err_mask=0x40)
[  234.980058] ata5.01: limiting speed to UDMA/25
[  234.984531] ata5: failed to recover some devices, retrying in 5 secs
[  240.289500] ACPI Error (dsopcode-0481): Attempt to CreateField of
length zero [20060707]
[  240.297721] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.IDE0.RATA] (Node ffff810001ff74d0), AE_AML_OPERAND_VALUE
[  240.310260] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.IDE0.CHN0.DRV1._GTF] (Node ffff810001ff77d0),
AE_AML_OPERAND_VALUE
[  240.475708] ACPI Error (dsopcode-0481): Attempt to CreateField of
length zero [20060707]
[  240.483930] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.IDE0.RATA] (Node ffff810001ff74d0), AE_AML_OPERAND_VALUE
[  240.496469] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.IDE0.CHN0.DRV1._GTF] (Node ffff810001ff77d0),
AE_AML_OPERAND_VALUE
[  240.509872] ata5.01: configured for UDMA/25
[  240.514094] scsi6 : ata_piix
[  241.733617] ATA: abnormal status 0x7F on port 0x177
[  241.739526] scsi 5:0:1:0: CD-ROM            _NEC     DVD_RW ND-3520AW
3.04 PQ: 0 ANSI: 5
[  241.751812] sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
[  241.758640] Uniform CD-ROM driver Revision: 3.20
[  241.763352] sr 5:0:1:0: Attached scsi generic sg5 type 5
