Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE6D187578
	for <linux-ide@vger.kernel.org>; Mon, 29 Jul 2024 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278761; cv=none; b=QI+tfd2gcvoU5/22aTc+h1zUOvqHxdx9vZQ/tWa5vf2UQXoTBAEahC+B0nfovhY1d+5GVLejWQllWkXc3UDCQwuiErHLgQ0+xFHqaVsic5eDYYSR7zerKNIWpkAvMOmS/4J5rgT8MbuT6md5/M/3vGwMo2b9IspPsJWXGxBuJ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278761; c=relaxed/simple;
	bh=NvIuLI+4BrZn0RBXooElp9mx8s1z1lRGxGpIC86QsMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fddKCYnWq0/PD3w0yToAgZSfBri0byvDYWvk82CrcZaAc7lz7HlbthRjBjq+SYxCZdb/W3bfQUS3vorhgaglocyjhwHzOMh1aPc0jl+NohpQGAUBwPjb+PwGl59bcFOl5hh3ODs1drE2TUf/B1BhFLD6UuvR2gBF1KHqAZ7Oc6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EQN4VSUg; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQN4VSUg"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2681941eae0so343996fac.0
        for <linux-ide@vger.kernel.org>; Mon, 29 Jul 2024 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722278759; x=1722883559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HKhfdhpiSfpqXTudKSrP8S6QnruaM9VfLtsbPnLaDPs=;
        b=EQN4VSUg28IYtWftZ29EKfnoz/A645+mpxX0l8c2ook3yFz3taIFcVt9s2jv+LhGCt
         CV4TI80Se3ipDmLk4SPRvwhntf7zBQFszeyVLSAG9pgJvePW113MqX3xPzGCH/Qc8goL
         8TJjWGUyPeyGpMnN87ssje9R/dpaXB1w/6X+tPPC7jl+4fWjarenth0LYywYGeSn2boh
         yZYJUO7MeLUOg0WfoW3JafvjTzkTKaxnqTCOz6Tr++viO0sNvJpzq7USfzJxDG2B8Xmt
         hVdWTbjezSFNULLtwB7IZUXPlRsOpezk39vAR3l2ARfWPCR10LOK+RTrkoZcUNpVTDhx
         rgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722278759; x=1722883559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKhfdhpiSfpqXTudKSrP8S6QnruaM9VfLtsbPnLaDPs=;
        b=EwhTCae6dRV42mmk7dOBGgTOl4dnK0+iBifV1dgAJ2VXmH/h/yAVgDr5Qnowvr+YP8
         uZEYTTwvUqHQXgFZXryDQjYQNnhua+stEEK8jJ8mAd2iaeycvZ0hGlb1MeqiHcr67lRl
         nry52bAeutJDLwe9lCnj8Nhh19F5tEcZ/c8BpdNyFA0vcTcA6jo9HQF3OA7xzjMcjNn0
         RxUjw5OVqsl4HBeyGqRxQorlA7oA7zjj0QDZceRgEspo6jF+TEheRpzpZ6ZB4N8TESak
         xXupVEeQgptMsJNkh+ri+MCiYtuxtb9NvfX7FxuS3MKH5FpLQ0DFphSozXUsYWFx/Q7E
         T4GA==
X-Gm-Message-State: AOJu0Yx3N8s7ZqNeG9ZZWRBpsNZaN3cF9XbopOa6xJ6vajkHtZO4sn8t
	aVljfearmji0c5x/WIajkKhpP2agRziTVdsCy5Fb3UD6YZgxRl/uzgAhovPqBnZOxX/BM0kBAY4
	v4Q==
X-Google-Smtp-Source: AGHT+IH/vG1qoH4oqVX3VPVLACa7E5sof52wvT9KTebe6ImTgDprwYNcbO18loWpGF8zDrWDkqDEeA==
X-Received: by 2002:a05:6870:d24c:b0:261:1cd4:cd9b with SMTP id 586e51a60fabf-267d4d1c918mr8147703fac.17.1722278758586;
        Mon, 29 Jul 2024 11:45:58 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f9ec3d0esm7652637a12.70.2024.07.29.11.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:45:57 -0700 (PDT)
Date: Mon, 29 Jul 2024 18:45:54 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 09/11] ata: pata_cs5520: Rephrase file header comment
Message-ID: <ZqfjYh5DeXzH_wl_@google.com>
References: <20240726031954.566882-1-dlemoal@kernel.org>
 <20240726031954.566882-10-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726031954.566882-10-dlemoal@kernel.org>

On Fri, Jul 26, 2024 at 12:19:52PM +0900, Damien Le Moal wrote:
> Remove the use of the term "blacklist". What the comment using that term
> refers to does not seem to exist at all anyway as the driver does not
> have such list but rather only a list of compatible controllers.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor

> ---
>  drivers/ata/pata_cs5520.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
> index 027cf67101ef..3163c8d9cef5 100644
> --- a/drivers/ata/pata_cs5520.c
> +++ b/drivers/ata/pata_cs5520.c
> @@ -8,9 +8,9 @@
>   *	PIO mode and smarter silicon.
>   *
>   *	The practical upshot of this is that we must always tune the
> - *	drive for the right PIO mode. We must also ignore all the blacklists
> - *	and the drive bus mastering DMA information. Also to confuse matters
> - *	further we can do DMA on PIO only drives.
> + *	drive for the right PIO mode and ignore the drive bus mastering DMA
> + *	information. Also to confuse matters further we can do DMA on PIO only
> + *	drives.
>   *
>   *	DMA on the 5510 also requires we disable_hlt() during DMA on early
>   *	revisions.
> -- 
> 2.45.2
> 
> 
