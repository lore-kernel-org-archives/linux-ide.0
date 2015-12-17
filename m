From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Thu, 17 Dec 2015 16:59:55 +0200
Message-ID: <1450364395.30729.136.camel@linux.intel.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	 <yw1x1tanffqg.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <yw1x1tanffqg.fsf@unicorn.mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, 2015-12-15 at 23:34 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
> Mans Rullgard <mans@mansr.com> writes:
>=20
> > Currently this driver only works with a DesignWare DMA engine which
> > it
> > registers manually using the second "reg" address range and
> > interrupt
> > number from the DT node.
> >=20
> > This patch makes the driver instead use the "dmas" property if
> > present,
> > otherwise optionally falling back on the old way so existing device
> > trees can continue to work.
> >=20
> > With this change, there is no longer any reason to depend on the
> > 460EX
> > machine type so drop that from Kconfig.
> >=20
> > Signed-off-by: Mans Rullgard <mans@mansr.com>
> > ---
> > =C2=A0drivers/ata/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A010 ++-
> > =C2=A0drivers/ata/sata_dwc_460ex.c | 192 ++++++++++++++++++++++++++=
+--
> > --------------
> > =C2=A02 files changed, 131 insertions(+), 71 deletions(-)
>=20
> The corresponding patch for the canyonlands devicetree looks
> something
> like this.=C2=A0=C2=A0I don't have any such hardware or even a manual=
, so I
> don't
> know what values to use for the various required DT properties of the
> DMA controller node, nor can I test it.=C2=A0=C2=A0The SATA driver wo=
rks with a
> different DMA controller on a Sigma Designs chip.
>=20
> diff --git a/arch/powerpc/boot/dts/canyonlands.dts
> b/arch/powerpc/boot/dts/canyonlands.dts
> index 3dc75de..959f36e 100644
> --- a/arch/powerpc/boot/dts/canyonlands.dts
> +++ b/arch/powerpc/boot/dts/canyonlands.dts
> @@ -190,12 +190,22 @@
> =C2=A0					=C2=A0/* DMA */ 0x2 &UIC0 0xc
> 0x4>;
> =C2=A0		};
> =C2=A0
> +		DMA0: dma@bffd0800 {
> +			compatible =3D "snps,dma-spear1340";
> +			reg =3D <4 0xbffd0800 0x400>;
> +			interrupt-parent =3D <&UIC3>;
> +			interrupts =3D <0x5 0x4>;
> +			#dma-cells =3D <3>;
> +			/* required properties here */

You have to move the master assignments and other custom dw_dmac
properties. Maybe at some point I will fix that in dw/platform.c.

> +		};
> +
> =C2=A0		SATA0: sata@bffd1000 {
> =C2=A0			compatible =3D "amcc,sata-460ex";
> -			reg =3D <4 0xbffd1000 0x800 4 0xbffd0800
> 0x400>;
> +			reg =3D <4 0xbffd1000 0x800>;
> =C2=A0			interrupt-parent =3D <&UIC3>;
> -			interrupts =3D <0x0 0x4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
/* SATA */
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x5 0x4>;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0/* AHBDMA */
> +			interrupts =3D <0x0 0x4>;
> +			dmas =3D <&DMA0 0 0 1>;
> +			dma-names =3D "sata-dma";
> =C2=A0		};
> =C2=A0
> =C2=A0		POB0: opb {
>=20
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
