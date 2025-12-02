Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D8118BC3D
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 02:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764643077; cv=none; b=BgsB8UmtvHLwGRs57Z41wlUec5RlNKEuLri+Hj8XQEh7BNkl0pbsnnqaLKNwdjlRx6zzQxKxl2FsZfiQBqXeIWMvP7TI3+ZimFf8X46fNLH8r8XFfryTW1IdJtUH61DdD72IiBq4oO58nIq8okHq5/mbASZ3JtNGyyaKDChaYho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764643077; c=relaxed/simple;
	bh=BuDYT7L0+QutUE2gJL5QGW42v8uNaD7rLWszLV3H2mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffa2v5nBHqitAwHF2RMUu6SY59QsznuGza61rA4tYypGbRqElthno5+7ju2d3ukl+bmHE7c+aVUjOj1AIHSZi8SvhgDWLmHp9IxRTczZHqR2x1RwDoeGnXFuiXg4/xW3EirBdhFAm46GAGFFgNiYdk1I9B9+gzCrrdf8R/o+C/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFsmVZcv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFsmVZcv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8498C4CEF1;
	Tue,  2 Dec 2025 02:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764643077;
	bh=BuDYT7L0+QutUE2gJL5QGW42v8uNaD7rLWszLV3H2mk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IFsmVZcvuXuczgiyItWisjhaRabKPtWxB7xRNCA0Yso7cw2ifz/QwZh5LP82zwcyO
	 dRHmKAx41XkruLY1qznCrvDvoKd6DKAgwOarkpFQj8F89PIE45M09IICvnkdrSadnk
	 SE5gjdC2a9hpgfg3Gjpbj8nm3srLlTS3r5YrdMZSJACaMdfLKx/CVig8st5ZrnSdlD
	 kGgos/SBtgLmOl7dMYXw0FATWajU238Mv/a0btPaX09EMzYzQ6OzZ8qo4Sa9G1UFID
	 Z8NjOyHo2deZMjjUKAX1+tLq7d9UH3AtiLbGKG0IIUF/8Qfp1YUrPnAs2LRQoWfVQF
	 KKckkS//VBMrA==
Message-ID: <537c6d08-4175-4e01-a57c-36f1f5bb64d4@kernel.org>
Date: Tue, 2 Dec 2025 11:37:55 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] ata: libata: Add libata.force parameter max_sec
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, xxjack12xx@gmail.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20251201123501.246282-10-cassel@kernel.org>
 <20251201123501.246282-17-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251201123501.246282-17-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 21:35, Niklas Cassel wrote:
> Add a new libata.force parameter called max_sec.
> 
> The parameter can take an arbitrary value using the format:
> libata.force=max_sec=<param_value>

s/<param_value>/<number of 512B sectors>

This way, we are clear about what the value represents.

> e.g. libata.force=max_sec=8191
> or
> libata.force=max_sec=2048
> 
> This will allow the user to set an arbitrary max_sectors value using
> libata.force.

...to set an arbitrary maximum command size (dev->max_sectors) using...

Again to be clear about what this is doing.

> We cannot remove the existing libata.force parameters "max_sec_128" and
> "max_sec_1024", as these are a part of the exising user facing API.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 ++++
>  drivers/ata/libata-core.c                       | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6c42061ca20e5..c5464b11a2ad5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3294,6 +3294,10 @@
>  			* [no]logdir: Enable or disable access to the general
>  			  purpose log directory.
>  
> +			* max_sec=<sectors>: Set the transfer size limit, in
> +			  sectors, to the value specified in <sectors>. The

..., in number of 512-Bytes sectors, to...

> +			  value specified in <sectors> has to be an integer.

...to be a non-zero positive integer.

With these addressed, feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
