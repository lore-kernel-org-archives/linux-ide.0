Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6141272D7
	for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2024 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934427; cv=none; b=Qtk0RdYDfLiHSy7YPNDaxP+XoKF2nLpM4K7tqLeQ5B29oAuOAwm1hzvvmgTGXBrIPzKo9G5+QtioXyuG6in/BAzeVtypBKrw/rCDzSNyTQikS/Yqbt8OQ9BiRWuWem17XXf/v+VipntZx0+lHVYLqRtDa23vRDLdClJJc4MPO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934427; c=relaxed/simple;
	bh=oE+zCqTlZFcxmaz9ZekWsm6Lt6TBpbjdC/o+WvAp8To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC45QpeiqArfJYphtUHMFgChJY7AVy58+XN9zhhDbarrPMyFbyl9YQdAoEqKoL/gTmTuJm89KHLhlMGRtO8cDNlcjwsJ/o2F+TreHWfxAZ5gQwTaqRbzRCZUZIhm9EHaomWXuOOR/tPPahzGc/1j8jPFywm5MFGicuCwGraoPXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxJE2ctX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxJE2ctX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E25C433F1;
	Wed, 14 Feb 2024 18:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707934427;
	bh=oE+zCqTlZFcxmaz9ZekWsm6Lt6TBpbjdC/o+WvAp8To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DxJE2ctXRTQMDlYHeE4mUTZYqIHgJuB9BRn7E/VJ80pPz3hsEFWPz0GVgXl69ifjV
	 wFP+McXWuddryNNMmEBxElQVpGDphYKVBz73FjQWKA7hRfcQl5r4W1FPahNjhy+P47
	 Jit11MU0qtPFpslNf5uUUfcA7Ly6L6Jmznrh8sTRVN/6wkhAoANVKaHQZQAtoe65PG
	 1a8vjLa1kJixFWbFYRBOETU8PCXyfR5sDSXcld40He8Uaj3XKz+e2qL4Bo8pRXqQIX
	 lYfNyOJit5CXwLlg/BNpDMXBO+Nntg7j5//Sz5pvaGZ6BiIaWHRHfJP5SzQzC1s6s8
	 La9akaQlh4bZQ==
Date: Wed, 14 Feb 2024 19:13:41 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Andrey Melnikov <temnota.am@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ahci: asm1064: correct count of reported ports
Message-ID: <Zc0C1ZKCMmJFpImY@x1-carbon>
References: <20240214165758.986896-1-cassel@kernel.org>
 <CA+PODjo_5u6hw8K8nNGR0-kRq1W_1bhBZJP9BCgL+VbFyvQY3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+PODjo_5u6hw8K8nNGR0-kRq1W_1bhBZJP9BCgL+VbFyvQY3Q@mail.gmail.com>

Hello Andrey,

On Wed, Feb 14, 2024 at 08:24:25PM +0300, Andrey Melnikov wrote:
> ср, 14 февр. 2024 г. в 19:58, Niklas Cassel <cassel@kernel.org>:
> >
> > From: "Andrey Jr. Melnikov" <temnota.am@gmail.com>
> >
> > The ASM1064 SATA host controller always reports wrongly,
> > that it has 24 ports. But in reality, it only has four ports.
> >
> > before:
> > ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> > ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode
> > ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst
> >
> > after:
> > ahci 0000:04:00.0: ASM1064 has only four ports
> > ahci 0000:04:00.0: forcing port_map 0xffff0f -> 0xf
> > ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> > ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA mode
> > ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst
> >
> > Signed-off-by: Andrey Jr. Melnikov <temnota.am@gmail.com>
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> > Changes since V1: use switch case.
> 
> I think we should stop abusing saved_port_map and convert all quirk's
> to use mask_port_map.

That sounds like a great idea to me.
Do you plan to send some patches?

If so, I could hold off this patch until I get something from you.


Kind regards,
Niklas
