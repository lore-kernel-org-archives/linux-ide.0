Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D7929CB36
	for <linux-ide@vger.kernel.org>; Fri, 11 Apr 2025 05:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744350179; cv=none; b=dQSeqDOKkl6zvbWsrOnW9qQ78E+va2fTwz6KwcRrhAvcB/SWKI0YhC1/wVl6E+Y0Bpm/4do6YnMsWuX1cv+kYDX8BLjABd3Bb8aMxGExdQEpipVDUVxLCIhaSSvJLaSNuwXx97mboo1Z1tHxfcrvy4ZSaWJ4Cwl1CxiMoEfEZao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744350179; c=relaxed/simple;
	bh=0iGBSss+xKGLSCP1CrT94ASyzN2pmG4jfEa7EfxGCN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqYiBEO4Q1Nszu6hpK4IlBFItpqaXSxyT6MY0Bx3+fkdwQVCZnPUmMi0gCllhMH23iP2vbX8BXtDrbDUBZMiRkA4qjpXSlP2RGdICm6pCtHNFEDs6QAmL4PxIiHWSsp8wY0/4pseaS0FcIg1nGBluZp0E0ZSsirxtRoZoQiu66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJPJ3cEY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJPJ3cEY"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso952183f8f.1
        for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2025 22:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744350176; x=1744954976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m6OpOy7j7ik21LnbOq/StONomD4s4xI/P1kyYyoXus4=;
        b=lJPJ3cEYPXNy1/NlHOKUoodf/515Clne4jTTy2E8Wg6geD40JEmcxsgJxxm0Xlzmd9
         IiW1dLWfDRnLaOAjNPPdtD8fGwxFZrlTUJ3GuhfSMhsZYz8VIda+8nW0tAYz4M0dlAmV
         BgpEw57ZXHFs1nrNK4DM+35gez0Z6OT4TttlIiTVEOZU9O4gPfstmpKXO9Z6lSACDxHN
         CdahbuwjcAuQ04AFeOYxhGiZBQt2KZSO+9fp+OCXTgP6wRKcugNdi5ORa/dlxUS8c4Sb
         SiQCYaOd24T4z5syJCCvCaMxxKPZf2t/+xagnblj7YPqHeZiaXdpEHPxru655cd7PduS
         MMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744350176; x=1744954976;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6OpOy7j7ik21LnbOq/StONomD4s4xI/P1kyYyoXus4=;
        b=lXUnyK3NibjEK0bOYdDHbyXS9EQIFG/e7bsso0j5pqwSlEpVNN4DerIzGk7FH7be2t
         kmrNfAfr+sfEk1lPeOR2gTrKztCoiCp9xSt7bWm+CstI9ZwXXcR8Y89nKF55sX3HYgne
         3vOvqvKybvCYBVAGt3N2TbWMXb+LxftXXNpsLiwUeF1azMFzGydp705weEBrect9F5jM
         +fhpO3GR4aTFoLGPZgpLFmo3DzNSM1W1l06di4gHtY1voMMPOHnK2P0EGrCGzvwHq36W
         Uc8UC4WikdgolSZ8pES1eA3PGhJ0sBvfAVQ4H2sKq5cRIqOKFVh6GeDXj71PVBAmGYs6
         NPeA==
X-Gm-Message-State: AOJu0YykUbHR82tkJv3KphNId42J+bV7JHYruQiWPEh1kr1mVqBsw2Cf
	4/2p35xh7Ksahy/G0GBAefp1lW4mfY4KmxduJOlksJTh7eotdH2t
X-Gm-Gg: ASbGncsSTNp0XHqDJMSFeTd/RUmUSkwl7S4cVxefgo7Uf7R597oAvG1Mj8/D8bIGykt
	8EdUPLivMFgUoZSiupdzJUOLGyGdKz4ZoYMIU0NGUdUt593b/ydlBaEP0/nKth3rTzA4MO8/SdB
	JnYX62f40aP2TT+n6Fwcq8ckHwOdv1QDIDWqxJoAyinlIUuA3d0HxgW9sdyuWg8QbjEgm2RTSV+
	y24tgYtnkg1zOuTMBuk20XY58UO9iIH3Ii9iWXZazNqtqHfi965yFHiBMem5rCjB09yojDMaPhs
	0j3G7JlINIIrTNvYSep5ytoVUzQtdjE+yottZEX0Sv3Jdm7sTLhZ/mZVUzPOGohwQBBHFKmgBJT
	mp/F3noJ78a5Tl9MaXZJwygbAUbrVW5N+YVGHN2VVMmr54Ct/S9qZaHU1ewwJbTaNUrUmYYpOkD
	Wvt7/A67QBCW2ppSDdFsrt/Zz54Ix6MCe2pKI+YvHA
X-Google-Smtp-Source: AGHT+IFfgpFbYmmg5ngGwO+lPbMT8XA/lXHd0AbQHXwV7DnLrN8EHR7CDlxRItWgDRdTUrCAg7YS8g==
X-Received: by 2002:a05:6000:2910:b0:39c:1efb:eec9 with SMTP id ffacd0b85a97d-39e6e49f471mr998667f8f.13.1744350175697;
        Thu, 10 Apr 2025 22:42:55 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a54c:3600:549:9f8b:a298:4c0e? (dynamic-2a02-3100-a54c-3600-0549-9f8b-a298-4c0e.310.pool.telefonica.de. [2a02:3100:a54c:3600:549:9f8b:a298:4c0e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39eaf43cb43sm931035f8f.65.2025.04.10.22.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 22:42:54 -0700 (PDT)
Message-ID: <f387fd43-186d-4431-9d74-8c45c3439c97@gmail.com>
Date: Fri, 11 Apr 2025 07:43:44 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Simplify ata_print_version_once
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <f9e7276d-d9f9-47cd-8b9b-5dc85567489a@gmail.com>
 <95ca32e1-6c90-4a31-8a54-c997a6653a1c@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <95ca32e1-6c90-4a31-8a54-c997a6653a1c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.04.2025 02:00, Damien Le Moal wrote:
> On 4/11/25 06:45, Heiner Kallweit wrote:
>> Use dev_dbg_once() instead of open-coding the once functionality.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/ata/libata-core.c |  6 +++---
>>  include/linux/libata.h    | 13 +------------
>>  2 files changed, 4 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 773799cfd..e58a22e83 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -6682,11 +6682,11 @@ const struct ata_port_info ata_dummy_port_info = {
>>  };
>>  EXPORT_SYMBOL_GPL(ata_dummy_port_info);
>>  
>> -void ata_print_version(const struct device *dev, const char *version)
>> +void ata_print_version_once(const struct device *dev, const char *version)
>>  {
>> -	dev_printk(KERN_DEBUG, dev, "version %s\n", version);
>> +	dev_dbg_once(dev, "version %s\n", version);
>>  }
>> -EXPORT_SYMBOL(ata_print_version);
>> +EXPORT_SYMBOL(ata_print_version_once);
> 
> Overall, looks good, but I really do not see the point of having this as an
> exported function. So while at it, can you change it to be inline in libata.h ?
> 
Right, this would be better. I'll submit a v2.
