Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C9C3E1D05
	for <linux-ide@vger.kernel.org>; Tue, 31 Mar 2026 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957301; cv=none; b=k6fhePFhDT4WO0ohVMgIrgZ98mIdkuM589QgbUEPGfsC55VFmiIc5OEVbsOOM1KoiL+4N9WYsM4yGRkCElIsAIyW+B12UWvZJygPNElKH5ETqiQg6dQlRLN0dZB9J+iS+9umB4HD3K15pOLvN1d90Am/ULTHry2KtgKiD/oCkOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957301; c=relaxed/simple;
	bh=vwQlzq0mdhTgI/PHzyVMY9HnUHMl1gjyDR7/2W07Omg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TghrAVPPBnwS48SwB5GRhRpcyvrWhz2yHnwL5RYSW8VR9YvvibQMxA9YELO+n+j4PI9/AC3iBzURd9293NgIG7Wu4KSykJyXMsKzB5DPrKU172ifv1RH3aOl5IjzJa2PzU6xu/sm1d4p71VO0Way7CFpINfnv9i1BSYAWBEMfWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOrdK3Kw; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOrdK3Kw"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a2b5366c7dso2585383e87.1
        for <linux-ide@vger.kernel.org>; Tue, 31 Mar 2026 04:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774957298; x=1775562098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qj9gE4kBX6rgK0AvPjemgB0jdHOJa/5lrZ++2CWyy1E=;
        b=nOrdK3KwTOeRdaQhG2HCwOIvedLaoWW78T9J7zhjx8I6GxqLt9te57WuyCbXhLH/Iu
         h1ddw/uLyqCBGnUa7z2qrG2vDM5y+IlBOnVJY0Z7Vg06vP1uKHfxRqxAYijDjdpHITik
         JYojrYN4YRw9gZBSQ8X0IuWsnUJLBGFuTJ+fnByIDkUcBTUo825WLCNEZteJWAjvP9Vc
         GdyH4WOx7mJqlJuoFxO0EdIrNsSPJfxUPmg/iD+4a8vR68I+sMmX6OVOsS6ojrAXwvNi
         C4iKfOotb2ggga7QXPxhnYxaDyMDesNSSViBE1+IYPc1nLim/qpWMXdhoJleO98afzvO
         28Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774957298; x=1775562098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qj9gE4kBX6rgK0AvPjemgB0jdHOJa/5lrZ++2CWyy1E=;
        b=LrrlF19fFHzQr5uCzgVk8nK0UjoBkmk34wvPkPFHIvYBDSAkR0v65Nj4xFFARf6he6
         1920716pG4AoOWXTm6M/haS0bltFx7FAuStCNkKZGc4CTUBoChn+5OAJTyAZ3C032w1M
         H5AYG41Q8SYqHuyJMn6Ge5ninZVL89CxkGD6gyYR3wi64+/FD7kZMEj5rLT49Y17l6h1
         TtMiYsNufuhKK/IrsmGSSHVcO9qAQKtlvx/GeRO+WKaEAgi+KAAhRYYDrm0aoHojxh6c
         pdHD23SViuLaMZU3O5JWI8F4Jl/WGaHj/VHlNr0LqYl7OjHwOxevRmg4MchDNBnxJJ8e
         b3Ow==
X-Gm-Message-State: AOJu0Yxq+akYKLe8alpf9xKGN+ZVKviOP3radOf+bD50mA2KwwpNTm42
	e1Vptp69C4+9Soq2ztBB/CjO8MfEGM1+IDpgXZVMhBikGPM+mEN+IPrM
X-Gm-Gg: ATEYQzzeUR+KNGCymgUpxp9OAjoE90AuyQ+cuN2jhsnMSwl3IHyDIIDoNZxSHge++kh
	HJdTON3N80uybpj6SUZ5IffnLqRPHu4Bz8Ye+RB59MiG51SngwZeIi1c+h0ZTW1ZB/hM4Eqbm9n
	Nlk39QIk1dSGfBcLFEL0j2BztcVKD6eYMXlhUh29MSmOpkpwWkP9sGULOaroR+0Qm7NUWS9WM1W
	oz7mSpGBW3PxiWPHMbBOOSXDU7APP1kLnepMFj1hg/rqLMaYYU0VR8MVqElfbyVSsoZixWKkUw/
	xarxpR+JP6A4eDM+eBUIEcSrBJX0RDMq2qoPJxJAbMJsSnCRBm1cUahnIMdg12enNIuJZ7WjkfQ
	Aa3SMw2V2zL7u+n4TVJowa1x+nRovMexp9bY3ozsQwQ7pzCFDtpPa1dx2q10L4G/wf8iiD7BfIA
	M5XHWZGjGlWmLveBqmEVK9+bvd1JzPCauaAlcmHzFT3AXB4LrZCZTazhtO37YruqApm7XO0KXxY
	kKF
X-Received: by 2002:a05:6512:1193:b0:5a2:bcbd:579c with SMTP id 2adb3069b0e04-5a2bcbd595cmr728062e87.28.1774957298013;
        Tue, 31 Mar 2026 04:41:38 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:306:797:c4a5:b190:f091:2055? ([2a00:1fa0:306:797:c4a5:b190:f091:2055])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b13f4345sm2417866e87.17.2026.03.31.04.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 04:41:37 -0700 (PDT)
Message-ID: <172bb3e2-03fd-4440-9a5c-a3b4b174c0a0@gmail.com>
Date: Tue, 31 Mar 2026 14:41:33 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ata: libata-transport: remove static variable
 ata_scsi_transport_template
To: Damien Le Moal <dlemoal@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
 <c23f827a-2ff9-4a6d-afcb-fce83fda4899@gmail.com>
 <6a02ae15-bc91-4a4d-be2d-87e311584ba5@kernel.org>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <6a02ae15-bc91-4a4d-be2d-87e311584ba5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 4:42 AM, Damien Le Moal wrote:
[...]
>> Simplify the code by making struct ata_scsi_transportt public, instead
>> of using separate variable ata_scsi_transport_template.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> One nit below. With that fixed,
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
>> diff --git a/drivers/ata/libata-transport.h b/drivers/ata/libata-transport.h
>> index fe5ca66fc..629ac843a 100644
>> --- a/drivers/ata/libata-transport.h
>> +++ b/drivers/ata/libata-transport.h
>> @@ -3,7 +3,7 @@
>>  #define _LIBATA_TRANSPORT_H
>>  
>>  
>> -extern struct scsi_transport_template *ata_scsi_transport_template;
>> +extern struct scsi_transport_template ata_scsi_transportt;
> 
> Drop the extern please.

   I'm afraid this will turn the variable declaration into definition,
and I don't think we want that in a header file... Unlike the functions,
*extern* with variable declarations is not implied, IIRC.

[...]

MBR, Sergey

