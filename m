Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353651E4B7
	for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2024 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939207; cv=none; b=Ndw3vP3vUGjbGclrLo4erq5azP7272dd/FbIrEOyCV48/2p8bJSntBF5Mj4PvlxlriG3tvtUNF13JmU1kMpoD4PmL1O2pU8rzcEOVSY65ABx4Gl9JQEB5Mifu4iqybCp1cbbVDTx3g/Ifb0HlG0wqXHcnobVvypvtpi6OvBuLAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939207; c=relaxed/simple;
	bh=PSDAYGyTnXi+TlFuTpvL8jdZlU3ID1muuQgeBMTMymI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KZMFqt3l+IR0XTGgZX8PCShI0BX6nYLDI/1oaRL1+Umgcsj2lph6FfErAu22dujRT9TFuBsTovCrV0CxfYgzU04qsxBud3EU/hY9EMt70M6w4KBavD4azScE55ZXz3NCxUJf+WkPhRMPNDm4n7pe3EOFO+fcUhYh2yMZGfqDJTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QW/PrtjZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW/PrtjZ"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51182f8590bso87079e87.0
        for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2024 11:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707939204; x=1708544004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RT2VmwPT+IvtReZOYNaGeuQWG2xOnYWOdlj2aiUjygI=;
        b=QW/PrtjZXFO6SM3kZf0DQchSqh+0IrCPc9yDJwd1587o9CP6mY7p1qn86EwIAYoVSJ
         d9utVfpf/4RCWRiHRCO30DL6BRi2IueFXCTE6LvsW9y83VSnrqgfo3e8rWSkMBptSQQj
         QGJ2TKL6MPooJXB/e4y4COJkfQuVZINGNSnhTsldF9VEPJp4MM4qKAQ4i5nS93VknWCg
         48VULmjadbU2HKvRA7+jkvsdDGS74ec+rtez8pr1DJKEtnWjqsIg9vteu1lTUWAkOQcQ
         aHjkcdiw4s6oQQODrSV2aUT99T8SPSCEivCWc0YmbVqduNcVgbOMj1y6GmdE+wcGpZ7L
         a72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939204; x=1708544004;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RT2VmwPT+IvtReZOYNaGeuQWG2xOnYWOdlj2aiUjygI=;
        b=EauhJ9otL11dwaBo55p0dnV0quob8hM8BsDP183ykH32xar7oE7TVIBDqWTzusEdA7
         j60Reroy9Fn2ajHBda7h2Rno7rvkbehIgAqyMqXQkdYnq6L55iEcyTiZ+CGjGcenGZqW
         CbVzhL6/Io+aqv+oQdN7ri+CQJ0Av+8lzovnpTs1E108VVL6VGHhzxnQ/t6uxPqw/O0B
         RvDIQfx0TxJPgbc3L6pU8LUkZR3mc4V3af5XH5uSI695i+r3RfrBTK21BTpehF0I9+J5
         qydD2wwMQA8rGl8Fo4gT3dkyxPc4LnyOZZ5lu3YpB+YZ2CpiYvkuZK2Y5jNKeE7kXDZ5
         +agA==
X-Forwarded-Encrypted: i=1; AJvYcCVGoMBob8t8RH8YXcXGD/u0byJNS5DsmyzHzeVVo5MsXTwrP7BAxZVxZP9wx+6RpodmFgdooNnKt19oSpwmfKO5UsuzLh10gKrx
X-Gm-Message-State: AOJu0YxeK9IrjZOD7oNRq1SZaipSLoSKrfiK87XvlmPzMVgdypE6D5sT
	YJxBEE94aAIyHNNZ8hT6Rk/q5GCtolHcEBR6gsz8yOe1Mwh4Y+Gy8SpGZkOL
X-Google-Smtp-Source: AGHT+IE7mo/yUuluNsixzzna4UTQ008P8I27FChNXU0bWDLiisF4Ga3t92DrnP+c8USivkzl2jfhMg==
X-Received: by 2002:a05:6512:39c2:b0:511:a803:7e63 with SMTP id k2-20020a05651239c200b00511a8037e63mr2550928lfu.54.1707939203500;
        Wed, 14 Feb 2024 11:33:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmHduDNPB0DLwt5k0Jp7cL/ECIWYOWIVWUH4r147RZTfPw1eFh5I5JW+7iyuvWGLbx8SFvpc6NDV8S/iLV/e63D8sRBH4NTVR4VI/9c+OBYKQr+Uqg98z4NzA8dzg=
Received: from [192.168.1.105] ([178.176.73.178])
        by smtp.gmail.com with ESMTPSA id k18-20020a0565123d9200b005116f7d1873sm1795759lfv.301.2024.02.14.11.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 11:33:22 -0800 (PST)
Subject: Re: [PATCH] ahci: print the number of implemented ports
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: Andrey Melnikov <temnota.am@gmail.com>, linux-ide@vger.kernel.org
References: <20240214182031.1004788-1-cassel@kernel.org>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <16121e16-df38-b422-8e8a-124f333e40c8@gmail.com>
Date: Wed, 14 Feb 2024 22:33:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240214182031.1004788-1-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2/14/24 9:20 PM, Niklas Cassel wrote:

> We are currently printing the CAP.NP field.
> CAP.NP is a 0's based value indicating the maximum number of ports
> supported by the HBA silicon. Note that the number of ports indicated
> in this field may be more than the number of ports indicated in the
> PI (ports implemented) register. (See AHCI 1.3.1, section 3.1.1 -
> Offset 00h: CAP – HBA Capabilities.)
> 
> Print the port_map instead, which is the value read by the PI (ports
> implemented) register (after fixups).
> 
> PI (ports implemented) register is a field that has a bit set to '1'
> if that specific port is implemented. This register is allowed to have
> zeroes mixed with ones, i.e. a port in the middle is allowed to be
> unimplemented. (See AHCI 1.3.1, section 3.1.4 - Offset 0Ch: PI – Ports
> Implemented.)
> 
> Fix the libata print to only print the number of implemented ports,
> instead of the theoretical number of ports supported by the HBA.
> 
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/ahci.h    | 11 +++++++++++
>  drivers/ata/libahci.c |  2 +-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index df8f8a1a3a34..92d29a059763 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -455,4 +455,15 @@ static inline int ahci_nr_ports(u32 cap)
>  	return (cap & 0x1f) + 1;
>  }
>  
> +static inline int ahci_nr_ports_in_map(u32 map)
> +{
> +	unsigned long port_map = map;

   Why cast to potentially 64-bit type?

> +	int i, n = 0;
> +
> +	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS)
> +		n++;

   There's hweight32() for that, IIUC.

> +
> +	return n;
> +}
> +
>  #endif /* _AHCI_H */
[...]

MBR, Sergey
