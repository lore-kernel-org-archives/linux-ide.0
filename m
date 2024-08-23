Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7041CD13;
	Fri, 23 Aug 2024 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724375456; cv=none; b=sMdrFzsASIMi5nmY2b15uzT/4c1nA14fz3MWHFhnCL9H7ujDuhk0ibFqyQ+l05IbBzWRBQTcBUNNpo2nWGEYOR0GWjIHkspEjDGZq6wbc1YYbQ0EhZeFc8wAoRuH5H5hu3vQd2m/glinjvVOjEOcSXcPCZ6hnD3hFYgD1jKWEMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724375456; c=relaxed/simple;
	bh=rit7npx25RybEEmpv6nSk9bwANItY8yC0gDusXkIcZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9M3lHFrap/oX64t7vc166QZx2a7uEzeKmC3m7bU2o2C5qejrIxFuCZy6wGp5D2aEXB0ZtXbeGmNRBtGP7ZvKNQqiVhvnIUl9ixBW2vM4DV5355QmtlCITmNeEzHdNQ9e2PrVzFuhf3RQGibrvA4kD7xjPU0JooLvrprsIBASic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JM3nrP5W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JM3nrP5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D2CC32782;
	Fri, 23 Aug 2024 01:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724375455;
	bh=rit7npx25RybEEmpv6nSk9bwANItY8yC0gDusXkIcZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JM3nrP5WAjMm09pppTC+OVjjlgqx0fS+8noDZYuPfWwcZTlCBpC8aaYicl0xTUcfo
	 AoIMhl5h4q05KZlcdHiwxDpUxxNYDM7VOe1a7BkSx0ZtZ9khyHLUQGnslWlFx7fGd6
	 u7FGqU1lZckiFDUell5Voqed5pQn91pSS3mu/57ZMK2ANaWl6EFwYOrCDlT4HdmHMH
	 z/+cz0TIXTz8s0kkL2FaYZWUp4XOA1OZpdBDmOcapLATEvD/4pWL6m/+w2mVTPB4e2
	 Q/tcE2jG84h6dygDqBtcfw/1iIq37AwI0LSJmH+spjTTTc+pTzI9qZHsF4Cl23hUH7
	 tnM801vHCj6GQ==
Message-ID: <e5862d36-6f16-469c-9d03-e7681bfb5bf5@kernel.org>
Date: Fri, 23 Aug 2024 10:10:53 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata: Fix memory leak for error path in
 ata_host_alloc()
To: Zheng Qixing <zhengqixing@huaweicloud.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 zhengqixing@huawei.com
References: <20240822033050.2909195-1-zhengqixing@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240822033050.2909195-1-zhengqixing@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/24 12:30 PM, Zheng Qixing wrote:
> From: Zheng Qixing <zhengqixing@huawei.com>
> 
> In ata_host_alloc(), if ata_port_alloc(host) fails to allocate memory
> for a port, the allocated 'host' structure is not freed before returning
> from the function. This results in a potential memory leak.
> 
> This patch adds a kfree(host) before the error handling code is executed
> to ensure that the 'host' structure is properly freed in case of an
> allocation failure.
> 
> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>

This needs a Fixes tag. So I added:

Fixes: 2623c7a5f279 ("libata: add refcounting to ata_host")
Cc: stable@vger.kernel.org>

and applied to for-6.11-fixes. Thanks.

> ---
> Changes in v2:
>  - error path is wrong in v1
> 
>  drivers/ata/libata-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e4023fc288ac..f27a18990c38 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5663,8 +5663,10 @@ struct ata_host *ata_host_alloc(struct device *dev, int n_ports)
>  	}
>  
>  	dr = devres_alloc(ata_devres_release, 0, GFP_KERNEL);
> -	if (!dr)
> +	if (!dr) {
> +		kfree(host);
>  		goto err_out;
> +	}
>  
>  	devres_add(dev, dr);
>  	dev_set_drvdata(dev, host);

-- 
Damien Le Moal
Western Digital Research

