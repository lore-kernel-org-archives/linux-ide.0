Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A237C2D12EC;
	Thu, 15 Oct 2026 05:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792042256; cv=none; b=H3b7B+rIWGDAGIs2nv60TfTqD/IejOzK+a5o4gx8cKpPaELigOma4zg6wSxn8q9VnBpLXRaYPXGqZMP2fsT+OvUr2FikGD4cltNKA3f485gc8jA5d9aYqI7WzfgO2OvfvWyjlcEbrfNBXNgay0ZXBUda37qa9H0IxfqWaAsI57I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792042256; c=relaxed/simple;
	bh=beHxk/FWmRgnqu/Pqh1VhxbTw79NLkQRA7aMrCGbNKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSsLMYTFOXRTHHej1sgY9PLPUk5fEDathqW4ZrD/skmMRYEcHtigUisrN11lC+aX3KQT7f/pVgj2cprHrpYv+lHScsXi6F1mo+mruyKDb7XA9gLyouD8/SwbUgrAnSfuIWNozjryFEgHFExNxdvk3NDBhofyTJ0rsKcjpMiMj7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyPCQFkz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyPCQFkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B03C1F000C4;
	Thu, 15 Oct 2026 05:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792042255;
	bh=m7VD029D4EwtxoXtCvvRC3LZVAN7OgQ2+TFLmwGl2aE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iyPCQFkzFK3NfzQpkhGnyQesvlyPf8OsIFVxxpDykTAqxqPMttnZ35zgFC1hDtBqd
	 3zukp4PO/hzr2J1WO6gmAQuMirV54aTz2kvUJJWTqZVHXLDhn8aPexrZ/sH0g5WvfI
	 mKwIVKFuW6UGaJFqRMgx0dMIDWQQgnn2FSx4nA6ObLc7s0yxyVyrdeiZv0WZbjapF9
	 tfwsD2T0etHBYLHrRp97MLl3b/nTsCRuJdRRwyyMz/fjmdZwiU1rW6136Kqd2x+rgA
	 wMoaV49Lohzy52HtSnkBeR8AVD4jY+556iYTx8nKL/lxHN4Q9bb66gRplrEYa9mMvx
	 hiKx1FDM3hK/A==
Message-ID: <9c6bafea-7eef-42c8-b514-bdb0777b9372@kernel.org>
Date: Thu, 15 Oct 2026 07:30:52 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: preserve sata_spd link cache across
 ata_dev_init
To: tongzhiwei <tongzhiwei@cmss.chinamobile.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261010075457.882-1-tongzhiwei@cmss.chinamobile.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261010075457.882-1-tongzhiwei@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/10 9:54, tongzhiwei wrote:
> a hot-unplug goes through
> ata_eh_schedule_probe() -> ata_dev_init() -> sata_spd = 0.
> After commit 69f2c9346313 ("ata: libata: Fix sata_down_spd_limit() when no
> link speed is reported"), when
> the device is unplugged, every probe lowers sata_spd_limit, which breaks
> commit 2dc0b46b5ea3 ("libata: sata_down_spd_limit should return if
> driver has not recorded sstatus speed"). The harm is, when the device
> is plugged back, it is limited to low speed which will never be recovered.
> 
> This patch stops zeroing sata_spd in ata_dev_init (sata_spd was
> introduced in commit 008a78961ec7 ("libata: improve SATA PHY speed down
> logic")).  sata_spd is then written only on a successful reset.  At
> struct ata_port's init time the sata_spd field is zeroed by kzalloc.
> 
> Fixes: 69f2c9346313 ("ata: libata: Fix sata_down_spd_limit() when no link speed is reported")
> Assisted-by: LLM
> Signed-off-by: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
> ---
>  drivers/ata/libata-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index f482c0a6d7e9..2ddad2e6ebd2 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5659,7 +5659,7 @@ void ata_dev_init(struct ata_device *dev)
>  
>  	/* SATA spd limit is bound to the attached device, reset together */
>  	link->sata_spd_limit = link->hw_sata_spd_limit;
> -	link->sata_spd = 0;
> +	/* link->sata_spd caches last negotiated link speed; not zeroed here */

This contradicts the previous comment, so let's make this consistent. E.g.
something like:

	/*
	 * The SATA speed limit is bound to the attached device, so reset it
	 * but keep the last negotiated speed indicated by link->sata_spd.
	 */

to replace the previous comment.

>  
>  	/* High bits of dev->flags are used to record warm plug
>  	 * requests which occur asynchronously.  Synchronize using


-- 
Damien Le Moal
Western Digital Research
