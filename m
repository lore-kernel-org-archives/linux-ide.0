Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BBC270557;
	Thu, 20 Nov 2025 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627844; cv=none; b=OH4QbVVNkvQhxo+c1h09GibIx2Fj5vHXVHaHeLPvLcV+Is1/jakGNCRPFpmGqacNWNXaU4oNAtmF1mkqZ1p0wmniFG/N9YQuftdXGXdUaGZ52zd/qPYnxY7XUOb7KByMVua8K/+gJ9zQ/qxrsEKCNipoxOajXBeOCFhJoGPRODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627844; c=relaxed/simple;
	bh=XXcUlfwqeVe8xYz85E2/c/2x+iC/uATRKXwVQ2d/Pdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHMCdNAOFC4IsGVofw4aHchg+jIeMR7jjB2pb0LyfkkUpCJyhaso0KrIg4oAZGkmnSAZQIUtz/Bf7EZGf2FWl0C5BWlxitJRWdyV6xH/id/2DBV5mSjCtR9rSw4OICAR6kOR8yzgBNRGIQhkl4D9MUU+W/sF15uQ+EAQkafao1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fr0gX68l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fr0gX68l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB70C116B1;
	Thu, 20 Nov 2025 08:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763627844;
	bh=XXcUlfwqeVe8xYz85E2/c/2x+iC/uATRKXwVQ2d/Pdo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fr0gX68lKCSmC5pkdj7YTfQ7/k4y8zrtKo943GXtKfWlsoAPSB2Y583U333ZjcDol
	 hVF35ORSQYkLkpnQgFkp5oFA5eYVErUHbdwPr+J9qN+cAxTrOwKRaAB8Ub0KmGFpRH
	 BgQlibCZGBl7rK+AMpvHnRIcfyJM647v8NuKjYEOI3Zk/PxhkPbYbYnVoxE7sHIiqZ
	 M7u/8Z2e/hLG6ryz7vm+qdOWA172e1UHlm8YfLaQlzrg3o1YKeN+VybiYYAsrmvwIr
	 Z+fdmFeT/hVjcLqfqT1lAu5VIUrDm0O9vO6wTw4hfMwhEJv2d97etVW80+mXM/i8th
	 EhnE06kzXeSug==
Message-ID: <00b955d1-e2f9-4241-b1ef-ddbf85ca1d9c@kernel.org>
Date: Thu, 20 Nov 2025 17:33:18 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: Add missing scsi_device_put() in
 ata_scsi_dev_rescan()
To: Yihang Li <liyihang9@h-partners.com>, cassel@kernel.org,
 martin.petersen@oracle.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 liuyonglong@huawei.com
References: <20251120035023.1256818-1-liyihang9@h-partners.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251120035023.1256818-1-liyihang9@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 12:50 PM, Yihang Li wrote:
> Call scsi_device_put() in ata_scsi_dev_rescan() if the device or its
> queue are not running.
> 
> Fixes: 0c76106cb975 ("scsi: sd: Fix TCG OPAL unlock on system resume")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yihang Li <liyihang9@h-partners.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
