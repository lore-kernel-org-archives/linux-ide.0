Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8C03C09FE;
	Mon, 31 Aug 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162812; cv=none; b=I6jzGIG+3V7NbilXRd1SQfRIs/zSqm/lBBAinzZPlzINDEEGNtUB7bQuDczYNFXTINLbNlUe/J+l2i6l2lB4xjfo/h5gz+mi55z18iGEADLXibQ+J93PEwWTBP8CKj+9LtIE6mhXXH0n3XY613bFLnHZx8+pqhNhecQyOIVPqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162812; c=relaxed/simple;
	bh=qxjUwXzCxcCtXTF7yIgm29Iv8X6efZhl1vS1ctrABxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQHqJhs90FE9VldQ99C/wvyGevmYWmkMYyG9F8RN+7g8bffsXC5lG99YqqEC/Pz4TmlMWHDAFjtOJfY3cJZmyu5derwEFLpNQ+GDY4UX1+ngAU64PVgz/aKKM2IR9DtWekWCytmCMkWk9h4rpD+6PFdZnrr5SSVeLLSAZT8xrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtgtCMl0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtgtCMl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2291F000E9;
	Mon, 31 Aug 2026 07:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788162811;
	bh=y5N+xCjVAfYhdDNXN3NADrKvKaR14dg85Uq+cZz2H28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DtgtCMl0wWmUQBw4N3Q9MqMtUwQnWSqx4PIACZcBNfDY7xTZ/GK0VrJUnKO7U91BA
	 DszHIAbIi9OxOvkkyV6XGYAVrHpPr8OeUSOWZVJ+jbDQ8wJOy67H9uqG28cfP8tzgU
	 UPjPs48VRFad2lJctRkqwE4tVWpHbyVu7KvD/SEmT4ECRUAJSeOuQ3lj9j1Zff2MJE
	 qg0ftvFZ0jPRFtiSX9xqjGIj9FgF+zSbk3G5QY2S4/hEX+kpk6WgbnUtnLzoP75bbL
	 JGiv7R/Ie/b4wC+ByaSkEYX0TUabilg7zBf3nw1CDUDev7KidF/68nLHb+NpR/9g/g
	 lHiRmBNI3MMXw==
Date: Mon, 31 Aug 2026 09:53:28 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Yang Zi <2959243019@qq.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: pata_pdc2027x: fix division by zero in
 pdc_adjust_pll
Message-ID: <apUy-Im7MroUT54y@ryzen>
References: <tencent_FA2F5F31DC5009EFE7B38D19D754AA6C4507@qq.com>
 <8418baf3-4a3c-4011-ba5d-a9c2e4ea893b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8418baf3-4a3c-4011-ba5d-a9c2e4ea893b@kernel.org>

On Fri, Aug 28, 2026 at 02:48:06PM +0900, Damien Le Moal wrote:
> On 8/25/26 17:32, Yang Zi wrote:
> > pdc_adjust_pll() divides pout_required by pll_clock_khz before checking
> > that pll_clock_khz is within the valid range. If the PLL input clock is
> > less than 1000 Hz, pll_clock_khz is 0 and the division triggers a
> > divide-by-zero error.
> > 
> > Move the sanity check ahead of the division so the invalid input is
> > rejected before the ratio is computed.
> > 
> > Signed-off-by: Yang Zi <2959243019@qq.com>
> 
> This is needs a fixes tag I think.
> 
> Other than that, looks OK.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Hello Yang,

Please send a V2 with a Fixes tag.


Kind regards,
Niklas
