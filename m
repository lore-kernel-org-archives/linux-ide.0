From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Thu, 17 Dec 2015 15:13:59 +0000
Message-ID: <yw1x60zxds5k.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<yw1x1tanffqg.fsf@unicorn.mansr.com>
	<1450364395.30729.136.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:45841 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755634AbbLQPOD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2015 10:14:03 -0500
In-Reply-To: <1450364395.30729.136.camel@linux.intel.com> (Andy Shevchenko's
	message of "Thu, 17 Dec 2015 16:59:55 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Tue, 2015-12-15 at 23:34 +0000, M=E5ns Rullg=E5rd wrote:
>> Mans Rullgard <mans@mansr.com> writes:
>>=20
>> > Currently this driver only works with a DesignWare DMA engine whic=
h
>> > it
>> > registers manually using the second "reg" address range and
>> > interrupt
>> > number from the DT node.
>> >=20
>> > This patch makes the driver instead use the "dmas" property if
>> > present,
>> > otherwise optionally falling back on the old way so existing devic=
e
>> > trees can continue to work.
>> >=20
>> > With this change, there is no longer any reason to depend on the
>> > 460EX
>> > machine type so drop that from Kconfig.
>> >=20
>> > Signed-off-by: Mans Rullgard <mans@mansr.com>
>> > ---
>> > =A0drivers/ata/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A010 ++-
>> > =A0drivers/ata/sata_dwc_460ex.c | 192 +++++++++++++++++++++++++++-=
-
>> > --------------
>> > =A02 files changed, 131 insertions(+), 71 deletions(-)
>>=20
>> The corresponding patch for the canyonlands devicetree looks
>> something
>> like this.=A0=A0I don't have any such hardware or even a manual, so =
I
>> don't
>> know what values to use for the various required DT properties of th=
e
>> DMA controller node, nor can I test it.=A0=A0The SATA driver works w=
ith a
>> different DMA controller on a Sigma Designs chip.
>>=20
>> diff --git a/arch/powerpc/boot/dts/canyonlands.dts
>> b/arch/powerpc/boot/dts/canyonlands.dts
>> index 3dc75de..959f36e 100644
>> --- a/arch/powerpc/boot/dts/canyonlands.dts
>> +++ b/arch/powerpc/boot/dts/canyonlands.dts
>> @@ -190,12 +190,22 @@
>> =A0					=A0/* DMA */ 0x2 &UIC0 0xc
>> 0x4>;
>> =A0		};
>> =A0
>> +		DMA0: dma@bffd0800 {
>> +			compatible =3D "snps,dma-spear1340";
>> +			reg =3D <4 0xbffd0800 0x400>;
>> +			interrupt-parent =3D <&UIC3>;
>> +			interrupts =3D <0x5 0x4>;
>> +			#dma-cells =3D <3>;
>> +			/* required properties here */
>
> You have to move the master assignments and other custom dw_dmac
> properties. Maybe at some point I will fix that in dw/platform.c.
>
>> +		};

The current sata_dwc driver calls dw_dma_probe() with null pdata which
causes the dw_dma driver to auto-detect most parameters.  It looks like
simply omitting those properties here results in the same thing,
although in this case dw_dma_parse_dt() leaves a devm-allocated pdata
struct adrift.  Deferring the allocation of that and changing the DT
binding doc to make these properties optional for auto-detect-capable
hardware should just work.  Something like this:

diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 68a4815..f90c465 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -103,18 +103,21 @@ dw_dma_parse_dt(struct platform_device *pdev)
 	struct device_node *np =3D pdev->dev.of_node;
 	struct dw_dma_platform_data *pdata;
 	u32 tmp, arr[DW_DMA_MAX_NR_MASTERS];
+	u32 nr_channels;
=20
 	if (!np) {
 		dev_err(&pdev->dev, "Missing DT data\n");
 		return NULL;
 	}
=20
+	if (of_property_read_u32(np, "dma-channels", nr_channels))
+		return NULL;
+
 	pdata =3D devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return NULL;
=20
-	if (of_property_read_u32(np, "dma-channels", &pdata->nr_channels))
-		return NULL;
+	pdata->nr_channels =3D nr_channels;
=20
 	if (of_property_read_bool(np, "is_private"))
 		pdata->is_private =3D true;


--=20
M=E5ns Rullg=E5rd
