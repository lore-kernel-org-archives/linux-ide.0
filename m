From: Lin Mac <mkl0301@gmail.com>
Subject: Cannot detect SATA disks w/ CONFIG_SATA_PMP w/o actually using SATA multiplier
Date: Tue, 30 Nov 2010 12:02:18 +0800
Message-ID: <AANLkTi=kbTcq3hYBiDzGcAb02Ppwb1QEcs12-1W_T=LG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43345 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab0K3ECU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Nov 2010 23:02:20 -0500
Received: by fxm8 with SMTP id 8so793666fxm.19
        for <linux-ide@vger.kernel.org>; Mon, 29 Nov 2010 20:02:18 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: cbouatmailru@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi,

I found that if I enabled CONFIG_SATA_PMP while not using multiplier
and connect the disks directly to the board, the disk cannot be found
due to software reset always failed.

With arm/cns3xxx
linux-2.6.37-rc3
ahci-platform driver

# modprobe ahci-platform
[   12.790000] ahci ahci.0: forcing PORTS_IMPL to 0x3
[   12.800000] ahci ahci.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x3
impl platform mode
[   12.810000] ahci ahci.0: flags: ncq sntf pm led clo only pmp pio
slum part ccc
[   12.850000] scsi0 : ahci_platform
[   12.860000] scsi1 : ahci_platform
[   12.870000] ata1: SATA max UDMA/133 irq_stat 0x00400040, connection
status changed irq 65
[   12.880000] ata2: SATA max UDMA/133 mmio [mem
0x83000000-0x83ffffff] port 0x180 irq 65
[   13.240000] ata2: SATA link down (SStatus 0 SControl 300)
[   18.900000] ata1: link is slow to respond, please be patient (ready=0)
[   22.930000] ata1: softreset failed (device not ready)
[   28.940000] ata1: link is slow to respond, please be patient (ready=0)
[   32.970000] ata1: softreset failed (device not ready)
[   38.980000] ata1: link is slow to respond, please be patient (ready=0)
[   68.030000] ata1: softreset failed (device not ready)
[   68.040000] ata1: limiting SATA link speed to 1.5 Gbps
[   70.280000] ata1: SATA link down (SStatus 1 SControl 310)

With some debug, ahci_check_ready always get PORT_TFDATA(20)=0x1d0

While using multiplier with CONFIG_SATA_PMP enabled, or using disks
directly without CONFIG_SATA_PMP have no issue.
After some googling, it seems common and the only fix is to disable
CONFIG_SATA_PMP.
So, before I keep on going, I would like to know whether this is a
limitation, or a bug?

Best Regards,
Mac Lin
