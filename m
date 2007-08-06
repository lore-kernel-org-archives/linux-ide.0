From: Bob Ham <rah@bash.sh>
Subject: Re: [PATCH 1/2] hpt366: fix PCI clock detection for HPT374
Date: Mon, 06 Aug 2007 18:10:06 +0100
Message-ID: <1186420206.23890.7.camel@orchid.arb.net>
References: <200708060006.35511.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RjuRoqh46wb1YOk+Xclc"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from waffl.ing.me.uk ([217.147.94.6]:59022 "EHLO waffl.ing.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756234AbXHFRKK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Aug 2007 13:10:10 -0400
In-Reply-To: <200708060006.35511.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org


--=-RjuRoqh46wb1YOk+Xclc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-08-06 at 00:06 +0400, Sergei Shtylyov wrote:=20
> HPT374 BIOS seems to only save f_CNT register value for the function #0 b=
efore
> re-tuning DPLL causing the driver to report obviously distorted f_CNT for=
 the
> function #1 -- fix this by always reading the saved f_CNT register value =
from
> in the init_chipset() method the function #0 of HPT374 chip.
> While at it, introduce 'chip_type' for the copy of the 'struct hpt_info' =
member
> and replace the structure assignment by memcpy()...

HPT374: IDE controller at PCI slot 0000:00:0d.0
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 16
HPT374: chipset revision 7
HPT374: DPLL base: 48 MHz, f_CNT: 142, assuming 33 MHz PCI
HPT374: using 50 MHz DPLL clock
HPT374: 100% native mode on irq 16
    ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA, hdh:pio
ACPI: PCI Interrupt 0000:00:0d.1[A] -> GSI 16 (level, low) -> IRQ 16
HPT374: DPLL base: 48 MHz, f_CNT: 142, assuming 33 MHz PCI
HPT374: using 50 MHz DPLL clock
    ide4: BM-DMA at 0xed00-0xed07, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0xed08-0xed0f, BIOS settings: hdk:DMA, hdl:pio


again, followed by a hard lock

--=20
Bob Ham <rah@bash.sh>

--=-RjuRoqh46wb1YOk+Xclc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGt1Xq7whsMRnFexQRAuE1AJ93hHbEFxflvXZ4KSZWk9+zOETljwCfTZv8
z5K0yajcTFWviKiRnNaO6Is=
=0flV
-----END PGP SIGNATURE-----

--=-RjuRoqh46wb1YOk+Xclc--

