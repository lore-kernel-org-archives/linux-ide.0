From: Timur Tabi <timur@freescale.com>
Subject: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
Date: Tue, 07 Apr 2009 09:54:12 -0500
Message-ID: <49DB6914.1030107@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:61163 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757547AbZDGOzQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2009 10:55:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org

Tejun,

Your patch

> ahci: drop intx manipulation on msi enable
>     
>     There's no need to turn off intx explicitly on msi enable.  This is
>     automatically handled by pci.  Drop it.
>     
>     This might be needed on machines if the BIOS turns intx off during
>     boot.  However, there's no evidence of such behavior for ahci and
>     the only such case seems to be ICH5 PATA according to ata_piix.
>     Also, given the way ahci operates, it's highly unlikely BIOS ever
>     disables IRQ for the controller.  However, as this change has slight
>     possibility of introducing failure, please schedule it for #upstream.

breaks SATA support on a Freescale MPC8610 HPCD (PowerPC) reference
board.  When I apply the patch, I get this result during boot:

ata1: SATA max UDMA/133 irq_stat 0x00400040, connection status changed
irq 19
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: limiting SATA link speed to 1.5 Gbps
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)

This board uses a ULI M1575 for SATA support.

Unfortunately, I don't know enough about SATA or PCI interrupts to
understand why you made the change or why it breaks on my board.

-- 
Timur Tabi
Linux kernel developer at Freescale
