Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA472535FA4
	for <linux-ide@vger.kernel.org>; Tue, 13 Oct 2026 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921404; cv=none; b=W3PNdTFyhlFae6Ab+gPeTrnRrL/zH/ErrPDpmXX4dSA3IXXuw8qppblhXk6BgWnSso6sSRUxpAFe/yem7WwLhmvcIPAPtFk+NN2s6do4TYCOsWTxFU9VzfB3wrQLMpHULLp2iGEJnAJsY5O11udWmDYAvGToN5yQApB2GguH7Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921404; c=relaxed/simple;
	bh=La7OvsttISwgLyCYGqKppL2/Zub/vJXz4k2MUNjup7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYT1P2GfMlNfba4gOh6vbCiaLa/E+ObEDfDNp6ytGWg+Ly7rolEs6/Q04F9oo9vPRntqyDjRjlyMYly7/fdmeUgcarDl6IOgS7wjkXRUX0zrUZbReSJm4Uvh82aoQBTOq/AMJK1mUIqv9bmPjRiwIkiFbu6RYDmm3jbi4vGlct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnOaNLv1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnOaNLv1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0271F000FF;
	Tue, 13 Oct 2026 19:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791921401;
	bh=8vr+Nh2nNWHw79Q6E/lDPFzSkoxZRxRs19GSHaw7BnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bnOaNLv1zFqSSrXimr/IIkdcWNJ6xzx95hLt6F7lt2ityA1RAjNnRacR2K0ZNVBgJ
	 Va2uoYd/2SKYgDt8U2DwGaxeJLXnJokY8L8UCGjCMmOgYyQhIPUWMchc8VMjUC7Tji
	 viQeFjNEzWq81wYvSlauPXLaYIM7Xaz4SanYnfekcDH02aat5q2hVIYnWh5IXVEDir
	 9T2Vyu4Tq/iz8TfSp1EW4tzbz+L4DaK0G6GAWEz3mP2vEscFfOEq0XJCi/k4rUbZFM
	 JwO/kKQ9+1KwU5706ulDul8G3ZVeTSexOvidzoDYfnQO7gNJuuenJIFzGeV3jFKqe8
	 j6sYHEYYey6iQ==
Date: Tue, 13 Oct 2026 21:56:33 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Ioannis Barkas <jnyb.de@gmail.com>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] libata: Fix wrong HPA horkage
Message-ID: <as6GuZaRvJFbxMgK@ryzen>
References: <20261013042146.76467-1-jnyb.de@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013042146.76467-1-jnyb.de@gmail.com>

On Tue, Oct 13, 2026 at 07:21:46AM +0300, Ioannis Barkas wrote:
>  Code wrongly filters disks by their serial numbers

I assume you found this using LLM, so a better commit message is something
like:

    ata: libata-core: Remove BROKEN_HPA quirks that can never match

    The ATA_QUIRK_BROKEN_HPA entries for "WDC WD3200JD-00KLB0" and
    "WDC WD2500JD-00HBB0" use "WD-WCAMR1130137" and "WD-WMAL71490727" as
    model_rev. These look like drive serial numbers. model_rev is matched
    against the firmware revision, which is at most ATA_ID_FW_REV_LEN (8)
    characters long, so these 15 character patterns without wildcards can
    never match. This has been the case since the entries were added in
    commit 16c55b038033 ("libata: implement BROKEN_HPA horkage and apply it
    to affected drives"), which compared the strings using strcmp().

    The firmware revisions of the affected drives are not known. Matching
    on the model only would apply ATA_QUIRK_BROKEN_HPA to drives that have
    never had it, and these entries would then take precedence over the
    "WDC WD3200JD-*" and "WDC WD2500JD-*" entries that match the same
    drives. Remove the two entries instead.

    No functional change.

    Assisted-by: LLM



i.e. I would simply let the patch drop these two entries, such that the
existing wildcard entries are the only ones used.


> 
> Fixes: 16c55b038033 (\libata: implement BROKEN_HPA horkage and apply it to affected drives")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=8888
> Signed-off-by: Ioannis Barkas jnyb.de@gmail.com
> Signed-off-by: Nick Barkas nickbgrk@gmail.com
> ---
>  drivers/ata/libata-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 59e87b987d..b23e1c3e4c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4248,8 +4248,8 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>  
>  	/* devices which puke on READ_NATIVE_MAX */
>  	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_QUIRK_BROKEN_HPA },
> -	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_QUIRK_BROKEN_HPA },
> -	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_QUIRK_BROKEN_HPA },
> +	{ "WDC WD3200JD-00KLB0", "08.05J08", ATA_QUIRK_BROKEN_HPA },
> +	{ "WDC WD2500JD-00HBB0", "08.02D08", ATA_QUIRK_BROKEN_HPA },
>  	{ "MAXTOR 6L080L4",	"A93.0500",	ATA_QUIRK_BROKEN_HPA },
>  
>  	/* this one allows HPA unlocking but fails IOs on the area */
> -- 
> 2.53.0
> 
