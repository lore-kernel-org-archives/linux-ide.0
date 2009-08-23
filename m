From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: 2.6.31-rc6: ACPI handle has no context apparenty from libata during suspend to RAM
Date: Sun, 23 Aug 2009 14:24:03 +0400
Message-ID: <200908231424.07900.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3197210.qu4hLDVgC1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

--nextPart3197210.qu4hLDVgC1
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Even if messages is DEBUG, I assume condition is unusual (otherwise we=20
would not need any message in the first place).

This is Dell XPS M1330 with ICH8M:

00:1f.1 IDE interface: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E)=20
IDE Controller (rev 02)                                                    =
            =20
        Subsystem: Dell Device 0209                                        =
   =20
        Kernel driver in use: ata_piix                                     =
   =20
        Kernel modules: ata_piix, pata_acpi, ata_generic, piix, ide-pci-
generic
00:1f.2 SATA controller: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E)=20
SATA AHCI Controller (rev 02)                                              =
          =20
        Subsystem: Dell Device 0209                                        =
   =20
        Kernel driver in use: ahci                                         =
   =20
        Kernel modules: ahci                                               =
   =20

Every time I do to sleep I get:

PM: Entering mem sleep
Suspending console(s) (use no_console_suspend to debug)
btusb_bulk_complete: hci0 urb ffff88005485d180 failed to resubmit (1)
btusb_bulk_complete: hci0 urb ffff880039086c00 failed to resubmit (1)
btusb_intr_complete: hci0 urb ffff880078556780 failed to resubmit (1)
sd 0:0:0:0: [sda] Synchronizing SCSI cache
sd 0:0:0:0: [sda] Stopping disk
ACPI handle has no context!
sdhci-pci 0000:03:01.1: PME# disabled
sdhci-pci 0000:03:01.1: PCI INT B disabled
ACPI handle has no context!
ata5: port disabled. ignoring.
ata_piix 0000:00:1f.1: PCI INT A disabled
ehci_hcd 0000:00:1d.7: PCI INT A disabled
=2E..

Otherwise there are no negative effects as far as I can tell.

--nextPart3197210.qu4hLDVgC1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqRGMMACgkQR6LMutpd94zqkQCgtfdwnBu7Gc9ycFLqkoaRpaXA
WE4AnRaQV9ATG1//aO8DXZf6N1YiiexF
=rs/A
-----END PGP SIGNATURE-----

--nextPart3197210.qu4hLDVgC1--
