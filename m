Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E477D3CB8FB;
	Tue, 30 Jun 2026 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818190; cv=none; b=Ru4N18F8wUmdmO4nW+yrXWH3cNcJqeHd/IXpyEtHvfWYRLihGf2ty6B3eJ623jQZxd2E89yhYDP1r0nh8e29WWElqFmrfGtYx5KEeh2xa4Gq6zWRh1jWjj4Z0Y6uOfeLma8m7oA3adK8X3ESkHnxTRyNIHI2mQM99wlQyHUNNQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818190; c=relaxed/simple;
	bh=pdoMaeV9JXf0yIggbKyt+j8Fr3sd4SZK4CFbRTGUPZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5kUOZ6UhjmAKXTHltWNdqUC0mVksnYFzgOoqN0k+AhBS82rLL4MNqvzjw2cyOAHTaBe5XmLgBI37NCL4tAtKGFEtbHgzD4Cc8lLfOnbCKk+bfJ9Z0bnLcEvaj06Onq2L6GIt78Ox+ZIQbcrIuzCD4i3J9ZU4V7CO/ZYAlxmrJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLzx5/Kd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLzx5/Kd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DBB1F00A3D;
	Tue, 30 Jun 2026 11:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818189;
	bh=OTPDtyFyxvlvcrv0KSLHZYeZFeNEnS0M8VoXDwD3ZB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OLzx5/Kd7HLop/R6N1oLBUN2mlpBZDXzkJZq41o/fMSVV9WCtEfir7/sczPcjjRT8
	 44ethiD+mJfCoYrDNF3+RlpFHVvzSc/D4ySZrXRtAVtxpKM+3W78jGRN7/ao32YmSj
	 wfiuP+9QMTki41Ng+MosgVnz3jM9FDKW9Mw5yFaAjZVcFOCpZLS/cpybSuRpwZLcyL
	 KSKIxSvvU7Qoc7wDeyfJ1+J02jVtE8K1p7uDdeC+eTaiep/VPRFkN6mSJ/7TYErytJ
	 ZzyuC69MxDY6qE+tAKIpKyBUuu3Ygx6STP1O6FlPb/IRSOVD5LlTQNWW2J88z9KMbo
	 2qB2rNdOw8R3w==
Date: Tue, 30 Jun 2026 13:16:26 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: sata_dwc_460ex: use platform_get_irq()
Message-ID: <akOlisttYmSoyRsl@ryzen>
References: <akNzEGgiYC5V3rtc@ryzen>
 <9327f32a-5037-477c-80dc-f99b97ed9740@kernel.org>
 <DF85BCA7-B344-4AD6-8F6B-22CB3A3DF823@kernel.org>
 <CAKxU2N8uWY3k3nHTmdxEn86zEZ_hGJgyPvHWuHt=zRaPk-29kg@mail.gmail.com>
 <CAKxU2N_2N0YWBrF1k82qXCYYyvZxa26GYi09xiyKbBAtUoC_mA@mail.gmail.com>
 <743a2748-a458-4e65-a1d2-f54a6657e7a6@kernel.org>
 <akOHEDdu3zw9Uhph@ryzen>
 <2865750f-9bab-47d8-b4c9-9cf1cbef7834@kernel.org>
 <akOSrMbpFIO_VLul@ryzen>
 <d691ff29-6712-478f-90f0-467394d6e84e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d691ff29-6712-478f-90f0-467394d6e84e@kernel.org>

On Tue, Jun 30, 2026 at 07:06:55PM +0900, Damien Le Moal wrote:
> On 6/30/26 18:55, Niklas Cassel wrote:
> > Sure, we could create a dummy / stub for that function, but to be honest,
> > I think my earlier suggestion of just using dev->of_node directly within
> > the ifdef, and drop the local np variable would be the smallest change.
> 
> Yes. But I am not against replacing that ifdef with IS_ENABLED().
> That's prettier :)

That is possible if we create a dummy / stub for sata_dwc_dma_init_old()
(since that function is currently defined within #ifdef).


Kind regards,
Niklas
