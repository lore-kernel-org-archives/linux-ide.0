Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92F25C804
	for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2025 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634058; cv=none; b=UE3n5+cf/24IiDnE0VK1YeV1/hYWYaon+WaT5/xVXXoz3VKd56udjSoG3KMNbIhLjAPi8BiONKThVLx20Uhgt4scSF6o8jl/Ey6/Dfab5E6YNongQ4Iz+qlKTRsYEuNIfI7tNc/WrLVM1ejBaG7qqhfWYBCCn2Isu6741hgdY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634058; c=relaxed/simple;
	bh=8Dwvx2jJlGSFnbIiFMbdP56XF0azTaxg2xZcZfjzyQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+wit3jOP1/qvLg2/BTL7d4D3hfbzzyAEXTkSI1YCSLlrfN3hacCp2drdMykDs0GGLDeTiTCdMu1FQ7SdSgnByuOt58tuojn7rhK4zDMKFjhiavy5eMUQ7ro7OgzjZydQKxyiOhqfOlQgDz1h3EQF2zL+Tl6s4SEdAKacAMpgFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azIRGvCs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azIRGvCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FA9C4CEEE;
	Wed, 11 Jun 2025 09:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749634057;
	bh=8Dwvx2jJlGSFnbIiFMbdP56XF0azTaxg2xZcZfjzyQg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=azIRGvCsMbrA1YT9zjLUKvEQeLxa24pT8Bm8JX6HkMqdpoL/1BaHKWyebtOf3tHdn
	 IigXqxjce9RHXi1yt+YBGe0Uc/ewjHD7nbmaShK2XKd45QaWqU7McoT094XuPszWRZ
	 hJrvlPC1UTCll0b5yYwk4SMSQqrQPCNjV3rCpaRRskBE81PPwDzx12CuFvJjlU0QGE
	 Rfx4HMNY5Dee6JlOrnk9176jOdGnOumYO3chTnwaLXyNmT1m6J3GE82NuZbyG3cOZU
	 D72Oe/Rvn1SaFfdZBsGxN+QHTS7Abvu3KKe6/buW00LCe/deJja2acPgQpqnZXUyhu
	 fAZR4jnAuDdkA==
Message-ID: <381a16af-6826-4462-94e5-6695f20c464a@kernel.org>
Date: Wed, 11 Jun 2025 18:25:50 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ata: ahci: Disallow LPM for ASUSPRO-D840SA
 motherboard
To: Niklas Cassel <cassel@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me, Hans de Goede <hansg@kernel.org>,
 Andy Yang <andyybtc79@gmail.com>, Mikko Juhani Korhonen
 <mjkorhon@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-ide@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 stable+noautosel@kernel.org
References: <20250610110757.1318959-5-cassel@kernel.org>
 <20250610110757.1318959-8-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250610110757.1318959-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/25 8:08 PM, Niklas Cassel wrote:
> A user has bisected a regression which causes graphical corruptions on his
> screen to commit 7627a0edef54 ("ata: ahci: Drop low power policy board
> type").
> 
> Simply reverting commit 7627a0edef54 ("ata: ahci: Drop low power policy
> board type") makes the graphical corruptions on his screen to go away.
> (Note: there are no visible messages in dmesg that indicates a problem
> with AHCI.)
> 
> The user also reports that the problem occurs regardless if there is an
> HDD or an SSD connected via AHCI, so the problem is not device related.
> 
> The devices also work fine on other motherboards, so it seems specific to
> the ASUSPRO-D840SA motherboard.
> 
> While enabling low power modes for AHCI is not supposed to affect
> completely unrelated hardware, like a graphics card, it does however
> allow the system to enter deeper PC-states, which could expose ACPI issues
> that were previously not visible (because the system never entered these
> lower power states before).
> 
> There are previous examples where enabling LPM exposed serious BIOS/ACPI
> bugs, see e.g. commit 240630e61870 ("ahci: Disable LPM on Lenovo 50 series
> laptops with a too old BIOS").
> 
> Since there hasn't been any BIOS update in years for the ASUSPRO-D840SA
> motherboard, disable LPM for this board, in order to avoid entering lower
> PC-states, which triggers graphical corruptions.
> 
> Cc: stable+noautosel@kernel.org # Depends on ahci_broken_lpm() refactor
> Reviewed-by: Hans de Goede <hansg@kernel.org>
> Reported-by: Andy Yang <andyybtc79@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220111
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
