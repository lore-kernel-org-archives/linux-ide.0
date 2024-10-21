Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D5913FFC
	for <linux-ide@vger.kernel.org>; Mon, 21 Oct 2024 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729471716; cv=none; b=Q1k/YzmNgmUaYJcU/hz41hjayke1KEROJb0rs1x7DUV9q4qu04K1YygYEUlF8RwVLhQqoDKV1/1YJJYns/s+IgNgnJMHZiLqx1iHKA77W4XnX4RjLMZ/AQ+SfvEe7TAvDVjYU0wdZSsEoOhUKzIPpbQzrKJlQ57QUkPPH8dQ99w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729471716; c=relaxed/simple;
	bh=K/TJJKjKQkv3ba3bvDmC17cnz+rzsya6pw0aZIlmAX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QQYhZaL3UeLs7hRl01jcA+rquAHjk/dcVWo4B5+XTgO1a4ToLKYmjqXt5Apg+g+iPN/NVcw8MVqMfDikzVgePrmz7EL43q+mnV7DQn1SM/oD6ccSNERVhZOWX6rtsakaakG5MIN0aLhaNA++bxXK+px5gRzp4U8c7vERkh8I8DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVoC9GmA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVoC9GmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73538C4CEC7;
	Mon, 21 Oct 2024 00:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729471716;
	bh=K/TJJKjKQkv3ba3bvDmC17cnz+rzsya6pw0aZIlmAX0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=EVoC9GmAbXDLutk9TUp16l7gjMyq+MuFiMGLqs49qdwM6Y7qDXb68+7eKa5jOi6O/
	 5f7xHnGtI8aGh9RBco+ercdyGdn6LxSSK1CGbYMW24EbCE4lZnAWUyU2Vd3u56QQ6K
	 8HFu8qGZNrgxzEJT7/Dmc7H67WtOAdJqxkNSagV34jt1fo8UoKLYVoInC9A1iqf8+9
	 B5UYFqdLauL8oW0wBO5Ryib1NGBBEJL/H+hZxAqzzhLrnbuy/eDOlUhWAqVJeVrEW3
	 NhCtZ2wYDF49prjbHw1TdvxupslsYGgbsIC2+TISjTWy6KuD4zR/bMTdeXLXAl5Lb1
	 mBGIB54bzZRUg==
Message-ID: <23f2e1d5-eec0-4886-8fcb-760ed81c672a@kernel.org>
Date: Mon, 21 Oct 2024 09:48:33 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ata: ata_generic: add comment about Toshiba
 Piccolo
To: Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <c1b91a7a-74a9-46bf-914a-b8dfc669849e@omp.ru>
 <7d8a58b7-dbc9-474c-8996-6218aa89d0be@omp.ru>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <7d8a58b7-dbc9-474c-8996-6218aa89d0be@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 01:49, Sergey Shtylyov wrote:
> Before the dedicated Toshiba Piccolo driver was written by Alan Cox,
> these chips were handled by the generic driver; in case the dedicated
> driver isn't enabled, the generic driver keeps claiming these chips --
> add a comment clarifying that...

Nice. But this really does not need to be a separate patch. Please squash 1/2
and 2/2 together.

> 
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> Changes in version 2:
> - new patch.
> 
>  drivers/ata/ata_generic.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
> index 2f57ec00ab82..d6c210510c36 100644
> --- a/drivers/ata/ata_generic.c
> +++ b/drivers/ata/ata_generic.c
> @@ -220,6 +220,11 @@ static struct pci_device_id ata_generic[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558), },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_CENATEK,PCI_DEVICE_ID_CENATEK_IDE),
>  	  .driver_data = ATA_GEN_FORCE_DMA },
> +	/*
> +	 * Before the dedicated Toshiba Piccolo driver was written,
> +	 * these chips were handled by the generic driver; keep the
> +	 * old behavior if the dedicated driver is not enabled...
> +	 */
>  #if !defined(CONFIG_PATA_TOSHIBA) && !defined(CONFIG_PATA_TOSHIBA_MODULE)
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1), },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2),  },


-- 
Damien Le Moal
Western Digital Research
