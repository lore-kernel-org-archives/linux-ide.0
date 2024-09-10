Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B633C2F
	for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2024 04:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943816; cv=none; b=GPwB1m5xQ/EwCk4xoHu3WZdyXilN4JZDQ/fTV7iDJ23PTcuzR7Ajj46ZEnIV5F28gzjkVHc+Xac/LnbGPxq5zSVAsguusEExA8htBBc4fHQHdqNniF1SyBswFTuYRkKl4D/4+QXk9SY20KvBEraSyvCnkT+oisXM0sT/XodXE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943816; c=relaxed/simple;
	bh=HNkhCENF5Wt6jYupzI0UofhelB4+8l95Bsx6YouuRdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MViEwTyPlSbKCI5/C7VRG7j3+FchHOV1zRCQzVegbOSdrE229lWGfH38+/vQJQfWRvkSb2Fgi+5pih4OKU6As5mf/pDfU9yqn0lGXW3vXChApb8gJPoTZRRFZlkxTdYngib5x2CyEOczHMOpyKNwpp9KNMOY9DAv7s7HjWP3JJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRJuItwK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRJuItwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8A2C4CEC3;
	Tue, 10 Sep 2024 04:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725943816;
	bh=HNkhCENF5Wt6jYupzI0UofhelB4+8l95Bsx6YouuRdc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GRJuItwKL/DS7Pc9Caeh5ffDaUzPTIIu7hy8k5THrMJbBnCorFAGIy0EWLHWYy/BO
	 a7yZxNMJFGfCuSGTRUa/HDVBwvfVbVk4arbiB51HQsfVs7tbsTGch4Hn/5vXdlpaFy
	 R1eC6u96KllX6YOYHAtC9SQwYAiG4qb5Xoc82ZWxXevGDw7a9uuPzSp8OvlPo4iZCM
	 98iYaCdL0NI4sxmB/tdU4uQRvJ834isgzmOCWI4Mel7Hw7iVtzGTrm9aIzoVVJpoD4
	 +D70TPEKWc0PLoh26Gb/04ShtsTMMRXCgsEHXl0fFu+Tl1E9xIOhxD5mNITFg7rGYG
	 o33hKpLNGAWkg==
Message-ID: <87f85704-656d-4c08-b729-87c9b2e6d686@kernel.org>
Date: Tue, 10 Sep 2024 13:50:14 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ata_generic: use IS_ENABLED() macro
To: Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: lvc-project@linuxtesting.org
References: <d9c0acab-909e-da06-decf-be5de59d23bf@omp.ru>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <d9c0acab-909e-da06-decf-be5de59d23bf@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 5:51 AM, Sergey Shtylyov wrote:
> Replace now gone out of fashion defined(CONFIG_PATA_TOSHIBA[_MODULE])
> with the new-fangled IS_ENABLED() macro in the ata_generic[] definition.

Please mention that CONFIG_PATA_TOSHIBA_MODULE actually does not exist at all
and so can be removed.

> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the for-next branch of the LibATA Group's repo.
> 
>  drivers/ata/ata_generic.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux/drivers/ata/ata_generic.c
> ===================================================================
> --- linux.orig/drivers/ata/ata_generic.c
> +++ linux/drivers/ata/ata_generic.c
> @@ -220,7 +220,7 @@ static struct pci_device_id ata_generic[
>  	{ PCI_DEVICE(PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558), },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_CENATEK,PCI_DEVICE_ID_CENATEK_IDE),
>  	  .driver_data = ATA_GEN_FORCE_DMA },
> -#if !defined(CONFIG_PATA_TOSHIBA) && !defined(CONFIG_PATA_TOSHIBA_MODULE)
> +#if !IS_ENABLED(CONFIG_PATA_TOSHIBA)

I do not understand the negation here... It seems very wrong. If the driver is
indeed enabled, we need to add its PCI ID, no ? and the reverse when not defined...

>  	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1), },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2),  },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_3),  },
> 


-- 
Damien Le Moal
Western Digital Research
