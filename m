Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7652E639
	for <linux-ide@vger.kernel.org>; Wed, 24 Jul 2024 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721842452; cv=none; b=I3OtJgsEChzurdfzoRxta2w12Iso85FKScp6mrENpTCbV1nqm3H5+WLveWrCgUoGgfxIy+1wpobzY2MHGFb/m04GqKIxc5JAjKncx0n3fi4a3HS8d1Yf/10UzijpazbzF7TSZg+xfAjYihD7+p5/mVCl2dPt9rkPHd0sjozgEvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721842452; c=relaxed/simple;
	bh=csqwKQujQFMvQp6C4wdiXdfaVpdnIa3FYpvZo24HobE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzByXnzcRI6kgnpoQVOO8CPtcFqS+S0EVAyrwv8li5/LwiBpflDMQ921WRM69LNn6OM3m0B36EhVavfHHNTfOAPjnZjibI3U2kl7d5v+5jhNig+T6gJgl4RkPrg7Rui68PRJSSfTcuj85uA4JdET7uIiqTGnBVuuXG2xcbnRq44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sZ93l8mp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sZ93l8mp"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd9e70b592so102815ad.3
        for <linux-ide@vger.kernel.org>; Wed, 24 Jul 2024 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721842450; x=1722447250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdQUEy2nOmnffhzoPdCEQa/EOxcY6lXelfPIqHLcsFo=;
        b=sZ93l8mpAp02bh9N2IS+ZZU8D+bREZz0MS4hEfDuSi0Bs80XJQtXj7iqxJ7dcSPKCl
         eT13LBUL3kt+sAyqLEA01dMwKA2SXztI7GcCgCuMuSfjCCYFfEYsK0InKuPK4Lh0dlvM
         3W0FMI8tE+551AzM8gSIBkMJMnM95qIssT4BGsbJDV5uSmPd1W8Xzfffox9zwQxnH74H
         7PADlOW6PpscRL/D99izGSOg37P8YIzH3AKc1RM/qqh3fN9lwIJzadOp0CfK0U3p7nc1
         auP3JtY8KZw6+6immQKIZPoHZp84FznHsxn8fDpRObRkY6mRRZfWMHM7Rk1FMxcYInK5
         FlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721842450; x=1722447250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdQUEy2nOmnffhzoPdCEQa/EOxcY6lXelfPIqHLcsFo=;
        b=BFXJD8ys114hqN9y0a3o/O3wsFWB5TuvBtpRRzq6+lDG+cF1b/xHr39YGkHfgX7Dr9
         Boh76CGc9I2le3KKQ+0xHGwG4mXzzPEl1q6mfMJ880V7GLqleyVp8yIOESPICJYnigy4
         3E5IcXEzp09059xS40bkgz4M/DyyWziai0+K2/yT4xj1mwP0+xrQUIM7PYyu4Y+/+7Dv
         czjg6LixC20O+Lu47ZOxYrrnlCJAjol+BRg1II+dq+ouvaFgfb3ejEwvzt4Q7ivKl3iy
         UHG+h2sJ4jwb0o6tQSthJ2XpG+DmMhXteeVrQzZH+oL63LIo9h4Yh5QxlD0Y375EPkwq
         2y6g==
X-Gm-Message-State: AOJu0YznEMea6xDZ76+QJu1mKw3wS6OIyp7WuA7Mhqa2YrVcJfBbfTgl
	IwPrZnjFjmYP3KUp1D+/Gw3AhYW7ouBY3ESAthasgKIsujlLCZsevtVhzWLo9g==
X-Google-Smtp-Source: AGHT+IEkT9WCDBwprJLl+y2BPMvXUMq0Q4VTxoq3600637Lr8wFBogGgePJH42Q1tjxA9P0SuwE1Ow==
X-Received: by 2002:a17:903:1c8:b0:1fb:93e6:94a3 with SMTP id d9443c01a7336-1fed385ffb0mr3419975ad.18.1721842449699;
        Wed, 24 Jul 2024 10:34:09 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f44f0d4sm96902455ad.219.2024.07.24.10.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:34:09 -0700 (PDT)
Date: Wed, 24 Jul 2024 17:34:05 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v5 3/4] ata: libata: Change ata_dev_knobble() to return a
 bool
Message-ID: <ZqE7DQo_N72whTj-@google.com>
References: <20240724054539.182655-1-dlemoal@kernel.org>
 <20240724054539.182655-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724054539.182655-4-dlemoal@kernel.org>

On Wed, Jul 24, 2024 at 02:45:38PM +0900, Damien Le Moal wrote:
> Change the function ata_dev_knobble() to return a boolean instead of a
> u8.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor
> ---
>  drivers/ata/libata-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 272770f09609..4ef1d14aba1e 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2219,12 +2219,12 @@ static int ata_do_link_spd_horkage(struct ata_device *dev)
>  	return 0;
>  }
>  
> -static inline u8 ata_dev_knobble(struct ata_device *dev)
> +static inline bool ata_dev_knobble(struct ata_device *dev)
>  {
>  	struct ata_port *ap = dev->link->ap;
>  
>  	if (ata_dev_horkage(dev) & ATA_HORKAGE_BRIDGE_OK)
> -		return 0;
> +		return false;
>  
>  	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
>  }
> -- 
> 2.45.2
> 
> 
