Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5B283124
	for <linux-ide@vger.kernel.org>; Tue, 25 Nov 2025 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073634; cv=none; b=nP2Hxp5FJrDt1CHBHc6hooWDX0x4Ja7yo7VMzvAnhVClvxGl1grMrxoXNY/nDczqW4Tznm1yDb2V9tFcefdU2grIYX7ql9qx292IZI7kLHRY5AbE45+1GzN82YBDkZJlUeQLlkjt4uPnjNZW4fLye5UslmMG4qTN8X/pOMpSdGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073634; c=relaxed/simple;
	bh=HQJjq6BBCkOvhlWZGL4z/mv0nDC5QfqFjeqJXS324ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irCXXbXHJWRQU6IiDVSTodeOWtxxodTJiwk3UNadoDXPx0HlLaeOaNJ4aFhigh4LJnJFuxRnsjX2b7/LOQ1wvszHXeGsBYjo9ISdhpfBWR8OdCgn64bA0ynbvQT3/Oh9jjgwavva0gyNMyC9LL0a/lb7uPzHxqz3L3UYzuZPuYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9y1Zdso; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9y1Zdso"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDB7C116B1;
	Tue, 25 Nov 2025 12:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764073634;
	bh=HQJjq6BBCkOvhlWZGL4z/mv0nDC5QfqFjeqJXS324ZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9y1Zdsoe/EOv870CHQIpFqDOimvFONqqkrHkSPQUXJF16Iirhxd6NDWr9AC8nWdL
	 pULK3wEvk0HrdUZZGA2P/UOsxWsldHF0w3JIZ2shHQ4GZNuwQ8IQOGuiUWe6NnHxrc
	 +LDw7Z4+EiL9WpkxqEXIltONHVLckjqh1OfcRozhQZnN5oU2OIU4Wc6nDbMuyQdrmJ
	 lctUFSapL85rwLOFP6A4iX2UhzaStm75CEH6C4aXYUaMg8Xi6pRTeF9XOvXSdJcxh6
	 xf1M6y0Zof5iF+uV94vpg1BhbnsJo7AF8KjC1yZWmArGvafm+/W8im4Dj56l1hSUk5
	 IQ0Uptaq6mbjQ==
Date: Tue, 25 Nov 2025 13:27:11 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Yihang Li <liyihang9@h-partners.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Disable LPM on Silicon Motion
 MD619HXCLDE3TC
Message-ID: <aSWgnwVzGDAqPf0i@ryzen>
References: <20251124163433.3082331-2-cassel@kernel.org>
 <8850d82e-6818-b67f-9acb-cdfe78b7cedd@h-partners.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8850d82e-6818-b67f-9acb-cdfe78b7cedd@h-partners.com>

Hello Yihang Li,

On Tue, Nov 25, 2025 at 07:31:36PM +0800, Yihang Li wrote:
> Hi Niklas,
> 
> On 2025/11/25 0:34, Niklas Cassel wrote:
> > According to a user report, the Silicon Motion MD619HXCLDE3TC SSD has
> > problems with LPM.
> > 
> > Reported-by: Yihang Li <liyihang9@h-partners.com>
> > Closes: https://lore.kernel.org/linux-ide/20251121073502.3388239-1-liyihang9@h-partners.com/
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> > Hello Yihang Li,
> > 
> > Please test this patch.
> 
> I found that the same issue also exists on another model of drive.
> The information is as follows:
> 
> # lsblk -o MODEL /dev/sda
> MODEL
> MD619GXCLDE3TC
> 
> # lsblk -o REV /dev/sda
>    REV
> TCV35D
> 
> At the same time, while testing this patch, I found that the issue was not solved.
> Therefore, I printed out the model_num and model_rev of MD619HXCLDE3TC SSD and discovered that
> the actual model_rev should be "TCVAID" instead of "ID." However, the information obtained using
> the `lsblk -o REV /dev/sdX` command showed "ID," and I am not sure why this is the case.
> 
> In any case, I suggest that the final modification should look like this, and after testing,
> this modification has solved my problem.
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index f48fb63d7e85..b721a8db11c4 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4216,6 +4216,10 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>         /* Apacer models with LPM issues */
>         { "Apacer AS340*",              NULL,   ATA_QUIRK_NOLPM },
> 
> +       /* Silicon Motion models with LPM issues */
> +       { "MD619HXCLDE3TC",             "TCVAID", ATA_QUIRK_NOLPM },
> +       { "MD619GXCLDE3TC",             "TCV35D", ATA_QUIRK_NOLPM },
> +

Ok, really nice that we have a patch that fixes your problem.

However, like I wrote in the comment section:

Before we apply this patch, it would be nice if you could try another SSD,
that supports LPM (HIPM and DIPM) with your AHCI controller:
Huawei Technologies Co., Ltd. HiSilicon AHCI HBA [19e5:a235] (rev 30)

Note: You can see if your drive supports HIPM and DIPM from the
ata_dev_print_features() print to dmesg during boot, e.g.:
ata6.00: Features: Trust Dev-Sleep HIPM DIPM NCQ-sndrcv NCQ-prio

Just so we can verify that it is the MD619HXCLDE3TC SSD that is not
handling LPM correctly, and that it is not the AHCI HBA that is at fault.

E.g. there have been some weird bugs with this AHCI controller before,
see e.g. 234e6d2c18f5 ("ata: ahci: Disable SXS for Hisilicon Kunpeng920").



Do you have any other drive, other than MD619HXCLDE3TC and MD619GXCLDE3TC,
which supports LPM, and you can see that the drive works as intended,
with LPM enabled, so we can be certain that it is not the HBA that has
broken LPM support?


Kind regards,
Niklas
