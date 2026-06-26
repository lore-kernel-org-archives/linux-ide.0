Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576DD75809;
	Fri, 26 Jun 2026 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782510218; cv=none; b=H0bnd6F9ZLJBhxDZMfvqwwnY0alUQUxIT1eNXKLtnsC7VXA1QgTDbF7nYrFmT8RuP9AhV7BPL84sKqvCQXb6zHDoZdmyE8M9XxHFcAbJzujJPWswvl3k/qZq2RFvUgQFoGnqruQPlkGfs64wALi8D8RXxB25jRFntLajYiVv+w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782510218; c=relaxed/simple;
	bh=RokVTaBD/HHCDHctrb1mY7Lvg/gnnGHj+r0aDonzDTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxVILuFpp3d+Mju/DaM4fS0b+Rwb/BV+B7nnQrIeBjYh8eaDw1KdwVNafAvvS5TXqTupnfsU5dbXwqT1CkVQvze9SYNHTDY76iJOf09PL0r5KuwBY70zZMMGQEd/YVfctx7+mjDRyHhZC009Ie61ViEFSvgXkKnIVnzfG4Msm6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6lssus3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6lssus3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A1B1F000E9;
	Fri, 26 Jun 2026 21:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782510217;
	bh=9hJh+CZcqfX6J2CNgGhEFv1qJp0G6v7RUfCi8Acrfhk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=I6lssus3Dh5gU0TBlAWfouorhxyGuNdeub1MDLFTxBdZ+Z9tKbQsDPR/qXI61MUUR
	 e82EKgp6X8W2yEVhp4V7iiwSXnVrG8TsscKLs6vXxR9O+fubD/cTwfBupvgXNGQgRH
	 jIB9EL7hlGo0FcSaiOdmoWOcgXu7r2tW4hWzW+7v+74j52+iy1+vPyFTF6KV4fb/fR
	 hrk11FVZXXgSxy517/V+vKHh/wlub72i5h0Blfb6dq3T/kkbANPKT0jaQqVyK7cgsA
	 Rv5dfgAnryrTVijdUoz7X93tdDxTxteCY37oAigadPHIgd6pzEoD4WRfmzGVMigmzE
	 odZYsSswO5Rdg==
Message-ID: <d06d7d2e-d7c1-423d-b35a-c56530a89b63@kernel.org>
Date: Sat, 27 Jun 2026 06:43:34 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_gemini: unwind clocks on IDE pinctrl errors
To: Myeonghun Pak <mhun512@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
References: <20260626085848.40199-1-mhun512@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260626085848.40199-1-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/26 17:58, Myeonghun Pak wrote:
> gemini_sata_bridge_init() prepares and enables both SATA PCLKs, then
> disables them again while keeping the clocks prepared for later bridge
> start and stop operations. If gemini_setup_ide_pins() fails after that,
> gemini_sata_probe() returns directly and skips the existing
> out_unprep_clk unwind path.
> 
> Route the IDE pinctrl failure through out_unprep_clk so the clocks
> prepared by gemini_sata_bridge_init() are unprepared before probe
> fails.
> 
> Fixes: d872ced29d5f ("ata: sata_gemini: Introduce explicit IDE pin control")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Applied to for-7.2-fixes. Thanks!

-- 
Damien Le Moal
Western Digital Research
