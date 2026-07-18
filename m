Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60AF846F;
	Sat, 18 Jul 2026 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784338739; cv=none; b=fBSLksFhghtEEg6Bbx7px0+Jzusiz4mX3yCLfLLqqdCP7BJcGis/BPJKRqpgQEPYGbQsvc7UgxMUGkG8Z7Ze4VbM6SuybaCy6S9pBz2mvnbAbg5lLNMidNTMPm3xiFsNfMfP/JB/+wBQ1maT2F7ls5s+nrLlY7wCp8LzkPivag8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784338739; c=relaxed/simple;
	bh=OreKbrZMmB9p8IulF1oZn7HdH3BNzdrBBKyu4zTvtlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EtDHca4ATxXQG0G/5pyIrfJ2SwmO4QlPjtB2gy1+kjJwJrukvQ6jf6U3LXyOHJ3bXuMvD6JsT1NNx7NBWGU14GHalJ6Kmskn+oJjq1t7efkFshTdv8CvU0+b/GKAIMXwXEbYFxSkXGXqbp5RFiSnED2yU1QhL6Xa/+S9fE8xuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxlenzjV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxlenzjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23141F000E9;
	Sat, 18 Jul 2026 01:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784338737;
	bh=f+sMSWrMTKxbkIXgTR03kTvVJytxxP018cMB/KGaSzM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZxlenzjVIYpyVxRSHDXVGfoqB7KTAqD/ItoYy6LunJS6zEc5DXJhaq3Kniy3/xM49
	 P8A7AOK+k1Gg3GOb+mKmt+OUmO+xkN3N/J/k9R60U6+yRTKGu/oGH9b2/0wyx04rwS
	 QQLg930Dn44meM8XXoFaf1+foYJBYyErgelgy8u0THWmV36zrH0TMVcf0Uqgmk+c6T
	 zE2FKtzUI8LM/brCFEo6t6wvVFT5muuE6o/SH3tq4DBINJLXyIwibHhPx6Dk8ZjARc
	 2o1dIuQRTMs/G4pibYhwFs8vfuhIPbzhDxqVZ8Wz3SQloSeeVpIgzolbNDNysYkY31
	 RnXVKA4ayzGjQ==
Message-ID: <f7842a93-c7f0-4ec2-9695-072f5440e2f2@kernel.org>
Date: Sat, 18 Jul 2026 10:38:55 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci_ceva: fix error paths in
 ceva_ahci_platform_enable_resources()
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com
References: <20260717182527.3414781-1-radhey.shyam.pandey@amd.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260717182527.3414781-1-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/18/26 03:25, Radhey Shyam Pandey wrote:
> On phy_init() failure the error path fell through to disable_rsts, which
> deasserted the controller reset and then entered disable_phys calling
> phy_power_off() on PHYs that were never powered on.  That corrupts the PHY
> power_count and triggers an extra runtime PM put.
> 
> Use a separate exit_phys path that unwinds with phy_exit() only and falls
> through to disable_clks while the controller remains in reset.  Reserve
> phy_power_off() for the phy_power_on() failure path only, and skip
> masked-out ports in both unwind loops.
> 
> On phy_power_on() failure re-assert the controller reset before disabling
> clocks and regulators, matching the teardown order used by
> ahci_platform_enable_resources() and ahci_platform_disable_resources().
> 
> Fixes: 26c8404e162b ("ata: ahci_ceva: fix error handling for Xilinx GT PHY support")
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Applied to for-7.2-fixes. Thanks!

-- 
Damien Le Moal
Western Digital Research
