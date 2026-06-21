Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6F3233722
	for <linux-ide@vger.kernel.org>; Sun, 21 Jun 2026 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782037313; cv=none; b=I4MyW4A8YiH8WwHKTGV7+VRl1gOtjPv20hRciQw25dgaLRNIV6pxt8A7izm5TySonG73SOtrkBzdHhG2Mja9dxFQ3LUjJM/l2gfURWgosBTLk+9WIVSd/9M6mJkh69YKGElEh0lvvnWAj+PvuCiuc/d/Laemm+TCwouuV2/Jy4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782037313; c=relaxed/simple;
	bh=N+a0MLrSshPDh2XG1wqAygiBo1tMzAz6L8HogcNk6s4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uu4W1v6jl1qh2L6kAKZDOOVmym8gZ1CUAlVibstvZzK+MrIo5yZrU36850890fEesIpfg6n7hfqTsJi1VhYZ0n2zWDHm51NzIGcLQupfbaH73BtLc9GU2UnZGMJzYKNsrARUG/L021AppLC+PGOjX+s6nJYFi4b0ZKoit5L9FRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpMwv0Fn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpMwv0Fn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CE51F000E9;
	Sun, 21 Jun 2026 10:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782037312;
	bh=rg89VG8iTDzmChg1Ck4UmwFalYI/XbF2OuiqRMGVZyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CpMwv0Fn2Zps9sRelGAxtgAVBShddqRNKd84sNCye/3xqX9d4m1xYjx3H1sxv1sAf
	 UqNkMgJcVGkbgEP1eqeG0Ws4srfugqse9PZq5SHtLNYFeX9w5ugda2wjyaMzrTdx8h
	 5t4XUE2TtoN8OZPD3RmW2s2mNgIuSQa38exNhJbHizFG93etJKr0JzX4YM3ff9AMXo
	 IuHYDDu12wg2Au+RUOdy9zjCXvLNKasv2vsPeHdGRhSEdb3wau66qKSK7QQA/iu1ZL
	 YMq3HvwbJSxGLwp/EH1szqlYGlYAWl0f3wfClsE+v12gR5WxTdTstedZumPnKgCXpt
	 28661ve/qOswA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: ahci: force 32-bit DMA for ASMedia ASM1166
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alvin Lim" <alvinwylim@gmail.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260621100844.1224301-1-alvinwylim@gmail.com>
References: <20260621100844.1224301-1-alvinwylim@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 10:21:51 +0000
Message-Id: <20260621102151.E9CE51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The 32-bit DMA quirk is applied only to the ASM1166, leaving i=
dentical sibling controllers (ASM1164 and ASM1165) exposed to catastrophic =
silent data corruption.
- [Critical] The `AHCI_HFLAG_32BIT_ONLY` quirk clears `HOST_CAP_64` from `h=
priv->cap`, preventing the driver from explicitly zeroing the upper 32-bit =
DMA address registers, which can lead to DMA to corrupted physical addresse=
s.
--

commit aa72273e536a2a474b07a2e0e23ffb50c8b94418
Author: Alvin Lim <alvinwylim@gmail.com>

ata: ahci: force 32-bit DMA for ASMedia ASM1166

This commit limits the ASMedia ASM1166 SATA controller to 32-bit DMA.
It addresses a regression that occurs when the IOMMU is enabled and hands
out DMA addresses above 4 GB, resulting in silent data corruption. A new
board_ahci_32bit_dma board type is introduced and applied to the ASM1166.

> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 58f512f8952a9..895956c2ca15f 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
[ ... ]
> @@ -132,6 +133,13 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
>  		.udma_mask	=3D ATA_UDMA6,
>  		.port_ops	=3D &ahci_ops,
>  	},
> +	[board_ahci_32bit_dma] =3D {
> +		AHCI_HFLAGS	(AHCI_HFLAG_32BIT_ONLY),

[Severity: Critical]
This is a pre-existing issue, but does using AHCI_HFLAG_32BIT_ONLY here
expose a regression in ahci_start_fis_rx()?

When AHCI_HFLAG_32BIT_ONLY is set, ahci_save_initial_config() clears
HOST_CAP_64 from the capability flags.

Later, in ahci_start_fis_rx(), the hardware registers PORT_LST_ADDR_HI and
PORT_FIS_ADDR_HI are not zeroed out because the flag is cleared:

    if (hpriv->cap & HOST_CAP_64) {
        writel((pp->cmd_slot_dma >> 16) >> 16,
               port_mmio + PORT_LST_ADDR_HI);
        writel((pp->rx_fis_dma >> 16) >> 16,
               port_mmio + PORT_FIS_ADDR_HI);
    }

If the hardware is genuinely 64-bit capable and not fully reset, can it
retain stale upper 32-bit addresses left by the firmware, causing DMA to
target the wrong physical addresses when concatenated with the new lower
32 bits?

> +		.flags		=3D AHCI_FLAG_COMMON,
> +		.pio_mask	=3D ATA_PIO4,
> +		.udma_mask	=3D ATA_UDMA6,
> +		.port_ops	=3D &ahci_ops,
> +	},
[ ... ]
> @@ -1559,7 +1567,7 @@ static const struct pci_device_id ahci_pci_tbl[] =
=3D {
>  	}, {
>  		/* ASM1166 */
>  		PCI_VDEVICE(ASMEDIA, 0x1166),
> -		.driver_data =3D board_ahci,
> +		.driver_data =3D board_ahci_32bit_dma,
>  	}, {

[Severity: Critical]
This is a pre-existing issue, but does this quirk need to be applied to
sibling controllers as well?

Looking at ahci_pci_tbl, ASM1164 and ASM1165 are from the same silicon
series and still map to plain board_ahci:

    /* ASM1164 */
    PCI_VDEVICE(ASMEDIA, 0x1164),
    .driver_data =3D board_ahci,
    }, {
    /* ASM1165 */
    PCI_VDEVICE(ASMEDIA, 0x1165),
    .driver_data =3D board_ahci,

Does leaving them without the 32-bit DMA limit expose them to the same
regression where IOMMU addresses above 4 GB cause data corruption?

>  		/*
>  		 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621100844.1224=
301-1-alvinwylim@gmail.com?part=3D1
