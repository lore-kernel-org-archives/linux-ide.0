From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v2 2/9] ata: ceva: Move sata port phy oob settings to
 device-tree
Date: Fri, 20 Oct 2017 12:42:32 +0200
Message-ID: <db0a29ba-f30e-e38c-04b1-c8cd4c832620@monstr.eu>
References: <cover.1503314240.git.michal.simek@xilinx.com>
 <b9b0e17612ef2d1e842f178bbc47ae6bd36258dd.1503314240.git.michal.simek@xilinx.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2pP0UIfnpJUTKtcrR9moDjVx3avE4QaJs"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b9b0e17612ef2d1e842f178bbc47ae6bd36258dd.1503314240.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc: Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2pP0UIfnpJUTKtcrR9moDjVx3avE4QaJs
Content-Type: multipart/mixed; boundary="WGtNXXaw4bUThrats8xfhMTRjFKv5iAAQ";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org,
 Tejun Heo <tj@kernel.org>
Cc: Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>,
 Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
 linux-ide@vger.kernel.org
Message-ID: <db0a29ba-f30e-e38c-04b1-c8cd4c832620@monstr.eu>
Subject: Re: [PATCH v2 2/9] ata: ceva: Move sata port phy oob settings to
 device-tree
References: <cover.1503314240.git.michal.simek@xilinx.com>
 <b9b0e17612ef2d1e842f178bbc47ae6bd36258dd.1503314240.git.michal.simek@xilinx.com>
In-Reply-To: <b9b0e17612ef2d1e842f178bbc47ae6bd36258dd.1503314240.git.michal.simek@xilinx.com>

--WGtNXXaw4bUThrats8xfhMTRjFKv5iAAQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

On 21.8.2017 13:17, Michal Simek wrote:
> From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>=20
> In SATA Speed negotiation happens with  OOB(Out of Band) signals. These=
 OOB
> signal timing values are configured through vendor specific registers i=
n the
> SATA controller. These OOB timings depends on the generator and detecto=
r clock
> frequency, which varies from board to board (ex: ep108 and zc1751 has d=
ifferent
> clock frequencies).
> To avoid maintaing these OOB settings in the driver, it is better to mo=
ve these
> settings to the device-tree node and read from the device-tree.
>=20
> This patch does the same.
>=20
> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Can you please look at these patches?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--WGtNXXaw4bUThrats8xfhMTRjFKv5iAAQ--

--2pP0UIfnpJUTKtcrR9moDjVx3avE4QaJs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlnp0x0ACgkQykllyylKDCExSACdG1gTAVdtIfKGgUri/7YTYVCB
5s4AniiB+usbJasESsSYXuklnVOcndtB
=34Sm
-----END PGP SIGNATURE-----

--2pP0UIfnpJUTKtcrR9moDjVx3avE4QaJs--
