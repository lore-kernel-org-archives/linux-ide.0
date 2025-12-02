Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFB92222D0
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764642239; cv=none; b=Itf46+fnzLgtkwJZBhxvNeq+pxg11LsLYtzes6UEJfJdzLIm6xKAf2oHIWaNyzDZcWO52Lxv7I6PbLVuBss5XJtlp63qVmXqBvTKdkD3lVQGGIxgVeEMZzk89X9AsXN0o+dQ7v+QxohzaqF7Bvp8U22u85xGHk6hT+49r1AvEm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764642239; c=relaxed/simple;
	bh=NrjnQeXiokVvJdrQsmKVDm6rbidletkF0p2RE9WnHKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3JpB6Fs03/qWurnPfkStqIDIN++6o3WBJ9ObZcWNJn7CymZ4GdHM+xAVC8/p1+E9W0ZRC/Q0QEo3gy952j8FOinDUNelH3N5twKTvpqCsQO1WerMTF2pKIQmD7v7xgDWmZX20MHWzkday4J7YCbEJ75BLYRsnLCaYpLSDAnysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqROSWBU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqROSWBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF54C4CEF1;
	Tue,  2 Dec 2025 02:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764642238;
	bh=NrjnQeXiokVvJdrQsmKVDm6rbidletkF0p2RE9WnHKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sqROSWBUk6rw3r8pq6AYoCxuKtQ89+CvOrYd5y+ZEUFC/MgBxjfThRyd5zV/Rxqv9
	 ZFiyfF3iJeVTOMk68Im/8RQwzZSmxec7TNhXlS1TfIQfwap2ErUMyoKHNtwbg+hvdg
	 cJUWi6hK5iK23aa5Eqd0fPv0ZnR/9hzS7f+0JTDRvWxqWedUbepoMRLCg8VQ7ZF7wB
	 bIrGe8a+kPRmFLqyq82yn1Gq/74Z83v8FNwDWWhH3PMxxZdDZ+aCFBZ7+23eEGc9w0
	 mXYos6FyACyUswEavCGJT6rW/FF8Valti/sIc7AdjlzIAsaITUUoSGMmFcjXIJXdrP
	 MdUHjdJfIWQhA==
Message-ID: <10a15e04-08ab-4cca-83dc-9ee288511dbb@kernel.org>
Date: Tue, 2 Dec 2025 11:23:56 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] ata: libata: Add ATA_QUIRK_MAX_SEC and convert all
 device quirks
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, xxjack12xx@gmail.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20251201123501.246282-10-cassel@kernel.org>
 <20251201123501.246282-13-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251201123501.246282-13-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 21:35, Niklas Cassel wrote:
> Add a new quirk ATA_QUIRK_MAX_SEC, which has a separate table with device
> specific values.
> 
> Convert all existing device quirks in __ata_dev_quirks to the new format.

...all existing ATA_QUIRK_MAX_SEC_XXX device quirks in...

> Quirks ATA_QUIRK_MAX_SEC_128 and ATA_QUIRK_MAX_SEC_1024 cannot be removed
> yet, since they are also used by libata.force, which functionally, is a
> separate user of the quirks. The quirks will be removed once all users
> have been converted to use the new format.
> 
> The quirk ATA_QUIRK_MAX_SEC_8191 can be removed since it has no equivalent
> libata.force parameter.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

One nit below.

With that,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +struct ata_dev_quirk_value {
> +	const char *model_num;
> +	const char *model_rev;
> +	u64 val;
> +};

Please align the field names with tabs.



-- 
Damien Le Moal
Western Digital Research
