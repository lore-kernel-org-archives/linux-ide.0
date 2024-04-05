Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7443A15F338
	for <linux-ide@vger.kernel.org>; Fri,  5 Apr 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306650; cv=none; b=tmqlbQxdS7nC7Zbwg7E/Na1s3pUGTbXvJylL/AqRBXuPYaJhN/fhf2dlWjUwjawcYrTPTr0bNkvKgpAVRZ4KMg1eB0nHVeKQT+QREMpT+InS9JnwxZcJ1pQEBdGGfDDcSabsS51iIRiClF3P6sTSZ7UT1seT1pI1zcZ6djhLv5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306650; c=relaxed/simple;
	bh=HDLzGnBRCjHtOKUnFf5iQp8PFDYWY8EzC06MLZZW8F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lupKD3MPhAd/0IHKdKxEZVcHOpJAXvqsI4h65Atma324tOWHpC4pRA1xjjxpdOS+wJSXdEVl+rUavlrPk/1u5TSWiyUoPNXlZ5g/luymrjbuOS/vpBu2Q4/SiJxWA9KdDB4tgdyTTW6aRtFQH9/LlC/gd7mZi5LOdc0A5xl6fPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUe0HyxB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUe0HyxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D05CC433F1;
	Fri,  5 Apr 2024 08:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712306649;
	bh=HDLzGnBRCjHtOKUnFf5iQp8PFDYWY8EzC06MLZZW8F4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUe0HyxBoLFSNf59wSDQGDBsx9tgBNVUkXWi30s37EcvRSpqokV//ApzL53ieHQBe
	 wHRZEWW85NAUtKIQVZ03pPw1J7MJXN8QFbPKdfJQ/LbE5rVSLxIo/zF+2B9FtuoaPd
	 x+3Qv5+G/vV3cSoRqLYZEQy9DWIQsevlTUtQfJAqkmXinGh4DE+fn8heKPKTDqd1vb
	 8APsYh0sBKTGsy7OdQWh69KJKji7OqTtDLnZ2iRiHH2qOV0v2fX3xSPk0wP+emGOGB
	 LKhfGBJUgKJSeNSNFukc4mWnu11lXofEv0qpN5HtzlSDJ0VUisocBOCUWnOxCzHLrB
	 nXzDIIaOpc6iQ==
Date: Fri, 5 Apr 2024 10:44:04 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Conrad Kostecki <conikost@gentoo.org>,
	Szuying Chen <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
Subject: Re: [PATCH] ata: ahci: Add mask_port_map module parameter
Message-ID: <Zg+51NstivN/215M@x1-carbon>
References: <20240404095026.929491-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404095026.929491-1-dlemoal@kernel.org>

On Thu, Apr 04, 2024 at 06:50:26PM +0900, Damien Le Moal wrote:
> Commits 0077a504e1a4 ("ahci: asm1166: correct count of reported ports")
> and 9815e3961754 ("ahci: asm1064: correct count of reported ports")
> attempted to limit the ports of the ASM1166 and ASM1064 AHCI controllers
> to avoid long boot times caused by the fact that these adapters report
> a port map larger than the number of physical ports. The excess ports
> are "virtual" to hide port multiplier devices and probing these ports
> takes time. However, these commits caused a regression for user that do

s/user/users/


> use PMP devices, as the ATA devices connected to the PMP cannot be
> scanned. These commits have thus been reverted by commit 6cd8adc3e18
> ("ahci: asm1064: asm1166: don't limit reported ports") to allow the
> discovery of devices connected through a port multiplier. But this
> revert re-introduced the long boot times for users that do not use a
> port multiplier setup.
> 
> This patch adds the mask_port_map ahci module parameter to allow users
> to manually specify port map masks for controllers. In the case of the
> ASMedia 1166 and 1064 controllers, users that do not have port
> multiplier devices can mask the excess virtual ports exposed by the
> controller to speedup port scanning, thus reducing boot time.
> 
> The mask_port_map parameter accepts 2 different format:

s/format/formats/


>  - mask_port_map=<mask>
>    This applies the same mask to all AHCI controllers
>    present in the system. This format is convenient for small systems
>    that have only a single AHCI controller.
>  - mask_port_map=<dev name>=<mask>,<dev name>=mask,...

Perhaps replace "dev name" with "pci_dev" or "pci_bdf".


>    This applies the specified masks only to the device listed. The
>    device name correspond to the string following "ahci" in probe
>    kernel messages. E.g. for:
>    ahci 0000:01:00.0: 2/2 ports implemented (port mask 0x3)
>    the device name is "0000:01:00.0".
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/ahci.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 562302e2e57c..3bc8626f3ba9 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -666,6 +666,90 @@ static int mobile_lpm_policy = -1;
>  module_param(mobile_lpm_policy, int, 0644);
>  MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
>  
> +static char *ahci_mask_port_map;
> +module_param_named(mask_port_map, ahci_mask_port_map, charp, 0444);
> +MODULE_PARM_DESC(mask_port_map,
> +		 "Provide 32-bit port map masks to ignore controllers ports. "
> +		 "Valid values are: "

Looking at other MODULE_PARM_DESC, it appears that you can use \n in the string.
So perhaps "Valid values are:\n"


> +		 "<mask> to apply the same mask to all controller devices, "
> +		 "<dev0_name>=<mask0>,<dev1_name>=<mask1>,...' to specify a "

Perhaps add a \n after describing the first format.


> +		 "different mask per controller, where <dev_name> is the "
> +		 "controller host name as printed in the messages "

Perhaps replace "host name" with PCI device or PCI BDF.
Perhaps replace "dev_name" with pci_dev or pci_bdf.


> +		 "\"ahci xxxx:bus:dev.func: ...\"");

s/xxxx/domain/


> +
> +static void ahci_apply_port_map_mask(struct device *dev,
> +				     struct ahci_host_priv *hpriv, char *mask_s)
> +{
> +	unsigned int mask;
> +
> +	if (kstrtouint(mask_s, 0, &mask)) {
> +		dev_err(dev, "Invalid port map mask\n");
> +		return;
> +	}
> +
> +	if (mask) {
> +		dev_warn(dev, "Forcing port map mask 0x%x\n", mask);
> +		hpriv->mask_port_map = mask;

I think this should use saved_port_map instead of mask_port_map, see:
https://lore.kernel.org/linux-ide/uu2exwldqvbdjus6t4r3cxuto5jpeqtjfvc7qiikulfwiyntf3@j4btf2bt23ld/

""
1. saved_port_map defines the ports actually available on the host
controller.
2. mask_port_map masks out the unused ports if it's initialized,
otherwise all available ports will be initialized and utilized.
""

(We don't want to initialize them at all.)

Also, if you use saved_port_map, you don't need any print.
There will already be a print:
https://github.com/torvalds/linux/blob/v6.9-rc1/drivers/ata/libahci.c#L537


Also, see:
566d1827df2e ("libata: disable forced PORTS_IMPL for >= AHCI 1.3")

A mask of 0 is valid, so I don't think that you can do

if (mask)

Perhaps just:

     if (kstrtouint(mask_s, 0, &mask)) {
             dev_err(dev, "Invalid port map mask\n");
             return;
     }

     hpriv->saved_port_map = mask;


> +	}
> +}
> +
> +static void ahci_get_port_map_mask(struct device *dev,
> +				   struct ahci_host_priv *hpriv)
> +{
> +	char *param, *end, *str, *mask_s;
> +	char *name;
> +
> +	if (!strlen(ahci_mask_port_map))
> +		return;
> +
> +	str = kstrdup(ahci_mask_port_map, GFP_KERNEL);
> +	if (!str)
> +		return;
> +
> +	if (!strchr(str, '=')) {
> +		/* Single mask case */
> +		ahci_apply_port_map_mask(dev, hpriv, str);
> +		goto free;
> +	}
> +
> +	/*
> +	 * Mask list case: parse the parameter to apply the mask only if
> +	 * the device name matches.
> +	 */
> +	param = str;
> +	end = param + strlen(param);
> +	while (param && param < end && *param) {
> +		name = param;
> +		param = strchr(name, '=');
> +		if (!param)
> +			break;
> +
> +		*param = '\0';
> +		param++;
> +		if (param >= end)
> +			break;
> +
> +		if (strcmp(dev_name(dev), name) != 0) {
> +			param = strchr(param, ',');
> +			if (param)
> +				param++;
> +			continue;
> +		}
> +
> +		mask_s = param;
> +		param = strchr(mask_s, ',');
> +		if (param) {
> +			*param = '\0';
> +			param++;
> +		}
> +
> +		ahci_apply_port_map_mask(dev, hpriv, mask_s);
> +	}
> +
> +free:
> +	kfree(str);
> +}
> +
>  static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>  					 struct ahci_host_priv *hpriv)
>  {
> @@ -688,6 +772,10 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>  			  "Disabling your PATA port. Use the boot option 'ahci.marvell_enable=0' to avoid this.\n");
>  	}
>  
> +	/* Handle port map masks passed as module parameter. */
> +	if (ahci_mask_port_map)
> +		ahci_get_port_map_mask(&pdev->dev, hpriv);
> +
>  	ahci_save_initial_config(&pdev->dev, hpriv);
>  }
>  
> -- 
> 2.44.0
> 
