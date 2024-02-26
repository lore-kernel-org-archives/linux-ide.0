Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA72D51C3E
	for <linux-ide@vger.kernel.org>; Mon, 26 Feb 2024 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941433; cv=none; b=pznyEKjl+lEFMQSEWv26DNGOq4rEb8dL0olpoP3zrRMe2YdSU9TfNNY5k+L0LXsMlaveWIUgjRHsCQTGmFPW6/yQwuOzVkBZQsVXDeEo3336xnO7Ws9F4xkkIMxHV1p9fYOqGJMnB4Pt4adIdNQoGPEIIgVLHoeCK0FqDzR83P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941433; c=relaxed/simple;
	bh=eRFVMHeViUfxHSJKXQN+WHYi8u7pihuJx5uvR4blc2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjSzmFICFxNDw5XODo+QuKjWVs/fwSDMXu9YVJ7zB2ggg6v2O3NPOHjWGKtOCVGF7crA234E5tLdV4InkYL+AfFlnHFJP6XjjqaUNvkv4mJ3Xvot3W2heSMZcrKB+OTw/t+ZhslRTvd/5YGwxce44oCy232CIFw6Ktfdnj1FFok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9DZIt8x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9DZIt8x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F099BC433C7;
	Mon, 26 Feb 2024 09:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708941433;
	bh=eRFVMHeViUfxHSJKXQN+WHYi8u7pihuJx5uvR4blc2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r9DZIt8xpz/qOsE3V5FIzG1cBD88A2Opbz+dwdjB5M6NTkx4hYh1ZC0/4zTNXWhF+
	 UMMo62ugZPbkxyTDduovrMNaaU7Z3jlSv8Rkb6KmIOcF2mmHKYw0IBWhYqsOJmeHA/
	 FUgLEQ11zjirsce2yDgFe3dOn75lSYJ3tW5N76MQqkOs08bt94LkQJTcM//s6CIGkZ
	 cCirt8Z92yppuoe0tMah/8B1kwkps6j4EH4nQv2eJKaxkpKWs7TeWCUhE08BuwUwNg
	 HbRWQGqP4r/ililfbIg3s+m68Jq9qZ6nARiVufwXpUk20/z9ymJmbERYVdLhPvBkTX
	 FlGeRwrFaZGrQ==
Date: Mon, 26 Feb 2024 10:57:08 +0100
From: Niklas Cassel <cassel@kernel.org>
To: "Andrey Jr. Melnikov" <temnota.am@gmail.com>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: stop using saved_port_map for quircks
Message-ID: <ZdxgdOTtoqNF2ch7@fedora>
References: <bc76towgdmpv3xilmhlerrshpubrd7feecl2tu6xanwtbkv3ze@zwizzrmcu43w>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc76towgdmpv3xilmhlerrshpubrd7feecl2tu6xanwtbkv3ze@zwizzrmcu43w>

Hello Andrey,

On Sun, Feb 25, 2024 at 12:55:42PM +0300, Andrey Jr. Melnikov wrote:
> 
> Stop using saved_port_map for masking port quirks, use force_port_map
> instead.
> 
> Signed-off-by: Andrey Jr. Melnikov <temnota.am@gmail.com>
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 682ff550ccfb..066e3118801c 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -675,18 +675,18 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>  		switch (pdev->device) {
>  		case 0x1166:
>  			dev_info(&pdev->dev, "ASM1166 has only six ports\n");
> -			hpriv->saved_port_map = 0x3f;
> +			hpriv->mask_port_map = 0x3f;
>  			break;
>  		case 0x1064:
>  			dev_info(&pdev->dev, "ASM1064 has only four ports\n");
> -			hpriv->saved_port_map = 0xf;
> +			hpriv->mask_port_map = 0xf;
>  			break;
>  		}
>  	}
>  
>  	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
>  		dev_info(&pdev->dev, "JMB361 has only one port\n");
> -		hpriv->saved_port_map = 1;
> +		hpriv->mask_port_map = 1;
>  	}
>  
>  	/*
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 1a63200ea437..cc705d3bdc50 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -531,16 +531,10 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>  		cap &= ~HOST_CAP_SXS;
>  	}
>  
> -	/* Override the HBA ports mapping if the platform needs it */
>  	port_map = readl(mmio + HOST_PORTS_IMPL);
> -	if (hpriv->saved_port_map && port_map != hpriv->saved_port_map) {
> -		dev_info(dev, "forcing port_map 0x%lx -> 0x%x\n",
> -			 port_map, hpriv->saved_port_map);
> -		port_map = hpriv->saved_port_map;
> -	} else {
> -		hpriv->saved_port_map = port_map;
> -	}
> +	hpriv->saved_port_map = port_map;
>  
> +	/* Override the HBA ports mapping if the platform needs it */
>  	if (hpriv->mask_port_map) {
>  		dev_warn(dev, "masking port_map 0x%lx -> 0x%lx\n",
>  			port_map,
>  

Before this patch, if there was a quirk, e.g. saved_port_map was set in
ahci_pci_save_initial_config():

then in ahci_save_initial_config(),
we would not store/overwrite saved_port_map with readl(HOST_PORTS_IMPL).

After this patch, saved_port_map will contain ports that might
have been "disabled" by a quirk.


Have you verified that this logical change is okay in all the
places where saved_port_map is used?

E.g.
drivers/ata/ahci_dwc.c:ahci_dwc_check_cap() seems to iterate over:
unsigned long port_map = hpriv->saved_port_map | hpriv->mask_port_map;

which would be different before and after this patch.

Serge, any comment?



Also ahci_platform_get_firmware() seems to set
saved_port_map based of device tree property "ports-implemented".

Before this patch, saved_port map would still contain that value from
device tree, after this patch, that saved_port_map will be overwritten
with readl(HOST_PORTS_IMPL).

Again, this code is authored by Serge. Serge, comments?


Kind regards,
Niklas
