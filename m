From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Asus M2V-MX SE (VIA K8T890): SATA-II disk only detected as UDMA/100
Date: Wed, 22 Jun 2011 15:56:51 +0200
Message-ID: <1308751011.16578.36.camel@mattotaupa>
References: <1308508217.4141.20.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-3o4gSV105sYqIxmCWmfy"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gw90.de ([188.40.100.199]:51063 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755582Ab1FVOTo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Jun 2011 10:19:44 -0400
Received: from f053036030.adsl.alicedsl.de ([78.53.36.30] helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1QZNvR-0006km-8E
	for linux-ide@vger.kernel.org; Wed, 22 Jun 2011 13:57:01 +0000
In-Reply-To: <1308508217.4141.20.camel@mattotaupa>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--=-3o4gSV105sYqIxmCWmfy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear SATA subsystem folks,


please keep my address in CC list since I am not subscribed.

This is a reply to my message to the coreboot list [1] and I am adding
more current information to it.


Am Sonntag, den 19.06.2011, 20:30 +0200 schrieb Paul Menzel:

the ASUS M2V-MX SE HAS A VIA K8T890 chipset and the following BIOS
version is used.

>         $ sudo dmidecode
>         [=E2=80=A6]
>         # dmidecode 2.9
>         SMBIOS 2.4 present.
>         49 structures occupying 1801 bytes.
>         Table at 0x000F0740.
>        =20
>         Handle 0x0000, DMI type 0, 24 bytes
>         BIOS Information
>                 Vendor: American Megatrends Inc.
>                 Version: 0304  =20
>                 Release Date: 10/30/2007
>                 Address: 0xF0000
>                 Runtime Size: 64 kB
>                 ROM Size: 512 kB
>         [=E2=80=A6]
>=20
> I had to replace my hard drive and bought a new SATA-II disk.
> Unfortunately the full speed is not detected. Instead of UDMA/133 =E2=80=
=93 as
> was used with the old SATA-I disk =E2=80=93 it is reporting UDMA/100.
>=20
>         $ uname -a
>         Linux joe 2.6.32-5-amd64 #1 SMP Tue Mar 8 22:49:26 UTC 2011 x86_6=
4 GNU/Linux
>         $ dmesg # new SATA-II disk
>         [=E2=80=A6]
>         [    0.792878] ata3: SATA max UDMA/133 cmd 0xec00 ctl 0xe880 bmdm=
a 0xe400 irq 21
>         [    0.792881] ata4: SATA max UDMA/133 cmd 0xe800 ctl 0xe480 bmdm=
a 0xe408 irq 21
>         [=E2=80=A6]
>         [    1.384015] ata4: SATA link up 1.5 Gbps (SStatus 123 SControl =
300)
>         [    1.392019] usb 2-1: new low speed USB device using uhci_hcd a=
nd address 2
>         [    1.548219] ata4.00: ATA-8: WDC WD20EARS-60MVWB0, 51.0AB51, ma=
x UDMA/100
>=20
> Here seems to be the problematic line, that somehow the drive is
> reporting the wrong maximum speed or the chipset does not detect it
> correctly.
>=20
>         [    1.548223] ata4.00: 3907029168 sectors, multi 16: LBA48 NCQ (=
depth 0/32)
>         [    1.556240] ata4.00: configured for UDMA/100
>         [    1.556343] scsi 3:0:0:0: Direct-Access     ATA      WDC WD20E=
ARS-60M 51.0 PQ: 0 ANSI: 5
>         [=E2=80=A6]
>         $ dmesg # old SATA-I disk
>         [    0.779300] ata1: SATA max UDMA/133 cmd 0xec00 ctl 0xe880 bmdm=
a 0xe400 irq 21
>         [    0.779303] ata2: SATA max UDMA/133 cmd 0xe800 ctl 0xe480 bmdm=
a 0xe408 irq 21
>         [=E2=80=A6]
>         [    0.980024] ata1: SATA link up 1.5 Gbps (SStatus 123 SControl =
300)
>         [    0.980427] ata3.00: configured for UDMA/33
>         [    1.144418] ata1.00: ATA-8: Hitachi HDP725050GLA360, GM4OA52A,=
 max UDMA/133
>         [    1.144421] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (d=
epth 0/32)
>         [    1.160414] ata1.00: configured for UDMA/133
>         [    1.160566] scsi 0:0:0:0: Direct-Access     ATA      Hitachi H=
DP72505 GM4O PQ: 0 ANSI: 5
>         [    1.364012] ata2: SATA link down 1.5 Gbps (SStatus 0 SControl =
300)
>         [=E2=80=A6]

[=E2=80=A6]

The guy at the computer shop said that under MS Windows you have to set
a jumper to get this working and I also found that in the FAQ of Western
Digital Web site [2]. But setting the jumper did not change anything.
The `dmesg` output is the same.

Also looking at the VIA controllers on their site [2] it does not match
the one I am using, so this problem might not be related to this at all.

        $ lspci
        00:00.0 Host bridge: VIA Technologies, Inc. K8M890CE Host Bridge
        00:00.1 Host bridge: VIA Technologies, Inc. K8M890CE Host Bridge
        00:00.2 Host bridge: VIA Technologies, Inc. K8M890CE Host Bridge
        00:00.3 Host bridge: VIA Technologies, Inc. K8M890CE Host Bridge
        00:00.4 Host bridge: VIA Technologies, Inc. K8M890CE Host Bridge
        00:00.5 PIC: VIA Technologies, Inc. K8M890CE I/O APIC Interrupt Con=
troller
        00:00.7 Host bridge: VIA Technologies, Inc. K8M890CE Host Bridge
        00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T80=
0/K8T890 South]
        00:02.0 PCI bridge: VIA Technologies, Inc. K8T890 PCI to PCI Bridge=
 Controller
        00:03.0 PCI bridge: VIA Technologies, Inc. K8T890 PCI to PCI Bridge=
 Controller
        00:0f.0 IDE interface: VIA Technologies, Inc. Device 5372
        00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/=
A/B/VT823x/A/C PIPC Bus Master IDE (rev 07)
        00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1=
.1 Controller (rev b0)
        00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1=
.1 Controller (rev b0)
        00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1=
.1 Controller (rev b0)
        00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1=
.1 Controller (rev b0)
        00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 90)
        00:11.0 ISA bridge: VIA Technologies, Inc. VT8237S PCI to ISA Bridg=
e
        00:11.7 Host bridge: VIA Technologies, Inc. VT8251 Ultra VLINK Cont=
roller
        00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-I=
I] (rev 7c)
        00:13.0 Host bridge: VIA Technologies, Inc. VT8237A Host Bridge
        00:13.1 PCI bridge: VIA Technologies, Inc. VT8237A PCI to PCI Bridg=
e
        00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opte=
ron] HyperTransport Technology Configuration
        00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opte=
ron] Address Map
        00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opte=
ron] DRAM Controller
        00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opte=
ron] Miscellaneous Control
        01:00.0 VGA compatible controller: VIA Technologies, Inc. K8M890CE/=
K8N890CE [Chrome 9] (rev 11)
        20:01.0 Audio device: VIA Technologies, Inc. VT1708/A [Azalia HDAC]=
 (VIA High Definition Audio Controller) (rev 10)

This problem is reproducible with Linux kernel 2.6.32 and 2.6.39 on a
Debian Sid/unstable system.

Any insight or help is much appreciated. Searching for

	linux-ide sata II via chipset udma 100

did not find anything useful.


Thanks,

Paul


[1] http://www.coreboot.org/pipermail/coreboot/2011-June/065622.html
[2] http://wdc.custhelp.com/app/answers/detail/search/1/a_id/1337/c/130/p/2=
27,294

--=-3o4gSV105sYqIxmCWmfy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk4B9KIACgkQPX1aK2wOHVicJACfUuZGETK1QJOuZsmlgMmJV1gJ
CngAn1uvwRbAWTa8IXTxUH5cw4xPWVrH
=DykC
-----END PGP SIGNATURE-----

--=-3o4gSV105sYqIxmCWmfy--

