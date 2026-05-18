Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7573890EF
	for <linux-ide@vger.kernel.org>; Mon, 18 May 2026 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096034; cv=none; b=Nqd+wI4RlBfj/uBRFMHYKBGE9agDzjfkAAwfND5tHln94lPcqBIY5izb9ZJ/n0cvSqCKasdpNfUzO07R3vZ8ZonRqhGmi+WYI3GYxJ9otPvxwsYZORGzPlBgxl7spB7guxch3SL9tg5l2mVPJYIRI5sdx4K8IHwYCuZQ/GhQZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096034; c=relaxed/simple;
	bh=uWAO2m+1APXMiwM+kElwNeh3TdsRKIbbVc6Rd8Dcz9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ef6AZ3axwg9YOXMMc0UdocHG65nSzmEvM5cmMLRNo0YlQP7RqdrzYDyXAnjPUUYpi/cf2gA+z1T7Ty0qaUu0IG5OMQsG/L2l8nyX3yxVb1eq932mlTWI7LN2k7Eqhhe6m/cF4ZlmnA/k8Rk0FEdWJbmwftLG2jU8hA07gl9kyNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWOxMpAj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWOxMpAj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F99AC2BCB7;
	Mon, 18 May 2026 09:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779096034;
	bh=uWAO2m+1APXMiwM+kElwNeh3TdsRKIbbVc6Rd8Dcz9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sWOxMpAjo93vQrtvIDwX4UFmJ7U1CPBxko8mV4vwkINzov3+0Sr24eV+XV2ZYzxLD
	 m1Lj7hAr4G/jSJHM/p2FGtad+iQxX8dl08Lu8fq818W0l/4lrm7wVt3PhjBeK7EN6K
	 H8j7gKBm7w6QBP1U5jSGrdOLV1vuO4Z3oYgwAmh0hwhfJ1z6RIeysDvijL7U/xAdrF
	 3/Oq1H5BJYWVhQiW8nYRXQZs6NcRaf8nbanA1qUJ534yO8xOELBVZFRfmChuPo87V/
	 M/c7jyKUHs2AU3XY3SrmF7j1BbogUGRQRNoPVfxsvk6mgcPuUayKwXUrIEUv97j6ef
	 svSkee0TNXYig==
Message-ID: <16999d8e-e9cf-4a30-b478-9451cd50339e@kernel.org>
Date: Mon, 18 May 2026 11:20:31 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] ata: libata-scsi: do not use the deferred QC
 feature for ATA_DEFER_PORT
To: Niklas Cassel <cassel@kernel.org>, Tommy Kelly <linux@tkel.ly>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 John Garry <john.g.garry@oracle.com>
Cc: linux-ide@vger.kernel.org
References: <20260514073858.1175072-6-cassel@kernel.org>
 <20260514073858.1175072-8-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260514073858.1175072-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/14 9:39, Niklas Cassel wrote:
> The deferred QC feature was meant to handle mixed NCQ and non-NCQ commands,
> i.e. for return value ATA_DEFER_LINK.
> 
> ATA_DEFER_PORT is returned by PATA drivers, but also certain SATA drivers
> like sata_mv and sata_sil24 that uses ap->excl_link to workaround hardware
> bugs in these HBAs. Regardless of the reason, using the deferred QC feature
> for ATA_DEFER_PORT is always wrong, and will break the ap->excl_link usage
> of the SATA drivers that rely on that feature.
> 
> Modify ata_scsi_qc_issue() to only use the deferred QC feature when mixing
> NCQ and non-NCQ commands, i.e. ATA_DEFER_LINK.
> 
> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
