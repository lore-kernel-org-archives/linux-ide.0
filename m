Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50C28061C
	for <linux-ide@vger.kernel.org>; Mon, 29 Jul 2024 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278639; cv=none; b=atr6StcVi7Cpne+u655zYar+YcWo9grHkpd2RBbdbw1GpYbpXSaWX/jPr7FlaJTwr4sOGGF3JbOfqpiOGr+7WnMOAXZ8grQpUEZsluJGezS+fVVuW/nL/w4+aKI0vH/TapOIGhuFuHSxmA8/VJ18qSW4zKg4XfYBraGq6L0I4Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278639; c=relaxed/simple;
	bh=Gg681NGa7BhILrgAUrD1SeOBE7elYqYGob6eDGQeUI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTyBibUGfYFkz1rLSmb5sJLowH0e7yiMtsW8uZwGypBPI7hRPpIQtLC2BOPdjoCjUaZ5rtr8Wl5MioKThhV7uwZfh9IamyNIrzfGgF+BfLJquBdo/KHbS+d6hGf7LL1sTZIhn9f5k9ZP+IwOcYtJd//F6pEpxkjmD4YOwM0FNRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bs1omZr/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bs1omZr/"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc47abc040so20175655ad.0
        for <linux-ide@vger.kernel.org>; Mon, 29 Jul 2024 11:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722278637; x=1722883437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WAq9ClGSunBCHLLMNY5dHVsJeSPAlmx3+c34QXnqqus=;
        b=bs1omZr/FYS9BSIkwkA1wocNVa/FIbKvd+g89Sufqwwm+XSAokUb7lU0XUjoePTwO2
         GOBhfBIolaVlf+a9KXI6ZmwttOYXhOv2++qhKj7C3Q6Vj7I+MtZYLtknJDiT9ud9s67V
         5Yd0nIZ17Gk8H0OoswP5ac+s9WG10KGczMgfb0yjvV0AZKwRsRHUTvGtSgg8ZML/YMOR
         lA2PCBHsf8DJS0PdHUHrX+W4MrNp+ySsqxySGSmJvISd0XiQbgdSKEU8B0LBlaxmOGdz
         7nI2rRgfXj/sx6RDjGSbozXshFEVqIUW4jPlKpXNr6dO80K1yTtii5b8/fBPsW6bLSL7
         2DNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722278637; x=1722883437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAq9ClGSunBCHLLMNY5dHVsJeSPAlmx3+c34QXnqqus=;
        b=o9GmlvlUlz1JUDXbjAZYm3P4qujBjWHqQtaIisi0GvkteYpkcPuIM+a3bMkGxPrSHX
         zoZFz4M+CR380bPhzYRiG/i4Bp/qs7v2A4aB60g3NZkgUFzgidx9IiKPWGqCToxybR9T
         5UVDW1DoYow+jssYU/zZ64XruYU5MkzXQb22A5UbOvoNBa3pCf0RFUAnZGFxAGC4xVmt
         ofSbdsUNwroUO+kGrCZGcBq6S3cgvTCiAN2Qg6c6bdEpF4H4a8y04X8yRovMo8dLB5+2
         AV7b/e0Ko7dkccOjSU1v8yuMXpiO3LRxmEhXSvos0vPvCa3ajbHW0Rw33dVxNRX5h1WN
         M3Yw==
X-Gm-Message-State: AOJu0YzuqAn/VaVdF3atlZ9jOYkxFxmRK/F1r51gusO4XELi5RoJDd6S
	n+bN2bAoqvNnk3NEXRj0hWjGu59PNUkY68KvbGoyHJFDyiVpjfaCuzJnWo4VPA==
X-Google-Smtp-Source: AGHT+IF87cxvxQAYXYUKmbJpdO1Pf9n5SJBeIN0hY3livBO66ZL65y8bO/2xxI3JxnLNJ8XeQ5Hkyg==
X-Received: by 2002:a17:902:f606:b0:1ff:493:8de1 with SMTP id d9443c01a7336-1ff04938ef9mr74548105ad.1.1722278636854;
        Mon, 29 Jul 2024 11:43:56 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7edd8ebsm86073435ad.177.2024.07.29.11.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:43:56 -0700 (PDT)
Date: Mon, 29 Jul 2024 18:43:52 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 06/11] ata: ahci: Rephrase comment to not use the term
 blacklist
Message-ID: <Zqfi6Hl7d33tDaNS@google.com>
References: <20240726031954.566882-1-dlemoal@kernel.org>
 <20240726031954.566882-7-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726031954.566882-7-dlemoal@kernel.org>

On Fri, Jul 26, 2024 at 12:19:49PM +0900, Damien Le Moal wrote:
> Rephrase the comment for the eMachines entry in the sysids array of
> ahci_broken_suspend() to not use the term blacklist.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor

> ---
>  drivers/ata/ahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index a05c17249448..45f63b09828a 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1370,7 +1370,7 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
>  		 * V1.03 is known to be broken.  V3.04 is known to
>  		 * work.  Between, there are V1.06, V2.06 and V3.03
>  		 * that we don't have much idea about.  For now,
> -		 * blacklist anything older than V3.04.
> +		 * assume that anything older than V3.04 is broken.
>  		 *
>  		 * http://bugzilla.kernel.org/show_bug.cgi?id=15104
>  		 */
> -- 
> 2.45.2
> 
> 
