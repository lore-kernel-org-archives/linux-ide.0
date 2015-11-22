From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH v1 1/2] sata_dwc_460ex: move to generic DMA driver
Date: Sun, 22 Nov 2015 13:03:19 +0000
Message-ID: <yw1xwptab2zs.fsf@unicorn.mansr.com>
References: <1425415282-3750-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1425415282-3750-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:60003 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672AbbKVND1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Nov 2015 08:03:27 -0500
In-Reply-To: <1425415282-3750-2-git-send-email-andriy.shevchenko@linux.intel.com>
	(Andy Shevchenko's message of "Tue, 3 Mar 2015 22:41:21 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, rsarmah@amcc.com, Alexey Brodkin <Alexey.Brodkin@synopsys.com>

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> The SATA implementation based on two actually different devices, i.e.=
 SATA and
> DMA controllers.
>
> For Synopsys DesignWare DMA we have already a generic implementation =
of the
> driver. Thus, the patch converts the code to use DMAEngine framework =
and
> dw_dmac driver.
>
> In future it will be better to split the devices inside DTS as well l=
ike it's
> done on other platforms.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/ata/sata_dwc_460ex.c | 736 +++++++--------------------------=
----------
>  1 file changed, 122 insertions(+), 614 deletions(-)
>

[...]

> @@ -1721,16 +1227,16 @@ static int sata_dwc_probe(struct platform_dev=
ice *ofdev)
>  		   idr, ver[0], ver[1], ver[2]);
>
>  	/* Get SATA DMA interrupt number */
> -	irq =3D irq_of_parse_and_map(np, 1);
> -	if (irq =3D=3D NO_IRQ) {
> +	hsdev->dma->irq =3D irq_of_parse_and_map(np, 1);

This doesn't look like it has been more than compile-tested.  Nothing
ever allocates hsdev->dma, so it can't possibly work.

Also, has anyone given any thought to getting rid of the dependency on
the DW DMA controller?  Presumably support for old device trees would
need to be retained for compatibility.  Maybe checking for a "dmas"
property and falling back on the current behaviour if it's missing.  My
goal is to get this driver working with another chip using the same SAT=
A
controller but a different DMA engine.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
