Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C790405F7;
	Fri,  4 Apr 2025 03:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743738922; cv=none; b=cP9q57+9l5cGEuAOZZe+9qJ0OkaW1Q1O0m41WPBUBS+f0iZJwEOQiV4MhqEy1Cx3nK6yotJS4YmFBONqnr0FFXv6SllXbXjQsFvpOSbht6jOzpvR+flsPHTipd7sXyjdYGT1GjqAE/kb2ON8WqbsBNyGZYZ9X4r3nGgVsELD3iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743738922; c=relaxed/simple;
	bh=nfrVIDcX82RBIgB6YujF5Ina9PlmqR0UkrDESoRx/38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYKolDXY+jIhVpluhcjEmL6qJj9OIleSmUTx134h68ToKJe2oxL2nHaUNjX2UcxDfr8LkwmdQxeApoXMga7t+unpqGwIfa3radH12mXnOqgkhVpIrkpyRNOsp5Xqv920oNpW4fv3GPHALHHK2+RX06MEzsIAuzZPapba9XWgSC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAolNBww; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAolNBww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AA3C4CEDD;
	Fri,  4 Apr 2025 03:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743738920;
	bh=nfrVIDcX82RBIgB6YujF5Ina9PlmqR0UkrDESoRx/38=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lAolNBwwQzHEihA6y/2uejPCga+LLvaa9Pj/hHExCZ0z8kkMfauFTsCPvADBNkISG
	 ZE//FueLAF/834ZoLsKNEZ7pycg0OXGTKloKHxCal+4mhbwUsY6whpY860i7GuV+LK
	 NCd3y73iKgudx83HG4x4q215yxghwOpu//aRnBUO3S9VMXES0UhFkpEU8+nPWdeYx6
	 nZRVtaITM6oHxWRHfBdzlfJ5X+fyaeaYw4U8mwUZ7JUyJw6/D/THioIoo3GhR6F+5h
	 KqQaBomIjMkZRuj/o8WwSJZVE7a7eVwCtAZipgqdtkY/sHgvHGNZjAvFjUuQ5IztrZ
	 kSfBnbWjJMk9A==
Message-ID: <6eef4b75-2a2c-42f2-a35e-558260143dba@kernel.org>
Date: Fri, 4 Apr 2025 12:54:36 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libata: Add error handling for pdc20621_i2c_read().
To: Wentao Liang <vulab@iscas.ac.cn>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250403103957.2550-1-vulab@iscas.ac.cn>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250403103957.2550-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/25 7:39 PM, Wentao Liang wrote:
> The pdc20621_prog_dimm0() calls the pdc20621_i2c_read(), but does not

The function pdc20621_prog_dimm0() calls the function pdc20621_i2c_read() but
does...


> handle the error if the read fails. This could lead to process with
> invalid data. A proper inplementation can be found in

s/inplementation/implementation

> pdc20621_prog_dimm_global(). As mentioned in its commit:
> bb44e154e25125bef31fa956785e90fccd24610b, the variable spd0 might be
> used uninitialized when pdc20621_i2c_read() fails.
> 
> Add error handling to the pdc20621_i2c_read(). If a read operation fails,
> an error message is logged via dev_err(), and return an under-zero value
> to represent error situlation.

and return a negative error code.

> 
> Add error handling to pdc20621_prog_dimm0() in pdc20621_dimm_init(), and
> return a none-zero value when pdc20621_prog_dimm0() fails.

return a negative error code if pdc20621_prog_dimm0() fails.

> 
> Fixes: 4447d3515616 ("libata: convert the remaining SATA drivers to new init model")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/ata/sata_sx4.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
> index a482741eb181..a4027eb2fb66 100644
> --- a/drivers/ata/sata_sx4.c
> +++ b/drivers/ata/sata_sx4.c
> @@ -1117,9 +1117,14 @@ static int pdc20621_prog_dimm0(struct ata_host *host)
>  	mmio += PDC_CHIP0_OFS;
>  
>  	for (i = 0; i < ARRAY_SIZE(pdc_i2c_read_data); i++)
> -		pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
> -				  pdc_i2c_read_data[i].reg,
> -				  &spd0[pdc_i2c_read_data[i].ofs]);
> +		if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
> +				       pdc_i2c_read_data[i].reg,
> +				       &spd0[pdc_i2c_read_data[i].ofs])){
> +			dev_err(host->dev,
> +				"Failed in i2c read at index %d: device=%#x, reg=%#x\n",
> +				i, PDC_DIMM0_SPD_DEV_ADDRESS, pdc_i2c_read_data[i].reg);
> +			return -1;

			return -EIO;
> +		}
>  
>  	data |= (spd0[4] - 8) | ((spd0[21] != 0) << 3) | ((spd0[3]-11) << 4);
>  	data |= ((spd0[17] / 4) << 6) | ((spd0[5] / 2) << 7) |
> @@ -1284,6 +1289,8 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
>  
>  	/* Programming DIMM0 Module Control Register (index_CID0:80h) */
>  	size = pdc20621_prog_dimm0(host);
> +	if (size < 0)
> +		return 1;

		return size;

>  	dev_dbg(host->dev, "Local DIMM Size = %dMB\n", size);
>  
>  	/* Programming DIMM Module Global Control Register (index_CID0:88h) */


-- 
Damien Le Moal
Western Digital Research
