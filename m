Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E186213A3E8;
	Wed, 21 Aug 2024 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724274858; cv=none; b=g/izj0T37rbdQxyVETO0BUY/+N2cYTGGTCLlYkhIdGMOJxdDvmZaOAvGIIk6wqDNA1bwe1pfshpRKM6L+fI44td1WkaogrEcXKIc5pHUK9uq0RHpIEAqUW76TgzELV2+QnDA72egkKgTJ4bkPWGP7ajDZ8g2hpjFRVffZ+webvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724274858; c=relaxed/simple;
	bh=9wLXvgVnBYA3Mp0u0f4UphPj9kKKVg7PojsAsngy374=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=otLNQ62dY4I/rImE3oZWwTKtGlSkhymn+mjHXJSpCiv7Swfr1NnGOiR0AL0rSH5T2VmI8cwZ2dFCYUFGUHgxrTsbUW1Lqsn3CJd0zFq0SSf2xo/L0c02BxR3JAhIGGWP561kqPGd8xhhggRDrRXk8baJStCQevPO18eZzTlYqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPBYXzu+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPBYXzu+"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-533488ffaf7so203778e87.0;
        Wed, 21 Aug 2024 14:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724274855; x=1724879655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QooDqJRC0GZshqLk0M/j0h7f/ulZAlj1gu5iEd0f5RI=;
        b=OPBYXzu+23+PtgsXiX4+os9BTxzZCFkKcBaHch1EAwKYrrOoOY3MKFXnnhVF9oQxoX
         P7DhFARAITrIEQOgoE0HV8qH5pby9CxsKCQGZXMuKrcRXks2s620ObFNZJ8q+lzs1cPZ
         zOkACTxt5Wz1hOppopP/gJf9YOYtUkAQlIEY2oP1CjnvRElCCsVubTKozE9Rq6f1qQCs
         DNw8SIBDot4GltdmB2u834/Q/wk3U/Uth5TWIS3awrO2Z4Y2gqVof1rdddUlPHXT5TGV
         gBUcI1Mer7QMB2l7V4olm74nKHbP0ZXj8Ip0EkM724CP9u2XRu5IovG/ERh8IKqq/d8r
         ilNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724274855; x=1724879655;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QooDqJRC0GZshqLk0M/j0h7f/ulZAlj1gu5iEd0f5RI=;
        b=W+noxzUqglIWi0PlZSpRRvU0Fsa9TMAFZvHeb5HNivmMxXTfSve9ei3A8wvDIcMvqJ
         yvg1h1HyQ0BQd+N/4b37gH9F+BX4AHww6Jwd9id+XdzG50+qSB1+xZSxXbIY7itgn5rJ
         UGYwOx7NTgtJFPUm4OTh+1BYzBkpPIymya2uAYMN2snGmB0Ipkl4xgpynVAu6ZHixG0e
         Yvju2obFxsdrOQp/vP4ZVfFCcwW1lbEEFE8aySpTZCrTg7o22R+yq4Q/sDLex7aS2B9k
         lYtJNIkyScSWWH7u6PEcAcUwW54SZyOGkmGDxwQ0sS8KOqlml9LypSC536aepgk6CcuP
         6U5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsvJGbufIy46nryVdsA3BWvUjQQiz8zafkWH7Uc3kLYsAwyHzvXoNoI6oQ86PeUSVe+LB7lIdYtU8=@vger.kernel.org, AJvYcCVu14nlhs8JKTdAXWDXt0Tr8DBmD9EmmVnu990mv2pxpTZjg/ERkDh+pQodF+q5ejMj8DYbQ0nwyokbbI5g@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo9pyk4Na9jkTdZdB22eZV3NnNARZDVdHFCNgsGc0WibLFKZy0
	10AX59Z0nY2FzoU37hexXhXD4/HwjwEJ9K51GkrfVJBUDCC2rT0+X/Ow8g==
X-Google-Smtp-Source: AGHT+IH9hjfvv1bggZJwWg4QtFtjrRkHo+ftqZCKHTUhTarOgJz3RokmUaFChJ/IHjPxYMzkP4zsuw==
X-Received: by 2002:a05:6512:1088:b0:52c:842b:c276 with SMTP id 2adb3069b0e04-533485fc7ebmr2423183e87.53.1724274854587;
        Wed, 21 Aug 2024 14:14:14 -0700 (PDT)
Received: from [192.168.1.105] ([31.173.81.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea88f27sm8048e87.256.2024.08.21.14.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 14:14:14 -0700 (PDT)
Subject: Re: [PATCH v2] ata: pata_macio: Use WARN instead of BUG
To: Michael Ellerman <mpe@ellerman.id.au>, cassel@kernel.org
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, hch@lst.de,
 linux-ppc@kolla.no, vidra@ufal.mff.cuni.cz
References: <20240820030407.627785-1-mpe@ellerman.id.au>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <6b2208d1-c18f-14d5-e6d0-acd5c82b4db1@gmail.com>
Date: Thu, 22 Aug 2024 00:13:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240820030407.627785-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 8/20/24 6:04 AM, Michael Ellerman wrote:

> The overflow/underflow conditions in pata_macio_qc_prep() should never
> happen. But if they do there's no need to kill the system entirely, a
> WARN and failing the IO request should be sufficient and might allow the
> system to keep running.

   WARN*() can kill your system with panic_on_warn -- Android is particularly
fond of this kernel parameter but I guess it's not your case... :-)
   Greg KH usually advices against using these macros. :-)

> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[...]

   Please do CC me on the PATA driver patches! This one circumvented my review
(again)... :-/

MBR, Sergey
