Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C984734F2;
	Sat, 12 Sep 2026 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789210832; cv=none; b=V2/K+G5aXF9UmxyDjGm855ETsQ/NI6P1GKrXGoR/KBy+RSCqhzhvU+abcO3JwEG/n5EEc7LpChP0KEAKS6BTGJJBVJd5voWyap02+eeqptCcCEySHYp6C0BLkdaFBYGlZ9VT1IArJfKeBIS7v2FDuTQ+0DHe1HeDwOT9C2o/h2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789210832; c=relaxed/simple;
	bh=2UjBG16lWj7D5EIaaVtnCU5MY7Agkdv/ByLRU8hEARc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ER0tJ/PVwlJj5DxisXQ7qtvR4Y1gFZ9QYxTDkXq2BRarTMBQQRIchPMcuC+fGvCJkalhK8boGZKEXjHaQGm5heyrY5b91NuseUmX+/rMSwpsdYT+Sio8ou5Xeufmy+JEZTYBgSqJV69e4hyuKE3+JiSWxmYwXcGoBVrQkI4iX9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY4ygWnB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY4ygWnB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0D81F00898;
	Sat, 12 Sep 2026 11:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789210831;
	bh=KHz/jAFNmIVmMpmdQ8Bn+Jk4k4FOR+oBO4ltmWpYG3Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TY4ygWnBU1UYJTad5oFB0aQm1f9sGe6iqLJMgwRKxjCLG3m5bGaBAgVMW1T3iL7ev
	 mPUO4Uvb0BJ1kkfVa4G2dyuefT6TjQGXwvP0Ivs8py2qFCBev7xbz/W5TihuUemRnN
	 0GqWgCpDDOQmpGyf3hOEbUQg/qiX3J09doUm/ZR54BxyFZyLH7PexCCb/OOrT5CJ8c
	 1uCwMI9h5TqS6xSy+FTMiqhUY2qYBj0+ze8aDlnBjzKh4hN67YMC7OS/I8Rl4I73+d
	 4LZ5nzl/x/wb0Fi4qF7SfCu0qCwuBxFcif1xshBooJs4/ko/WieaquuYVeXbNAdfVE
	 RURUXTYrlNf6A==
Message-ID: <4093fff5-4627-44da-aa74-78c112e2bd0f@kernel.org>
Date: Sat, 12 Sep 2026 20:00:28 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: Fix ata_scsi_hotplug() reference in
 kernel-doc
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260912101215.86413-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260912101215.86413-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/26 19:12, Karl Mehltretter wrote:
> The ata_scsi_remove_dev() comment misspells its caller as
> ata_eh_scsi_hotplug(). The caller is ata_scsi_hotplug(). Correct the
> reference, which predates libata's move from drivers/scsi to
> drivers/ata.
> 
> Fixes: 580b2102327a ("[PATCH] libata-hp: implement SCSI part of hotplug")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
