From: Mathieu Chouquet-Stringer <mchouque@free.fr>
Subject: libata-core and pccard CF card reader
Date: Wed, 1 Feb 2006 11:31:01 +0100
Message-ID: <20060201103101.GA14737@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp13.wanadoo.fr ([193.252.22.54]:36646 "EHLO
	smtp13.wanadoo.fr") by vger.kernel.org with ESMTP id S932397AbWBAKcE
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Feb 2006 05:32:04 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1301.wanadoo.fr (SMTP Server) with ESMTP id 037E47000085
	for <linux-ide@vger.kernel.org>; Wed,  1 Feb 2006 11:32:03 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

	Hello,

During the last couple of month I've been using extensively Mark Lord's
driver for my flash card reader (downloadable at [1]).

Not too long ago he posted an skeleton [2] that was close to work with
the lastest libata release...

In a private email, he made me aware that because of time constraint, h=
e
wasn't sure when he would have the time to fix it.

So I started hacking and made some progress, I fixed a bunch of
functions whose prototypes had changed, add some more bits here and
there and was finally able to compile and to load my kernel module.


The host now registers itself with libata (using standard function
ata_device_add), I see it in dmesg but it fails to register the CF card=
:

ata1: dev 0 not supported, ignoring


Browsing the source, here's what happens:
- the code call ata_device_add (I guess it was originally coded like
  this because ata_pci_init_one which calls ata_pci_init_native_mode or
  ata_pci_init_native_mode would overwrite the special cmd_addr,
  altstatus_addr and ctl_addr)
- this function does some processing then calls ata_bus_probe
- which itself calls ata_dev_identify

I put some debug statements and found my 'problem' in
drivers/scsi/libata-core.c, function ata_dev_identify, around line 1329
(of the latest git). Here's a snippet of code:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
	/* ATA-specific feature tests */
	if (dev->class =3D=3D ATA_DEV_ATA) {
		if (!ata_id_is_ata(dev->id)) /* sanity check */
			goto err_out_nosup;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Problem is my device sets bit 15 of word 0 when you send it a "DEVICE
IDENTIFY" command; the ata_id_is_ata macro expanding to:
(((id)[0] & (1 << 15)) =3D=3D 0)

I then proceeded by removing this check and if you abstract the debug
messages I put here and there in the code, here's what I got in the
logs:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
ata1: dev 0 cfg 49:0300 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000=
 88:0000
class is ATA_DEV_ATA
ata id isn't ata, 0x848a
ata1: dev 0 not supported, ignoring
scsi20 : delkin_cb
libata version 1.20 loaded.
delkin_cb version 0.01
ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNKA] -> GSI 11 (level, lo=
w) -> IRQ 11
ata1: PATA max PIO4 cmd 0x4010 ctl 0x401E bmdma 0xD2000000 irq 11
delkin_cb: id hasn't dma
delkin_cb: phy_reset, c50b2310
ata1: dev 0 cfg 49:0300 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000=
 88:0000
class is ATA_DEV_ATA
ata id isn't ata, 0x848a
ata1: dev 0 ATA-10, max MWDMA2, 4001760 sectors: LBA
ata1: dev 0 configured for PIO4
scsi21 : delkin_cb
  Vendor: ATA       Model: SanDisk SDCFH-20  Rev: HDX=20
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 4001760 512-byte hdwr sectors (2049 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write through
SCSI device sda: 4001760 512-byte hdwr sectors (2049 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write through
 sda: sda1
sd 21:0:0:0: Attached scsi removable disk sda
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

So PIO modes appear to be working correctly (forget the bmdma value,
it's totally bogus...). I mounted the device and started reading stuff
(mainly comparing sha1sums of files I also had on disk): it worked.

But now, I wanted to know more about this bit 15 so I went googling.

On t13.org, I found this old description for bit 15 under "IDENTIFY
DRIVE" command:
15      0 reserved for non-magnetic drive


Then in a revision made in 95 (http://www.t13.org/ballots/d96112r0.pdf)=
,
the bit meaning was changed to:
- Word 0 - Bit 15 set in ATA-2 meant non-magnetic media. Now means
  ATAPI. This breaks use with PCMCIA Flash ATA devices which set this
  bit.

  This was done to be compatible with ATAPI devices as currently
  specified in SFF8020. Since ATA-3 devices and ATAPI SFF8020 devices
  must coexist on the same physical cable with different device drivers=
,
  this compatibility is required. In the case of most if not all PCMCIA
  PC Card ATA devices today, a unique PCMCIA PC Card ATA aware device
  driver is used and this PCMCIA PC Card ATA aware device driver will
  never encounter an ATAPI device.


And now in the latest draft for ATA-8, they say:
15      0 =3D ATA Device
with a comment reading:
Devices that conform to this standard shall clear bit 15 to zero.

(note the "shall" here)


In the logs, I saw my device returned 0x848a. After reading some more
ATA documents, I found it's in fact a known ID and is defined as:
"CompactFlash=E2=84=A2Association (CFA) feature set" (found in a bunch =
of
different working drafts of ATA-x).

So now the questions are:
- is this test in libata-core.c/ata_dev_identify correct?
- if it isn't, should we OR it with something like
  || dev->id[0] =3D=3D 0x848a
- or should we just test bit 7 of word 0 ("removable media device")?
- or did I just open a new can of worms that will lead to adding a new
  subclass of device (CFA feature set) in ata_dev_identify?


Any pointers or ideas would be great, I'd like to get this thing merged
eventually...

Thanks.

[1] http://rtr.ca/delkin_cb-2.6.11.patch
[2] http://lkml.org/lkml/2006/1/19/150

--=20
Mathieu Chouquet-Stringer                         mchouque@free.fr
    "Le disparu, si l'on v=C3=A9n=C3=A8re sa m=C3=A9moire, est plus pr=C3=
=A9sent et
                 plus puissant que le vivant".
           -- Antoine de Saint-Exup=C3=A9ry, Citadelle --

