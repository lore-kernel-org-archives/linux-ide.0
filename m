From: Jure =?UTF-8?Q?Pe=C4=8Dar?= <pegasus@nerv.eu.org>
Subject: Re: gigabyte iRam not seen by linux
Date: Sat, 11 Mar 2006 09:20:13 +0100
Message-ID: <20060311092013.487c1263.pegasus@nerv.eu.org>
References: <20060310013604.1acac722.pegasus@nerv.eu.org>
	<4411BCB6.5080108@gmail.com>
	<44122FBD.9000909@tw.ibm.com>
	<20060311034630.4c12cf83.pegasus@nerv.eu.org>
	<20060311033143.GA12866@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.pecar.org ([193.95.219.68]:54711 "EHLO mail.pecar.org")
	by vger.kernel.org with ESMTP id S1752373AbWCKIT4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2006 03:19:56 -0500
In-Reply-To: <20060311033143.GA12866@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertl@mail.com

On Sat, 11 Mar 2006 12:31:43 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Can you apply the following patch and try again?

OK, now we have this:

SCSI subsystem initialized
libata version 1.20 loaded.
sata_nv 0000:00:0e.0: version 0.8
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LSA0] -> GSI 23 (level, lo=
w) -> IRQ 16
PCI: Setting latency timer of device 0000:00:0e.0 to 64
ata_device_add: ENTER
ata_host_add: ENTER
ata_port_start: prd alloc, virt ffff810076c7e000, dma 76c7e000
ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE482 bmdma 0xE000 irq 16
ata_host_add: ENTER
ata_port_start: prd alloc, virt ffff810074551000, dma 74551000
ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE082 bmdma 0xE008 irq 16
ata_device_add: probe begin
ata_device_add: ata1: probe begin
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata_bus_reset: ENTER, host 1, port 0
ata_bus_reset: devmask=3D0x1
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_try_classify: dev=3D0, TF 00 00:01:01:00:00 a0 50
ata_bus_reset: EXIT
ata_dev_identify: ENTER/EXIT (host 1, dev 0) -- nodev
ata_dev_identify: ENTER/EXIT (host 1, dev 1) -- nodev
ata_device_add: ata1: probe end
scsi0 : sata_nv


--=20

Jure Pe=C4=8Dar
http://jure.pecar.org/
