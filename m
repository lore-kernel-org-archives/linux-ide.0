Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B970B1C5D4E;
	Mon, 28 Apr 2025 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826279; cv=none; b=mxUODicblaMdc9h2NhF6LpenD4JHg53y453oVDk0HWk9pFBKqmqmun88J/BKQ1WRwwSGtRzcu5EcoYqqfyjfV9OEcvmHTcwVoVUudAUrJ3TsAkdrQMLfYwwrolhvyDuF8piHzSVLLRm9yikbtbnNNGL8lfhxodTOSVYtXIBg5wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826279; c=relaxed/simple;
	bh=iaOEkR7J0upw1H1sW/Gba6M32XBT6NbbB44yO9AFP40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u26ZWPvbBS+v3SGIxhOsoNKqPASzOrU4HbhKUrrtFXEN0l7joscDhe96Zo84/QoRmzTJHpr/jzvDXPzOJKCOdji8He8Ad6o9fbDWPPRm60HQAUZ3jBsdcvwWg7YsNHixK+j+lG26QOQHV2sNQIFIUDIR5XyT59Nsb56uoIchc5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1rnsjNW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1rnsjNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CB8C4CEEC;
	Mon, 28 Apr 2025 07:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745826279;
	bh=iaOEkR7J0upw1H1sW/Gba6M32XBT6NbbB44yO9AFP40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G1rnsjNWP3ey3w5VHNKSOLAdfXR7x2aGaGIszhDbLvZAVcGD0HalBsWhLNF1Cj27Z
	 au8hCz3MgBvvjqH9zQGHtdC4UPfAbxBLmUc8Y9xzNFLVDEzBXld+IKwhZtpeN8YNxU
	 Y0feWYZaw/LFvdmswcY8jwEgrV7pNbS7tqsQaeSwDBoBMTFy1srphuMDtILZQ5KDzT
	 y7jkBIQb4a0+zrS5P9c7l/RsoTWrqtXnXUBmhnDkKtLsAa+F68lnD9BBznN1SDljBU
	 qtNTZNj6c1PtTV1gFRovCsP95APNsj6VxXb2zWL7tKIVuFt0TviMnYEHZjbYpOJjoz
	 N/EYLtUJ4nMUw==
Date: Mon, 28 Apr 2025 09:44:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0
 hard drives
Message-ID: <aA8x47kjcGAsFrTZ@ryzen>
References: <CAAZ0mTfSFZoL_CS9s1L0JhfaoyMGJ6Up5Z9_YvU-pX05MOZ99w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAZ0mTfSFZoL_CS9s1L0JhfaoyMGJ6Up5Z9_YvU-pX05MOZ99w@mail.gmail.com>

On Fri, Apr 25, 2025 at 10:33:17PM +0300, Mikko Juhani Korhonen wrote:
> Make WDC WD20EFAX-68FB5N0 hard drives work again after regression in
> 6.9.0 when LPM was enabled, so disable it for this model.
> 
> Signed-off-by: Mikko Korhonen <mjkorhon@gmail.com>
> ---
> drivers/ata/libata-core.c | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 773799cfd443..5c2f26945d61 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4239,6 +4239,11 @@ static const struct ata_dev_quirks_entry
> __ata_dev_quirks[] = {
>        { "WDC WD3000JD-*",             NULL,   ATA_QUIRK_WD_BROKEN_LPM },
>        { "WDC WD3200JD-*",             NULL,   ATA_QUIRK_WD_BROKEN_LPM },
> 
> +       /*
> +        * This specific WD SATA-3 model has problems with LPM.
> +        */
> +       { "WDC WD20EFAX-68FB5N0",       NULL,   ATA_QUIRK_NOLPM },
> +
>        /*
>         * This sata dom device goes on a walkabout when the ATA_LOG_DIRECTORY
>         * log page is accessed. Ensure we never ask for this log page with
> 
> base-commit: 14a3cc755825ef7b34c986aa2786ea815023e9c5
> --
> 2.47.2

When submitting a v4,
please add:

Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")

So that Sasha's scripts will see it and backport it to stable kernels.


Kind regards,
Niklas
