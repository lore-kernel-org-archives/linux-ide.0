Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC06A33F8C5
	for <linux-ide@vger.kernel.org>; Tue, 13 Jan 2026 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298524; cv=none; b=Alfg2OwZkux7sKlBYpzaB4XORRJPphCdv6CkKsSCpnXcQoSWBfeH57d55AUwoQQty1dMrK34elRbCOF5UNOViIOQSwIBI75QSdF+deayVU5+8f10GdFHhM45fTv9PTe3mikfMnvMiqKKhO4tPkDHfS5Nie6j5FgO12axAKJN03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298524; c=relaxed/simple;
	bh=+qohZ2sL1OplrlZjCpVCQ5Qx5TrfCcVp3F4DfYinQF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+BSkZM+jGwDlWNDx0ytQypGOyjZdiuugpkZWBYQQ/d6n4jMLHnCgLMYgohTptEO3Zwjv3YmdqmT5H1au9SPywQFv3n7kufTsrsXqwu6yOwMCJR9z/JRyDslNWgSUiOGFfvGVQ9VJaYjnZQpDvBY7WcWAYGZUcz5eA4RfJ1A6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cx3CGGWM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cx3CGGWM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7209CC116C6;
	Tue, 13 Jan 2026 10:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768298524;
	bh=+qohZ2sL1OplrlZjCpVCQ5Qx5TrfCcVp3F4DfYinQF8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cx3CGGWMhSRmFXZXEoKe4aN2ry5zGSqFnGwWnS1pPdsg2SJ2VYm/8/L2zgpocmpJC
	 hpMiibU4nNOxcrvo93mHu7pcVPkKFo/QPTZe8n6+I3RloE29rncCeuckYcTjo9t2bt
	 Nnng36SW1IfZ2Ckv+P9K+oELEgdMwtilVsQq6zT5uNUuYckXf2FSoyWv1dGYD2EyvU
	 2AUhw1MnNSvolOdQoBe2R9fk+VPdPaRiH8jN3MzsC0P8TV0lge47Esl+nDNkCp01Ay
	 pvcjOlRUEz9u1EkcfDYXMDhlY6V1bbDsGU1iKYaI1J/iPc+FRg6cIo6Yg1hqBGD/eZ
	 4qWESB4UEijNw==
Message-ID: <3b15785d-104a-448c-b354-db77112e83b8@kernel.org>
Date: Tue, 13 Jan 2026 11:02:01 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] misc LPM related fixes
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, wolf@yoxt.cc
References: <20260112122044.143637-8-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260112122044.143637-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 13:20, Niklas Cassel wrote:
> Hello there,
> 
> we had a recent bug report on the mailing list related to LPM, which made
> me review the LPM related code.
> 
> While doing so, I found some issues. This series fixes those issues.
> 
> The most serious issue is that ATA_QUIRK_NOLPM was not getting applied for
> ATAPI devices and that we read the per port area for unimplemented ports,
> even though the AHCI specification explicitly forbids this.

Applied to for-6.20-fixes. Thanks !


-- 
Damien Le Moal
Western Digital Research
