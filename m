Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB1E252292
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 02:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764642521; cv=none; b=AQu+NN4HcVv4m7YX9xllYAarJkRnYCPdgryfn5dW6z50WnfokZKtiKwU9yoYwQ5ZlvUv4ZTE2NJu3ShvbAncEEpRVOSURuLXN/enwT/1pBplViLfoOHtfiIfRX9fuMgQ8ImHzd//bnWYgAADfKQ5bSeI1BpM7Dh0i7PXYUzOaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764642521; c=relaxed/simple;
	bh=AJlaLjgbtW/Kl0GnW1F9AAGghB5BXd/q9MAjILFQ0vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5a8qbagzPBIkzLLaWyo/UFpHBGiV/bZE8Drscf8r24DlDWGCgXTCk85DGaD+Yjkb/S6SST39RpDbU4yx0leQUtBVPKiiZQaZLYBrhkuGgxCZylfEni2YlqkbFO9Bp5RoWEL/5H1j24UGLSqqe5MY/Osse1OvzGiysx33bo/nS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfIg+AUx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfIg+AUx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1795C4CEF1;
	Tue,  2 Dec 2025 02:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764642520;
	bh=AJlaLjgbtW/Kl0GnW1F9AAGghB5BXd/q9MAjILFQ0vo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FfIg+AUxruCflJZ8t5iYtbUz9+9KHdRB8/vvXSayMjHc9sAAI/miJrvT+MwVX+A6j
	 x3ybhKX/5cH/HObU0QLPhl4dJM6HzXveSJhMcr5D1WWYyd9d54sM7Q0bazN2VGjv0w
	 L1+R43nT9yW8NGeddDuLOV1Ai0skx3We/XAIydXW51JFwouxsFAYfEhBBpcuviyVhT
	 Oa/59rKSPpuMCPRP2fr6qVLahhbv0NnlwHU0AGVTWD9QNsEo+9H26Bue2oqIxm7+f8
	 FucQtVKZtDZqtg8qA4SyvNY3DdKS6a5idwmtY7wiRnygADLVFayrDArCzbUKTcL1g2
	 4A1e1k4QTbsPw==
Message-ID: <2accc2a3-e88b-46f7-bcf7-b9f5cb631640@kernel.org>
Date: Tue, 2 Dec 2025 11:28:38 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] ata: libata: Add ata_force_get_fe_for_dev() helper
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, xxjack12xx@gmail.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20251201123501.246282-10-cassel@kernel.org>
 <20251201123501.246282-14-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251201123501.246282-14-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 21:35, Niklas Cassel wrote:
> Add ata_force_get_fe_for_dev() helper to get the struct ata_force_ent for
> a struct ata_device.
> 
> Use the helper in ata_force_quirks().
> The helper will also be used in follow up commits.
> 
> No functional change intended.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

A few nits below. With these addressed, feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> -/**
> - *	ata_force_quirks - force quirks according to libata.force
> - *	@dev: ATA device of interest
> - *
> - *	Force quirks according to libata.force and whine about it.
> - *	For consistency with link selection, device number 15 selects
> - *	the first device connected to the host link.
> - *
> - *	LOCKING:
> - *	EH context.
> - */
> -static void ata_force_quirks(struct ata_device *dev)
> +static const struct ata_force_ent
> +*ata_force_get_fe_for_dev(struct ata_device *dev)

The "*" should be on the previous line as it is part of the type definition for
the return value.

>  {
>  	int devno = dev->link->pmp + dev->devno;
>  	int alt_devno = devno;
>  	int i;
> +	const struct ata_force_ent *fe;

Nit: move this as the first declaration so that there is not a long declaration
line after a short one. Yes, this is 100% visual only, not a bug :)

>  
>  	/* allow n.15/16 for devices attached to host port */
>  	if (ata_is_host_link(dev->link))
>  		alt_devno += 15;
>  
>  	for (i = 0; i < ata_force_tbl_size; i++) {
> -		const struct ata_force_ent *fe = &ata_force_tbl[i];
> +		fe = &ata_force_tbl[i];
>  

Maybe drop the blank line here ?

>  		if (fe->port != -1 && fe->port != dev->link->ap->print_id)
>  			continue;



-- 
Damien Le Moal
Western Digital Research
