Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CAC24291B;
	Wed, 12 Mar 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786470; cv=none; b=ue1Tbcpyszy3dFcisROTG63q62zLUHAeSWRR1KQ9a9CHIdEd0IW/AECFcYU6uDkJoKO0vR59oBuP9/LJx4n0rauW+7XXSiSFJP4Y7FreHKqaAR4cmk4B4t/+TJcjDeDV4b5eONdIAIr4KdiTIcMdW8nNBZIcFHGLS1kA9lDATqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786470; c=relaxed/simple;
	bh=wKL4lrVz2M2xc1noHZ5gtGG2/c6lZODViuh1rBhkLL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2rXu+Y0hU3b3BLhcCbf+yjAzPe5trgsCCCsbgwepc3LoE6YW8a94KH7+ZjvqMA9EFjthBbs9NZDXuBbCRmZMwpDokSwByniB85Od8hhQrU/ij2lU3kIUJgG/rPAa5cvAV6UtNQRcOunS6e2DJzj/LpjwXQI7RvnVXMtQpkkepc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF2L8ruE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF2L8ruE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7EBC4CEEC;
	Wed, 12 Mar 2025 13:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741786469;
	bh=wKL4lrVz2M2xc1noHZ5gtGG2/c6lZODViuh1rBhkLL8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hF2L8ruEs9c4d2XnKZeJmFiZq8ElG70EY8n9UixV1RH5JiEzrpqTU4ypvpz/8bS5I
	 qW6yBoZ/ozo3IcftMzoxMV5gWqu+zLvICJ/y24y06XPfRR8ZV6pNwYPDpKli9yLGZC
	 /ipjedvNxIsJgsGtZs+6nT0f9TG13on+3VhoWfj01tT9SZIAtheF8F+UVBo5UuvTrv
	 DXjfhSS+k29XU+dSe6nmY1Y2NNA9MvDpuuxXzm06YGUDFCB0aZPg59gxHilQVBu2yO
	 7GMMcp3IIWFEyLauzM9mqPB/Yylwa3AZlTrAPC9ESs5Qxt4NAi8s5KbzDfCFzdk1i3
	 D6QRR5YKPtMbA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1319331566b.1;
        Wed, 12 Mar 2025 06:34:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuWdiXK14CSjogLggm3IVd4MSBl05gg0bSfwCQq/R7b7YOcKE10B4LxGWNBahh02RbCh4D/cqSv2oF2XG0@vger.kernel.org, AJvYcCWBFQI6ICm638dDrAqFPTCRMHlvuUuh+lyaz9uuWfzMarjXR82ijMnnc/o6QkqJKgIVD0HAvJj8eGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjm2uolhAb08cPSpMVVm4fBdc/PL5fDf49fGUoXxtkJUM+SYhh
	yuDrJY1Zsllw2jguBbveIBgFsM7FB1QLN+NtHKxFY2ICzK38VGq7uGZG2TKsVQ7Sg3Bm+PR1GVM
	NGz3MtvilPfMS3qwwxRvx4jDhHwA=
X-Google-Smtp-Source: AGHT+IFLnlggjCs+EWtfguWP98k65UHhb7EskXJ3vQ7RFuGd7nxnZB5N04Esb9NtRmktVDQqQttFt4XQepF3o7pGgwE=
X-Received: by 2002:a17:906:6a07:b0:ac2:c75d:f30a with SMTP id
 a640c23a62f3a-ac2c75dfff9mr954661766b.37.1741786468418; Wed, 12 Mar 2025
 06:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311030217.4177569-1-chenhuacai@loongson.cn> <Z9AUUvfId9J66zWS@ryzen>
In-Reply-To: <Z9AUUvfId9J66zWS@ryzen>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 12 Mar 2025 21:34:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H53467no-gK5S7R2FODw2SbWe1Lm8LLnssc1CDB=xn+mg@mail.gmail.com>
X-Gm-Features: AQ5f1Jq_X76b-K4W2O-nLrzYdbmbwICKVH3CW5cdM6pdedHYKb7X6YcSE2V-zX0
Message-ID: <CAAhV-H53467no-gK5S7R2FODw2SbWe1Lm8LLnssc1CDB=xn+mg@mail.gmail.com>
Subject: Re: [PATCH V2] ahci: Marvell 88SE9215 controllers prefer DMA for ATAPI
To: Niklas Cassel <cassel@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Damien Le Moal <dlemoal@kernel.org>, 
	linux-ide@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org, 
	Yuli Wang <wangyuli@uniontech.com>, Jie Fan <fanjie@uniontech.com>, 
	Erpeng Xu <xuerpeng@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 6:45=E2=80=AFPM Niklas Cassel <cassel@kernel.org> w=
rote:
>
> Hello Huacai Chen,
>
> On Tue, Mar 11, 2025 at 11:02:17AM +0800, Huacai Chen wrote:
> > We use CD/DVD drives under Marvell 88SE9215 SATA controller on many
> > Loongson-based machines. We found its PIO doesn't work well, and on the
> > opposite its DMA seems work very well. We don't know the detail of the
> > 88SE9215 SATA controller, but we have tested different CD/DVD drives
> > and they all have problems under 88SE9215 (but they all work well under
> > an Intel SATA controller). So we can define a new AHCI board id named
> > board_ahci_atapi_dma, and for this id we set the ATA_FLAG_ATAPI_DMA and
> > ATA_QUIRK_ATAPI_MOD16_DMA flags on the SATA controller to prefer ATAPI
> > DMA.
>
> This patch does not apply.
> It conflicts with:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/comm=
it/?h=3Dfor-6.15&id=3D885251dc35767b1c992f6909532ca366c830814a
>
> Please add Daniel to CC when you respin, so that he might also be able
> to test.
OK.

>
>
> >
> > BTW, return -EOPNOTSUPP instead of 1 if ATAPI DMA is not supported in
> > atapi_check_dma().
>
> Please create a separate patch (e.g patch 1/2) for this with a proper
> commit log. (A proper commit log should always answer the question: Why?)
OK.

>
>
> >
> > Reported-by: Yuli Wang <wangyuli@uniontech.com>
> > Tested-by: Jie Fan <fanjie@uniontech.com>
> > Tested-by: Erpeng Xu <xuerpeng@uniontech.com>
> > Tested-by: Yuli Wang <wangyuli@uniontech.com>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/ata/ahci.c        | 12 ++++++++++++
> >  drivers/ata/libata-core.c |  6 +++++-
> >  include/linux/libata.h    |  1 +
> >  3 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index f813dbdc2346..a64db28549d8 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -49,6 +49,7 @@ enum board_ids {
> >       /* board IDs by feature in alphabetical order */
> >       board_ahci,
> >       board_ahci_43bit_dma,
> > +     board_ahci_atapi_dma,
> >       board_ahci_ign_iferr,
> >       board_ahci_no_debounce_delay,
> >       board_ahci_no_msi,
> > @@ -137,6 +138,12 @@ static const struct ata_port_info ahci_port_info[]=
 =3D {
> >               .udma_mask      =3D ATA_UDMA6,
> >               .port_ops       =3D &ahci_ops,
> >       },
> > +     [board_ahci_atapi_dma] =3D {
> > +             .flags          =3D AHCI_FLAG_COMMON,
> > +             .pio_mask       =3D ATA_PIO4,
> > +             .udma_mask      =3D ATA_UDMA6,
> > +             .port_ops       =3D &ahci_ops,
> > +     },
> >       [board_ahci_ign_iferr] =3D {
> >               AHCI_HFLAGS     (AHCI_HFLAG_IGN_IRQ_IF_ERR),
> >               .flags          =3D AHCI_FLAG_COMMON,
> > @@ -591,6 +598,8 @@ static const struct pci_device_id ahci_pci_tbl[] =
=3D {
> >         .driver_data =3D board_ahci_yes_fbs },
> >       { PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
> >         .driver_data =3D board_ahci_yes_fbs },
> > +     { PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9215),
> > +       .driver_data =3D board_ahci_atapi_dma },
> >       { PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
> >         .driver_data =3D board_ahci_no_debounce_delay },
> >       { PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid =
642L */
> > @@ -1917,6 +1926,9 @@ static int ahci_init_one(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
> >       /* save initial config */
> >       ahci_pci_save_initial_config(pdev, hpriv);
> >
> > +     if (board_id =3D=3D board_ahci_atapi_dma)
> > +             pi.flags |=3D ATA_FLAG_ATAPI_DMA;
> > +
>
> No need for these three lines, just rename your board_ahci_atapi_dma
> board to board_ahci_atapi_dma_quirk_yes_fbs
OK, but I will use a different name such as
board_ahci_yes_fbs_atapi_dma since yes_fbs is the main feature for
marvell controllers.

>
> and in the initialization of ahci_atapi_dma_quirk_yes_fbs, set:
> AHCI_HFLAGS     (AHCI_HFLAG_ATAPI_DMA_QUIRK |
>                  AHCI_HFLAG_YES_FBS),
> .flags          =3D AHCI_FLAG_COMMON,
>
>
> And rename ATA_FLAG_ATAPI_DMA to AHCI_HFLAG_ATAPI_DMA_QUIRK and put it in
> AHCI_HFLAGS instead.
OK.

>
>
>
> >       /* prepare host */
> >       if (hpriv->cap & HOST_CAP_NCQ) {
> >               pi.flags |=3D ATA_FLAG_NCQ;
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index c085dd81ebe7..87a3dbf3ac93 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -3029,6 +3029,10 @@ int ata_dev_configure(struct ata_device *dev)
> >               dev->max_sectors =3D ATA_MAX_SECTORS;
> >       }
> >
> > +     if ((dev->class =3D=3D ATA_DEV_ATAPI) &&
> > +         (ap->flags & ATA_FLAG_ATAPI_DMA))
> > +             dev->quirks |=3D ATA_QUIRK_ATAPI_MOD16_DMA;
> > +
> >       if ((dev->class =3D=3D ATA_DEV_ATAPI) &&
> >           (atapi_command_packet_set(id) =3D=3D TYPE_TAPE)) {
> >               dev->max_sectors =3D ATA_MAX_SECTORS_TAPE;
> > @@ -4544,7 +4548,7 @@ int atapi_check_dma(struct ata_queued_cmd *qc)
> >        */
> >       if (!(qc->dev->quirks & ATA_QUIRK_ATAPI_MOD16_DMA) &&
> >           unlikely(qc->nbytes & 15))
> > -             return 1;
> > +             return -EOPNOTSUPP;
> >
> >       if (ap->ops->check_atapi_dma)
> >               return ap->ops->check_atapi_dma(qc);
> > diff --git a/include/linux/libata.h b/include/linux/libata.h
> > index c1c57f814b98..67d374279a65 100644
> > --- a/include/linux/libata.h
> > +++ b/include/linux/libata.h
> > @@ -194,6 +194,7 @@ enum {
> >                                           /* (doesn't imply presence) *=
/
> >       ATA_FLAG_SATA           =3D (1 << 1),
> >       ATA_FLAG_NO_LPM         =3D (1 << 2), /* host not happy with LPM =
*/
> > +     ATA_FLAG_ATAPI_DMA      =3D (1 << 4), /* ATAPI use DMA */
>
> s/ATAPI use DMA/force ATAPI to use DMA/
OK.

Huacai
>
>
> >       ATA_FLAG_NO_LOG_PAGE    =3D (1 << 5), /* do not issue log page re=
ad */
> >       ATA_FLAG_NO_ATAPI       =3D (1 << 6), /* No ATAPI support */
> >       ATA_FLAG_PIO_DMA        =3D (1 << 7), /* PIO cmds via DMA */
> > --
> > 2.47.1
> >
>
> Kind regards,
> Niklas
