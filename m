Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED78359B40
	for <linux-ide@vger.kernel.org>; Wed, 13 Mar 2024 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710367616; cv=none; b=hZg1EM7aAqQr5rG9T/epLcq5pHSQFx/3WVUWUBN/PE4KiTEi/41m5UajTj5e4GeasR1uS6LAkJVMgBxMtAESrFjq/EZZKS2ESjFUVOit/VyeYgnNd0+U9QtqnmjTlM56QWjvidqyXfrR1JlOVUCUBBAFYl1r+ZMwHiSWQ1E2Za0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710367616; c=relaxed/simple;
	bh=N7r0G7B9q/oyyJ7Dmyn3sKZrxXNeqRMYC837/sBRDCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COoDprqFQefra05RFYkigiVeRDO0XjZONAJIruZw+BtZe1fmAVvv6/evBKXQCPMA8Qhiy9HpI5g5zJG09/Ks+TuajWZfUYdxk0GMcr4u/Sx64o1vQcM2RnrVhxHchkVJQ9pqimLjT1VeauDWkRlajQ47KV+5C78kRrEDzskK+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9hDvIkt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9hDvIkt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710367614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=euRtFSTUhVmhnZxiO/6tHfKYbzxwPzGW5Dtxe0N8J6U=;
	b=Q9hDvIktrSuQ7Q9k3iPSrWl9OictJ3x4WerwX0BvNxHe64+LrFfWtrro9K9b/JIlMjjjMG
	kMB24kp54kncgSLwzGzrwj/5DMYRPJzy7StIyKTkBPLO3HmBbG+reKVJiyG9dI2pknWMO9
	EdJ382DAIJLZZUZY1Zm4BuPI+4c02HU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-zT1cZm8CMaeLnVhfunknHQ-1; Wed, 13 Mar 2024 18:06:51 -0400
X-MC-Unique: zT1cZm8CMaeLnVhfunknHQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56851f72749so120171a12.0
        for <linux-ide@vger.kernel.org>; Wed, 13 Mar 2024 15:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710367610; x=1710972410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euRtFSTUhVmhnZxiO/6tHfKYbzxwPzGW5Dtxe0N8J6U=;
        b=g408OyupqWWDhC5fadtucciLPLgfLxfZIseXiACWvmflwpNuvgjWn5a8HnlMHFEBeg
         uqbAH0Sz1xBvr/pOCOlUIzq0vN4nYcZBT/T8cyYBf5MHrQ5qZL/hk8EHthr3tpwCCbMk
         kAeXiNP3Vm+KVPo1xMKlUUGzHhR4hDV5/stNcDzWP8rTBZIopt9uFqJ27/PvpdPcbDmw
         EzhLyTEL6NpchQw1GEI6ZmKn9TL3UeCXG1cFyJf7XPqg3hzLLZDjPpYfG/t3rN891F+2
         IMz72RpFCQMvejKKxrmGKK3LJugmJ7+o1b9zPQ6Ih1GOsU9YMc3iKE9D9aJUs4Xurm6p
         snhA==
X-Gm-Message-State: AOJu0YzzmCA1vJnm1GlSlJRZDcg4ZFA/YpxdPrFyzxsfJckcD3oifUQT
	b32TmJV43AhW6o5zNr7l5aC4/4AZlrfZ/WC83oNUZRhmGcBlOr9Zp1ICL0mv+Y+4wj0Q+/trXMM
	2zTJlzuh+iz479GANN5DK9Lj4OQASh8EAcKOdLomsOfgs1A4bO2/wPiiFZawo1c8P8Ix7FbjPa5
	NVwVoQh2w5l49iM6RNUJYX67inXLTgrHejT5K4S0EZNg==
X-Received: by 2002:a50:bb29:0:b0:568:3362:ccdc with SMTP id y38-20020a50bb29000000b005683362ccdcmr3152559ede.16.1710367610268;
        Wed, 13 Mar 2024 15:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGieN1VorljanQZcYQgfoyll+3URJEZ2SfEhkgMK0qTOVapjEmHcBmywc0ixjYtXwfQ4nko1g==
X-Received: by 2002:a50:bb29:0:b0:568:3362:ccdc with SMTP id y38-20020a50bb29000000b005683362ccdcmr3152549ede.16.1710367609901;
        Wed, 13 Mar 2024 15:06:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a9-20020aa7cf09000000b0056671c5c1a1sm43033edy.80.2024.03.13.15.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 15:06:49 -0700 (PDT)
Message-ID: <cf0a0dbe-0df9-40c3-affd-ddf9b499d03d@redhat.com>
Date: Wed, 13 Mar 2024 23:06:48 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: asm1064: asm1166: don't limit reported ports
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, dlemoal@kernel.org, cryptearth@googlemail.com
References: <20240313214650.2165-1-conikost@gentoo.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240313214650.2165-1-conikost@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/13/24 10:46 PM, Conrad Kostecki wrote:
> Previously, patches have been added to limit the reported count of SATA
> ports for asm1064 and asm1166 SATA controllers, as those controllers do
> report more ports than physical having.
> 
> Unfortunately, this causes trouble for users, which are using SATA
> controllers, which provide more ports through SATA PMP
> (Port-MultiPlier) and are now not any more recognized.
> 
> This happens, as asm1064 and 1166 are handling SATA PMP transparently,
> so all non-physical ports needs to be enabled to use that feature.
> 
> This patch reverts both patches for asm1064 and asm1166, so old
> behavior is restored and SATA PMP will work again, so all physical and
> non-physical ports will work again.
> 
> Fixes: 0077a504e1a4 ("ahci: asm1166: correct count of reported ports")
> Fixes: 9815e3961754 ("ahci: asm1064: correct count of reported ports")
> Cc: stable@vger.kernel.org
> Reported-by: Matt <cryptearth@googlemail.com>
> Signed-off-by: Conrad Kostecki <conikost@gentoo.org>

Thank you for the quick patch, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans







> ---
>  drivers/ata/ahci.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 78570684ff68..562302e2e57c 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -669,19 +669,6 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
>  static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>  					 struct ahci_host_priv *hpriv)
>  {
> -	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
> -		switch (pdev->device) {
> -		case 0x1166:
> -			dev_info(&pdev->dev, "ASM1166 has only six ports\n");
> -			hpriv->saved_port_map = 0x3f;
> -			break;
> -		case 0x1064:
> -			dev_info(&pdev->dev, "ASM1064 has only four ports\n");
> -			hpriv->saved_port_map = 0xf;
> -			break;
> -		}
> -	}
> -
>  	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
>  		dev_info(&pdev->dev, "JMB361 has only one port\n");
>  		hpriv->saved_port_map = 1;

