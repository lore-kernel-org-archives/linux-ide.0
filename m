Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941EA13398C
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2024 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010583; cv=none; b=ggebzT4cTQMcL9SUgHedenn3XkXG3GcFhZS7Z3GQO4g+aa60mY6f2aCJpE93jsyqAS0oSwd/E1xmsr6+sIEXEu8Y/QXLoJua6cLb7O22b/kNizXulax1QZ4N9KKwm2KSHSlJTplYrCiGXImwEuxwF8Kv5GA7gp6fjcr+sWOCIsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010583; c=relaxed/simple;
	bh=PL72pL08vJLWNTF69b6M6GVZXXDj5c3k64IHI48YWxI=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nhC+3i0+1LzyZfVICyS2Wn5lDpbAyxX2ZSUQ2qtkeiVLn6nTy3Dp9Nhka4G3VKekqs9FfmgCQMXQ1WCJhQarpOSi09UMiHAAdtS5B2sVVidRtuvRnfqnlr6RN/x04Kwa6Kbszwh87xCMP8Jxfu4YUTg3F3WaVK/YYyb/KdQsynY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ5tbL6h; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ5tbL6h"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51182ece518so1161303e87.3
        for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2024 07:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708010579; x=1708615379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnxJ/ju8DOvCzZ2alxzgBKtpF8LbyY5jQuCnN2xtt0c=;
        b=RJ5tbL6hAwf0KGRX4jxDJx7JUEiuQFIjtir0irkBj+AxbJz6Ojcjw21NyM4H+ki+No
         vi0omgc8pgsGmMd3ahdRPXMHlaeEmHC7scmphyg67II2Q7ut5XlolFeLLLe1rSzmSfXX
         z95XN9UkqoTl47VE1HtxhnKQw16sO0OXf+9+v3+Pd1WDUvMKu3jdzA0OAOSIWYXpTUU5
         DqfhD7dja2MyzrDrrsDRhhH1x4SY8RIuYqBjxEtBoulePlbvMEWPZT2FkLmfB1k2CLi1
         piP5iR2RUiPsCv9cc0e8zsYuNSo2DLMgqwDyoLswmUGIk3JuYiYsTzHwMrVU+SQyHW0i
         y4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708010579; x=1708615379;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HnxJ/ju8DOvCzZ2alxzgBKtpF8LbyY5jQuCnN2xtt0c=;
        b=X61mSsrw5dN4DHy3WZN9iRjRj4m3h/cZlMS6NQyFFBES1OWyTE54RSwKhczN5YQjZQ
         a849ytqbm7GJmkbSQiExx5tYexPfNb70182br2b5wtpX7aetfuyQdNH3sCrR0Ffi8cjw
         4vDxzlvwYwGn4B+tjrXfw/Ga6pghRNem/g8hIZacyKRTPZhbVw4G7WKwk/yY3C3fTBOP
         X/B6kdxd24P1hzenQZ+RgjmwPJb5F4C7wNlqQwb7lmtVPHsuw+Htegz3EzNaUD6/kUcF
         u2k9jks6v+ndOF4MGKL8lvhQWirqmL9oCmr7JFCEorJ4tDZx0Z8o0NQTJVtKes//o7WI
         nlIg==
X-Forwarded-Encrypted: i=1; AJvYcCUkdhQHehRZM1MHvynkZXCHuiyzfZ1k3efJnpNq6tDDBGm73VG+PaRSri2TAH8cukl+gZ0NOGu555b3WA7s0DOiikeR7Dgd61U8
X-Gm-Message-State: AOJu0Yxaxixz/iTz1wvC57/3eQwxutLD9QGiT3HECFxD4ajhMqp0nbrq
	p6ihMVnE+BSP3EHo7jf2Exb18deLzRa2KnKOH4AYC+2UpB3NmJYpNPqQcQnP
X-Google-Smtp-Source: AGHT+IEuJkcHjR8B6Ga1no4vbcuxZxM/fZdb1ejTopByFpwChbyXW4wHZGz42Awbo7lljnOKBvK5eg==
X-Received: by 2002:a05:6512:138c:b0:511:5411:1144 with SMTP id fc12-20020a056512138c00b0051154111144mr2006164lfb.14.1708010578724;
        Thu, 15 Feb 2024 07:22:58 -0800 (PST)
Received: from [192.168.1.105] ([178.176.74.227])
        by smtp.gmail.com with ESMTPSA id f25-20020a193819000000b00511a0a3b2bbsm285616lfa.87.2024.02.15.07.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 07:22:58 -0800 (PST)
Subject: Re: [PATCH] ahci: print the number of implemented ports
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: Andrey Melnikov <temnota.am@gmail.com>, linux-ide@vger.kernel.org
References: <20240214182031.1004788-1-cassel@kernel.org>
 <16121e16-df38-b422-8e8a-124f333e40c8@gmail.com>
Message-ID: <eae22518-cd67-0cc4-130b-55eb6b3f3e70@gmail.com>
Date: Thu, 15 Feb 2024 18:22:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <16121e16-df38-b422-8e8a-124f333e40c8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2/14/24 10:33 PM, Sergei Shtylyov wrote:
[...]

>> We are currently printing the CAP.NP field.
>> CAP.NP is a 0's based value indicating the maximum number of ports
>> supported by the HBA silicon. Note that the number of ports indicated
>> in this field may be more than the number of ports indicated in the
>> PI (ports implemented) register. (See AHCI 1.3.1, section 3.1.1 -
>> Offset 00h: CAP – HBA Capabilities.)
>>
>> Print the port_map instead, which is the value read by the PI (ports
>> implemented) register (after fixups).
>>
>> PI (ports implemented) register is a field that has a bit set to '1'
>> if that specific port is implemented. This register is allowed to have
>> zeroes mixed with ones, i.e. a port in the middle is allowed to be
>> unimplemented. (See AHCI 1.3.1, section 3.1.4 - Offset 0Ch: PI – Ports
>> Implemented.)
>>
>> Fix the libata print to only print the number of implemented ports,
>> instead of the theoretical number of ports supported by the HBA.
>>
>> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>> ---
>>  drivers/ata/ahci.h    | 11 +++++++++++
>>  drivers/ata/libahci.c |  2 +-
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
>> index df8f8a1a3a34..92d29a059763 100644
>> --- a/drivers/ata/ahci.h
>> +++ b/drivers/ata/ahci.h
>> @@ -455,4 +455,15 @@ static inline int ahci_nr_ports(u32 cap)
>>  	return (cap & 0x1f) + 1;
>>  }
>>  
>> +static inline int ahci_nr_ports_in_map(u32 map)
>> +{
>> +	unsigned long port_map = map;
> 
>    Why cast to potentially 64-bit type?

  Ah, I figured it's for find_next_bit()....

> 
>> +	int i, n = 0;
>> +
>> +	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS)
>> +		n++;
> 
>    There's hweight32() for that, IIUC.

   Yeah, it replaces this whole function... :-)

[...]

MBR, Sergey

