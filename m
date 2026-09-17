Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558C9524B19
	for <linux-ide@vger.kernel.org>; Thu, 17 Sep 2026 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651610; cv=none; b=uKoaWD25Vv2oREcmwnMjTchDQ4YehKHWhlrQzsVGM5+W0x9mefo3WQu8TFTEBCynlHPZ8lKu1HKn5D93i0jSfvfMnpl6RRMjpXTsadwNkcihf5FHiss6iGYsTOW0bupUt7LnBgQrzMbBRLLi00/3jHauRMp5IvUdp6Av3Vjs+iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651610; c=relaxed/simple;
	bh=9tmxOGpu37hEB314dznYCr60bkWw5AoAmxcdKCtiFO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tF3rvQzg3PfVqqYlVkAnocDzsKt6zG9XfoBfVmq1u/vbIxshbldJxcipqIIzAYEh7CYgmMTy3QkcMht9AOYxv4mJMMNnu/VCMdiwaj3kq7MEATA4ufbb9Aqwu6rLBr5IaKC6YsyOjDOI8O2Q4jfwOxtlIPwSzkf4sy0cNnXNYVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YrRRhfIJ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YrRRhfIJ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso10231435e9.2
        for <linux-ide@vger.kernel.org>; Thu, 17 Sep 2026 06:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789651605; x=1790256405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iB8gTEHafDG72B6ZCeWxmI2WLo7MG6Pn+BQ9nyHXtso=;
        b=YrRRhfIJ5eqsEI9zFzgJLP0Vq0Giyaohyo/LHgnavG8lLL3ozBbMfWtgjyVLGgXrXm
         3McZkU5yqS0Tds+kDbh26DKli2OoJ4sBIlAkHS92pRmZJ9T3tmyoB4LsLU+YfyXv1q6U
         wkIpJQ4teG33tYjRC0KfXdaa9v6GvvPx56WCo2V+6H0clzHt04JQ+yFZL0L5fd6s2oWN
         bLgqEr3wkuSB4ke4zlZRbg3Z0BekgFiG9h+TrCyrLJcGq1eOJoY3eKP7DiJlL/PZlr6/
         L9UJVbfRqDa1v4chI2VDzmcY1cf8oC3JShdfdf3/sh2Y7WND5i4Il6n+t/TA0q8Xkh1d
         EKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651605; x=1790256405;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iB8gTEHafDG72B6ZCeWxmI2WLo7MG6Pn+BQ9nyHXtso=;
        b=Xa236aVCXu2Lz4J1EXt46fU+1i6zzqDirOdclVj3K/xSgwkp455wI51WNg9WYzRrVX
         rzGTG0dNDXgaxzGp0xpQILVkcGHOb13gsMraLymoLb6jzAJ9LL1HiH9MjbIkf1qCt04T
         fMjElOlSBjGWkoVLoEQbj5BCOJmQwnRcp2lgaCb30bEJbZ4kOcr7pqcSfcZITIwmSXfU
         Vcjw8Mg+eNkL6AG+AlKTMpNt5P6yuEcmsJSqtCuuNnyzwbrltA/SfHKFDdAOOV6Ph6Zt
         b0zl7VGuc7hMfaWkoFir1yWg8Ocez8gUvl3xfsPb0iMzREzrqbA3d8OBCZ1Bc2WwFqWI
         xOsA==
X-Forwarded-Encrypted: i=1; AKwUvBy018mm6OG6w/s3j9X/xjw2JdLCZmQcSPLEgNy2EZDz1rEKaNG30BR5hR/FEEyAJCe9tDhtRDr8/m0=@vger.kernel.org
X-Gm-Message-State: AFuF++kfIM8YH7yfrjgp07juMkpmRDiiGlX4ZU+dy2ssJRnh9hlULHXE
	WKv7R2Xpb9LfoG1A/DNhDrDCY/URSd7szzpvArwg+X2CSXyLnT2P/7MJ2rVaPG9sUFg=
X-Gm-Gg: AYBFou1IMHT0FVTdq4we8ZBWpXyWwPwgkXz/cufciyKIO/i9UvQ3jft0E9VMOzsOPcJ
	zPGiJ9IjmSPjoQFaz3XILdWluUdQsTwihweR3+iNdvBirBBGJvgKlrXVuh3nT8Id9H9FhkWWZ2g
	NwuT1P6k4YyNvNDu3HkqmF/x91mvdy07R0o4qx4jJ53GtuFmDCMK1h7zz/FTZ9/y7FTqAxaZn/b
	QJzObY4wnm5++HPF901twm/G2tfg/RXbmSHc9YE3JOuKP+GLjz58mIS1P1GE0BuPL74i8fy/scJ
	LH/Z6Q/Q2nwdpAHDQoofi2zpXb3dxg5zC2J/ZouJw16rOFJCNkMgrHPcCoUEW+MucMgzItr29jf
	wrZdAGlQo++9ymk1muktyfUYoSUaFHwjS/mcFr4djewW4ewV8Oi4KOAyjZg5g+Uftz0z9OKkosf
	+HWBSiz9pNKl7FQDQaCe2TB6RLPNUDrsTAy9/TsntfSOkcGw/znLWtc/9ilVGsyOQdWH1ZggOYe
	LSjyaRA/mUv/RzIgImfzUWpLA==
X-Received: by 2002:a05:600c:1551:b0:49c:f512:2361 with SMTP id 5b1f17b1804b1-49eb733721dmr115458705e9.14.1789651605193;
        Thu, 17 Sep 2026 06:26:45 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd24774esm122038495e9.10.2026.09.17.06.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 06:26:44 -0700 (PDT)
Message-ID: <3d8e8d30-1c67-4973-aed6-5fa9737b6492@suse.com>
Date: Thu, 17 Sep 2026 16:26:41 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: sata_dwc_460ex: Don't enable interrupt if libATA
 core registration fails
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: cassel@kernel.org, rosenp@gmail.com
References: <20260917113526.1589813-1-nik.borisov@suse.com>
 <71caed6b-2aa9-4c4d-bbd9-aac41aa6a011@kernel.org>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <71caed6b-2aa9-4c4d-bbd9-aac41aa6a011@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17.09.26 г. 16:18 ч., Damien Le Moal wrote:
> On 2026/09/17 18:35, Nikolay Borisov wrote:
>> Recent 4bbc16a353a9 commit changed the timing when interrupts are
>> enabled. However it didn't account for the libATA registration step. So
>> it's possible that interrupts are enabled when the device is not
>> registered with libATA core.
>>
>> Resolve the issue by ensuring that interrupts are enabled only if the rest of the
>> initialization is successful.
>>
>> Fixes: 4bbc16a353a9 ("ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is registered")
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>> ---
>>
>>
>> Changes since v1:
>> 	* Added proper goto label
>> Changes since v2:
>>      * Rework logic so that interrupts are enabled if everything is successful
>> 	and don't call phy_exit otherwise, as the driver is quite broken w.r.t to it.
>>
>>   drivers/ata/sata_dwc_460ex.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
>> index 8e3fc713891a..e74335dec42a 100644
>> --- a/drivers/ata/sata_dwc_460ex.c
>> +++ b/drivers/ata/sata_dwc_460ex.c
>> @@ -1185,11 +1185,13 @@ static int sata_dwc_probe(struct platform_device *ofdev)
>>   	 * error_handler() to execute a dummy Softreset EH session
>>   	 */
>>   	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
>> -	if (err)
>> +	if (err) {
>>   		dev_err(dev, "failed to activate host");
> 
> Why not simply "goto err_out;" here ?

That was in V2 however Niklas discovered some issue w.r.t to phy_exit. 
https://lore.kernel.org/all/aqGFjsuIMRIy5xfv@ryzen/
> 
>> +	} else {
>> +		/* Enable SATA Interrupts */
>> +		sata_dwc_enable_interrupts(hsdev);
>> +	}
>>   
>> -	/* Enable SATA Interrupts */
>> -	sata_dwc_enable_interrupts(hsdev);
>>   	return 0;
>>   
>>   error_out:
>> --
>> 2.55.0
> 
> 

