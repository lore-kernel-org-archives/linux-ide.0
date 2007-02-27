From: Thomas Kraemmer <thomas.kraemmer@nefkom.net>
Subject: sata_sx4 driver
Date: Tue, 27 Feb 2007 21:23:35 +0100
Message-ID: <45E49347.9080108@nefkom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:35006 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbXB0UUD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Feb 2007 15:20:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi Jeff,


I'd be very grateful to get your advice on the following issue:

My Promise Sata150 SX4  adapter doesn't work with the sata_sx4 driver 
versions 0.7, 0.8 and 0.9. The card is properly shown by lspci:
0000:04:02.0 RAID bus controller: Promise Technology, Inc. PDC20621 
[SATA150 SX4] 4 Channel IDE RAID Controller (rev 01)

Booting leads to the following error in versions 0.7, 0.8, 0.9 (tried 
different kernels, e.g. Kernel 2.6.20.1 with 0.9):
Feb 24 21:54:55 gatekeeper kernel: libata version 1.12 loaded.
Feb 24 21:54:55 gatekeeper kernel: sata_sx4 version 0.7
Feb 24 21:54:55 gatekeeper kernel: ACPI: PCI Interrupt 0000:04:02.0[A] 
-> GSI 28 (level, low) -> IRQ 19
Feb 24 21:54:55 gatekeeper kernel: Detect Local DIMM Fail
Feb 24 21:54:55 gatekeeper kernel: ACPI: PCI interrupt for device 
0000:04:02.0 disabled
Feb 24 21:54:55 gatekeeper kernel: sata_sx4: probe of 0000:04:02.0 
failed with error -12

Booting with driver version 0.5 works (kernel 2.6.9) and yields the 
following log:
Feb 27 19:53:32 gatekeeper kernel: sata_sx4 version 0.50
Feb 27 19:53:32 gatekeeper kernel: ACPI: PCI interrupt 0000:04:02.0[A] 
-> GSI 28 (level, low) -> IRQ 28
Feb 27 19:53:32 gatekeeper kernel: ata1: SATA max UDMA/133 cmd 
0xF8EC0200 ctl 0xF8EC0238 bmdma 0x0 irq 28
Feb 27 19:53:32 gatekeeper kernel: ata2: SATA max UDMA/133 cmd 
0xF8EC0280 ctl 0xF8EC02B8 bmdma 0x0 irq 28
Feb 27 19:53:32 gatekeeper kernel: ata3: SATA max UDMA/133 cmd 
0xF8EC0300 ctl 0xF8EC0338 bmdma 0x0 irq 28
Feb 27 19:53:32 gatekeeper kernel: ata4: SATA max UDMA/133 cmd 
0xF8EC0380 ctl 0xF8EC03B8 bmdma 0x0 irq 28


Any ideas or advice how to further analyse that problem with the driver 
versions above 0.5 ?


Many thanks in advance and best regards,
Thomas


-- 
Thomas Kraemmer
Sonnenstrasse 7
91058 Erlangen
mailto:thomas.kraemmer@nefkom.net

