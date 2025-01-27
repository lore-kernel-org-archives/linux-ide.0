Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773844A1D
	for <linux-ide@vger.kernel.org>; Mon, 27 Jan 2025 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737938219; cv=none; b=O09pg+mjsz5/ccoubhZpjJb0rn81P9qijmY0vHbYm1dfVLVr66rmXOqf1opv6gpB43VA2xYPl1e7uFIr7/STR7m6Tdjr7nE2+xevdm9MPF8btctrohS2209a93LVF05othpjpNz2ZOPVTXRNaglr+UQhjFvHZDZAAfHvRWjtGyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737938219; c=relaxed/simple;
	bh=rrr1GaJLZaEUQ2Hyx22x4ymhwLrGGx5DMMeS56+FJKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYH88HnZ2+OJEZjcAGLkrR8rs61KKqGFWZ5ArDbCFy2v7EOoMdQY3iKRu8Am0kLQ2E+ghqTY8ANrr7k4W1zbvjZIYV2+DZHngggj8l2op1a29/gsxnFPl0jutHff3TrYQhO7VHcAdkcoy5fq8XmXoRO8A+WPBBoX1hOTM9xF3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBSLdmZ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBSLdmZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD393C4CED3;
	Mon, 27 Jan 2025 00:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737938219;
	bh=rrr1GaJLZaEUQ2Hyx22x4ymhwLrGGx5DMMeS56+FJKo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UBSLdmZ2lxyH24kPMazcQk8jPc4icBPjNgT6YSGx48ruh5RHqc+iK5d8D9VHAliqO
	 Kkyr4fM5ocyO3D+9o2fo7LB8C2mDugJU0dU2zzVItNbfc8LAg/Tcl93BPUZHmH4HNo
	 OwA7WCnk7xGQPl5lJpdb2kzvwdco6lc8rWHQARB3A6u/6xMHh+pRQOQ6TEVLgQH6LU
	 j5EsiNYL1gtrImHKflIaCGiD70Guqr7pL9vLsmEH4BcpzIfdq/6NzrUDhjAUd2t5C3
	 cEMq8kxfPAeP7MWQSKt3mbrVb8PncwGJTD4E+IyUx/TFaCobzMPQmb5KYLBRaOj2ZR
	 XPGL/7d5EXKiQ==
Message-ID: <6569c283-afb7-4320-ad6a-7c4386dec8df@kernel.org>
Date: Mon, 27 Jan 2025 09:36:57 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: ahci: Add external_port_map module parameter
To: Niklas Cassel <cassel@kernel.org>
Cc: Christian Heusel <christian@heusel.eu>, linux-ide@vger.kernel.org
References: <20250116143630.1935474-4-cassel@kernel.org>
 <20250116143630.1935474-6-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250116143630.1935474-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/25 23:36, Niklas Cassel wrote:
> Commit ae1f3db006b7 ("ata: ahci: do not enable LPM on external ports")
> changed so that LPM is not enabled on external ports (hotplug-capable or
> eSATA ports).
> 
> This is because hotplug and LPM are mutually exclusive, see 7.3.1 Hot Plug
> Removal Detection and Power Management Interaction in AHCI 1.3.1.
> 
> This does require that firmware has set the appropate bits (HPCP or ESP)
> in PxCMD (which is a per port register in the AHCI controller).
> 
> If the firmware has failed to mark a port as hotplug-capable or eSATA in
> PxCMD, then there is currently not much the user can do.
> 
> If LPM is enabled on the port, hotplug insertions and removals will not be
> detected on that port.
> 
> In order to allow a user to fix up broken firmware, add a module parameter
> 'external_port_map' for the 'ahci' driver.

Maybe we should call the parameter "force_external_port_map" to make it clear
that this is a user forced setup ?

Otherwise looks good to me.

> 
> The external_port_map parameter accepts 2 different formats:
>  - external_port_map=<map>
>    This applies the same map to all AHCI controllers
>    present in the system. This format is convenient for small systems
>    that have only a single AHCI controller.
>  - external_port_map=<pci_dev>=<map>,<pci_dev>=map,...
>    This applies the specified maps only to the PCI device listed. The
>    <pci_dev> field is a regular PCI device ID (domain:bus:dev.func).
>    This ID can be seen following "ahci" in the kernel messages. E.g.
>    for "ahci 0000:01:00.0: 2/2 ports implemented (port mask 0x3)", the
>    <pci_dev> field is "0000:01:00.0".
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/ahci.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 92b08d3a0c3c..ec2bc5f17b96 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -676,6 +676,17 @@ MODULE_PARM_DESC(mask_port_map,
>  		 "where <pci_dev> is the PCI ID of an AHCI controller in the "
>  		 "form \"domain:bus:dev.func\"");
>  
> +static char *ahci_external_port_map;
> +module_param_named(external_port_map, ahci_external_port_map, charp, 0444);
> +MODULE_PARM_DESC(external_port_map,
> +		 "32-bits port map to force set one or more ports as external. "
> +		 "Valid values are: "
> +		 "\"<map>\" to apply the same map to all AHCI controller "
> +		 "devices, and \"<pci_dev>=<map>,<pci_dev>=<map>,...\" to "
> +		 "specify different maps for the controllers specified, "
> +		 "where <pci_dev> is the PCI ID of an AHCI controller in the "
> +		 "form \"domain:bus:dev.func\"");
> +
>  typedef void (*port_map_callback_t)(struct device *dev,
>  				    struct ahci_host_priv *hpriv, char *mask_s);
>  
> @@ -758,6 +769,34 @@ static void ahci_get_port_map_mask(struct device *dev,
>  				 ahci_apply_port_map_mask);
>  }
>  
> +static void ahci_apply_external_port_map(struct device *dev,
> +					 struct ahci_host_priv *hpriv,
> +					 char *mask_s)
> +{
> +	struct ata_host *host = dev_get_drvdata(dev);
> +	unsigned long port_map;
> +	unsigned int map;
> +	int i;
> +
> +	if (kstrtouint(mask_s, 0, &map)) {
> +		dev_err(dev, "Invalid external port map\n");
> +		return;
> +	}
> +
> +	port_map = map;
> +	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {
> +		if (i < host->n_ports)
> +			host->ports[i]->pflags |= ATA_PFLAG_EXTERNAL;
> +	}
> +}
> +
> +static void ahci_get_external_port_map(struct device *dev,
> +				       struct ahci_host_priv *hpriv)
> +{
> +	ahci_get_port_map_helper(dev, hpriv, ahci_external_port_map,
> +				 ahci_apply_external_port_map);
> +}
> +
>  static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>  					 struct ahci_host_priv *hpriv)
>  {
> @@ -2020,6 +2059,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (pi.flags & ATA_FLAG_EM)
>  		ahci_reset_em(host);
>  
> +	/* Handle external port map passed as module parameter. */
> +	if (ahci_external_port_map)
> +		ahci_get_external_port_map(&pdev->dev, hpriv);
> +
>  	for (i = 0; i < host->n_ports; i++) {
>  		struct ata_port *ap = host->ports[i];
>  


-- 
Damien Le Moal
Western Digital Research
