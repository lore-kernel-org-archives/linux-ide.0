From: "Georg C. F. Greve" <greve@gnu.org>
Subject: Re: Problem with Promise SATA-II 150 TX4 Controller (rev 2) [105a:3d18]
Date: Tue, 28 Dec 2004 19:53:38 +0100
Message-ID: <m3pt0u45l9.fsf@reason.gnu-hamburg>
References: <m3zmzy492i.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="20041228195338+0100-101831621-2701149867269777";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from c159162.adsl.hansenet.de ([213.39.159.162]:28544 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S261228AbUL1Sxo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Dec 2004 13:53:44 -0500
In-Reply-To: <m3zmzy492i.fsf@reason.gnu-hamburg> (Georg C. F. Greve's message
	of "Tue, 28 Dec 2004 18:38:29 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, rick@linuxmafia.com

--20041228195338+0100-101831621-2701149867269777
Content-Type: multipart/mixed; boundary="20041228195338+0100982486263526160861579393"

--20041228195338+0100982486263526160861579393

[update]

After some more investigation, I stumbled upon the thread that dealt
with the Promise 579 in October 2004, which contained a similar
situation and error message with the proposed fix at

 http://marc.theaimsgroup.com/?l=linux-ide&m=109814647928388&w=2

so I made the changes


--20041228195338+0100982486263526160861579393
Content-Disposition: inline; filename=patch

--- linux-2.6.10/drivers/scsi/sata_promise.c	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6.10-lirc/drivers/scsi/sata_promise.c	2004-12-28 19:03:31.000000000 +0100
@@ -160,10 +160,11 @@ static struct pci_device_id pdc_ata_pci_
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20319 },
 	{ }	/* terminate list */
 };
 
-
 static struct pci_driver pdc_ata_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= pdc_ata_pci_tbl,
@@ -408,6 +409,8 @@ static irqreturn_t pdc_interrupt (int ir
 
         spin_lock(&host_set->lock);
 
+        writel(mask, mmio_base + PDC_INT_SEQMASK);
+
         for (i = 0; i < host_set->n_ports; i++) {
 		VPRINTK("port %u\n", i);
 		ap = host_set->ports[i];

--20041228195338+0100982486263526160861579393


and recompiled.

When rebooting, this was the dmesg output


--20041228195338+0100982486263526160861579393
Content-Disposition: inline

sata_promise version 1.01
ACPI: PCI interrupt 0000:02:0c.0[A] -> GSI 20 (level, low) -> IRQ 20
ata3: SATA max UDMA/133 cmd 0xF881A200 ctl 0xF881A238 bmdma 0x0 irq 20
ata4: SATA max UDMA/133 cmd 0xF881A280 ctl 0xF881A2B8 bmdma 0x0 irq 20
ata5: SATA max UDMA/133 cmd 0xF881A300 ctl 0xF881A338 bmdma 0x0 irq 20
ata6: SATA max UDMA/133 cmd 0xF881A380 ctl 0xF881A3B8 bmdma 0x0 irq 20
ata3: no device found (phy stat 00000000)
scsi4 : sata_promise
ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:407f
ata4: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
ata4: dev 0 configured for UDMA/133
scsi5 : sata_promise
ata5: no device found (phy stat 00000000)
scsi6 : sata_promise
ata6: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:407f
ata6: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
ata6: dev 0 configured for UDMA/133
scsi7 : sata_promise
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05

--20041228195338+0100982486263526160861579393
Content-Disposition: inline


which does not yet look perfect, but it seems to work.

The disks are present in the system and can be partitioned. Will let
you know in case I run into problems.

Any chance to have the adapter supported in the next release? :)

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--20041228195338+0100982486263526160861579393--

--20041228195338+0100-101831621-2701149867269777
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.92 (GNU/Linux)

iD8DBQBB0auybvivwoZXSsoRAq5bAJ4l1EASLrhXfAd8kd/Dd9MrTMxnSQCePa66
pA/yPcxJu5De9w5mZLE9c4o=
=YzBu
-----END PGP SIGNATURE-----
--20041228195338+0100-101831621-2701149867269777--
