Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D3D811F3
	for <linux-ide@vger.kernel.org>; Tue, 23 Jan 2024 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036700; cv=none; b=V39rStppK5IjPDsgirU908iFNX48DErM+iPHjhC9kaxAQIrVny4AKSJApgeeGiuNOy81SS5mNEbHRT16/a9xhUJMqtE9+TsZUBEI0X6igsHsZOIh0m6e+HJboazZkP8VZoEQ7CVY+gfzTJRmYD+Er/TKSnzVy2GygFc4GwnLtdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036700; c=relaxed/simple;
	bh=inpYRunu7a+/P69OHKJdfPr+xzfMvH62XScswjJIiSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDgucBj8wRpK8onqwcWQWfTPbpULdei6jA7At5lRDJb+R92GM6C/E+QaycgBWZWLzo4S4Y0fBB2tOK4wp4SZ0m3v5rpKwDDSDM5EKIEFylXRBusQ3lGD+/HU7JvDTbqrb1j/TEfJkCfeZB48X8RDjvQ1scIZe+7xa3wqpapeYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OLcNyvox; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLcNyvox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706036698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/sN5hulO719YCIZsmMNq+K6W2dI39cuVDmxC+XWuWg=;
	b=OLcNyvoxFJuBCHMz/E0PVCNKRG9TyB+Dud97QZysK1XarYSPtw74rDlLR6NUiRjJDLqN2u
	jfO3Hv8Xw3IT3XOOK7t444qvhYc2H4sD9G9kYIOPrXmLMZN0khLpu52PtKjZIXONK813uC
	YU/O07nI5RKdT1Ed7F665vDZB+hlbeo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-0Y7VEny_PpKhTSL5DwyhFQ-1; Tue, 23 Jan 2024 14:04:56 -0500
X-MC-Unique: 0Y7VEny_PpKhTSL5DwyhFQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50e81d186e2so5396969e87.0
        for <linux-ide@vger.kernel.org>; Tue, 23 Jan 2024 11:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036694; x=1706641494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/sN5hulO719YCIZsmMNq+K6W2dI39cuVDmxC+XWuWg=;
        b=uGPo8GsYOBZ2iVpKEiNPM8FA9ToC11lXMBi5v/71P6TUU1YHWOPYMjbGbeCe5zSTH8
         nMMdduep5E4U9g4WnhPrE0p7cAenYmMFUGKYcV0vYerojZ5KAKc2ViQU0lzjj2DSZ4bs
         4qXRbyCjDOU9j10XVuswGPIgt70sud4qP3muwzShxXznE3zVvTAXcRFq74QMgjUbCNIo
         9Yu0C6R0x1zYymHJbL07jrrf3XBC21Tkm054mif+jxTuuCyj/y/me7LYN0pfC6+X5mlL
         4dMc95M1h7clPYYiAY9TgEqjX0iPn3saVdgJ6exNBN8boS7fSpDABhByEsO/cJKjm/Rg
         bGsQ==
X-Gm-Message-State: AOJu0YxyQd5ff3w4MEe0bohlO0nX0ExBMbo1nA30Hy+3Sbvjv71I5zx0
	qvsq0plYbBJeJnZSdUon8b55m8GTeHSxq4Y5TFyc6A0iAhoOd6sXiT6a9XLNm1uE2jcWTWkld9M
	iBAFmT+Bi5JeeJEm6ZwPo/NgQnAuPbO0lbI5wBeY+VDbcPnxGD4xAxVXcmJMnNyl/3wtaXO9lGA
	Kr9YleDJhYifFZF7xu3WEPvpbov50aDaqiOu5FWS7RmA==
X-Received: by 2002:a05:6512:2256:b0:510:e05:4361 with SMTP id i22-20020a056512225600b005100e054361mr160057lfu.3.1706036694552;
        Tue, 23 Jan 2024 11:04:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELdDdUxhnmzOyCMSiWHb7nJmmPa4jYjqQ90Y7Q/9boZpyaEPI4tuKbVIU7sH1yj2FDxMnD/Q==
X-Received: by 2002:a05:6512:2256:b0:510:e05:4361 with SMTP id i22-20020a056512225600b005100e054361mr160048lfu.3.1706036694162;
        Tue, 23 Jan 2024 11:04:54 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id vs7-20020a170907a58700b00a2caa85c0c1sm13758772ejc.30.2024.01.23.11.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 11:04:53 -0800 (PST)
Message-ID: <c0d59d12-edf3-44eb-adfd-29c3dc1bde23@redhat.com>
Date: Tue, 23 Jan 2024 20:04:53 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: asm1166: correct count of reported ports
Content-Language: en-US, nl
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dlemoal@kernel.org
References: <20240123183002.15499-1-conikost@gentoo.org>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240123183002.15499-1-conikost@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Conrad,

On 1/23/24 19:30, Conrad Kostecki wrote:
> The ASM1166 SATA host controller always reports wrongly,
> that it has 32 ports. But in reality, it only has six ports.
> 
> This seems to be a hardware issue, as all tested ASM1166
> SATA host controllers reports such high count of ports.
> 
> Example output: ahci 0000:09:00.0: AHCI 0001.0301
> 32 slots 32 ports 6 Gbps 0xffffff3f impl SATA mode.
> 
> By adjusting the port_map, the count is limited to six ports.
> 
> New output: ahci 0000:09:00.0: AHCI 0001.0301
> 32 slots 32 ports 6 Gbps 0x3f impl SATA mode.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=211873
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218346
> Signed-off-by: Conrad Kostecki <conikost@gentoo.org>

Looks like this is a double submission of the earlier
version (which did make it to the list).

Anyways this version looks good to me too:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/ata/ahci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 3a5f3255f51b..762c5d8b7c1a 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -663,6 +663,11 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
>  static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>  					 struct ahci_host_priv *hpriv)
>  {
> +	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
> +		dev_info(&pdev->dev, "ASM1166 has only six ports\n");
> +		hpriv->saved_port_map = 0x3f;
> +	}
> +
>  	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
>  		dev_info(&pdev->dev, "JMB361 has only one port\n");
>  		hpriv->saved_port_map = 1;



