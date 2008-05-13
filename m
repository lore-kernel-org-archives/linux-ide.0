From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: ata_piix 2.6.25 sata failure
Date: Tue, 13 May 2008 09:56:59 +0200
Message-ID: <482949CB.7000208@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co203.xi-lite.net ([149.6.83.203]:52297 "EHLO
	toronto.xi-lite.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756767AbYEMIae (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 May 2008 04:30:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi,

the 2.6.25 from debian fail to make work the second port. I got a "SATA 
link down (SStatus 61 Scontrol 30)" for ata2. ata1 got "SATA link up 3.0 
Gbps (SStatus 13 SControl 30)"
The 2.6.24 works [1]. But some previous kernel (IRRC 2.6.18) had the 
same problem, ie ata2 doesn't work.

My hardware is a intel ICH8[2]

Matthieu



[1]
scsi0 : ata_piix
scsi1 : ata_piix
ata1: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0x11f0 irq 14
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x11f8 irq 15
ata1.00: ATA-7: SAMSUNG HD080HJ/P, ZH100-43, max UDMA/100
ata1.00: 156301488 sectors, multi 16: LBA48
ata1.00: configured for UDMA/100
ata2.00: ATA-7: SAMSUNG HD160JJ/P, ZM100-46, max UDMA7
ata2.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata2.01: ATAPI: HL-DT-STDVD+-RW GSA-H31L, 1.05, max UDMA/100
ata2.00: configured for UDMA/133
ata2.01: configured for UDMA/100


[2]
00:1f.2 IDE interface: Intel Corporation 82801H (ICH8 Family) 4 port 
SATA IDE Controller (rev 02)
00:1f.2 0101: 8086:2820 (rev 02)
