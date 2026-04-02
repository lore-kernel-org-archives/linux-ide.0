Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117A1A681B;
	Thu,  2 Apr 2026 05:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775108155; cv=none; b=a1ka3/q0TEhZoa9dyMQ+jsNrEciS4ZnnWlOXmCdz/CCFHJnsfbVqR3LHfnYfeA2iy0M6NL0hMGdHy1BM2heZIkEHMx5jqUt2d3TJfOG6haZil+rWRJRhJ26wESE2m8kRKbuRhvLszInJFGJy/Qgfgg09OOcc0y6qeajwFP+7pko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775108155; c=relaxed/simple;
	bh=O78pE/Lb4fwLnLUP7G5VFPUEOu+YgBQ3pI3scyvhutw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWtWvBFQjc7j8zuEAYA7LMUKpfyupU9BlwE+ofc5jTErgeJPXaxQ3Eb71ZK+wyn4Em0jhRzWst6e3V93vi9QVpfgURTKHh5I/jMtONuhpiguLgun6FqtIQACqE1wtKZNdlSMA4nEzN96tyALaCWPiwnX8tNW9lmzI6D0KFreWTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnlJCXzq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnlJCXzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3131C19423;
	Thu,  2 Apr 2026 05:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775108155;
	bh=O78pE/Lb4fwLnLUP7G5VFPUEOu+YgBQ3pI3scyvhutw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AnlJCXzqvx8eD7V1EyOLoNyF1Y6k7n+fcwJo5k2UzVoQbDbxHx5lktPpCTO0bn3b8
	 I+l7R4g556OfHwLdPJoG5Bv7YUp1uhe5bqvJiHorM3hoUGbSpVtOZBWdi/vl56E4K1
	 19idvg59rZoWzg9sawIs/fFnRP9vat5rXdDO2Use11sp1BQDVR1VOs8olFQKVEsLBa
	 mn9deyNz9CNYKFPto7nF6hVce/gObrUm1VNlr+fcv0Hb20RUawQqHujyMzUv+aKjyL
	 Im0kcNwtRLdJBsFsAdxYfrQ2MCZESFbn/dchwmtTUN8ldF3JYjDC6NZZ7JIb2YZToF
	 sy5AO7Cx6YFSw==
Message-ID: <403a9722-02b8-463b-9980-e7de32e30008@kernel.org>
Date: Thu, 2 Apr 2026 14:35:47 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_arasan_cf: fix missing newline in dev_err
 messages
To: Haoyu Lu <hechushiguitu666@gmail.com>, Viresh Kumar <vireshk@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260402021027.56-1-hechushiguitu666@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260402021027.56-1-hechushiguitu666@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/04/02 11:10, Haoyu Lu wrote:
> Add missing trailing newlines to dev_err() messages in pata_arasan_cf.c.
> 
> This keeps the error output as properly terminated log lines.
> 
> Signed-off-by: Haoyu Lu <hechushiguitu666@gmail.com>
> ---
>  drivers/ata/pata_arasan_cf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
> index 514d549286b5..abcdef123456 100644
> --- a/drivers/ata/pata_arasan_cf.c
> +++ b/drivers/ata/pata_arasan_cf.c
> @@ -380,7 +380,7 @@ static int arasan_cf_xfer(struct arasan_cf_dev *acdev, struct ata_queued_cmd *qc

There is no such function, and yet your patch applies. I am confused...
Which tree is this patch against ?

>  	if (!wait_for_completion_timeout(&acdev->cf_completion, TIMEOUT)) {
>  		u32 rw = acdev->qc->tf.flags & ATA_TFLAG_WRITE;
> 
> -		dev_err(acdev->host->dev, "%s TimeOut", rw ? "write" : "read");
> +		dev_err(acdev->host->dev, "%s TimeOut\n", rw ? "write" : "read");
>  		return -ETIMEDOUT;
>  	}
> 
> @@ -474,7 +474,7 @@ static int arasan_cf_xfer(struct arasan_cf_dev *acdev, struct ata_queued_cmd *qc
>  			dma_len = min(xfer_cnt, FIFO_SIZE);
>  			ret = dma_xfer(acdev, src, dest, dma_len);
>  			if (ret) {
> -				dev_err(acdev->host->dev, "dma failed");
> +				dev_err(acdev->host->dev, "dma failed\n");
>  				goto fail;
>  			}
> 
> --
> 2.17.1


-- 
Damien Le Moal
Western Digital Research
