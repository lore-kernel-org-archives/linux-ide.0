From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Subject: Re: ATIIXP support (SATA, ATA133)
Date: Mon, 20 Dec 2004 21:30:43 +0100
Message-ID: <87is6whfv0.fsf@londo.ultra.csn.tu-chemnitz.de>
References: <878y7x2qhq.fsf@kosh.ultra.csn.tu-chemnitz.de>
	<58cb370e041217034449d1b2a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:36595 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261635AbULTUqu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Dec 2004 15:46:50 -0500
In-Reply-To: <58cb370e041217034449d1b2a9@mail.gmail.com> (Bartlomiej
 Zolnierkiewicz's message of "Fri, 17 Dec 2004 12:44:28 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

--=-=-=

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> writes:

>> are there plans to support newer ATI IXP chipsets? I mean:
>> 
>> * PCI 1002:4376 which is an ATA133 controller; this should probably work
>>   with the already existing drivers/ide/pci/atiixp.c driver
>
> Have you tested it?

Yes, but with mixed results:

* a harddisk works fine and without problems

* reading from a DVD/CD-ROM drives with DMA mode gives read-errors
  (position not reproducible, no single-bit errors). I will have to
  make further tests to see if it is caused by the drive, the system
  (see below) or the driver. There are no kernel-messages regarding
  read-errors. In PIO mode, data are read correctly.


The system is an AMD64 system where:

* the i386 mode does not work (lots of lost interrupts)

* in x86_64 mode, the timer is running twice as fast as it should. Dunno
  if this affects the CD-ROM operation

Happens both with the Fedora Core 3 kernel (kernel-2.6.9-1.681_FC3) and
2.6.10-rc3-bk13.


>> * PCI 1002:4379 which is a SATA controller; I verified that it works
>>   with the drivers/ide/pci/atiixp.c driver of 2.6.9 also.
>
> Care to make a patches for 1002:4376 and 1002:4379?

ok, attached. The :4379 uses the sata_sil driver. 'hdparm -t' gives
30MB/s but because of the broken timer this should be around 60MB/s in
real.

After this 'hdparm' command I see a

| HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device

caused by

| ioctl(3, BLKFLSBUF, 0)                  = 0
| ioctl(3, 0x31f, 0)                      = -1 ENOTTY (Inappropriate ioctl for device)


I never saw hdparm on other SATA drives so I can not tell if this is
expected.


>> * PCI 1002:436E and 1002:437A which are both SATA controller. I saw them
>>   in the windoze driver file only and can not tell whether they work
>>   with atiixp.c
>> 
>> Although at least one SATA chipset works with the IDE driver, an own
>> driver using libata would be the better solution. Does there exist
>> already something which can be tested?
>
> At least some of ATi SATA chipsets are based on Silicon Image SATA
> so it should be possible to use sata_sil.c for them.

Thanks. As you can see in the patch, I use it for the :4379 device.



Enrico


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=linux-2.6.10-rc3-bk13-atiixp.diff
Content-Description: support for 1002:437[69] ATI IXP devices

2004-12-20  Enrico Scholz  <enrico.scholz@informatik.tu-chemnitz.de>
	* drivers/ide/pci/atiixp.c: handle 1002:4376 IDE controller also
	* drivers/scsi/sata_sil.c: handle 1002:4379 SATA controller also

--- Linuxa-2.6.10-rc3/drivers/scsi/sata_sil.c.atiixp	2004-12-03 22:52:13.000000000 +0100
+++ linux-2.6.10-rc3/drivers/scsi/sata_sil.c	2004-12-20 20:23:14.000000000 +0100
@@ -71,6 +71,7 @@ static struct pci_device_id sil_pci_tbl[
 	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
+	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ }	/* terminate list */
 };
 
--- linux-2.6.10-rc3/drivers/ide/pci/atiixp.c.atiixp	2004-12-20 19:34:12.000000000 +0100
+++ linux-2.6.10-rc3/drivers/ide/pci/atiixp.c	2004-12-20 20:21:34.000000000 +0100
@@ -348,6 +348,7 @@ static int __devinit atiixp_init_one(str
 static struct pci_device_id atiixp_pci_tbl[] = {
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP2_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_ATI, 0x4376, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);

--=-=-=--
