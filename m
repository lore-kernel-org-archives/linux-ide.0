From: =?iso-8859-15?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
Subject: Re: [PATCH] pci: imx: enable pcie msi support
Date: Mon, 9 Dec 2013 12:00:53 +0100
Message-ID: <201312091200.53928.jbe@pengutronix.de>
References: <1386581119-2962-1-git-send-email-richard.zhuhongxing@gmail.com> <1386581119-2962-2-git-send-email-richard.zhuhongxing@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53522 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758780Ab3LIK67 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Dec 2013 05:58:59 -0500
In-Reply-To: <1386581119-2962-2-git-send-email-richard.zhuhongxing@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: marex@denx.de, hrhaan@gmail.com, shawn.guo@linaro.org, jgarzik@pobox.com, tj@kernel.org, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

Hi Richard,

On Monday 09 December 2013 10:25:19 Richard Zhu wrote:
> [...]
> +static int dw_msi_check_device(struct msi_chip *chip, struct pci_dev=
 *pdev,
> +		int nvec, int type)=20
> +{
> +	struct pcie_port *pp =3D sys_to_pcie(pdev->bus->sysdata);
> +	u32 val;
> +
> +	if (pp->quirks & DW_PCIE_QUIRK_MSI_SELF_EN) {
> +		if ((type =3D=3D PCI_CAP_ID_MSI) || (type =3D=3D PCI_CAP_ID_MSIX))=
 {
> +			/* Set MSI enable of RC here */
> +			val =3D readl(pp->dbi_base + 0x50);
> +			if ((val & (PCI_MSI_FLAGS_ENABLE << 16)) =3D=3D 0) {
> +				val |=3D PCI_MSI_FLAGS_ENABLE << 16;
> +				writel(val, pp->dbi_base + 0x50);
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}

Maybe I'm wrong: but does setting this bit not already happen in functi=
on
msi_set_enable() in 'drivers/pci/msi.c' (just to a 16 bit register, so =
there's
no bit shift required)?

Regards,
Juergen

--=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.pengut=
ronix.de/  |
