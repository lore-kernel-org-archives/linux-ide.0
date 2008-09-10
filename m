From: "liping.ye" <liping.ye@candelis.com>
Subject: Sony SATA Tape drive problem
Date: Wed, 10 Sep 2008 14:30:53 -0700
Message-ID: <001901c9138c$81bbaf80$d9c8a8c0@DC4QY5D1>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omr3.networksolutionsemail.com ([205.178.146.53]:47021 "EHLO
	omr3.networksolutionsemail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753146AbYIJV27 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Sep 2008 17:28:59 -0400
Received: from mail.networksolutionsemail.com (ns-omr3.mgt.netsolmail.com [10.49.6.66])
	by omr3.networksolutionsemail.com (8.13.6/8.13.6) with SMTP id m8ALSwmq020593
	for <linux-ide@vger.kernel.org>; Wed, 10 Sep 2008 17:28:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I saw a similar problem posted in this list by Russell Brown several months
ago and didn't see any solution.
I really need some help for this. I'm willing to do any tests and report
results. Any suggestion is highly appreciated. Thanks in advance.
I am trying to use the Sony AIT3Ex SATA tape drive (SDX-870V) on the Intel
Corporation 82801I (ICH9 Family) 2 port SATA IDE Controller (An onboard SATA
controller in Dell PowerEdge T300 Server).
I've tried it on kernel 2.6.24.4 and it is not working correctly when
reading/writing data. 
Sometimes data can be written to tape (using tar) if its size is small. (ex:
<100MB) It fails if the size of the data is large (ex: >500MB) and generates
error message.

The drive status is ok.

mt -f /dev/nst0 status
drive type = Generic SCSI-2 tape
drive status = -1291844608
sense key error = 0
residue count = 0
file number = 0
block number = 0
Tape block size 1024 bytes. Density code 0xb3 (unknown).
Soft error count since last status=0
General status bits on (41010000):
 BOT ONLINE IM_REP_EN

mt -f /dev/nst0 tell
At block 0.

tar -b 128 -chf /dev/nst0 file1
tar: /dev/nst0: Cannot write: Input/output error
tar: Error is not recoverable: exiting now

When I used the sonytape tool to check the tape write and read function. I
got:

./sonytape /dev/sg3 -w datap.bin
SONY tape device detected.
SONY SDX-870V   Revision: 0100
Checking tape drive write and read function.
Warning!! This process will write over data and takes several minutes.
Data compression disabled.
Request Sense data: 0x72 0x0b 0x00 0x00 0x00 0x00 0x00 0x0e 0x09 0x0c
 0x00 0x00 0x00 0x03 0x00 0x00 0x00 0x00 0x00 0x00
 0xa0 0x10
No Sense, Setmark detected
Done.

dmesg error 

ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: BMDMA stat 0x24
ata4.00: cmd a0/01:00:00:00:fc/00:00:00:00:00/a0 tag 0 dma 65536 out
         cdb 0a 01 00 00 40 00 00 00  00 00 00 00 00 00 00 00
         res 10/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
ata4: soft resetting link
ata4.00: configured for UDMA/100
ata4: EH complete
st0: Sense Key : Aborted Command [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 0b 00 00 00 00 00 0e 09 0c 00 00 00 03 00 00 
        00 00 00 00 a0 10 
st0: Add. Sense: No additional sense information
st0: Sense Key : Unit Attention [current] 
Info fld=0x1
st0: Add. Sense: Power on, reset, or bus device reset occurred
st0: Error on write filemark.                    

Other related information from kernel log:

ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 23 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi1 : ata_piix
scsi2 : ata_piix
ata1: SATA max UDMA/133 cmd 0xbc20 ctl 0xbc10 bmdma 0xbc40 irq 18
ata2: SATA max UDMA/133 cmd 0xbc28 ctl 0xbc14 bmdma 0xbc48 irq 18
ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.5[D] -> GSI 22 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.5 to 64
scsi3 : ata_piix
scsi4 : ata_piix
ata3: SATA max UDMA/133 cmd 0xbc30 ctl 0xbc18 bmdma 0xbc60 irq 19
ata4: SATA max UDMA/133 cmd 0xbc38 ctl 0xbc1c bmdma 0xbc68 irq 19
ata3.00: ATAPI: Optiarc DVD+/-RW AD-5170S, 101B, max UDMA/66
ata3.00: configured for UDMA/66
ata4.00: ATAPI: SONY    SDX-870V,     0100, max UDMA/100
ata4.00: applying bridge limits
ata4.00: configured for UDMA/100
scsi 3:0:0:0: CD-ROM            Optiarc  DVD+-RW AD-5170S 101B PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 3:0:0:0: Attached scsi CD-ROM sr0
sr 3:0:0:0: Attached scsi generic sg2 type 5
scsi 4:0:0:0: Sequential-Access SONY     SDX-870V         0100 PQ: 0 ANSI: 3
st 4:0:0:0: Attached scsi tape st0
st 4:0:0:0: st0: try direct i/o: yes (alignment 512 B)
st 4:0:0:0: Attached scsi generic sg3 type 1
I2O subsystem v1.325

Lspci -v (for the SATA controllers)

00:1f.2 IDE interface: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 4 port
SATA IDE Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Dell PowerEdge T300
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 18
        I/O ports at cc20 [size=8]
        I/O ports at cc10 [size=4]
        I/O ports at cc28 [size=8]
        I/O ports at cc14 [size=4]
        I/O ports at cc40 [size=16]
        I/O ports at cc50 [size=16]
        Capabilities: [70] Power Management version 3
        Capabilities: [b0] #13 [0306]

00:1f.5 IDE interface: Intel Corporation 82801I (ICH9 Family) 2 port SATA
IDE Controller (rev 02) (prog-if 85 [Master SecO PriO])
        Subsystem: Dell Unknown device 0210
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 19
        I/O ports at cc30 [size=8]
        I/O ports at cc18 [size=4]
        I/O ports at cc38 [size=8]
        I/O ports at cc1c [size=4]
        I/O ports at cc60 [size=16]
        I/O ports at cc70 [size=16]
        Capabilities: [70] Power Management version 3
        Capabilities: [b0] #13 [0306]

Best Regards,
Liping Ye




