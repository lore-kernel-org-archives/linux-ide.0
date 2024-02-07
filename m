Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FEF1B806
	for <linux-ide@vger.kernel.org>; Wed,  7 Feb 2024 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304513; cv=none; b=tikVnQCjIU3EErZcYiRnT3gn+44YWFq6TbxRqYUYjc8Koq0kmRlq02ep6Y3kYD77/XFQUvEikqboofkpa62Z7pZvxikeMU/HLl4uRGv43YcQY/fvazeYl6/0lKcOK18jj+WxxulDG17wIBGLC6Ys8VivRuUuxV1DnBnX3NE2PhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304513; c=relaxed/simple;
	bh=2jRd6S/kViHophAQmJqHxJZPJSo88AAapcBv8aFpxnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6oD9Yn0t2T//RkW6zk8O/97xD7ElM08nNuGxygebZLgZF0NMq4w3Kg/2YaS9ktBP+l2JmRkfXzsKGq/HVxfk1bYzJhPRyu2jw0PYWFQf5l64mGl3fo/IJ0qsQ55iIfvXigecML4LC5bJHMs0k9eW+nCfmjzQY2K2wpJaptW7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0282IXN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0282IXN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707304510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmoBg7e7gy5QqQecjw4wn2ntdcJ+MlXfkM360aqYPa8=;
	b=K0282IXNRlF27yZiL2hdFcsAwT/5/ONEm7JcBp85jW6MYICjuVza4TJLGST6Jdf6U4y8FQ
	6erbwe6/Uzg4B2Y5zK8ACF6SNtgKUa+ot0YPkEhw9p+k/1hmfg5QrPk8C8zfhpQcIKslrz
	Q1gt46j28G2qcgD3Z4zK400D3dpNPrI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-PZPsw39jM4Stq3-Ujnlmsg-1; Wed, 07 Feb 2024 06:15:08 -0500
X-MC-Unique: PZPsw39jM4Stq3-Ujnlmsg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a36fd38d133so25875166b.3
        for <linux-ide@vger.kernel.org>; Wed, 07 Feb 2024 03:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707304507; x=1707909307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmoBg7e7gy5QqQecjw4wn2ntdcJ+MlXfkM360aqYPa8=;
        b=qE7hgGwjvp3ceI1TUoVb4TswjV9wStxknvWSI3Mx304XKdjT1KUypKk0Y1l0T2n1pZ
         TffoEdjHKFKQErN7/IfwShVqC9mVvA/6NZtnp8cWbZ18Yf79y8ms9AkWOVPyoUJyv4O2
         m+OSc4rekhJawivSzCY/Uy7XO4VACfqey3Gx/XPcjpCD5v94e0laKyIQs9SC+GGirPu2
         MBIMajgGgj7BmsxYbIjG0eSp62ZZPXrZ5bg6qWexRp8RP5sAVU6N7k2Ee1mWolPnyYiu
         p+rSEDLzQlsbM1mDYsqF7Phr8dfn6eEtygElYMMmpbOGf+3KHSQsQz0QoJ0ROU0RhOe7
         rIcA==
X-Gm-Message-State: AOJu0YyBsTnibdYXVutMPKZnAmKWqDG4Ch5CAMQSdVUxIzh5lH/9pYik
	Y+LfQ1B3VXfspk9XIQQegOv7DcWZREJtX9np43i/3rsrkdoOUhXMuj3JsQu3ofUXpLhB951YIEK
	RqiVCp6h1vQoYM/maZ0V1C6P2fQXZqUfbFMK7voxETHlMcoaDbXuwIZ7Vtw==
X-Received: by 2002:a17:907:78d8:b0:a38:4842:56da with SMTP id kv24-20020a17090778d800b00a38484256damr2394303ejc.61.1707304507619;
        Wed, 07 Feb 2024 03:15:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFI7phN0cl7yqV3k3uQG1I17le+bYyLwlre47A/++8jqI4873lc2i/D0SykgCpk0lxan1uBoA==
X-Received: by 2002:a17:907:78d8:b0:a38:4842:56da with SMTP id kv24-20020a17090778d800b00a38484256damr2394288ejc.61.1707304507235;
        Wed, 07 Feb 2024 03:15:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXORI031b40O/G+OxcTOjq/8CfUjMsqC32dPuAVMquninPKNgyQbIMqFY431qT03c2avtkG9jigcpQ1ya0L+4ZB/Opyfc5pqVrXcBS8S0g8I0AKjj4dqK8d6bXkF2sHIFN4Kz/wgoz
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ti14-20020a170907c20e00b00a36f0610088sm647138ejc.96.2024.02.07.03.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 03:15:06 -0800 (PST)
Message-ID: <31d9b48d-320b-44b6-9ab5-d53f741dcc72@redhat.com>
Date: Wed, 7 Feb 2024 12:15:06 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: asm1064: correct count of reported ports
Content-Language: en-US, nl
To: "Andrey Jr. Melnikov" <temnota.am@gmail.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: dlemoal@kernel.org
References: <vbpzr7uqpfemb3qa6xy2fxioct44l5vugg2wkywyolfpzqcmau@jgrrhmk2scaj>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <vbpzr7uqpfemb3qa6xy2fxioct44l5vugg2wkywyolfpzqcmau@jgrrhmk2scaj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrey

On 2/7/24 10:58, Andrey Jr. Melnikov wrote:
> The ASM1064 SATA host controller always reports wrongly,
> that it has 24 ports. But in reality, it only has four ports.
> 
> before:
> ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode
> ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst 
> 
> after:
> ahci 0000:04:00.0: ASM1064 has only four ports
> ahci 0000:04:00.0: forcing port_map 0xffff0f -> 0xf
> ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA mode

This still says 24 ports, is that a copy & paste error in the commit msg ?

Regards,

Hans



> ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst 
> 
> 
> Signed-off-by: Andrey Jr. Melnikov <temnota.am@gmail.com>
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index da2e74fce2d9..ec30d8330d16 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -671,9 +671,14 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
>  static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>  					 struct ahci_host_priv *hpriv)
>  {
> -	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
> -		dev_info(&pdev->dev, "ASM1166 has only six ports\n");
> -		hpriv->saved_port_map = 0x3f;
> +	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
> +		if (pdev->device == 0x1166) {
> +			dev_info(&pdev->dev, "ASM1166 has only six ports\n");
> +			hpriv->saved_port_map = 0x3f;
> +		} else if (pdev->device == 0x1064) {
> +			dev_info(&pdev->dev, "ASM1064 has only four ports\n");
> +			hpriv->saved_port_map = 0xf;
> +		}
>  	}
>  
>  	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
> 

