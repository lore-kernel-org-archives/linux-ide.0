From: Peter Klotz <peter.klotz@aon.at>
Subject: Problems with Silicon Image Port Multiplier Card
Date: Tue, 03 Nov 2009 22:34:52 +0100
Message-ID: <4AF0A1FC.4030106@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from warsl404pip5.highway.telekom.at ([195.3.96.77]:4056 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754216AbZKCVew (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Nov 2009 16:34:52 -0500
Received: from 212-183-98-70.adsl.highway.telekom.at (HELO [192.168.0.102]) ([212.183.98.70])
          (envelope-sender <peter.klotz@aon.at>)
          by smarthub96.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 3 Nov 2009 21:34:52 -0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello

My port multiplier capable eSATA Express Card refuses to talk to my 
external HDD box (2 HDDs, JBOD mode).

Inserting the card into the Express Card slot looks normal:

[  622.549794] pciehp 0000:00:1c.2:pcie04: Card present on Slot(0)
[  622.698856] sata_sil24 0000:03:00.0: enabling device (0100 -> 0103)
[  622.698873] sata_sil24 0000:03:00.0: PCI INT A -> GSI 18 (level, low) 
-> IRQ 18
[  622.702334] scsi8 : sata_sil24
[  622.709268] scsi9 : sata_sil24
[  622.709409] ata7: SATA max UDMA/100 host m128@0xfd804000 port 
0xfd800000 irq 18
[  622.709418] ata8: SATA max UDMA/100 host m128@0xfd804000 port 
0xfd802000 irq 18
[  624.800150] ata7: SATA link down (SStatus 0 SControl 0)
[  626.890131] ata8: SATA link down (SStatus 0 SControl 0)


Turning on the external box results in lots of errors:

[  666.030153] ata8: hard resetting link
[  668.250125] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  668.250949] ata8.15: Port Multiplier 1.1, 0x1095:0x5744 r33, 3 ports, 
feat 0x1/0x9
[  668.251251] ata8.15: applying bridge limits
[  668.251340] ata8.00: hard resetting link
[  668.720140] ata8.00: failed to read SCR 0 (Emask=0x40)
[  668.720156] ata8.15: hard resetting link
[  668.720161] ata8: controller in dubious state, performing PORT_RST
[  670.980112] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  673.250164] ata8.00: hard resetting link
[  673.720114] ata8.00: failed to read SCR 0 (Emask=0x1)
[  673.720135] ata8.15: hard resetting link
[  673.720139] ata8: controller in dubious state, performing PORT_RST
[  676.000079] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  678.250112] ata8.00: hard resetting link
[  678.720165] ata8.00: failed to read SCR 0 (Emask=0x1)
[  678.720178] ata8.00: failed to recover link after 3 tries, disabling
[  678.720188] ata8.15: hard resetting link
[  678.720192] ata8: controller in dubious state, performing PORT_RST
[  680.980162] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  681.330653] ata8.01: hard resetting link
[  681.800122] ata8.01: failed to read SCR 0 (Emask=0x40)
[  681.800137] ata8.15: hard resetting link
[  681.800142] ata8: controller in dubious state, performing PORT_RST
[  684.060102] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  686.330059] ata8.01: hard resetting link
[  686.900089] ata8.01: failed to read SCR 0 (Emask=0x1)
[  686.900107] ata8.15: hard resetting link
[  686.900111] ata8: controller in dubious state, performing PORT_RST
[  689.160103] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  691.330098] ata8.01: hard resetting link
[  691.800119] ata8.01: failed to read SCR 0 (Emask=0x40)
[  691.800130] ata8.01: failed to recover link after 3 tries, disabling
[  691.800140] ata8.15: hard resetting link
[  691.800144] ata8: controller in dubious state, performing PORT_RST
[  694.060108] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  694.760490] ata8.02: hard resetting link
[  695.110928] ata8.02: SATA link down (SStatus 0 SControl 320)
[  695.810613] ata8: EH complete


Sometimes the messages look a bit different and one of the HDDs is 
detected but never both.

The initial error seems to always be "failed to read SCR 0".

Does this look like a hardware or a software problem?



The lspci -vnn output of the controller:

03:00.0 Mass storage controller [0180]: Silicon Image, Inc. SiI 3132 
Serial ATA Raid II Controller [1095:3132] (rev 01)
	Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller 
[1095:3132]
	Flags: bus master, fast devsel, latency 0, IRQ 18
	Memory at fd804000 (64-bit, non-prefetchable) [size=128]
	Memory at fd800000 (64-bit, non-prefetchable) [size=16K]
	I/O ports at c000 [size=128]
	[virtual] Expansion ROM at f8000000 [disabled] [size=512K]
	Capabilities: [54] Power Management version 2
	Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 
Enable-
	Capabilities: [70] Express Legacy Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting <?>
	Kernel driver in use: sata_sil24


Regards, Peter.
