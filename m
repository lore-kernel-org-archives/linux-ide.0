Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C03EF0A8
	for <linux-ide@vger.kernel.org>; Tue, 20 Jan 2026 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916959; cv=none; b=hM5IpM7brthum1fc9teRdy/xCp5Y1UdUc8YGEa258wtfGWguLCxvgmw6oL9rTSy8LTZN34JsbjsByRkLysy9C9UX2vrcJYCsUlonwl3T6WJitOv0SO/AkU8HlwJQ2nH/p3Z4/FGEZM2UBDeo87WIb1Bcz55c7GB9KskkxBwYvNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916959; c=relaxed/simple;
	bh=UH+jRfid1F5e4ChTidFxmAirU5hqFtsl7SNWOKiPrUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9V72UR1HhryCVVCpnhwkWBeqJfxkUlU0Ok2VOa+JhECIxQswqnv9LLTUwOMlBSKt7l91Hbisl7ROSR6McNNFOovRAU4pH7fLK3Fb9MxgvXDygOasmCfsuVJWV17R5EAJkyfs98AjX9w5lXx+Pj6W8z2x26u87fzHT8/6w/2oLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amJBmQef; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amJBmQef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31DDC16AAE;
	Tue, 20 Jan 2026 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768916958;
	bh=UH+jRfid1F5e4ChTidFxmAirU5hqFtsl7SNWOKiPrUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amJBmQef2fTVh4HnEYcfboW8ubGX03nnwyObXGFRz9IiC1WazHaY8H/jsZtVfVbT1
	 AF9l2WkA+jSXOZYYjXp+CLkh2VUkXoR1KvBRL+wHdG8T8zxSfgLvJQpN622FN4lGCu
	 FlSMom+cLEoLalVnhEWwQsaTtJoBAx/AASY3mqcyft8uk7CvarywfqxbbmggB942Py
	 SZ9X/E44fFkR3mqs7Cik5yLAAoadwNe3OpR/AIZVKQ9o9fUY2D+XgZ2RAAESQLWMWg
	 8RpylSBP3sPvTcSYsCU1YvuVKD8zZxTkx9TUFZF8r5QbMVZpwOfmW1lQh519E7uD7y
	 EPRhn+BWFX2KA==
Date: Tue, 20 Jan 2026 14:49:14 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Wolf <snow.wolf.29@proton.me>, Damien Le Moal <dlemoal@kernel.org>
Cc: "1120831@bugs.debian.org" <1120831@bugs.debian.org>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Quirk INTEL SSDSC2KG480G8 max_sectors
Message-ID: <aW-H2uEwgjKoU7ma@ryzen>
References: <20260120103237.3922391-2-cassel@kernel.org>
 <kH1HPlwkQ_5AcoiqCiLZ7VgrxVC0bJBfB_Bo_1hlMfUwn6ebZHhEtBTAmkzMPBkp50zHeUqMGGzRKmAWp4XheOQjQNRNPPn5JajTY5TZnRk=@proton.me>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kH1HPlwkQ_5AcoiqCiLZ7VgrxVC0bJBfB_Bo_1hlMfUwn6ebZHhEtBTAmkzMPBkp50zHeUqMGGzRKmAWp4XheOQjQNRNPPn5JajTY5TZnRk=@proton.me>

Hello Wolf,

On Tue, Jan 20, 2026 at 01:29:27PM +0000, Wolf wrote:
> > Hello Wolf,
> >
> > please test this patch and see if it works.
> >
> > The patch is based on the for-next branch of:
> > git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git
> >
> > drivers/ata/libata-core.c | 3 +++
> > 1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index e888f2445692..8e41e8a33096 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -4082,6 +4082,7 @@ static const struct ata_dev_quirk_value __ata_dev_max_sec_quirks[] = {
> > { "LITEON CX1-JB*-HP", NULL, 1024 },
> > { "LITEON EP1-", NULL, 1024 },
> > { "DELLBOSS VD", "MV.R00-0", 8191 },
> > + { "INTEL SSDSC2KG480G8", "XCV10120", 8191 },
> > { },
> > };
> >
> > @@ -4336,6 +4337,8 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
> >
> > { "Micron", NULL, ATA_QUIRK_ZERO_AFTER_TRIM },
> > { "Crucial*", NULL, ATA_QUIRK_ZERO_AFTER_TRIM },
> > + { "INTEL SSDSC2KG480G8", "XCV10120", ATA_QUIRK_ZERO_AFTER_TRIM |
> > + ATA_QUIRK_MAX_SEC },
> > { "INTELSSD", NULL, ATA_QUIRK_ZERO_AFTER_TRIM },
> > { "SSDINTEL", NULL, ATA_QUIRK_ZERO_AFTER_TRIM },
> > { "SamsungSSD", NULL, ATA_QUIRK_ZERO_AFTER_TRIM },
> > --
> > 2.52.0
> 
> Hello Niklas,
> 
> The patched linux/6.19.0~rc1 is working.

Thank you for testing!

Hopefully Damien can queue it up.

I suggest queueing it up for for-next,
since it depends on some patches there.


Kind regards,
Niklas
