Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3900C2629F
	for <linux-ide@vger.kernel.org>; Fri, 11 Apr 2025 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744329637; cv=none; b=iPKNxt+w9Krq1FGw6TKRozAbavMHFsiyB9JWUxjKntXkn2uA0GaCCiimKtnJKTuwQww/7j1EEuqXxgc2rI+QARTVdj6M85Uf5ARcIGX2CV7KFBEuNlEBlYgnfOTxD7m7gMDdZH2HW7iDRLI8ng7XFk/RcFSkYtJE1BAM98nCupY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744329637; c=relaxed/simple;
	bh=Lxs59YrCuhjHa8MrSTTjFP98rE8UdjzMY1ZSHHfWrFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQiG8cz0h1lVV+dAbDHnsCwCQTyiXrnNt/rANAsSZY1RVNFXoibVl9MNwpdGHpvKkQ7BCRzdsIFdb0nblnmpKxkpYsUpi5lKhKDxnuwZj78wkoQAN0S6+eCIJy1VGqWMTbMM/GGhjdaHQ8Ep2bcq0xIfWI6wPyzbprHRfmM2AJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib5bblYR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib5bblYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEE2C4CEDD;
	Fri, 11 Apr 2025 00:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744329636;
	bh=Lxs59YrCuhjHa8MrSTTjFP98rE8UdjzMY1ZSHHfWrFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ib5bblYRoDL9rGwa5l1GsYmjp686SgmVST8vtRsr9Ga9WvfAtPXmc4lxR6msmyTNV
	 krSEpetaFpWPYD1qN6lp85goD/YXfb9yPe9LD6jUv+Qiq68+POHsWYEJdxJlUhc095
	 E00roZB+tyFr5MOxZTWrZxPrmdDY+WgOmd3IvQLIv4v8VZVBc18sg9FvJBzx5OOc++
	 6LrdT3ClUP/uwn9D1UKH7z175mNeaZr30W3p0u2nGZE2hBY0Npetu/nlf7QwE6+ttg
	 i/oFMcjlzRMMiVRegJ3CqYGao9y3kc71PtOGF9wJFQglgEd2Mrh3X3/bpO9KuPK6vR
	 07YJPOLg8GwIg==
Message-ID: <95ca32e1-6c90-4a31-8a54-c997a6653a1c@kernel.org>
Date: Fri, 11 Apr 2025 09:00:34 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Simplify ata_print_version_once
To: Heiner Kallweit <hkallweit1@gmail.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <f9e7276d-d9f9-47cd-8b9b-5dc85567489a@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <f9e7276d-d9f9-47cd-8b9b-5dc85567489a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 06:45, Heiner Kallweit wrote:
> Use dev_dbg_once() instead of open-coding the once functionality.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/ata/libata-core.c |  6 +++---
>  include/linux/libata.h    | 13 +------------
>  2 files changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 773799cfd..e58a22e83 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -6682,11 +6682,11 @@ const struct ata_port_info ata_dummy_port_info = {
>  };
>  EXPORT_SYMBOL_GPL(ata_dummy_port_info);
>  
> -void ata_print_version(const struct device *dev, const char *version)
> +void ata_print_version_once(const struct device *dev, const char *version)
>  {
> -	dev_printk(KERN_DEBUG, dev, "version %s\n", version);
> +	dev_dbg_once(dev, "version %s\n", version);
>  }
> -EXPORT_SYMBOL(ata_print_version);
> +EXPORT_SYMBOL(ata_print_version_once);

Overall, looks good, but I really do not see the point of having this as an
exported function. So while at it, can you change it to be inline in libata.h ?

>  
>  EXPORT_TRACEPOINT_SYMBOL_GPL(ata_tf_load);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(ata_exec_command);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index e5695998a..02c9f621e 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -41,16 +41,7 @@
>   */
>  #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
>  
> -
> -#define ata_print_version_once(dev, version)			\
> -({								\
> -	static bool __print_once;				\
> -								\
> -	if (!__print_once) {					\
> -		__print_once = true;				\
> -		ata_print_version(dev, version);		\
> -	}							\
> -})
> +void ata_print_version_once(const struct device *dev, const char *version);
>  
>  /* defines only for the constants which don't work well as enums */
>  #define ATA_TAG_POISON		0xfafbfcfdU
> @@ -1593,8 +1584,6 @@ do {								\
>  #define ata_dev_dbg(dev, fmt, ...)				\
>  	ata_dev_printk(debug, dev, fmt, ##__VA_ARGS__)
>  
> -void ata_print_version(const struct device *dev, const char *version);
> -
>  /*
>   * ata_eh_info helpers
>   */


-- 
Damien Le Moal
Western Digital Research
