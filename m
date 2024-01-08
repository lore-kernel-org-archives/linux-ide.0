Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E731170A
	for <linux-ide@vger.kernel.org>; Mon,  8 Jan 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRwrZL58"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cd0f4f306fso16940011fa.0
        for <linux-ide@vger.kernel.org>; Mon, 08 Jan 2024 00:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704704231; x=1705309031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5CXD7c0UGH987jW9OXIXFw1njivBjhL3diRiFSG+u4=;
        b=NRwrZL58rU75bKgy0ZZgVWhO3EKSD0Z+wy+Ee3BXlJk477XaG4EhwQjsY0c9nkzSdg
         nTqlYwbS01wOdkMSSzxe9KW4jvwtjSQccOcPl0rKFetTVaFZboG9v/EfK550Az/ZobEw
         8d9qUSZMoT5hlj6JZ3ctV10sORmxC03CIn+rWl3N7MZoP1od8rsnzKEvmnL29tYQvRWf
         r/s2CsD5hXPAg9ZeNV7Iq2Jg8fo7HLb87GZ40Hx4foMY43VyrvzmynOni2TL4IlHchel
         oLewuJL0lkq5l5a3jO0XDkII0OljLG70SjTTHxrhOM+h5L9nDsUGDrta7Q5GUkDf9oco
         yxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704704231; x=1705309031;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5CXD7c0UGH987jW9OXIXFw1njivBjhL3diRiFSG+u4=;
        b=hSk7Q2IeeqmfTQf7KRnds6jl4qkC+KrY+EiyDMKFoecmts2KTOMWZYzHgpdDEDjYaf
         vzReduG42Zmri/UNgDw6SUBACUzbCBSlPRu3btSg9Q6LHMENaYn/KP1FJlcfhxKvmSsr
         uGx4uvtpRdSqAN1QMasOheAqP3811xlg4Cth6SS3ElcEyh+74FJsxQUZomO4n2fuzcP+
         bkSX6GUZoYEtVA1ET7BfysoObbMq5HGmoQg9IISsGHvXxK2zILJqo25/DgtiEEwIgCJD
         qFpaFZkAOznpvsUtc5lcSmzfJBTtLyd/D326854GYR/yXoQx9MjijhbxP9zqwHQjH/7C
         vm2g==
X-Gm-Message-State: AOJu0YxBJVa3P/SKd5/+MobV/lItLlJFTRoh7g9jAR7D9I4WZGoiCOzZ
	OF+rsmMQJHtyElO+4wXc0sGgMB6+FGg=
X-Google-Smtp-Source: AGHT+IHWtn2/86zIB+ixyLycP5jofvJOCM9L/Xh28g6sNLvxkQC6FxmIkoUdDVyCmiY5dRfiWcdJqw==
X-Received: by 2002:a05:651c:10ae:b0:2cd:463f:6c2f with SMTP id k14-20020a05651c10ae00b002cd463f6c2fmr1049298ljn.72.1704704230670;
        Mon, 08 Jan 2024 00:57:10 -0800 (PST)
Received: from [192.168.1.104] ([31.173.81.242])
        by smtp.gmail.com with ESMTPSA id f8-20020a2e6a08000000b002ccac895a03sm1462968ljc.140.2024.01.08.00.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 00:57:09 -0800 (PST)
Subject: Re: [PATCH 3/4] libata: avoid waking disk for several commands
To: Phillip Susi <phill@thesusis.net>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
 <20240104223940.339290-3-phill@thesusis.net>
 <13374917-5c23-1cb4-8484-479cc7d20e7b@gmail.com>
 <87bk9yyzlt.fsf@vps.thesusis.net>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <fe5f6d90-0546-3b74-8d15-bb0ea1094d69@gmail.com>
Date: Mon, 8 Jan 2024 11:57:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87bk9yyzlt.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 1/6/24 11:29 PM, Phillip Susi wrote:
[...]

>>    How about a *switch* instead?
> 
> So what's the status on switch case fall through these days?  I thought
> you just had to add a /* fallthrough */ comment to make it explicit, but
> gcc is still complaining.

   There's a fallthrough macro in <linux//compiler_attributes.h> now,
I think you're suppoed to use it now...

MBR, Sergey
