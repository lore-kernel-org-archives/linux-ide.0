Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98816331ECE;
	Thu, 10 Sep 2026 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060809; cv=none; b=ewc+laSQ0tazjTfjZoTLyDhGFO1dSK1tRVHbW8TF+c2+8oEOAMW3AldvW/nO+PvlE4/bUGy9w1mmJEqEisWGUM+dVpAu3u0ZLaPyUzkWi5/sYNLKpOpqxJwYEFNB/q0oz8+ljRF4zcg4+bVit7XswrKqxQGIQND22bQczK7LXAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060809; c=relaxed/simple;
	bh=XBr0kJEwPKSxxjdY4oM1dcTpoX7nbVAYdo4N3Ba/33w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUUiNYTr15zHm/Sf4QIEqUxihjZWd2uJmMjLtNZkn274C8wCcRcepU/Cx8IQu4+LFUXOOn/nCLmRp8YtPLBifFj1ZiKXVqidsh60FwwTzaXAy4fVXj3uceLdgmjUuXr2zPq6HjXbPtP+Mj+YtCNC7Ji8gq/P+SzkZDgQ9yVSe7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjT5ZxYj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjT5ZxYj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBA81F000FF;
	Thu, 10 Sep 2026 17:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789060790;
	bh=DrX4NOQJok5n2M/naSkHQ3webuu6aCc83fNaqLNjriE=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=JjT5ZxYjbXe7W0NJ0665wBdWFWmLz94HAfEnTsESs1nQC/dJp+j2WSfQWQSzVoF0T
	 TNDYTZEoqAeleSLHGdCz8ERu3BzfVvfDOQRMq4E2H39Csq/IIllWJlCIcesVybdZnP
	 xKpn7ot6zEYOJiYpA47T6p/pWoUPVxESkBx3IwCCW2scs19TqqjJmkY1oqCRuNf8w2
	 gPtBK2uNiQVLal9ODs5lt5EetpTiZ9LuBEAntWTZ9CQVJPftjxQ4ODZH10C5OWAmgS
	 wcq049gzrVsD0GAaqDLW4EPMh8X7PW4Xi35hZyvilWzPFDI2pn8mYbulaEcAY5+gls
	 9+FML5n2WpYMg==
Date: Thu, 10 Sep 2026 19:19:46 +0200
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH v2 0/2] ata: pata_parport: fix UAF on protocol module
 unload
Message-ID: <aqLmskJMHq2iMetP@ryzen>
References: <cover.1788867690.git.xiaopei01@kylinos.cn>
 <178895116744.2768460.12721406127250514018.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178895116744.2768460.12721406127250514018.b4-ty@kernel.org>

On Wed, Sep 09, 2026 at 12:52:47PM +0200, Niklas Cassel wrote:
> On Tue, 08 Sep 2026 19:47:26 +0800, Pei Xiao wrote:
> > This series fixes use-after-free issues in pata_parport when a protocol
> > module goes away while pi_adapter devices created by it are still
> > attached.
> > 
> > Patch 1 pins the protocol module before the device becomes visible.
> > Previously try_module_get() ran after device_register(), so a forced
> > module unload in between left pi->proto dangling from the moment the
> > device appeared on the bus.
> > 
> > [...]
> 
> Applied to libata/linux.git (for-7.4), thanks!
> 
> [1/2] ata: pata_parport: pin the protocol module before device_register()
>       https://git.kernel.org/libata/linux/c/5d3355c7
> [2/2] ata: pata_parport: unregister devices on protocol unregister
>       https://git.kernel.org/libata/linux/c/d82c5cf6

This series was dropped because of kernel test robot reporting
build error.

(Interestingly, Sashiko did only reported an unrelated pre-existing issue,
but did not report the build error.)


Kind regards,
Niklas
