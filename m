Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E160161B43
	for <linux-ide@vger.kernel.org>; Fri,  5 Apr 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319852; cv=none; b=KLvVskakcTV70qo0jm53Kj4h9X4K8oiy5p7EZz48DRfDx5qg7wZ029ZepoTyOWQZKN7strsxdr/1bvnVeN2gLR4ANliX4EfBIX7rVra3nqulaU3gZhNh09QmVonr9RNu6ZmjB8qm+TNV7g+rhq/i9VE4fEFO2MgCpJJEQeW+EkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319852; c=relaxed/simple;
	bh=FEwVdsil0gLkn1bNWIZW/CMErvuJXQVhepcYuPhWVh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vj0oeMnQ7yNr8V/0qR4ofF7tVX4aqQN0WN2nx+TYjet5LRm39bd3vs5RGX48np+rxCSqfrn0TnIGCgvmh8ks80aIUsuzs1jQ3dPhsyf627nUq/as1YuqOKD0Wos4qZ4N6mc2bktn7h3HixgydCLxI0lmqSrcdVgdJn0dXiXJ9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwjSKMfA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwjSKMfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FCEC433F1;
	Fri,  5 Apr 2024 12:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712319852;
	bh=FEwVdsil0gLkn1bNWIZW/CMErvuJXQVhepcYuPhWVh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SwjSKMfAUT8tEWzcFMHBuLuzqFgfYRf0Kk/WpgLwWcjllvqY2OwHZxl4ccyzMsg/L
	 jAN02DVlNH91tZNI5biGIY+FelsHrKUkz0qZYtorL+ZOSDSbPWh6mc035LfI5SRJYc
	 ErHo/csz9KEbHkOHWWbSA2HEThJBCYPYSv3GxjiNS/my5edy7vJTlPpURqKKt+NkDW
	 G7yD96dFd42zzMhIRO90bhIQYrqc9ZqKLR8WgK/5GciNXTTD4PH7i9PPdqgCslL2dj
	 RmaaQZr3gU9kPlF6xriQIjmxpRiglJbtfUcAMWPTfvXqkJpoPYzsaV+uWM7aZkyyet
	 v+M89BdkFHA3g==
Message-ID: <9e016f41-8df3-458d-91df-f3795d3a4628@kernel.org>
Date: Fri, 5 Apr 2024 21:24:09 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: Add mask_port_map module parameter
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Conrad Kostecki <conikost@gentoo.org>,
 Szuying Chen <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
 Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
References: <20240404095026.929491-1-dlemoal@kernel.org>
 <Zg+51NstivN/215M@x1-carbon>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Zg+51NstivN/215M@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/24 17:44, Niklas Cassel wrote:
>> +static char *ahci_mask_port_map;
>> +module_param_named(mask_port_map, ahci_mask_port_map, charp, 0444);
>> +MODULE_PARM_DESC(mask_port_map,
>> +		 "Provide 32-bit port map masks to ignore controllers ports. "
>> +		 "Valid values are: "
> 
> Looking at other MODULE_PARM_DESC, it appears that you can use \n in the string.
> So perhaps "Valid values are:\n"
> 
> 
>> +		 "<mask> to apply the same mask to all controller devices, "
>> +		 "<dev0_name>=<mask0>,<dev1_name>=<mask1>,...' to specify a "
> 
> Perhaps add a \n after describing the first format.

Yes, I saw that in many places the description string is split using "\n".
However, with that, the print of the parameter description with "modinfo ahci"
is rather weird, with the parameter type (charp) ending up on its own line. I
did not like it so I did not add any "\n".

>> +static void ahci_apply_port_map_mask(struct device *dev,
>> +				     struct ahci_host_priv *hpriv, char *mask_s)
>> +{
>> +	unsigned int mask;
>> +
>> +	if (kstrtouint(mask_s, 0, &mask)) {
>> +		dev_err(dev, "Invalid port map mask\n");
>> +		return;
>> +	}
>> +
>> +	if (mask) {
>> +		dev_warn(dev, "Forcing port map mask 0x%x\n", mask);
>> +		hpriv->mask_port_map = mask;
> 
> I think this should use saved_port_map instead of mask_port_map, see:
> https://lore.kernel.org/linux-ide/uu2exwldqvbdjus6t4r3cxuto5jpeqtjfvc7qiikulfwiyntf3@j4btf2bt23ld/
> 
> ""
> 1. saved_port_map defines the ports actually available on the host
> controller.
> 2. mask_port_map masks out the unused ports if it's initialized,
> otherwise all available ports will be initialized and utilized.
> "">
> (We don't want to initialize them at all.)

Correct, and they do not. The masked ports are using the dummy ops. So it works
exactly as intended. This module argument defines a *mask* for a port map, not
the port map to use.
> Also, if you use saved_port_map, you don't need any print.
> There will already be a print:
> https://github.com/torvalds/linux/blob/v6.9-rc1/drivers/ata/libahci.c#L537

Hmm... Checking the code in ahci_save_initial_config(), we have:

	/* Override the HBA ports mapping if the platform needs it */
	port_map = readl(mmio + HOST_PORTS_IMPL);
	if (hpriv->saved_port_map && port_map != hpriv->saved_port_map) {
		dev_info(dev, "forcing port_map 0x%lx -> 0x%x\n",
			 port_map, hpriv->saved_port_map);
		port_map = hpriv->saved_port_map;
	} else {
		hpriv->saved_port_map = port_map;
	}

	if (hpriv->mask_port_map) {
		dev_warn(dev, "masking port_map 0x%lx -> 0x%lx\n",
			port_map,
			port_map & hpriv->mask_port_map);
		port_map &= hpriv->mask_port_map;
	}

So by setting the mask_port_map, we *always* mask the port map, be it a forced
one defined by saved_port_map, or the hardware reported one.

The patch results in this:

modrpobe ahci mask_port_map=0000:00:17.0=0x1
dmesg | grep ahci
...
ahci 0000:00:17.0: Forcing port map mask 0x1
ahci 0000:00:17.0: masking port_map 0xff -> 0x1
ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
ahci 0000:00:17.0: (0000:00:17.0) 1/8 ports implemented (port mask 0x1)

So I could remove the message I added I guess...

I prefer that this module parameter defines a mask rather than a map as it is
more general: it can be used for testing to override saved_port_map or masks
already set for some controllers.

> A mask of 0 is valid, so I don't think that you can do

A mask of 0 would mean "no ports". So better off completely ignoring the
controller for that case :) So no, I do not want that value to be valid.

> 
> if (mask)
> 
> Perhaps just:
> 
>      if (kstrtouint(mask_s, 0, &mask)) {
>              dev_err(dev, "Invalid port map mask\n");
>              return;
>      }
> 
>      hpriv->saved_port_map = mask;

See above. That is not necessarily better.

-- 
Damien Le Moal
Western Digital Research

