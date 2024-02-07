Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454C14A85
	for <linux-ide@vger.kernel.org>; Wed,  7 Feb 2024 04:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707279581; cv=none; b=ZSvtFdxjHM9paF5w+n9amKkd6/g7eQ8AlkdeqehHxQq7Xqr9SP1F0IsuqXs9aUnAy5ZDW4y5LZr8MmEnxyrPyhFaRVo+snBUTcn3X76h5SjPteb6uuQ3D16muvPidgYru2xlL/2XbJRrHljswqo2XyxFOOaVyGJLpwPZYfWrnRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707279581; c=relaxed/simple;
	bh=f4R7hS7lFJxCy9U5xxKSAOmCPfTMvNn0vNMENkVnYuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2UVfIo7iEMetvsrOJRRpmgmWQm81RJ3O4hPD0BcUZiG+0Iq2p+Z6D4iaEe8gEU3ekEJ9dyZjKt1Z8cWNImOnDpHnGa7baxr3Jd7X4UtbV79YSHrUEn1wK29IInbzDWtEOpr/5h4IUHcCc4yrMWPCphlACczFmxneVa+U0hLNeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=Z2ZLoiqL; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="Z2ZLoiqL"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60491cb9571so1388417b3.0
        for <linux-ide@vger.kernel.org>; Tue, 06 Feb 2024 20:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707279576; x=1707884376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxg6HcRaoKngrV15Tx+b1IUvWwxDtumqRy/Rp12M9A0=;
        b=Z2ZLoiqLT3WqqbC2ATG4YpaGwjm7Rt0zug2aH/1OQzxPm8kS/5GeQ3VYqR7T3klsbU
         yqeGyqAV1mcr5us1pHpUPKXc1LDrZIuupm/RryI1bs2vWT7I9PH8/AC7oEOUZR1vxInJ
         xoA0zYV4XS7qKPS4pwXtCsiAN7RfeGnTstat7+Gb3Om/o401cYmM00t0SCV7RBlKlsx/
         cY/EbZ50dnmkkYl7EAmZP3NVRAqq6q5IF5uiI3TzSAjpGfEkMa1a4VsoBWPCvjnd9y2w
         fgrDHwDKo7nQpFUTUxx3dAtQ6tfiaDXCQZsSSJv6A47V6Iu7v0ZSIoK0cuw7smHMBpXS
         TMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707279576; x=1707884376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxg6HcRaoKngrV15Tx+b1IUvWwxDtumqRy/Rp12M9A0=;
        b=c35xwxVdQDxYAX+o1Myavms/jaycstbtbJRNMeG0UydoRu5S4bKOdbncYsAKTw9H+K
         kgg4Lr2WsSTBByp6ElGI2OT1x2RxKv7ppREgZo9W4nlM9HPtdjH4EzGk0KjZconvS1oe
         eG9gvtBPWhoDnxouItUDU9kXhncpLKRh6fgS3ozYGqwX6Ye98xKw7MNtany7Zyg5Tg39
         8oFSfiq0jfTN4BZ7/IEOXKX4Fy9F+60e83yNUcQfJZRAMz+i7EEP9BzKyuoKI+Rq6ltz
         GIo5dxOdMBsAMrPLe33XiN06FwN5AyLN3BT0l9OuxhWwDSOKCdTnPzLKz0i7BE9Z3pKd
         sLYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBuP5HA7kpqQXjZUPztk4mZEtaC0RJlree8e8AjL5LcA+tamI1+es6WjqIa2WtCPz++mr0B8PoxSn0lhDOmvehlkSvWiqWUhjP
X-Gm-Message-State: AOJu0YwMNt+KH1ViRFaAyYqpFWZ/d6BW/jErwrbvGwh0ktyer03ybXoC
	iaU5d5fwhoh2oTwa8YUmz7FskQsswwncGLwN5r/A0HNV42LUEUVSGvvX3cjN/M+cnA0oxTRQ64x
	hZNyIgqnoRpgXuXFMKqK2e76qVljWWUUw7Qu5MQ==
X-Google-Smtp-Source: AGHT+IEWvQEwiVXCTvsCXGJwUsGBswTU7PNiA14+DVMjDCpuqxuazVe9CnnaT3iClx8wBZtFQN+vSrAH0QEL2NXxCzQ=
X-Received: by 2002:a81:b204:0:b0:604:727c:695 with SMTP id
 q4-20020a81b204000000b00604727c0695mr3592859ywh.42.1707279576084; Tue, 06 Feb
 2024 20:19:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206211352.1664816-1-cassel@kernel.org> <20240206211352.1664816-6-cassel@kernel.org>
In-Reply-To: <20240206211352.1664816-6-cassel@kernel.org>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Wed, 7 Feb 2024 12:19:00 +0800
Message-ID: <CAPpJ_edRhF98PiT4tpDFijJCDBNoV-LCMGz-Um1z8zAapDDASg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ata: ahci: Drop low power policy board type
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Werner Fischer <devlists@wefi.net>, 
	Daniel Drake <drake@endlessos.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Dieter Mummenschanz <dmummenschanz@web.de>, Mario Limonciello <mario.limonciello@amd.com>, 
	Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Niklas Cassel <cassel@kernel.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=885:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> The low power policy board type was introduced to allow systems
> to get into deep states reliably.  Before it was introduced `min_power`
> was causing problems for a number of drives.  New power policies
> `min_power_with_partial` and `med_power_with_dipm` have been introduced
> which provide a more stable baseline for systems.
>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> [cassel: rebase patch and fix trivial conflicts]
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/Kconfig |   5 +-
>  drivers/ata/ahci.c  | 109 +++++++++++++++++++-------------------------
>  drivers/ata/ahci.h  |   9 ++--
>  3 files changed, 53 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 42b51c9812a0..928ec93c6b45 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -116,15 +116,14 @@ config SATA_AHCI
>           If unsure, say N.
>
>  config SATA_MOBILE_LPM_POLICY
> -       int "Default SATA Link Power Management policy for low power chip=
sets"
> +       int "Default SATA Link Power Management policy"
>         range 0 4
>         default 0
>         depends on SATA_AHCI
>         help
>           Select the Default SATA Link Power Management (LPM) policy to u=
se
>           for chipsets / "South Bridges" supporting low-power modes. Such
> -         chipsets are typically found on most laptops but desktops and
> -         servers now also widely use chipsets supporting low power modes=
.
> +         chipsets are ubiquitous across laptops, desktops and servers.
>
>           The value set has the following meanings:
>                 0 =3D> Keep firmware settings
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 9d052ff2b86c..ae0a592e2185 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -50,7 +50,6 @@ enum board_ids {
>         board_ahci,
>         board_ahci_43bit_dma,
>         board_ahci_ign_iferr,
> -       board_ahci_low_power,
>         board_ahci_no_debounce_delay,
>         board_ahci_nomsi,
>         board_ahci_noncq,
> @@ -143,13 +142,6 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
>                 .udma_mask      =3D ATA_UDMA6,
>                 .port_ops       =3D &ahci_ops,
>         },
> -       [board_ahci_low_power] =3D {
> -               AHCI_HFLAGS     (AHCI_HFLAG_USE_LPM_POLICY),
> -               .flags          =3D AHCI_FLAG_COMMON,
> -               .pio_mask       =3D ATA_PIO4,
> -               .udma_mask      =3D ATA_UDMA6,
> -               .port_ops       =3D &ahci_ops,
> -       },
>         [board_ahci_no_debounce_delay] =3D {
>                 .flags          =3D AHCI_FLAG_COMMON,
>                 .link_flags     =3D ATA_LFLAG_NO_DEBOUNCE_DELAY,
> @@ -283,13 +275,13 @@ static const struct pci_device_id ahci_pci_tbl[] =
=3D {
>         { PCI_VDEVICE(INTEL, 0x2924), board_ahci }, /* ICH9 */
>         { PCI_VDEVICE(INTEL, 0x2925), board_ahci }, /* ICH9 */
>         { PCI_VDEVICE(INTEL, 0x2927), board_ahci }, /* ICH9 */
> -       { PCI_VDEVICE(INTEL, 0x2929), board_ahci_low_power }, /* ICH9M */
> -       { PCI_VDEVICE(INTEL, 0x292a), board_ahci_low_power }, /* ICH9M */
> -       { PCI_VDEVICE(INTEL, 0x292b), board_ahci_low_power }, /* ICH9M */
> -       { PCI_VDEVICE(INTEL, 0x292c), board_ahci_low_power }, /* ICH9M */
> -       { PCI_VDEVICE(INTEL, 0x292f), board_ahci_low_power }, /* ICH9M */
> +       { PCI_VDEVICE(INTEL, 0x2929), board_ahci }, /* ICH9M */
> +       { PCI_VDEVICE(INTEL, 0x292a), board_ahci }, /* ICH9M */
> +       { PCI_VDEVICE(INTEL, 0x292b), board_ahci }, /* ICH9M */
> +       { PCI_VDEVICE(INTEL, 0x292c), board_ahci }, /* ICH9M */
> +       { PCI_VDEVICE(INTEL, 0x292f), board_ahci }, /* ICH9M */
>         { PCI_VDEVICE(INTEL, 0x294d), board_ahci }, /* ICH9 */
> -       { PCI_VDEVICE(INTEL, 0x294e), board_ahci_low_power }, /* ICH9M */
> +       { PCI_VDEVICE(INTEL, 0x294e), board_ahci }, /* ICH9M */
>         { PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
>         { PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
>         { PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
> @@ -299,9 +291,9 @@ static const struct pci_device_id ahci_pci_tbl[] =3D =
{
>         { PCI_VDEVICE(INTEL, 0x3b23), board_ahci }, /* PCH AHCI */
>         { PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
>         { PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
> -       { PCI_VDEVICE(INTEL, 0x3b29), board_ahci_low_power }, /* PCH M AH=
CI */
> +       { PCI_VDEVICE(INTEL, 0x3b29), board_ahci }, /* PCH M AHCI */
>         { PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
> -       { PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_low_power }, /* PCH M RA=
ID */
> +       { PCI_VDEVICE(INTEL, 0x3b2c), board_ahci }, /* PCH M RAID */
>         { PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
>         { PCI_VDEVICE(INTEL, 0x19b0), board_ahci_pcs7 }, /* DNV AHCI */
>         { PCI_VDEVICE(INTEL, 0x19b1), board_ahci_pcs7 }, /* DNV AHCI */
> @@ -324,9 +316,9 @@ static const struct pci_device_id ahci_pci_tbl[] =3D =
{
>         { PCI_VDEVICE(INTEL, 0x19cE), board_ahci_pcs7 }, /* DNV AHCI */
>         { PCI_VDEVICE(INTEL, 0x19cF), board_ahci_pcs7 }, /* DNV AHCI */
>         { PCI_VDEVICE(INTEL, 0x1c02), board_ahci }, /* CPT AHCI */
> -       { PCI_VDEVICE(INTEL, 0x1c03), board_ahci_low_power }, /* CPT M AH=
CI */
> +       { PCI_VDEVICE(INTEL, 0x1c03), board_ahci }, /* CPT M AHCI */
>         { PCI_VDEVICE(INTEL, 0x1c04), board_ahci }, /* CPT RAID */
> -       { PCI_VDEVICE(INTEL, 0x1c05), board_ahci_low_power }, /* CPT M RA=
ID */
> +       { PCI_VDEVICE(INTEL, 0x1c05), board_ahci }, /* CPT M RAID */
>         { PCI_VDEVICE(INTEL, 0x1c06), board_ahci }, /* CPT RAID */
>         { PCI_VDEVICE(INTEL, 0x1c07), board_ahci }, /* CPT RAID */
>         { PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
> @@ -334,29 +326,29 @@ static const struct pci_device_id ahci_pci_tbl[] =
=3D {
>         { PCI_VDEVICE(INTEL, 0x1d06), board_ahci }, /* PBG RAID */
>         { PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
>         { PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI=
 */
> -       { PCI_VDEVICE(INTEL, 0x1e03), board_ahci_low_power }, /* Panther =
M AHCI */
> +       { PCI_VDEVICE(INTEL, 0x1e03), board_ahci }, /* Panther M AHCI */
>         { PCI_VDEVICE(INTEL, 0x1e04), board_ahci }, /* Panther Point RAID=
 */
>         { PCI_VDEVICE(INTEL, 0x1e05), board_ahci }, /* Panther Point RAID=
 */
>         { PCI_VDEVICE(INTEL, 0x1e06), board_ahci }, /* Panther Point RAID=
 */
> -       { PCI_VDEVICE(INTEL, 0x1e07), board_ahci_low_power }, /* Panther =
M RAID */
> +       { PCI_VDEVICE(INTEL, 0x1e07), board_ahci }, /* Panther M RAID */
>         { PCI_VDEVICE(INTEL, 0x1e0e), board_ahci }, /* Panther Point RAID=
 */
>         { PCI_VDEVICE(INTEL, 0x8c02), board_ahci }, /* Lynx Point AHCI */
> -       { PCI_VDEVICE(INTEL, 0x8c03), board_ahci_low_power }, /* Lynx M A=
HCI */
> +       { PCI_VDEVICE(INTEL, 0x8c03), board_ahci }, /* Lynx M AHCI */
>         { PCI_VDEVICE(INTEL, 0x8c04), board_ahci }, /* Lynx Point RAID */
> -       { PCI_VDEVICE(INTEL, 0x8c05), board_ahci_low_power }, /* Lynx M R=
AID */
> +       { PCI_VDEVICE(INTEL, 0x8c05), board_ahci }, /* Lynx M RAID */
>         { PCI_VDEVICE(INTEL, 0x8c06), board_ahci }, /* Lynx Point RAID */
> -       { PCI_VDEVICE(INTEL, 0x8c07), board_ahci_low_power }, /* Lynx M R=
AID */
> +       { PCI_VDEVICE(INTEL, 0x8c07), board_ahci }, /* Lynx M RAID */
>         { PCI_VDEVICE(INTEL, 0x8c0e), board_ahci }, /* Lynx Point RAID */
> -       { PCI_VDEVICE(INTEL, 0x8c0f), board_ahci_low_power }, /* Lynx M R=
AID */
> -       { PCI_VDEVICE(INTEL, 0x9c02), board_ahci_low_power }, /* Lynx LP =
AHCI */
> -       { PCI_VDEVICE(INTEL, 0x9c03), board_ahci_low_power }, /* Lynx LP =
AHCI */
> -       { PCI_VDEVICE(INTEL, 0x9c04), board_ahci_low_power }, /* Lynx LP =
RAID */
> -       { PCI_VDEVICE(INTEL, 0x9c05), board_ahci_low_power }, /* Lynx LP =
RAID */
> -       { PCI_VDEVICE(INTEL, 0x9c06), board_ahci_low_power }, /* Lynx LP =
RAID */
> -       { PCI_VDEVICE(INTEL, 0x9c07), board_ahci_low_power }, /* Lynx LP =
RAID */
> -       { PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_low_power }, /* Lynx LP =
RAID */
> -       { PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_low_power }, /* Lynx LP =
RAID */
> -       { PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_low_power }, /* Cannon L=
ake PCH-LP AHCI */
> +       { PCI_VDEVICE(INTEL, 0x8c0f), board_ahci }, /* Lynx M RAID */
> +       { PCI_VDEVICE(INTEL, 0x9c02), board_ahci }, /* Lynx LP AHCI */
> +       { PCI_VDEVICE(INTEL, 0x9c03), board_ahci }, /* Lynx LP AHCI */
> +       { PCI_VDEVICE(INTEL, 0x9c04), board_ahci }, /* Lynx LP RAID */
> +       { PCI_VDEVICE(INTEL, 0x9c05), board_ahci }, /* Lynx LP RAID */
> +       { PCI_VDEVICE(INTEL, 0x9c06), board_ahci }, /* Lynx LP RAID */
> +       { PCI_VDEVICE(INTEL, 0x9c07), board_ahci }, /* Lynx LP RAID */
> +       { PCI_VDEVICE(INTEL, 0x9c0e), board_ahci }, /* Lynx LP RAID */
> +       { PCI_VDEVICE(INTEL, 0x9c0f), board_ahci }, /* Lynx LP RAID */
> +       { PCI_VDEVICE(INTEL, 0x9dd3), board_ahci }, /* Cannon Lake PCH-LP=
 AHCI */
>         { PCI_VDEVICE(INTEL, 0x1f22), board_ahci }, /* Avoton AHCI */
>         { PCI_VDEVICE(INTEL, 0x1f23), board_ahci }, /* Avoton AHCI */
>         { PCI_VDEVICE(INTEL, 0x1f24), board_ahci }, /* Avoton RAID */
> @@ -390,26 +382,26 @@ static const struct pci_device_id ahci_pci_tbl[] =
=3D {
>         { PCI_VDEVICE(INTEL, 0x8d66), board_ahci }, /* Wellsburg RAID */
>         { PCI_VDEVICE(INTEL, 0x8d6e), board_ahci }, /* Wellsburg RAID */
>         { PCI_VDEVICE(INTEL, 0x23a3), board_ahci }, /* Coleto Creek AHCI =
*/
> -       { PCI_VDEVICE(INTEL, 0x9c83), board_ahci_low_power }, /* Wildcat =
LP AHCI */
> -       { PCI_VDEVICE(INTEL, 0x9c85), board_ahci_low_power }, /* Wildcat =
LP RAID */
> -       { PCI_VDEVICE(INTEL, 0x9c87), board_ahci_low_power }, /* Wildcat =
LP RAID */
> -       { PCI_VDEVICE(INTEL, 0x9c8f), board_ahci_low_power }, /* Wildcat =
LP RAID */
> +       { PCI_VDEVICE(INTEL, 0x9c83), board_ahci }, /* Wildcat LP AHCI */
> +       { PCI_VDEVICE(INTEL, 0x9c85), board_ahci }, /* Wildcat LP RAID */
> +       { PCI_VDEVICE(INTEL, 0x9c87), board_ahci }, /* Wildcat LP RAID */
> +       { PCI_VDEVICE(INTEL, 0x9c8f), board_ahci }, /* Wildcat LP RAID */
>         { PCI_VDEVICE(INTEL, 0x8c82), board_ahci }, /* 9 Series AHCI */
> -       { PCI_VDEVICE(INTEL, 0x8c83), board_ahci_low_power }, /* 9 Series=
 M AHCI */
> +       { PCI_VDEVICE(INTEL, 0x8c83), board_ahci }, /* 9 Series M AHCI */
>         { PCI_VDEVICE(INTEL, 0x8c84), board_ahci }, /* 9 Series RAID */
> -       { PCI_VDEVICE(INTEL, 0x8c85), board_ahci_low_power }, /* 9 Series=
 M RAID */
> +       { PCI_VDEVICE(INTEL, 0x8c85), board_ahci }, /* 9 Series M RAID */
>         { PCI_VDEVICE(INTEL, 0x8c86), board_ahci }, /* 9 Series RAID */
> -       { PCI_VDEVICE(INTEL, 0x8c87), board_ahci_low_power }, /* 9 Series=
 M RAID */
> +       { PCI_VDEVICE(INTEL, 0x8c87), board_ahci }, /* 9 Series M RAID */
>         { PCI_VDEVICE(INTEL, 0x8c8e), board_ahci }, /* 9 Series RAID */
> -       { PCI_VDEVICE(INTEL, 0x8c8f), board_ahci_low_power }, /* 9 Series=
 M RAID */
> -       { PCI_VDEVICE(INTEL, 0x9d03), board_ahci_low_power }, /* Sunrise =
LP AHCI */
> -       { PCI_VDEVICE(INTEL, 0x9d05), board_ahci_low_power }, /* Sunrise =
LP RAID */
> -       { PCI_VDEVICE(INTEL, 0x9d07), board_ahci_low_power }, /* Sunrise =
LP RAID */
> +       { PCI_VDEVICE(INTEL, 0x8c8f), board_ahci }, /* 9 Series M RAID */
> +       { PCI_VDEVICE(INTEL, 0x9d03), board_ahci }, /* Sunrise LP AHCI */
> +       { PCI_VDEVICE(INTEL, 0x9d05), board_ahci }, /* Sunrise LP RAID */
> +       { PCI_VDEVICE(INTEL, 0x9d07), board_ahci }, /* Sunrise LP RAID */
>         { PCI_VDEVICE(INTEL, 0xa102), board_ahci }, /* Sunrise Point-H AH=
CI */
> -       { PCI_VDEVICE(INTEL, 0xa103), board_ahci_low_power }, /* Sunrise =
M AHCI */
> +       { PCI_VDEVICE(INTEL, 0xa103), board_ahci }, /* Sunrise M AHCI */
>         { PCI_VDEVICE(INTEL, 0xa105), board_ahci }, /* Sunrise Point-H RA=
ID */
>         { PCI_VDEVICE(INTEL, 0xa106), board_ahci }, /* Sunrise Point-H RA=
ID */
> -       { PCI_VDEVICE(INTEL, 0xa107), board_ahci_low_power }, /* Sunrise =
M RAID */
> +       { PCI_VDEVICE(INTEL, 0xa107), board_ahci }, /* Sunrise M RAID */
>         { PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RA=
ID */
>         { PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
>         { PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
> @@ -422,16 +414,16 @@ static const struct pci_device_id ahci_pci_tbl[] =
=3D {
>         { PCI_VDEVICE(INTEL, 0xa356), board_ahci }, /* Cannon Lake PCH-H =
RAID */
>         { PCI_VDEVICE(INTEL, 0x06d7), board_ahci }, /* Comet Lake-H RAID =
*/
>         { PCI_VDEVICE(INTEL, 0xa386), board_ahci }, /* Comet Lake PCH-V R=
AID */
> -       { PCI_VDEVICE(INTEL, 0x0f22), board_ahci_low_power }, /* Bay Trai=
l AHCI */
> -       { PCI_VDEVICE(INTEL, 0x0f23), board_ahci_low_power }, /* Bay Trai=
l AHCI */
> -       { PCI_VDEVICE(INTEL, 0x22a3), board_ahci_low_power }, /* Cherry T=
r. AHCI */
> -       { PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_low_power }, /* ApolloLa=
ke AHCI */
> -       { PCI_VDEVICE(INTEL, 0x34d3), board_ahci_low_power }, /* Ice Lake=
 LP AHCI */
> -       { PCI_VDEVICE(INTEL, 0x02d3), board_ahci_low_power }, /* Comet La=
ke PCH-U AHCI */
> -       { PCI_VDEVICE(INTEL, 0x02d7), board_ahci_low_power }, /* Comet La=
ke PCH RAID */
> +       { PCI_VDEVICE(INTEL, 0x0f22), board_ahci }, /* Bay Trail AHCI */
> +       { PCI_VDEVICE(INTEL, 0x0f23), board_ahci }, /* Bay Trail AHCI */
> +       { PCI_VDEVICE(INTEL, 0x22a3), board_ahci }, /* Cherry Tr. AHCI */
> +       { PCI_VDEVICE(INTEL, 0x5ae3), board_ahci }, /* ApolloLake AHCI */
> +       { PCI_VDEVICE(INTEL, 0x34d3), board_ahci }, /* Ice Lake LP AHCI *=
/
> +       { PCI_VDEVICE(INTEL, 0x02d3), board_ahci }, /* Comet Lake PCH-U A=
HCI */
> +       { PCI_VDEVICE(INTEL, 0x02d7), board_ahci }, /* Comet Lake PCH RAI=
D */
>         /* Elkhart Lake IDs 0x4b60 & 0x4b62 https://sata-io.org/product/8=
803 not tested yet */
> -       { PCI_VDEVICE(INTEL, 0x4b63), board_ahci_low_power }, /* Elkhart =
Lake AHCI */
> -       { PCI_VDEVICE(INTEL, 0x7ae2), board_ahci_low_power }, /* Alder La=
ke-P AHCI */
> +       { PCI_VDEVICE(INTEL, 0x4b63), board_ahci }, /* Elkhart Lake AHCI =
*/
> +       { PCI_VDEVICE(INTEL, 0x7ae2), board_ahci }, /* Alder Lake-P AHCI =
*/
>
>         /* JMicron 360/1/3/5/6, match class to avoid IDE function */
>         { PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> @@ -459,7 +451,7 @@ static const struct pci_device_id ahci_pci_tbl[] =3D =
{
>         { PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
>         { PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AM=
D Hudson-2 (AHCI mode) */
>         { PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
> -       { PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power }, /* AMD Green =
Sardine */
> +       { PCI_VDEVICE(AMD, 0x7901), board_ahci }, /* AMD Green Sardine */
>         /* AMD is using RAID class only for ahci controllers */
>         { PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>           PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
> @@ -1660,11 +1652,6 @@ static void ahci_update_initial_lpm_policy(struct =
ata_port *ap)
>         struct ahci_host_priv *hpriv =3D ap->host->private_data;
>         int policy =3D CONFIG_SATA_MOBILE_LPM_POLICY;
>
> -
> -       /* Ignore processing for chipsets that don't use policy */
> -       if (!(hpriv->flags & AHCI_HFLAG_USE_LPM_POLICY))
> -               return;
> -
>         /*
>          * AHCI contains a known incompatibility between LPM and hot-plug
>          * removal events, see 7.3.1 Hot Plug Removal Detection and Power
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index df8f8a1a3a34..4a0a602c6b16 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -241,13 +241,10 @@ enum {
>         AHCI_HFLAG_YES_ALPM             =3D BIT(23), /* force ALPM cap on=
 */
>         AHCI_HFLAG_NO_WRITE_TO_RO       =3D BIT(24), /* don't write to re=
ad
>                                                       only registers */
> -       AHCI_HFLAG_USE_LPM_POLICY       =3D BIT(25), /* chipset that shou=
ld use
> -                                                     SATA_MOBILE_LPM_POL=
ICY
> -                                                     as default lpm_poli=
cy */
> -       AHCI_HFLAG_SUSPEND_PHYS         =3D BIT(26), /* handle PHYs durin=
g
> +       AHCI_HFLAG_SUSPEND_PHYS         =3D BIT(25), /* handle PHYs durin=
g
>                                                       suspend/resume */
> -       AHCI_HFLAG_NO_SXS               =3D BIT(28), /* SXS not supported=
 */
> -       AHCI_HFLAG_43BIT_ONLY           =3D BIT(29), /* 43bit DMA addr li=
mit */
> +       AHCI_HFLAG_NO_SXS               =3D BIT(26), /* SXS not supported=
 */
> +       AHCI_HFLAG_43BIT_ONLY           =3D BIT(27), /* 43bit DMA addr li=
mit */
>
>         /* ap->flags bits */
>
> --
> 2.43.0
>

Acked-by: Jian-Hong Pan <jhp@endlessos.org>
