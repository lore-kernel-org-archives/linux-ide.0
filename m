From: "Thomas Pfaff" <tpfaff@gmx.net>
Subject: CompactFlash on VT6421 PATA (failed to set xfermode)
Date: Mon, 28 Aug 2006 13:38:07 +0200
Message-ID: <20060828113807.15790@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:20936 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964831AbWH1LiI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Aug 2006 07:38:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have some trouble with a Hitachi XX.V.3.7 CompactFlash connected to a=
n VIA VT6421 Raid Controller together with kernel 2.6.17.

=46irst i had to add a patch from VIA to support PATA in sata-via.c.

Now i get following error during boot :

libata version 1.20 loaded.
sata_via 0000:00:14.0: version 1.1
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [LNKB] -> GSI 5 (level, low=
) -> IRQ 5
sata_via 0000:00:14.0: routed to hard irq line 7
ata_device_add: ENTER
ata_host_add: ENTER
ata_port_start: prd alloc, virt cf63e000, dma f63e000
ata1: PATA max UDMA/133 cmd 0xFD00 ctl 0xFD0A bmdma 0xF900 irq 5
ata_host_add: ENTER
ata_port_start: prd alloc, virt cf626000, dma f626000
ata2: PATA max UDMA/133 cmd 0xFC00 ctl 0xFC0A bmdma 0xF908 irq 5
ata_host_add: ENTER
ata_port_start: prd alloc, virt c12e9000, dma 12e9000
ata3: PATA max UDMA/133 cmd 0xFB00 ctl 0xFB0A bmdma 0xF910 irq 5
ata_device_add: probe begin
ata_device_add: ata1: bus probe begin
ata_bus_reset: ENTER, host 1, port 0
ata_bus_softreset: ata1: bus reset via SRST
ata1: disabling port
ata_bus_reset: EXIT
ata_device_add: ata1: bus probe end
scsi0 : sata_via
ata_device_add: ata2: bus probe begin
ata_bus_reset: ENTER, host 2, port 1
ata_bus_softreset: ata2: bus reset via SRST
ata2: disabling port
ata_bus_reset: EXIT
ata_device_add: ata2: bus probe end
scsi1 : sata_via
ata_device_add: ata3: bus probe begin
ata_bus_reset: ENTER, host 3, port 2
ata_bus_softreset: ata3: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_read_id: ENTER, host 3, dev 1
ata_dev_select: ENTER, ata3: device 1, wait 1
ata_dev_select: ENTER, ata3: device 1, wait 1
ata_exec_command_pio: ata3: cmd 0xEC
ata_pio_sector: data read
ata_dev_init_params: init dev params=20
ata_dev_select: ENTER, ata3: device 1, wait 1
ata_tf_load_pio: feat 0x0 nsect 0x30 lba 0x0 0x0 0x0
ata_tf_load_pio: device 0xBE
ata_exec_command_pio: ata3: cmd 0x91
ata_host_intr: ata3: protocol 1 (dev_stat 0x50)
ata_dev_init_params: EXIT, err_mask=3D0
ata_dev_select: ENTER, ata3: device 1, wait 1
ata_exec_command_pio: ata3: cmd 0xEC
ata_pio_sector: data read
ata_dev_configure: ENTER, host 3, dev 1
ata3: dev 1 cfg 49:0200 82:7000 83:4004 84:4000 85:7000 86:0004 87:4000=
 88:0000
ata_dump_id: 49=3D=3D0x0200  53=3D=3D0x0003  63=3D=3D0x0000  64=3D=3D0x=
0003  75=3D=3D0x0000 =20
ata_dump_id: 80=3D=3D0x0000  81=3D=3D0x0000  82=3D=3D0x7000  83=3D=3D0x=
4004  84=3D=3D0x4000 =20
ata_dump_id: 88=3D=3D0x0000  93=3D=3D0x0000
ata3: dev 1 ATA-0, max PIO4, 500400 sectors: LBA
ata_dev_configure: EXIT, drv_stat =3D 0x50
ata_dev_set_xfermode: set features - xfer mode
ata_dev_select: ENTER, ata3: device 1, wait 1
ata_tf_load_pio: feat 0x3 nsect 0xC lba 0x0 0x0 0x0
ata_tf_load_pio: device 0xB0
ata_exec_command_pio: ata3: cmd 0xEF
ata_host_intr: ata3: protocol 1 (dev_stat 0x51)
ata_dev_set_xfermode: EXIT, err_mask=3D1
ata3: failed to set xfermode (err_mask=3D0x1)
ata_device_add: ata3: bus probe end
scsi2 : sata_via
ata_device_add: host probe begin
ata_device_add: EXIT, returning 3

What does "failed to set xfermode (err_mask=3D0x1)" means ?

Is this a problem with the CompactFlash card or with the PATA support i=
n sata-via ?

Thank you in advance,
Thomas
--=20


"Feel free" =E2=80=93 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail
