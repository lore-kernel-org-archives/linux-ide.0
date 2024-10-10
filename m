Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9437224CF
	for <linux-ide@vger.kernel.org>; Thu, 10 Oct 2024 02:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728526337; cv=none; b=DU154eFIqb2f35bUHsXMpG0HdG+dU2IjBnHXSjoYiZNXxCS4royU4r/B20CuSP9d/1YmQoWV/da2LuON7Tzrqwir0uxxOXo+s2rpfzv6yNWO7wnbfIeP6DgRWD/zgKfQpRO3g9wpBbNGVCvKTMzEHr78TtO0yMRzP/IACMGcCjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728526337; c=relaxed/simple;
	bh=i4Cb8Fb89L3rJxikmoMyPYcAN9HXOhWchek75L8UpdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LK1q+utBaaz3F4FTWCHUFY3vQc4PUccePTi0xm7Tx+gwclCbyRCOrSyUi9Cw5o8AooxNt7mQmoVfidIciw9Z1qekxk5/i8hBReOYnCZ0MvdALD8uQmVTmOknX2yc2efivrc4qRytuOFAiN9dDbJ98uUWDceKuWK5XQ1pfRtozyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VzfZV0WR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VzfZV0WR"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so967026b3a.1
        for <linux-ide@vger.kernel.org>; Wed, 09 Oct 2024 19:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728526334; x=1729131134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6gHNsRM/lRU4Gsv9YYAhW2euNbJUCHkLS9Da0SUpO98=;
        b=VzfZV0WRZtuKGiLRFRim2QnV9Xs4VXjHEododjSxU1MngBwtSkEqcrWoiNmoylRrF2
         u8xx4+aG0TbhR0xbvhsD0fvOMGAkglza/iozedlJZ6lHTP4bMoID5r7yDj5KOAP4jejD
         g1epckW88adP1BIFGdVhya4DD7HqZPCiMmgt3n+fhVdUFXuWv7z4dBkiKqDynAoXdBxz
         F26GLA4EC3+jx0IeZ0t/wyf4S6PY1Su2IKM1AKpC1xYN9aRe3hYFGI0HlFcmq/CrV2Zm
         +fPbMF1LlkepEJME5BtNOi1Gd6LEZfA+Gy06FWZnYFUqtb4C8/4Z+HU3mb8LMF3FzwOY
         VXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728526334; x=1729131134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6gHNsRM/lRU4Gsv9YYAhW2euNbJUCHkLS9Da0SUpO98=;
        b=FiMyuccRm4nlG7RmL6sBHFFoEdff9iaiZIrlS9FpVoCRwzlquGMMRnTWZtErnRyp1O
         YaT8sqzPxbnSWO3dx52LwM+eK46vNjdAio1DexcnwzVClwOqC/1tNOkX8MjYXua2hQJM
         wwN7vfDZ8TDkosvpor6MnR2JeXcoJG7C/+FcEKAvxUnZC0K8bC9VExG5+Y+HTNE++9Nz
         OOd7F2bzU5Ve/rt6Uj/aA7sl5ZN62XoRWaHNytX1YMGKy3wx2n9B4Eu7gWViiwsQ1DI+
         suSTSqgBQc6LXRbNeuyb6HxvVGta+sBBELx1eIjvXzSlFg/s+2gG3cyDMNkFiR30MS6T
         TDAA==
X-Forwarded-Encrypted: i=1; AJvYcCUfvXxcKILj44/zJ9chx0VXbag4FKeqxftCrxKlb4i082TVNnbGOBQ9jDngYOe42rEIld8AHCGWdIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyebRr6QsAWLhtXifX0BQ6QWieahnduZTvoEaNrUNehHCN5M///
	9grQPGYxiOkS3wojxQ8iwPeqPHO3U5YrAo2LfyKO0OffzBnalqseNBILVeLrJoNWhGomoBYwXqw
	5eZE=
X-Google-Smtp-Source: AGHT+IFv0VG36sLamybi1yEmdaOLdJk9J6cZhBOBlHHOvBZp5jbszaeSifOovmevavHvb8nmAd6cMw==
X-Received: by 2002:a05:6a20:bf18:b0:1d8:abf3:58bd with SMTP id adf61e73a8af0-1d8ae0dbebemr2033975637.13.1728526333602;
        Wed, 09 Oct 2024 19:12:13 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9ec1d1sm101399b3a.16.2024.10.09.19.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 19:12:12 -0700 (PDT)
Message-ID: <1cc81d36-e259-4ed9-99ec-22280f12b728@kernel.dk>
Date: Wed, 9 Oct 2024 20:12:11 -0600
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata: Update MAINTAINERS file
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20241010020117.416333-1-dlemoal@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241010020117.416333-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/24 8:01 PM, Damien Le Moal wrote:
> Modify the entry for the ahci_platform driver (LIBATA SATA
> AHCI PLATFORM devices support) in the MAINTAINERS file to remove Jens
> as maintainer. Also remove all references to Jens block tree from the
> various LIBATA driver entries as the tree reference for these is defined
> by the LIBATA SUBSYSTEM entry.

Same as last:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

