Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1185F4A1E;
	Tue,  8 Apr 2025 03:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744082925; cv=none; b=kOVCsRiqgjnUEehACpTIMaF5Ee0Akec/OMM7++O+ZVoKfTkMJvoo1YvfImcn1LOdioBN7T5njWcpYK+zp4eETwhTR5URsS8W0FLrCsJUHj8DpPMDwVgSxTVcyqDBszDCTD1UNq0EnhB5/vsGdbMGnELwxTdp5NQGMqi+9MHTP/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744082925; c=relaxed/simple;
	bh=nzjhib953oS0hVUOBcaDvvbJLZ6cdA3gRX5MsetGVRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUK6oybB/xSNIlessBfOjMxbWvZF6JNPF9k/nXmIymXh0AfCfRRe0zPKLmHUyRpjsf68il46+0VzhzT0KNUAIt8Wsv6RhWPXncZXPFD+IWCW5U5IyVIrd3oGwHBrfe1oA+JJBha/JFu8Jmd1ReuRFmLaPqxzRwojqsRVqiJ7UmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ983dHG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ983dHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F038DC4CEDD;
	Tue,  8 Apr 2025 03:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744082924;
	bh=nzjhib953oS0hVUOBcaDvvbJLZ6cdA3gRX5MsetGVRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IZ983dHGqACCd1RR41uXnPie3Y105feJuqszTXk2HNhyDvXO1QHjY15f/xGIJIynB
	 ayQDMyUOh6d44XTarnAHcgd1kwe187IxDbHv8Or9sc47ErHKdcTVzxp0Zi+knvVTlC
	 R6JEP8bRVyex6gssfx2z1DlJE7tid9lXxJOaBTtR9wHFAmmqSskF/sJW0nFpSTGsU4
	 VPUp0Y5ltngxq48/Jxd8X8DCV6Y4/qvPGy5uS5Q+3QkhLRu3+achu8ivrxw3sWMBSQ
	 N+G1SmI3JptPGNdO/Tgcl/DxDY/jsTW4/ldBRazjpGfqCylbJj/F+eLEomgMeZHLy1
	 eHxW+uVa/abyg==
Message-ID: <ae64e37e-0a4b-4ab4-8dcf-cd4561388334@kernel.org>
Date: Tue, 8 Apr 2025 12:28:02 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] libata: Add error handling for pdc20621_i2c_read()
To: Wentao Liang <vulab@iscas.ac.cn>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250405135333.2348-1-vulab@iscas.ac.cn>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250405135333.2348-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/25 10:53 PM, Wentao Liang wrote:

You forgot to update the patch title. As I said, it must be:

ata: sata_sx4: Add error handling in pdc20621_i2c_read()

> The function pdc20621_prog_dimm0() calls the function pdc20621_i2c_read()
> but does not handle the error if the read fails. This could lead to
> process with invalid data. A proper inplementation can be found in
> /source/drivers/ata/sata_sx4.c, pdc20621_prog_dimm_global(). As mentioned
> in its commit: bb44e154e25125bef31fa956785e90fccd24610b, the variable spd0
> might be used uninitialized when pdc20621_i2c_read() fails.
> 
> Add error handling to the pdc20621_i2c_read(). If a read operation fails,

s/to the/to

> an error message is logged via dev_err(), and return a negative error
> code.
> 
> Add error handling to pdc20621_prog_dimm0() in pdc20621_dimm_init(), and
> return a negative error code if pdc20621_prog_dimm0() fails.
> 
> Fixes: 4447d3515616 ("libata: convert the remaining SATA drivers to new init model")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/ata/sata_sx4.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
> index a482741eb181..c3042eca6332 100644
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
> +				       &spd0[pdc_i2c_read_data[i].ofs])) {
> +			dev_err(host->dev,
> +				"Failed in i2c read at index %d: device=%#x, reg=%#x\n",
> +				i, PDC_DIMM0_SPD_DEV_ADDRESS, pdc_i2c_read_data[i].reg);
> +			return -EIO;
> +		}
>  
>  	data |= (spd0[4] - 8) | ((spd0[21] != 0) << 3) | ((spd0[3]-11) << 4);
>  	data |= ((spd0[17] / 4) << 6) | ((spd0[5] / 2) << 7) |
> @@ -1284,6 +1289,8 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
>  
>  	/* Programming DIMM0 Module Control Register (index_CID0:80h) */
>  	size = pdc20621_prog_dimm0(host);
> +	if (size < 0)
> +		return size;
>  	dev_dbg(host->dev, "Local DIMM Size = %dMB\n", size);
>  
>  	/* Programming DIMM Module Global Control Register (index_CID0:88h) */


-- 
Damien Le Moal
Western Digital Research
