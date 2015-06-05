From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v2 1/2] devicetree:bindings: add devicetree bindings for
 ceva ahci
Date: Fri, 05 Jun 2015 08:46:28 +0200
Message-ID: <557145C4.6030801@monstr.eu>
References: <1433484148-7464-1-git-send-email-suneel.garapati@xilinx.com> <1433484148-7464-2-git-send-email-suneel.garapati@xilinx.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="k4d7d49qSpFhqjTQ3cscvOu48asqpWJmf"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433484148-7464-2-git-send-email-suneel.garapati@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suneel Garapati <suneel.garapati@xilinx.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tj@kernel.org, michals@xilinx.com, sorenb@xilinx.com, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k4d7d49qSpFhqjTQ3cscvOu48asqpWJmf
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 06/05/2015 08:02 AM, Suneel Garapati wrote:
> adds bindings for CEVA AHCI SATA controller. optional property
> broken-gen2 is useful incase of hardware speed limitation.
>=20
> Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-ceva.txt | 20 +++++++++++++=
+++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-ceva.txt=

>=20
> diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.txt b/Docu=
mentation/devicetree/bindings/ata/ahci-ceva.txt
> new file mode 100644
> index 0000000..7ca8b97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> @@ -0,0 +1,20 @@
> +Binding for CEVA AHCI SATA Controller
> +
> +Required properties:
> +  - reg: Physical base address and size of the controller's register a=
rea.
> +  - compatible: Compatibility string. Must be 'ceva,ahci-1v84'.
> +  - clocks: Input clock specifier. Refer to common clock bindings.
> +  - interrupts: Interrupt specifier. Refer to interrupt binding.
> +
> +Optional properties:
> +  - ceva,broken-gen2: limit to gen1 speed instead of gen2.
> +
> +Examples:
> +	ahci@fd0c0000 {
> +		compatible =3D "ceva,ahci-1v84";
> +		reg =3D <0xfd0c0000 0x200>;
> +		interrupt-parent =3D <&gic>;
> +		interrupts =3D <0 133 4>;
> +		clocks =3D <&clkc SATA_CLK_ID>;
> +		ceva,broken-gen2;
> +	};
> --
> 2.1.2

Acked-by: Michal Simek <michal.simek@xilinx.com>

FYI: Adding ceva prefix to vendor-prefixes is already in arm-soc tree.
And
ceva,broken-gen2 targets hardware limitation.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--k4d7d49qSpFhqjTQ3cscvOu48asqpWJmf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlVxRcQACgkQykllyylKDCGFkgCglKFiAZCuzPL8eAGxaqnDnzKL
8+wAn2Tzq5mE0HEOAkc1b2vwOrZCTMTt
=12it
-----END PGP SIGNATURE-----

--k4d7d49qSpFhqjTQ3cscvOu48asqpWJmf--
