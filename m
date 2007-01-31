From: Jose Alberto Reguero <jareguero@telefonica.net>
Subject: Re: Add suport for Marvell 88SE6121 in ahci
Date: Wed, 31 Jan 2007 17:43:12 +0100
Message-ID: <200701311743.13091.jareguero@telefonica.net>
References: <200701311504.40277.jareguero@telefonica.net> <45C0AFB6.5010907@garzik.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hcMwFBihoYRst7o"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.telefonica.net ([213.4.149.66]:22695 "EHLO
	ctsmtpout2.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1030261AbXAaQn1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 11:43:27 -0500
In-Reply-To: <45C0AFB6.5010907@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Jay Cliburn <jacliburn@bellsouth.net>

--Boundary-00=_hcMwFBihoYRst7o
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

El Mi=E9rcoles, 31 de Enero de 2007 16:03, Jeff Garzik escribi=F3:
> Jose Alberto Reguero wrote:
> > This work for kernel 2.6.20-rc6
> >
> > First apply this patch:
> >
> > http://marc.theaimsgroup.com/?l=3Dlinux-ide&m=3D116986924301674&w=3D2
> >
> > Then apply the patch attached.
> >
> > Comments:
> >
> > The Marvell 88SE6121 has three ports (0,1,2). The PATA port is port 2.
> > (PATA port for 6141 is port 4). In M2V Motherboard(Marvell 88SE6121)
> > there is only two SATA ports, one of them is external SATA. This two
> > ports work well with this patch.
> >
> > With this part:
> >
> > <       if (pci_enable_msi(pdev) =3D=3D 0)
> > ---
> >
> >>       if ((pdev->vendor !=3D PCI_VENDOR_ID_MARVELL) &&
> >> (pci_enable_msi(pdev)
> >
> > =3D=3D 0))
> >
> > you don't need to disable MSI in kernel.
> > MMCONFIG is disabled at startup in M2V.
> >
> > dmesg:
> > ........
> > PCI: Not using MMCONFIG.
>
> Very useful data points, thanks!
>
> For the future, please make sure to create patches using "diff -u",
> otherwise the patches are very difficult to read and apply.
>
> I've attached your patch as a "diff -u" patch so that others can check
> it out.
>
> 	Jeff

Thanks.
I have another question. When attaching a external SATA disk to the externa=
l=20
SATA PORT, the driver take som seconds, and recognize de disk, and work wel=
l,=20
but there are some errors in dmesg.=20

dmesg1 is after attaching de disk

dmesg2 is after detaching the disk

Can you look them?
They are important?

Jose Alberto

--Boundary-00=_hcMwFBihoYRst7o
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg1"

ata4: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata4: (irq_stat 0x02400000, PHY RDY changed)
ata4: waiting for device to spin up (8 secs)
ata4: soft resetting port
ata4: softreset failed (port busy but CLO unavailable)
ata4: softreset failed, retrying in 5 secs
ata4: hard resetting port
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 31/32)
ata4.00: Drive reports diagnostics failure. This may indicate a drive
ata4.00: fault or invalid emulation. Contact drive vendor for information.
ata4.00: configured for UDMA/133
ata4: EH complete
scsi 3:0:0:0: Direct-Access     ATA      ST3300831AS      3.03 PQ: 0 ANSI: 5
SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1
sd 3:0:0:0: Attached scsi disk sdd
sd 3:0:0:0: Attached scsi generic sg3 type 0

--Boundary-00=_hcMwFBihoYRst7o
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg2"

ata4: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata4: (irq_stat 0x04400000, PHY RDY changed)
ata4: soft resetting port
ata4: SATA link down (SStatus 0 SControl 300)
ata4: failed to recover some devices, retrying in 5 secs
ata4: hard resetting port
ata4: SATA link down (SStatus 0 SControl 300)
ata4: failed to recover some devices, retrying in 5 secs
ata4: hard resetting port
ata4: SATA link down (SStatus 0 SControl 300)
ata4.00: disabled
ata4: EH complete
ata4.00: detaching (SCSI 3:0:0:0)
Synchronizing SCSI cache for disk sdd:
FAILED
  status = 0, message = 00, host = 4, driver = 00

--Boundary-00=_hcMwFBihoYRst7o--
