From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Tue, 15 Dec 2015 23:34:47 +0000
Message-ID: <yw1x1tanffqg.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:41892 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933794AbbLOXet convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Dec 2015 18:34:49 -0500
In-Reply-To: <1450221935-6034-1-git-send-email-mans@mansr.com> (Mans
	Rullgard's message of "Tue, 15 Dec 2015 23:25:32 +0000")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Mans Rullgard <mans@mansr.com> writes:

> Currently this driver only works with a DesignWare DMA engine which i=
t
> registers manually using the second "reg" address range and interrupt
> number from the DT node.
>
> This patch makes the driver instead use the "dmas" property if presen=
t,
> otherwise optionally falling back on the old way so existing device
> trees can continue to work.
>
> With this change, there is no longer any reason to depend on the 460E=
X
> machine type so drop that from Kconfig.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  drivers/ata/Kconfig          |  10 ++-
>  drivers/ata/sata_dwc_460ex.c | 192 +++++++++++++++++++++++++++------=
----------
>  2 files changed, 131 insertions(+), 71 deletions(-)

The corresponding patch for the canyonlands devicetree looks something
like this.  I don't have any such hardware or even a manual, so I don't
know what values to use for the various required DT properties of the
DMA controller node, nor can I test it.  The SATA driver works with a
different DMA controller on a Sigma Designs chip.

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/=
dts/canyonlands.dts
index 3dc75de..959f36e 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -190,12 +190,22 @@
 					 /* DMA */ 0x2 &UIC0 0xc 0x4>;
 		};
=20
+		DMA0: dma@bffd0800 {
+			compatible =3D "snps,dma-spear1340";
+			reg =3D <4 0xbffd0800 0x400>;
+			interrupt-parent =3D <&UIC3>;
+			interrupts =3D <0x5 0x4>;
+			#dma-cells =3D <3>;
+			/* required properties here */
+		};
+
 		SATA0: sata@bffd1000 {
 			compatible =3D "amcc,sata-460ex";
-			reg =3D <4 0xbffd1000 0x800 4 0xbffd0800 0x400>;
+			reg =3D <4 0xbffd1000 0x800>;
 			interrupt-parent =3D <&UIC3>;
-			interrupts =3D <0x0 0x4       /* SATA */
-				      0x5 0x4>;     /* AHBDMA */
+			interrupts =3D <0x0 0x4>;
+			dmas =3D <&DMA0 0 0 1>;
+			dma-names =3D "sata-dma";
 		};
=20
 		POB0: opb {


--=20
M=E5ns Rullg=E5rd
