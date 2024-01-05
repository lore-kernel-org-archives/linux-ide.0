Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8964735EE4
	for <linux-ide@vger.kernel.org>; Fri,  5 Jan 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNc7m9Nu"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cd17a979bcso22936011fa.0
        for <linux-ide@vger.kernel.org>; Fri, 05 Jan 2024 10:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704479622; x=1705084422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kfp1ncJ757FCexy96EdMwAy7FpcXaIn+uYaVu8Dydc=;
        b=CNc7m9NuIBkBsgp6cDYs2nJ0SdTOAXXqZG8mW4e1GGZOklVYLvGUfbhV0ffI5EaH3x
         coWsgtJIwsRtkKSgPwiVG9Yk6Y7pYAzcm+0htjixSEcCD9BOOfTC/s7daOfNpjqbGP3t
         X416CWcJRHgqDv+Ay5Wej1HBcWsrQjbzpmotnyuH/DmP0F034gys+eTpXDvp6GYrmGCr
         gdsUSVUBxnBZ+n2lLGc66PH9mQYI2X3M5JG+U5aV1rQTpulior8YDFdern9SmD5knx/i
         k+cxHe+OaR/vuNtAA2yv0pZi1jkHqK4/WWCqdSVzeU2y1crB2pGLAXpM9dSImd30u26q
         bZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704479622; x=1705084422;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kfp1ncJ757FCexy96EdMwAy7FpcXaIn+uYaVu8Dydc=;
        b=M85PVMlgktZ3efrPm357SJL3zp7h6XbhuKQvaUyS3VuabjctNuF5S4XYvfaq/wiwTy
         zwwCOGwPUboTbn3NP8uiOl0E03y7N1LaNy8S5MhCRTGpaOx4kYARvOPmQJg2Z0FCfjeZ
         P1GPjRrRfCDgcIFJZSlqVIqxg8wPXwKEfbH2xvNdz1OHrcp/2RqRQTT9iPgHO5qp1WqO
         TJqGOjrPeE0+cmSU+M1jrntJ2CFW0Pn+swXF3MLZu8X4rCF3740XAn7ed0S+Z8gnPNZB
         tzf27wuljfvPnGV9wp29IZ6ifVQBB86il7dUYXPoqii9W8y5LGOjS663DRJbgjXP7ZHS
         psgA==
X-Gm-Message-State: AOJu0Yw/xLFZk4mgR5CKkJtMi7J3jyJyH1ylSqT7PubEDUpYCA7Ojjc0
	gpVs5lt4Jgmp2Aa1jzOem53HusMMLfk=
X-Google-Smtp-Source: AGHT+IFR4CSgPZA/cwVOWjvwEQgWI9gh0tXwtKdow62LhAvvl/eaC3rmQjNJUjczH5INX81YE/qADg==
X-Received: by 2002:a2e:be29:0:b0:2cc:f5fa:28ae with SMTP id z41-20020a2ebe29000000b002ccf5fa28aemr809802ljq.149.1704479621817;
        Fri, 05 Jan 2024 10:33:41 -0800 (PST)
Received: from [192.168.1.104] ([31.173.81.170])
        by smtp.gmail.com with ESMTPSA id f12-20020a05651c03cc00b002cd17747bd5sm404914ljp.10.2024.01.05.10.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 10:33:41 -0800 (PST)
Subject: Re: [PATCH 3/4] libata: avoid waking disk for several commands
To: Phillip Susi <phill@thesusis.net>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
 <20240104223940.339290-3-phill@thesusis.net>
 <13374917-5c23-1cb4-8484-479cc7d20e7b@gmail.com>
 <877cknu4t0.fsf@vps.thesusis.net>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <518e7f55-4a15-6caa-fcba-db6e5a846b6e@gmail.com>
Date: Fri, 5 Jan 2024 21:33:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <877cknu4t0.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 1/5/24 7:24 PM, Phillip Susi wrote:
[...]

>>   This command is "officially" called CHECK POWER MODE... 
> 
> Right.
> 
>>    Know.
>>    Double "to".
> 
> Ooops.
> 
>>    Asleep.
> 
> Why would you capitalize that A?  It isn't a proper noun, nor the first
> word of the sentance.

   It was a start of my (single-word) sentence. I didn't mean you
should capitalize it, it just had a typo. :-)

>>    How about a *switch* instead?
> 
> Ok.

   Should be convertable into one...

MBR, Sergey
