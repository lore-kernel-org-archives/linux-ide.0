Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0676FA5
	for <linux-ide@vger.kernel.org>; Fri,  2 Feb 2024 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706838886; cv=none; b=T0evbz8wWoE4sn7Vyt/963sGp1yrLQ5Kf6iQi9ry2frroT2k/2KFk1OQuRXs6DnU+Pb1bF/t+zDx9hs0J4P+4SFmtUQdmE2muDIHv4Dh4gpmCbb4EVWgNxDRzo0wJi/Uej+4SyLSI+5QVmtPBpRPBwGSgvWfw5ySfqBjUlSLvUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706838886; c=relaxed/simple;
	bh=BzkScVfwmc6dPo7egoNYhuoG9EADHREgqmfIdb9UTqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gg3H0ggDj0dlzDdmv/W6MSuCrHcPekAP5NoZP5GM5lxgzWSURK8HH9tOFo+MyOY/cvyqzdFnQoh+KRrvoiqaoPHIuoqMMne8QQSncjD6zNcjaMgqSo2MNN7Wc45XrscdMK9IZb6hT/G8vrK+7dBQXKvKS1nb/meU1mXmkVnnZRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixAl1liH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixAl1liH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F27C433F1;
	Fri,  2 Feb 2024 01:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706838886;
	bh=BzkScVfwmc6dPo7egoNYhuoG9EADHREgqmfIdb9UTqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ixAl1liHDBQZu0EXukByG4xTDYPhxnxN1OK6IttBHTYl8TGnnMKA6SVa6j4V7YhjP
	 y2i/mVYIMi99w8ktT/xrqbPYsbTXp1IRuHbteQs6+ZyNwnJiAlXGwTmKMTa+7MMeUB
	 QQpLgzZY25/7rF5rNRyvaRttOlEG2dsBDhV72OyjBuuUm8eXZOmSVqfHEwdkgpxhia
	 qQkboK8SLsXX3qacRjK7G8eLQsbJogX1TAq2KhTIHFfxm6GOQaiK9NYnQUsWIH+G3p
	 iUhPvt3FGH/36GgmJOf2Mbhci8XRNEwck5jau3lAjjtGizovENPDUDFEWpG4bg37Bk
	 TXRMbGKzxESoA==
Message-ID: <0f68e5d3-9768-4489-9bc1-60c834390504@kernel.org>
Date: Fri, 2 Feb 2024 10:54:43 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] ata: ahci: a hotplug capable port is an external port
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>, Daniel Drake <drake@endlessos.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jian-Hong Pan <jhp@endlessos.org>, Dieter Mummenschanz
 <dmummenschanz@web.de>, linux-ide@vger.kernel.org
References: <20240201161507.1147521-1-cassel@kernel.org>
 <20240201161507.1147521-3-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240201161507.1147521-3-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 01:14, Niklas Cassel wrote:
> A hotplug capable port is an external port, so mark it as such.
> 
> We even say this ourselves in libata-scsi.c:
> /* set scsi removable (RMB) bit per ata bit, or if the
>  * AHCI port says it's external (Hotplug-capable, eSATA).
>  */
> 
> This also matches the terminology used in AHCI 1.3.1
> (the keyword to search for is "externally accessible").
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/ahci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 157ab88bdf75..8c8403bae36f 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1649,7 +1649,8 @@ static void ahci_mark_external_port(struct ata_port *ap)
>  	u32 tmp;
>  
>  	tmp = readl(port_mmio + PORT_CMD);
> -	if ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS))
> +	if (((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)) ||
> +	    (tmp & PORT_CMD_HPCP))
>  		ap->pflags |= ATA_PFLAG_EXTERNAL;
>  }
>  
> @@ -1945,7 +1946,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		if (ap->flags & ATA_FLAG_EM)
>  			ap->em_message_type = hpriv->em_msg_type;
>  
> -		/* mark esata ports */
> +		/* mark external ports (hotplug-capable, eSATA) */

OK. So you fix the comment here... Maybe move that comment inside
ahci_mark_external_port() to make it clear which port are considered "external"
and remove the comment here ?

Otherwise, looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

>  		ahci_mark_external_port(ap);
>  
>  		ahci_update_initial_lpm_policy(ap, hpriv);

-- 
Damien Le Moal
Western Digital Research

