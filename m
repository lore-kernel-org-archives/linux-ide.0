Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4942139D3
	for <linux-ide@vger.kernel.org>; Wed, 19 Jun 2024 03:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718768836; cv=none; b=qCgGPPE3gllpOICW3/cvYB+7/b/PoxAlqZ0qViYXA/YuHzyPhKR+bxEzxtmZoejnnhPgFxqoe+JLKk9nY7q7Odf3VaIqpT3y/SbvI7tRsrwwVVFRjtxq2/9nnxUJ525u2RLggyOgUjv5zjbdj42MAutcREvYe1wZHLhrPULdXfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718768836; c=relaxed/simple;
	bh=59VcRgX6VXKAht2QNmWKDqCLc8bHvtcJ93rVLbcqowI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9qixO1nUvhXCcHdt5DoJYREQgGhcAwQlW6evsY5vzSEvUXe0AT8NUxGLqrMVrObKMYHAHATWmHpE9J2dV5x8wty65piSWMzoYYbTZSoz+HVLyE4+WqCmfJ+lV96Kcrab/lzS/ptBd5VLsiV0JAi+OCaURjVggL5cX9EYOql5wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiHkvnwL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiHkvnwL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A9BC2BBFC;
	Wed, 19 Jun 2024 03:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718768836;
	bh=59VcRgX6VXKAht2QNmWKDqCLc8bHvtcJ93rVLbcqowI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eiHkvnwL6SaOHkp6NAhlSJdRvKNhf5Il0OPjYrtGYAcsn9eU4pIlpjTOTZCmVmVxe
	 1/3PbY7THXaJZCR5liz6/t/Po9GxT+i8hYzeM/BsUu+sLjNKkJqPijXu3fvTEcY26X
	 HCoOBKTHBBJ1x0FsYi+yhpLho7Vgp7AeLkLWI6tT4Tx2/oGqeOZiZveQy24n9YhLh4
	 Pwl7/o8VJu2JWyBsGKDITt2MlV9LFO2hzluf/Ivl4xK854BVHAczkqm8fAnPugh3Ie
	 3MA+DYnjYSMgQ8E5VHk3+riSaBk6s4grloufuU6KSjsjDy9FpG6Mm0RxIrmR3XHJic
	 jDs89AErBxSpg==
Message-ID: <ebcdff9f-ac12-4f9b-8f70-182a05717c6a@kernel.org>
Date: Wed, 19 Jun 2024 12:47:14 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] ata: libata-scsi: Remove superfluous assignment in
 ata_sas_port_alloc()
To: Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-ide@vger.kernel.org
References: <20240618153537.2687621-7-cassel@kernel.org>
 <20240618153537.2687621-9-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240618153537.2687621-9-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 00:35, Niklas Cassel wrote:
> ata_sas_port_alloc() calls ata_port_alloc() which already assigns ap->lock
> so there is no need to ata_sas_port_alloc() to assign it again.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/ata/libata-sata.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 9e047bf912b1..c564eac9d430 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1228,7 +1228,6 @@ struct ata_port *ata_sas_port_alloc(struct ata_host *host,
>  		return NULL;
>  
>  	ap->port_no = 0;
> -	ap->lock = &host->lock;
>  	ap->pio_mask = port_info->pio_mask;
>  	ap->mwdma_mask = port_info->mwdma_mask;
>  	ap->udma_mask = port_info->udma_mask;

-- 
Damien Le Moal
Western Digital Research

