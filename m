From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: libata-dev-2.6 ATAPI interrupt lost problem with pdc2027x under UDMA mode
Date: Tue, 16 Nov 2004 17:03:55 +0800
Message-ID: <006601c4cbbb$369788c0$6801a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:46830 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261946AbUKPJEU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Nov 2004 04:04:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

Hi,
  I am testing ATAPI device with libata-dev.2.6 code and the pdc2027x driver.

Environment:
- pdc20275 on the MSI P4HS-4 mainboard
- Maxtor 6Y080L0 as primary dev0
- Seagate ST380011A as primary dev1
- Asus CRW-5232AS as secondard dev0

The following are the results:

1. All the harddisk drives works fine with either PIO or DMA
2. For the ATAPI device, READ and other commands works fine with ATAPI UDMA protocol.
   However, when REQUEST_SENSE / MODE_SENSE is issued to the CD-RW drive with
   ATAPI DMA protocol, the interrupt is lost. 
3. All commands, including REQUEST_SENSE/MODE_SENSE, work fine with ATAPI PIO protocol.
4. PIIX and the same Asus drive work fine, both UDMA and PIO.

For the problem of lost interrupt, I've checked the pdc2027x global control register (which shows 
the status of INTRQ and DMARQ directly), the Asus drive already report INTRQ and 
said UDMA completed.  However, pdc20275 does not report interrupt and said DMA on going.

Any clue or idea for this problem? Thanks.
Albert
=============================================================
(dmesg log attached)
ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 60 00 20 00 00
atapi_xlat: nodata[0]
ata_sg_setup_one: mapped buffer of 96 bytes for read
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)        => "inquiry" is successful
ata_sg_clean: unmapping 1 sg elements
  Vendor: ASUS      Model: CRW-5232AS        Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 05
ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 6 (dev_stat 0x50)   => "test unit ready" is successful
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 2a 00 00 00 00 00 80  => "mode sense" fails 
atapi_xlat: nodata[0]
ata_sg_setup_one: mapped buffer of 128 bytes for read
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_scsi_error: ENTER                 => Promise pdc2027x timeout here. Interrupt lost. (PIIX works.)
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata2: command 0xa0 timeout, stat 0x50 host_stat 0x1  => Device: OK, host: DMA on going.
ata_sg_clean: unmapping 1 sg elements
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
sr0: scsi3-mmc drive: 0x/0x caddy 
=> should be   sr0: scsi3-mmc drive: 52x/52x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20


