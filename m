From: Ajit Prem <Ajit.Prem@motorola.com>
Subject: sata_vsc and gd31244 on an Intel IQ3124H card
Date: Thu, 07 Oct 2004 09:56:21 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41657535.1070407@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from motgate7.mot.com ([129.188.136.7]:54610 "EHLO motgate7.mot.com")
	by vger.kernel.org with ESMTP id S267518AbUJGQ40 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Oct 2004 12:56:26 -0400
Received: from az33exr02.mot.com (az33exr02.mot.com [10.64.251.232])
	by motgate7.mot.com (Motorola/Motgate7) with ESMTP id i97GnCdn023143
	for <linux-ide@vger.kernel.org>; Thu, 7 Oct 2004 09:49:12 -0700 (MST)
Received: from [144.189.77.128] (mvp-144-189-77-128.corp.mot.com [144.189.77.128])
	by az33exr02.mot.com (Motorola/az33exr02) with ESMTP id i97Gs5NK028629
	for <linux-ide@vger.kernel.org>; Thu, 7 Oct 2004 11:54:05 -0500
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

My SATA disk does not get recognized off
an Intel IQ3124H PCI card that uses the gd31244.
I'm using standard 2.6.8.1 on an MPC8540ADS
board. The IQ3124H card has 4 ports. I connected
the first port to a Maxtor Maxline Plus SATA disk.
I turned on debugging for libata and got the
following messages:


sata_vsc version 0.01
ata_device_add: ENTER
ata_host_add: ENTER
ata_port_start: prd alloc, virt c75ae000, dma 75ae000
ata1: SATA max UDMA/133 cmd 0xCA05F200 ctl 0xCA05F229 bmdma 0xCA05F270 
irq 100
ata_host_add: ENTER
ata_port_start: prd alloc, virt c7029000, dma 7029000
ata2: SATA max UDMA/133 cmd 0xCA05F400 ctl 0xCA05F429 bmdma 0xCA05F470 
irq 100
ata_host_add: ENTER
ata_port_start: prd alloc, virt c702a000, dma 702a000
ata3: SATA max UDMA/133 cmd 0xCA05F600 ctl 0xCA05F629 bmdma 0xCA05F670 
irq 100
kernel: ata_host_add: ENTER
ata_port_start: prd alloc, virt c702c000, dma 702c000
ata4: SATA max UDMA/133 cmd 0xCA05F800 ctl 0xCA05F829 bmdma 0xCA05F870 
irq 100
ata_device_add: probe begin
ata_device_add: ata1: probe begin
ata1: no device found (phy stat 00e050c0)
ata_device_add: ata1: probe end
scsi0 : sata_vsc
ata_device_add: ata2: probe begin
ata2: no device found (phy stat 00008038)
ata_device_add: ata2: probe end
scsi1 : sata_vsc
ata_device_add: ata3: probe begin
ata3: no device found (phy stat 00008038)
ata_device_add: ata3: probe end
scsi2 : sata_vsc
ata_device_add: ata4: probe begin
ata4: no device found (phy stat 2a006d71)
ata_device_add: ata4: probe end
scsi3 : sata_vsc
ata_device_add: probe begin
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,1,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:0,2,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:0,3,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:0,4,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:0,5,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:0,6,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:0,7,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:0,8,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:0,9,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:0,10,0) 12 00 00 00 2400 58 00 c7
ata_scsi_dump_cdb: CDB (1:0,11,0) 12 00 00 00 2400 58 00 c7
ata_scsi_dump_cdb: CDB (1:0,12,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:0,13,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:0,14,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:0,15,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:1,0,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:1,1,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:1,2,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:1,3,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:1,4,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:1,5,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:1,6,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:1,7,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:1,8,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:1,9,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:1,10,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:1,11,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:1,12,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:1,13,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:1,14,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (1:1,15,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (2:0,1,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (2:0,2,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (2:0,3,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (2:0,4,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (2:0,5,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (2:0,6,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (2:0,7,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (2:0,8,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (2:0,9,0) 12 00 00 00 24 00 58 00 c7
...
and so on, till
ata_scsi_dump_cdb: CDB (4:1,14,0) 12 00 00 00 24 00 58 00 c7
ata_scsi_dump_cdb: CDB (4:1,15,0) 12 00 00 00 24 00 58 00 c7
sata_vsc after device add


sata_vsc has been built as a module. If I unload and reload
the module, the phy_stat values in the log above change to
something else.

Any advise on what I should do to be able to use my SATA disk?

Thanks,

AP

