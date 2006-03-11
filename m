From: Jure =?UTF-8?Q?Pe=C4=8Dar?= <pegasus@nerv.eu.org>
Subject: Re: gigabyte iRam not seen by linux
Date: Sat, 11 Mar 2006 03:46:30 +0100
Message-ID: <20060311034630.4c12cf83.pegasus@nerv.eu.org>
References: <20060310013604.1acac722.pegasus@nerv.eu.org>
	<4411BCB6.5080108@gmail.com>
	<44122FBD.9000909@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.pecar.org ([193.95.219.68]:35442 "EHLO mail.pecar.org")
	by vger.kernel.org with ESMTP id S1752323AbWCKCqP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Mar 2006 21:46:15 -0500
Received: from localhost.localdomain (unknown [192.168.0.13])
	by mail.pecar.org (Postfix) with ESMTP id 0937716094
	for <linux-ide@vger.kernel.org>; Sat, 11 Mar 2006 03:46:25 +0100 (CET)
In-Reply-To: <44122FBD.9000909@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


> Tejun Heo wrote:
> > After booting with such kernel, please post the result of dmesg.

This is the relevant part of dmesg with 2.6.16-rc5:

SCSI subsystem initialized
libata version 1.20 loaded.
sata_nv 0000:00:0e.0: version 0.8
ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 23
GSI 16 sharing vector 0xB1 and IRQ 16
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LSA0] -> GSI 23 (level, lo=
w) -> IRQ 16
PCI: Setting latency timer of device 0000:00:0e.0 to 64
ata_device_add: ENTER
ata_host_add: ENTER
ata_port_start: prd alloc, virt ffff81007a0c1000, dma 7a0c1000
ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE482 bmdma 0xE000 irq 16
ata_host_add: ENTER
ata_port_start: prd alloc, virt ffff81007a740000, dma 7a740000
ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE082 bmdma 0xE008 irq 16
ata_device_add: probe begin
ata_device_add: ata1: probe begin
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata_bus_reset: ENTER, host 1, port 0
ata_bus_softreset: ata1: bus reset via SRST
ata_bus_reset: EXIT
ata_dev_identify: ENTER/EXIT (host 1, dev 0) -- nodev
ata_dev_identify: ENTER/EXIT (host 1, dev 1) -- nodev
ata_device_add: ata1: probe end
scsi0 : sata_nv
ata_device_add: ata2: probe begin
ata2: SATA link down (SStatus 0)
ata_device_add: ata2: probe end


On Sat, 11 Mar 2006 10:02:37 +0800
Albert Lee <albertcc@tw.ibm.com> wrote:

>=20
> This pseudo SATA drive looks interesting. There is a SATA connector
> on the PCI adapter. At the first glance, I thought it is a new
> SATA adapter, but it is not.
> (http://www6.tomshardware.com/2005/09/07/can_gigabyte/page2.html)

PCI just provides the power to charge the battery. The memory controlle=
r and sata interface is implemented in the fpga. It's entirely possible=
 that gigabyte did take some shortcuts here ... at least that's my unde=
rstanding of the info above :)
But if the bios and windows see the device and know how to use it ...=20

--=20

Jure Pe=C4=8Dar
http://jure.pecar.org/
