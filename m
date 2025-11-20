Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6341CEADB
	for <linux-ide@vger.kernel.org>; Thu, 20 Nov 2025 03:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609726; cv=none; b=AugACuXSZzpr/gDlhgUuiJsv3/+T7+dXdJ/c2HMGA0fPk+JcKKFFk4tmc9LIMdm5eL3mEFe+uPmXqZcJpsYYAcR/38wyIOswCS9u6NVeC/2hmRWt+g1+VV7R3yf22uKvZrnUdDpWpNaTlM20M57WHNe9ffE4Wdu/dj3Re6MXey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609726; c=relaxed/simple;
	bh=fsEPAcR+TvIqnJ04RTgfcvsHv9OzVT1L4kquN2t/9yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFvOYBW+QQqQkj7spzJLdRjJUZZEmdY2i5dko8khjzlZedRg2U03481gES6FGHySdTUBuslbIbZbc5ht/0IsUY39BuerNNMTX3N9ZtmWKJi4XCva3iZEtNBrkcuODDJWa62DB0Ld2mSVePid5bB2G58S49ICCvJY/XdeluFYhnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLvllXES; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLvllXES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D30C113D0;
	Thu, 20 Nov 2025 03:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763609725;
	bh=fsEPAcR+TvIqnJ04RTgfcvsHv9OzVT1L4kquN2t/9yM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nLvllXESErKuntVK1ZutVkRt33/K8VmkJ5tI3jPNs0z/RQqy60myvJP1zPcYcsDdS
	 RyhPB4liboiC1aIVKzzzyJsa/CQMm5BCjIdBSdHaad5QkGfUnM7BsqHEEsUo7p7Ckj
	 AYXaIReJr/pzEbKW6ejxbjCeJSrpgcuqHUY0pPS+109krEcVDkyLgKtprj1qjghhRm
	 PD2IbEfV9TezBbZLGw0NrHemIdHdH+Nkp2gT6ZjGc4LCypLQTJH7Ro2f3kU2vir+t/
	 VzJyqfhVDJ31zPhFP7pOiCiQOt27LOLgHCep7IXS183QOqsKC7ARHbjZjoRY4hE9eZ
	 9R/A5EYFfeHGA==
Message-ID: <8a361a94-eaf5-4ebb-9c77-9cbc25b82cc3@kernel.org>
Date: Thu, 20 Nov 2025 12:31:19 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: libata-core: Set capacity to zero for a security
 locked drive
To: Niklas Cassel <cassel@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Ilia Baryshnikov <qwelias@gmail.com>, linux-ide@vger.kernel.org
References: <20251119141313.2220084-3-cassel@kernel.org>
 <20251119141313.2220084-4-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251119141313.2220084-4-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 11:13 PM, Niklas Cassel wrote:
> For Security locked drives (drives that have Security enabled, and have
> not been Security unlocked by boot firmware), the automatic partition
> scanning will result in the user being spammed with errors such as:
> 
>   ata5.00: failed command: READ DMA
>   ata5.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 7 dma 4096 in
>            res 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
>   ata5.00: status: { DRDY ERR }
>   ata5.00: error: { ABRT }
>   sd 4:0:0:0: [sda] tag#7 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>   sd 4:0:0:0: [sda] tag#7 Sense Key : Aborted Command [current]
>   sd 4:0:0:0: [sda] tag#7 Add. Sense: No additional sense information
> 
> during boot, because most commands except for IDENTIFY will be aborted by
> a Security locked drive.
> 
> For a Security locked drive, set capacity to zero, so that no automatic
> partition scanning will happen.
> 
> If the user later unlocks the drive using e.g. hdparm, the close() by the
> user space application should trigger a revalidation of the drive.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
