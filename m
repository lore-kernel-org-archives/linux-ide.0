Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7E74420
	for <linux-ide@vger.kernel.org>; Mon, 29 Jul 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278727; cv=none; b=Oix2YZmEbtd+H1smFrqX198ZNuwdM/HyzI5fub2nOOSr6R4kNfBgISnPJRe9+22UkXlNKBo6DyXFcPVDjrpjbM3rZoXW1S9ZdJ7cJmyznGAzJTM/K5wttE27OhD+TKNR4B5y7NerK7nk5ZvlmSmvfVT3GVaMVISQgIz3RdV258g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278727; c=relaxed/simple;
	bh=yEgbRPmw0Tjv3k1Xy3AOdmXF26caAEqAzOO6edtCt9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl5T3mrFB4Uvc4QObhagJOq6VT7VQqpnouFN56lxKT76h9+OQazv4aymeRiK74n9q04YR0+RdiABdX7ZaC0dgYmkurb115VrurnvHRA8c0SdnkBFl6uVlqJJmdYQru4nVwWTErEhb/EV2i7lq2xwC9ZBmwddONuKrfbtoRvcCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QxCHQ3Bd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxCHQ3Bd"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc66fc35f2so21474875ad.0
        for <linux-ide@vger.kernel.org>; Mon, 29 Jul 2024 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722278723; x=1722883523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kOS2pGkP601vWjuep9ZYp3BVnTEH0eox7Tm7M0yDD4Y=;
        b=QxCHQ3BdtZqtFWi6pkV2vm7ioTJhe/S/YfuppIGOA7Qfsi1b0sV8nuK7Mh8YLkDIZa
         9bV6GTUgNEXOr/gNrCQOfguv9TX03kv04Y8GbiroilJl5skv0NQfGypMB94Bkf5nQku6
         xeMWwdE7kl8Vhx8jtCfTnU7r97Yq9thQPzrku1vOGABNPHAeROGuYLRVEEKsRFQngug/
         oLhu47SjdyI+NxjE2jwhkQ+TWgl4B2Xq9ivJ/mslMQk8r/xXaHP7NUqS6IqBceeaKpe8
         gy/+nrWquW/Od9jEJ0OZhYWaGh/jIjPNaMzXvH1umqa/5osWHjhTys7G6otJGiaybXck
         4agQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722278723; x=1722883523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOS2pGkP601vWjuep9ZYp3BVnTEH0eox7Tm7M0yDD4Y=;
        b=tikAcco4nvnXysVR5E1tw7OfW7pmUerP16aijrMmZ5nDVosfqRmskju3zb0mGvZf0S
         6nqUZNw3UW5xaZVLd6V0XUE3nvwivMApDvE2lEXvfyGaEBa4IgSWo1yq6YRxGvY+vd3E
         0eHXkxNPo+sNSvPGIDItPzXamEhZSDbsIYUWqVmOBdkiirxgozDUJzAR5YkgOyYWm/7Q
         85S471Q9l2+Nz+1fjDRmCb7wVW/B/xFIhXateT7afaknA/rvAmoHQ4tgWACluX6ItGH/
         +QaHmfQG8l54oO+LAzXHzgVtfQ/avpU9L0tSkDwVB3Rr2F4foGnCICFNraEj6EtQzQ2H
         iVMw==
X-Gm-Message-State: AOJu0Yxi8gpj/hHmeYzvBJ/n6FdK2KGEh6UCj+HBQt+yialJnZffXANY
	NHB2SmMwl+FBc3Vm1erkVwKJDZAf76TsOV71oLDEgCf6Kk+VOI/yELQFj1F86MtEIPtQba1LHo3
	Eqg==
X-Google-Smtp-Source: AGHT+IH/xRaqF8nRyHzL1UaUfK3pVrWqwKDu4BS9XBfQI8DCVueTCz8xuRtExiNSikPZs+paGxRhWg==
X-Received: by 2002:a17:902:ced0:b0:1f2:fcc0:66f with SMTP id d9443c01a7336-1ff04b1fd1bmr138509965ad.31.1722278722774;
        Mon, 29 Jul 2024 11:45:22 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d15e98sm86713595ad.99.2024.07.29.11.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:45:22 -0700 (PDT)
Date: Mon, 29 Jul 2024 18:45:18 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 08/11] ata: ata_piix: Remove useless comment in
 piix_init_sidpr()
Message-ID: <ZqfjPh8lljpw_biX@google.com>
References: <20240726031954.566882-1-dlemoal@kernel.org>
 <20240726031954.566882-9-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726031954.566882-9-dlemoal@kernel.org>

On Fri, Jul 26, 2024 at 12:19:51PM +0900, Damien Le Moal wrote:
> Remove the comment using the term "blacklist" from piix_init_sidpr().
> That comment is useless given that the function piix_no_sidpr() name is
> clear about what is being checked.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor

> ---
>  drivers/ata/ata_piix.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index ec3c5bd1f813..093b940bc953 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -1446,7 +1446,6 @@ static int piix_init_sidpr(struct ata_host *host)
>  		if (hpriv->map[i] == IDE)
>  			return 0;
>  
> -	/* is it blacklisted? */
>  	if (piix_no_sidpr(host))
>  		return 0;
>  
> -- 
> 2.45.2
> 
> 
