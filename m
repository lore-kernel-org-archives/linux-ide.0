Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1FA49659
	for <linux-ide@vger.kernel.org>; Thu,  5 Jun 2025 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749125901; cv=none; b=ceZkytcum3vsuT1gPDt0QG/B8V4UzVv5PdUEozPOLPXNId6kj2wS5zWOAd+qJr6I7LBUJc39cQyvHvK4rjzcjAhcFIcOlsbPK+w3eGLaKUQWmObZg7jjPFHND+EVyEFbI8PHU3c+ptBEFGXveVdVVxGfKcEBBwswHwLaFjTEWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749125901; c=relaxed/simple;
	bh=RfAx4jXY+1kr2n9Gf7neHxXtNMaU/PIuvGvf94aKHrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uh6tf5XKpkTyyTWPGUTdFZUH7dIKobaZ4VcQGgdQk0i1+pyt21efmPei08ORw4F4B2rztuYzOUf85eWNYu36DENSt0NQsItrkCkJ1i5KWcgXe92vJeJMSJ0qnSQAlysLm2b3CR7MlAyWf/T/wcx349rsOVRWa2cQdfW0pVZmRfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baYMmkaP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baYMmkaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6C8C4CEE7;
	Thu,  5 Jun 2025 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749125900;
	bh=RfAx4jXY+1kr2n9Gf7neHxXtNMaU/PIuvGvf94aKHrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=baYMmkaPJRXtepfAyx4+YzfjuS1SX20KAK3Mq073Xpxzj6cHxcWK1KVgvnkinFAM1
	 xFinAB7AYihbXO9mQq152a+Oz8EI6gl/lQ13PVYOe8bmDuEb1qlQnXg9EVyHPCa/Qb
	 nLapnV8I7SbaNrFMRyGKqJUWDysy+FT/ds2mCLc9JQ71UyEyTs4MLsQ00AkoxcWH49
	 UcfoC0Li68OYlYm+MvOSZD7Q950XLXg9nFKmnRO3B2/LQ+gPCemhwSzLYwHK7Gg69L
	 ym5DjlTnknWfUASPJAVDvn1BmDmrwg4VDxAzVrft12wrEjud8M/xqzamma+bwhwuTP
	 9Jn6flyFB41XA==
Date: Thu, 5 Jun 2025 14:18:16 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0
 hard drives
Message-ID: <aEGLCBnh_PSON3Sx@ryzen>
References: <98E34F63-CCAE-48C4-9584-9053C3D1A7FD@kernel.org>
 <CAAZ0mTdcAazi=133Dz0+OgSGOERe7WmCTr27ePudEVhkJj6VbA@mail.gmail.com>
 <48F49924-F5FE-4A91-8323-E2C789D1BEFB@kernel.org>
 <CAAZ0mTdtOVSidMeC76X9oZyHCtJdgyiu44+UEKqP5tSUaD9ZsQ@mail.gmail.com>
 <aCG-gS2f3uXKaQPj@ryzen>
 <CAAZ0mTfqE+w8BBCyVSg0KKQ6fYZwKaqvh_ND8dLCANg-oMaphA@mail.gmail.com>
 <aCHZg4tj6YwS9vph@ryzen>
 <CAAZ0mTeiVqZQvkWzJ8aFH4FUPCZwy5O+9hPBgDPhSgNNz+t6HA@mail.gmail.com>
 <aCTZkV5mRjDsYyeE@ryzen>
 <CAAZ0mTcge55H4Ow0JG8PE5Wpgtz6TG60uvGxRUXrq-aVH4k9aQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAZ0mTcge55H4Ow0JG8PE5Wpgtz6TG60uvGxRUXrq-aVH4k9aQ@mail.gmail.com>

Hello Mikko,

On Mon, Jun 02, 2025 at 02:17:49PM +0300, Mikko Juhani Korhonen wrote:
> 
> Or shall we just disable dipm on ports 5-6 along lines of:
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 163ac909bd06..65dadac93461 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -52,6 +52,7 @@ enum board_ids {
>        board_ahci_ign_iferr,
>        board_ahci_no_debounce_delay,
>        board_ahci_no_msi,
> +       board_ahci_no_dipm_ports45,
>        /*
>         * board_ahci_pcs_quirk is for legacy Intel platforms.
>         * Modern Intel platforms should use board_ahci instead.
> @@ -152,6 +153,12 @@ static const struct ata_port_info ahci_port_info[] = {
>                .udma_mask      = ATA_UDMA6,
>                .port_ops       = &ahci_ops,
>        },
> +       [board_ahci_no_dipm_ports45] = {
> +               .flags          = AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM_PORTS45,
> +               .pio_mask       = ATA_PIO4,
> +               .udma_mask      = ATA_UDMA6,
> +               .port_ops       = &ahci_ops,
> +       },
>        [board_ahci_no_msi] = {
>                AHCI_HFLAGS     (AHCI_HFLAG_NO_MSI),
>                .flags          = AHCI_FLAG_COMMON,
> @@ -466,6 +473,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>        { PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /*
> AMD Hudson-2 (AHCI mode) */
>        { PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>        { PCI_VDEVICE(AMD, 0x7901), board_ahci }, /* AMD Green Sardine */
> +       { PCI_VDEVICE(AMD, 0x43EB), board_ahci_no_dipm_ports45 }, /*
> 500 Series Chipset */
>        /* AMD is using RAID class only for ahci controllers */
>        { PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>          PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index b990c1ee0b12..de4e058401a5 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -3432,7 +3432,10 @@ static int ata_eh_set_lpm(struct ata_link
> *link, enum ata_lpm_policy policy,
>        struct ata_eh_context *ehc = &link->eh_context;
>        struct ata_device *dev, *link_dev = NULL, *lpm_dev = NULL;
>        enum ata_lpm_policy old_policy = link->lpm_policy;
> -       bool no_dipm = link->ap->flags & ATA_FLAG_NO_DIPM;
> +       bool no_dipm = link->ap->flags & ATA_FLAG_NO_DIPM ||
> +               ( link->ap->flags & ATA_FLAG_NO_DIPM_PORTS45 &&
> +               ( link->ap->port_no == 4 ||
> +               link->ap->port_no == 5 ));
>        unsigned int hints = ATA_LPM_EMPTY | ATA_LPM_HIPM;
>        unsigned int err_mask;
>        int rc;
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index e5695998acb0..467a91362d2d 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -218,6 +218,7 @@ enum {
>                                              * led */
>        ATA_FLAG_NO_DIPM        = (1 << 23), /* host not happy with DIPM */
>        ATA_FLAG_SAS_HOST       = (1 << 24), /* SAS host */
> +       ATA_FLAG_NO_DIPM_PORTS45= (1 << 25), /* host ports 45 not
> happy with DIPM */
> 
>        /* bits 24:31 of ap->flags are reserved for LLD specific flags */
> 
> or for all ports (Damien's patch earlier in this thread) ? I don't know.

Personally, I think that checking for certain port numbers, for a specific
motherboard makes the code very ugly, and will not scale very well if some
other motherboard has a different subset of ports where LPM does not work,
so I would rather avoid a quirk handling port numbers.

It is unfortunate that the BIOS manufacturer has managed to mess this up,
but since this is the first motherboard where I've heard about the problem
of LPM only working on certain ports, even though it is a per controller
thing, just not having good power saving for this motherboard seems fine.

I suggest that we simply add the DMI name of your motherboard to
ahci_broken_lpm().

(Since LPM works on the other ports, it seems wrong to quirk all of this
generation of AMD AHCI. It is most likely a BIOS problem and not a AHCI
controller problem.)


Kind regards,
Niklas
