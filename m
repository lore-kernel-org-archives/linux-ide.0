Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D8A28EC99;
	Wed, 15 Jan 2025 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736929692; cv=none; b=Rbj2f2dY/mlTAF2T9pxRSV5cV/bhntt7bLrPyD0kOq9qXVz2rPIlv9A/UM5epk0NciP9ltbIi+zn+jq2pQQeT1eDpd4dOecuKLOsORPmgOrX1jNgW37ODYrMZ3LngBYZJSGRz815ym9y6nFGXH6qMF+/jD3BAS0tuDBHXFRCzhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736929692; c=relaxed/simple;
	bh=11Zq8qmfVIZzrkTSMxpBb/L+l5LfIN8O7VN98/BT8II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tdm0GubGIwYF9f8K4ljSbgDtANJvS7zuzPNDjteGdxfn5knim9bG3S1StM3Kk/n20pfaDqrkqC/9EQchaCUDGsWd7c5cSwAf782cSf63M8+rAwRrSkgnxCN8RTiIAETBuFhOltQHlbBgSs5C2vElLsX/9GyoxSostyb0+qOnaZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0EP9A2R; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0EP9A2R"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso45461225e9.2;
        Wed, 15 Jan 2025 00:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736929689; x=1737534489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7VsayfsbgUkjz33UWIbO/Za5YihWzgN9JEYCylKHiN4=;
        b=I0EP9A2Rh7HBPEb3kwOdVVnHqAms+0s11p9OAZwEXzvhugWHYp5iw98bP8agqsbu/w
         TOlxonzql1PsXcGRH6k7RdMJ3t2fR3TCzdpx3X1g8C/oeJBzUPKEeZsC0gGi8osSncS7
         kzcyXk5zDhSSWFGELZ1lFPtZDowaAHolKbhxBbjqf9rImiNXvvbyM1Fg02m3D6VxhaoY
         CKNUNAkejKP7WveuqdqOqrxz5SI9Qwbe3xvUnFts8e00IwWIZdn7yO6d4DUe8fqJ++4r
         UyWduRRVAu6UuthMKRTYWg9/P2F/hBMfac7VXQvmE/tK+Q3EWqxyxJsRmM/2t0JrEgig
         amIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736929689; x=1737534489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VsayfsbgUkjz33UWIbO/Za5YihWzgN9JEYCylKHiN4=;
        b=OhIn71rF05cly134dZ0KhHYVeycQndDN0eXNRIfkxW4YlC3ZTJrLAwNiUXzo/PwZ8f
         cae+XiyB+VeJWVU8zcUZIKO1k5rvtVleEGSbkcH1bdCkDdN+v4KfgJTpnVDCNi/5pk55
         UV19+1VppZgIEnHbQbTFClsBdy9aGn2g4WI6jmwJgzAWF3ga45ECMAiZKqUVKBP/3OaT
         yL5AF9v4aG+CYl0UzIs/wCetUCXJlAD5/TvIb/ef5dCfC3xApAaVtiwQYLkU5xB0UhYJ
         f0lH5t7+Tn8/UrYbe61BH9rnrciorneJsPY+IhuAmn85WwWNrnvquNi0+3k3sePivqHJ
         uLKg==
X-Forwarded-Encrypted: i=1; AJvYcCVh/rnH7eynJivHkFzW3G/vpR5SZy/ZgEThH0Fx5y0wGoLAZCObIjeA0WGmzmbiDQqXh4584Ho6mRE=@vger.kernel.org, AJvYcCWsv23g2dz84cXAe5XFHK5kYA5w3ANlEkdpD4lzi1JPKBnMl5a0MMmLNUrdlJ9WwYrA4B/8l/YK5y88Wirx@vger.kernel.org
X-Gm-Message-State: AOJu0YwwzCyM+NTYG6gIuoYXOCitkgFX+olAbKsJ99E3f08j/VwTWExj
	VE+YoXV95ylCgSZpfPfgzy8CmOwe8rX1iUbjunhrRFJrLceBNLjs
X-Gm-Gg: ASbGncu3QyDNOSDeKb5cE6vB1nc0tQjsfr1ONAhW1IPWtydSwGcRDgmYIPPAys0+7Ky
	YHBDcmz/PVSNzAZ3SecwXTMZ1s3RySxYap1cMhDXlPBCAQPCCH2t0Kp0RaFW88mk98XYsltNLFp
	/BZCiVmfNiulM4KjLK4s8+a2wr9Dacy0aoKdtDynduzZX1qtuoiPFArVrz04BkmTRUWqcfVYq/w
	+oUtSiAeZ/RhmkiT3WztiQ9ID+zHLIrADWlSn9QqfVQHwE9C+zbDV/8L8qqjW3GjU6auxX0YQKU
	OVsxUZ+6h3/4Z5ppyB3LOi37lA==
X-Google-Smtp-Source: AGHT+IGL3BMYFdeGwsOc+4hVyEkEjlFrsyaDEQrSgFINthPSQpTJR9k3ryox/oDYyXaXdiw8pZ9GLg==
X-Received: by 2002:a05:600c:4f49:b0:435:194:3cdf with SMTP id 5b1f17b1804b1-436e26bd59bmr124095735e9.19.1736929689301;
        Wed, 15 Jan 2025 00:28:09 -0800 (PST)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74c6179sm14967605e9.22.2025.01.15.00.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 00:28:08 -0800 (PST)
Message-ID: <a5608ccd-e427-404c-8eb7-f189591a57e8@gmail.com>
Date: Wed, 15 Jan 2025 09:28:08 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ahci: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250109175427.64384-1-rgallaispou@gmail.com>
 <07a7177d-7705-4eb5-a11e-02a9429ffac2@kernel.org>
 <Z4EDKUb+hO0ovV2i@x1-carbon>
 <cfecaa65-f6bc-48c1-9295-9bfe18f13db3@kernel.org>
 <261f9fac-82de-4f39-bf5c-cdfcee917588@gmail.com>
 <88fb7ad5-e2b3-498d-82d0-cdba8cf50c1b@kernel.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <88fb7ad5-e2b3-498d-82d0-cdba8cf50c1b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 14/01/2025 à 01:59, Damien Le Moal a écrit :
> On 1/14/25 05:28, Raphaël Gallais-Pou wrote:
>>> Do you want us to do that cleanup ? (fine with me).
>>
>> Regarding the other ata drivers, if you have the patience I can do this
>> in a few weeks.  There is other things on the stove I would like to do.
> 
> OK. We will work on this.

Sorry to change my plans,  I actually started working on this.  Is this 
okay to let me handle this ?  I will try to submit something promptly.

Thanks,
Raphaël
> 
> 

