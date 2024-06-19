Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ABD2139D3
	for <linux-ide@vger.kernel.org>; Wed, 19 Jun 2024 03:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718768936; cv=none; b=hoTdOyTBciOg8+EerT4r+xyWyZCdIE3vHhC1/kbF1ToMfH69+LxZyQW7LB6741mGqg+3blAHgg5gMYf/PdjszvA9ZgB/0VcBzEES+gtarOlpFtTF5YA7zvKjbm89rHeFgpNpz8p36difnYrh3/0O8HbvqS8ho42SycF4gp+nc0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718768936; c=relaxed/simple;
	bh=P8L3ilMqIetlve8BIfqZjukI7xqduMFmZMjvhwlIkrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMSHTFmWh8XLRVP9K2lhl8INC0YVTWMXW4V2qWnaRLMu9WukHNt3ZFEge3v9gecz94uIOs5ZYl1fBYKuFsUnzRkeNmUO+OKgRTrY4S0EKubybVWxza2pmwnlHntPxylvzf5o+rAe75hUlGUHgPDtgBDrE29zOav2z8klvmQExzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVbXXe50; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVbXXe50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EB3C2BBFC;
	Wed, 19 Jun 2024 03:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718768935;
	bh=P8L3ilMqIetlve8BIfqZjukI7xqduMFmZMjvhwlIkrc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uVbXXe50DgBCxkqm49Bg2DeBI8messVLDqPUsPZTxEjPAOEAe4JdZHVGK8KpWO86V
	 E0EvNeVC8nkOzSiXN0cd8aTjYxFOap/ExgcFBo42tPge+0oH7jtJ9SdRUvX3tIHYvo
	 XPG78YNeJAm3azgsJZ92UTfd/g94Y/kbYw86q0vq4RC6DOV6sCIY05KyNhcuQa9pPR
	 gaBddTgdXNegFN9zCNHCvoqa4oniDYW1qHZmbRcOlifZkI2u6Q0L+tjjXHlhmDrRVZ
	 mjxsZzNG5ie1ux+2as5WTvae7VJgfcfrX8GestrOpoFLMuJ6wA2uGbP5ko5Liash93
	 yLTtIFCVRm1Og==
Message-ID: <67d69524-213b-40cb-a17d-0b8f462f26ba@kernel.org>
Date: Wed, 19 Jun 2024 12:48:53 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ata: ahci: Add debug print for external port
To: Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-ide@vger.kernel.org
References: <20240618153537.2687621-7-cassel@kernel.org>
 <20240618153537.2687621-12-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240618153537.2687621-12-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 00:35, Niklas Cassel wrote:
> Add a debug print that tells us if LPM is not getting enabled because the
> port is external.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

