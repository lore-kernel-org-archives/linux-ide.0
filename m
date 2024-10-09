Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011C561FEB
	for <linux-ide@vger.kernel.org>; Wed,  9 Oct 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482734; cv=none; b=O8c7i/f0gRjtwoHPxTm9IsJvBoawbXRODEhwvOj4gbVZi0VHripIPEvTUHYbItSsjNBKiAeyCq8zsMhtSaWt8OSZbEWj6+QJNQYIS7f/Y/po8H9tC/3SwCt4b+MOwpngYJ86Y+l+2b62b7g7NU90vljz13PpzVP3txOnDFBxjTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482734; c=relaxed/simple;
	bh=OrI2MRVtvlD9VgmY9LW1VhVvbNmPb7o/M3w9JCg9HPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/l5AsrYOy2JCd+5kM1MYW4B2iNT7JU79LUhj/jTf3SiojrBpDSbu59e7DSKIUFeUkJ/ne1EZcZyVWI6xIQ9gWEb8bIIzAywjO0tmSOnhikwOjUaGVvKBA3q870bpuWJ933YOfB+ulmuOCbknsxCY/QZr1dJT3ivC88awwMqYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zss5bqL9; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zss5bqL9"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82ce1cd202cso293466139f.0
        for <linux-ide@vger.kernel.org>; Wed, 09 Oct 2024 07:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728482731; x=1729087531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yX62R23+j8teX0Raf5b3bGahNrU2VceE4KyunCRlSG0=;
        b=zss5bqL9PfPLUHihECA9jUhtABwJ00upjsLP9rL3mu1UPcscNTQTqQs5dqZdWUFsjb
         qU9fKdYFK4xXmcF2AnzO4zJN3fsL7/F+ZjOgR5cEb37kg9fb8Rh67hDtVXeCe+HtTrXx
         vN5ENxUPiuUNXsOOg0niMqk5HTEHHgovJ1x2sRageeoZB6a3Fl2DnEXYnO4wrz4UVNOZ
         0ZR2xzf+YCCx9VcYWucZ0NR5kXe+1yx8WtKatR7KpMi6eiEG83+629vaXaAcDmS+3f3V
         QVX4LK/vtBLyW18vpHVp8CVpn9TOSH/1JqGaKe53p8eQmZD3V0vbxMbBcDOh4KKNW++t
         05EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728482731; x=1729087531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yX62R23+j8teX0Raf5b3bGahNrU2VceE4KyunCRlSG0=;
        b=AkXgyWachWZ6zfm8Tt05jB2wKVJFF6AgNkffyJUjmJAtiJi1SfPU/06DpOEI21TkxL
         iOPmZzo4jL6rTVk1BySYME0uwZcyXfrp0kROrUI36WoKPeoxbcmwrlEGbQCSZq7GXT1h
         /jAwqdE9dfHCmGK1XeVXVFAZdIY2sk5B8vY9VbON5LXx3A3wNLfQlXKbHWNli1HvvB3u
         MNn7K5PH5mv9N2zhXwB0yP2+ss5kU3go9uyLBC/JgxXgHdhSVdUjCs6SlCSqhwt0B2U3
         D3idbCVurPmHKoMWjL2sUnT6Y9shXiGkIUJ46TnYuX7KcANArdjEPUnxhRdfpvKiKHJo
         KEsA==
X-Gm-Message-State: AOJu0Ywn9LU0BCo8wGOXSBm1trt9nL6JApOA3fy1oj8heSmHNd1ZENc1
	X983hqjESsE76qLq9G/0Kl+HspPGp09a+nmvVH3mPmyBddidXAEMfbgIG9ynaGs=
X-Google-Smtp-Source: AGHT+IEewJs4T1lhdu+G572UeVNVjj2nkq4Kxj80+JmtVHbIF2ZQCf06GNK0wBRcGvmYoDBgtyi18w==
X-Received: by 2002:a05:6602:3c6:b0:82c:e4e1:2e99 with SMTP id ca18e2360f4ac-8353d4f7953mr301839539f.11.1728482731022;
        Wed, 09 Oct 2024 07:05:31 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83503b15397sm220907839f.39.2024.10.09.07.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 07:05:30 -0700 (PDT)
Message-ID: <018e4cca-3aff-46ce-b929-aad1a4fae190@kernel.dk>
Date: Wed, 9 Oct 2024 08:05:29 -0600
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci_platform: Modify MAINTAINERS entry
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20241009081557.377035-1-dlemoal@kernel.org>
 <ZwZKW-KlUZR0UMDd@ryzen>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZwZKW-KlUZR0UMDd@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/24 3:18 AM, Niklas Cassel wrote:
> On Wed, Oct 09, 2024 at 05:15:57PM +0900, Damien Le Moal wrote:
>> Modify the MAINTAINERS entry for the ahci_platform driver (LIBATA SATA
>> AHCI PLATFORM devices support) to remove Jens as maintainer.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  MAINTAINERS | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c27f3190737f..d377e81ab2bc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12961,7 +12961,6 @@ F:	drivers/ata/sata_gemini.h
>>  
>>  LIBATA SATA AHCI PLATFORM devices support
>>  M:	Hans de Goede <hdegoede@redhat.com>
>> -M:	Jens Axboe <axboe@kernel.dk>
>>  L:	linux-ide@vger.kernel.org
>>  S:	Maintained
>>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> 
> This entry, and other "LIBATA XXX" entries still mention
> axboe/linux-block.git as the tree.

Hah indeed, not sure how I missed that. Yep should get updated too.

-- 
Jens Axboe
