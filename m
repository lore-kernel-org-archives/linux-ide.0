From: "Georg C. F. Greve" <greve@fsfeurope.org>
Subject: Problem with Promise SATA-II 150 TX4 Controller (rev 2) [105a:3d18]
Date: Tue, 28 Dec 2004 18:38:29 +0100
Message-ID: <m3zmzy492i.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="20041228183829+010087522799-58362784105753720";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from c159162.adsl.hansenet.de ([213.39.159.162]:15744 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S261204AbUL1Rie (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Dec 2004 12:38:34 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, rick@linuxmafia.com

--20041228183829+010087522799-58362784105753720

Hi Jeff / all,

I got myself a PDC20518 SATAII 150 IDE Controller by Promise, which
has PCI ID 105a:3d18 (listed in PCIID database on sf.net) and claims
Linux kernel support in its handbook. It is listed as a dubious
candidate at http://www.linuxmafia.com/faq/Hardware/sata.html, it
seems, which is why I am CCing Rick.

Running lspci -vvv shows it as

0000:02:0c.0 Unknown mass storage controller: Promise Technology, Inc. PDC20518 SATAII 150 IDE Controller (rev 02)
	Subsystem: Promise Technology, Inc. PDC20518 SATAII 150 IDE Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at d080 [size=128]
	Region 2: I/O ports at de00 [size=256]
	Region 3: Memory at feafd000 (32-bit, non-prefetchable) [size=4K]
	Region 4: Memory at feac0000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at feab0000 [disabled] [size=32K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

On first attempt, neither the sata_promise nor sata_tx4 drivers of
kernel 2.6.10 recognize the controller.


The second shot was another driver offered by Promise for download at

 http://www.promise.com/support/download/download2_eng.asp?productId=129&category=All&os=100

which seems to consist of a wrapper/kernel module under the GNU GPL
called pdc-ulsata2, which itself incorporates a "Common Access Module
with Linux Serial ATA Driver" (CAM); this CAM appears to be
proprietary and is marked Copyright (c) 2002 Promise Technology.

But even if one felt like ignoring the messy license situation, which
I really don't, the driver does not build out of the box with kernel
2.6.10. Spending much time on that driver seems wasted as long as it
is proprietary, anyway.


So as a third shot, I brutally added the PCI ID to sata_promise.c,
recompiled and gave it a try. Here is the syslog output:

 sata_promise version 1.01
 ACPI: PCI interrupt 0000:02:0c.0[A] -> GSI 20 (level, low) -> IRQ 20
 ata3: SATA max UDMA/133 cmd 0xF8BD8200 ctl 0xF8BD8238 bmdma 0x0 irq 20
 ata4: SATA max UDMA/133 cmd 0xF8BD8280 ctl 0xF8BD82B8 bmdma 0x0 irq 20
 ata5: SATA max UDMA/133 cmd 0xF8BD8300 ctl 0xF8BD8338 bmdma 0x0 irq 20
 ata6: SATA max UDMA/133 cmd 0xF8BD8380 ctl 0xF8BD83B8 bmdma 0x0 irq 20
 ata3: no device found (phy stat 00000000)
 scsi4 : sata_promise
 ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:407f
 ata4: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
 ata4: dev 0 configured for UDMA/133
 scsi5 : sata_promise
 ata5: no device found (phy stat 00000000)
 scsi6 : sata_promise
 irq 20: nobody cared!
  [__report_bad_irq+34/128] __report_bad_irq+0x22/0x80
  [note_interrupt+80/128] note_interrupt+0x50/0x80
  [__do_IRQ+281/288] __do_IRQ+0x119/0x120
  [do_IRQ+26/48] do_IRQ+0x1a/0x30
  [common_interrupt+26/32] common_interrupt+0x1a/0x20
  [default_idle+42/64] default_idle+0x2a/0x40
  [cpu_idle+70/112] cpu_idle+0x46/0x70
  [start_kernel+329/368] start_kernel+0x149/0x170
 handlers:
 [pg0+944219616/1068004352] (ohci_irq_handler+0x0/0x6b0 [ohci1394])
 [pg0+946226192/1068004352] (pdc_interrupt+0x0/0x1a0 [sata_promise])
 Disabling IRQ #20
 ata6: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:407f
 ata6: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48

Well, this looks like it *almost* worked and might be made to work
without too much hassle by someone who knows what he/she is
doing. (Jeff?)

All help very much appreciated.

If you need more info, please let me know.

Regards,
Georg

-- 
Georg C. F. Greve                                 <greve@fsfeurope.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
GNU Business Network                        (http://mailman.gnubiz.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--20041228183829+010087522799-58362784105753720
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.92 (GNU/Linux)

iD8DBQBB0ZoVbvivwoZXSsoRAugnAJwMrhQeOpTKo76CxkkxtBOc1L+UlgCgseNm
tTQnUMUPekXXN3BbZjlUIyI=
=c8or
-----END PGP SIGNATURE-----
--20041228183829+010087522799-58362784105753720--
