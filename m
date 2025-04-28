Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5CA1E0E01;
	Mon, 28 Apr 2025 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826060; cv=none; b=NYw4Iujto3ad0ow6BUWHcDTL3XwQHZu4IcJEsORc3g+jDkJMaka/iPtSFFFFEUojOgTQOoBfPKoR92uPgtC9+VZYVXivuFashEzauhRHYRjgE8KC8CFj6Eq0x/jltX7op2x2IRGk/OitmEPbz28j4J2NdvJmVIfN4O7x/0kBowA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826060; c=relaxed/simple;
	bh=LzVpdwJcKpZdkOV8B9Y+2Li11cLZ5tEAp6VjWD6e1Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFfWoPaULRrsDWkJAGRsztWuAb3PUviQB1SHEHf4/Iu2Ndq+xDXX7YMITB8pahs8/xdQeYLte89aEcip7k501DdX06XJHVslL/EWYt3CAvnfdR1EedbZs+eXQ8y3/OtKQbm09PwYdxlFUBbt8DYagJon5901QYVhPe5hXRtZJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpdewwJr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpdewwJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B6FC4CEEC;
	Mon, 28 Apr 2025 07:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745826059;
	bh=LzVpdwJcKpZdkOV8B9Y+2Li11cLZ5tEAp6VjWD6e1Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kpdewwJrSOiAzPz9K0N+/4/6Y6od6z2URw95Qp0HDsFkxmqkLntlEwLe7kL/3xiKk
	 RGK/9Kihq3tagpW6o2IyqP/zVv72NyEXRn7QP3Y03lZ7ivf+OQoVzqBBN711H5gged
	 8ipC8aJCzz7ErZPjGfCOkVZJfnzLl3eW3T+9HUyQMFVkTm+fq9f4mVSp2l+rhT2uCS
	 GCel+wHHmP6kL1m5gZqPWXzJHKPb9BDF9Bun5rvqN55ffH9EAnjS70FTX5dtr7eSOr
	 kzyYNUyE8EPCeuesS3lE1g+ivtgHVF4Ub7jNo1Y2KYr9ZkRBDHCHrbVXBbhVNY9TYK
	 F8Ke9oBbl6U0Q==
Date: Mon, 28 Apr 2025 09:40:56 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0
 hard drives
Message-ID: <aA8xCLulpVz6V8T0@ryzen>
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

Hello Mikko,

I tried to apply this commit, but it fails with:

Applying: ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
Patch failed at 0001 ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
error: corrupt patch at line 10


Please use:
$ git format-patch -1
You should then get a foo.patch.

You should then be able to do (locally):
$ git checkout HEAD~
$ git am foo.patch

to verify that the commit can be applied.


Kind regards,
Niklas
