Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A51FAA;
	Tue, 10 Jun 2025 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558684; cv=none; b=dAg6x+56+24p9IoRKItnzA8eL5pd9JUXpvF3FYRB1LNvat7NGirGJcIIR0GhMkzO1Ev5D6WF4HeYyb4AyJwJj+3uPL37Knkslf1NT/m8QJPsEeElqesUKb+varGwBnCacVr0lViLNVril7bZk0TzHHjGFzkQ4b0p5wQhO7VlWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558684; c=relaxed/simple;
	bh=8BwZyUXjZ+u8UfJhyh4/cxvJDU9B3jL/iOjUeYpFVbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jw0BvUXP+lCLlnEPpelT0b7ittK5H1pvtsdyZXhD4TprMwB8YtJWLhWAvSjDBl/wlLnFtBA8iPFy+RHNgfBACdq6qYUy8mQeqiEEvrJpnHcijOe7Tqnp0KgopU4Y30iHej3wNCFwoE1pL/AMAq0wXi+1shs+OVGywLcMzNkOzQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szOg94Fk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szOg94Fk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B56C4CEEF;
	Tue, 10 Jun 2025 12:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749558684;
	bh=8BwZyUXjZ+u8UfJhyh4/cxvJDU9B3jL/iOjUeYpFVbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szOg94FknpQD/p437CpZhtmGfuGU9iBCvIyiGyvAGjES/B5Bv1EtVk/cQKLiYpaqx
	 HC8Ctv6FmFjROi/be3vYb43tRZcU65C2M0M3DFHgbRdshmH+W/rmYI6En2YcuYE33z
	 PJpwvCHi3TYhSxxhhLv5n0z6dpubLjy5d5M+dgmNvvDliUOyCupqRZ3tBaZEtXfl33
	 lrJf83u9W5s8B36/Da4m4KwjIFjl7ZjxGA1DcuTKkKT9mwkiB9HI02fdR2Xjqh0O+e
	 hbaGF7JHK1tSf2UuMAIW2WvCL+Ng+dfqD7tLLh8Aoj+uwA0d4Jsf4GCx9YEH7aseij
	 3jKXCV3bRq55w==
Date: Tue, 10 Jun 2025 14:31:20 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: macio: Use non-hybrid PCI devres API
Message-ID: <aEglmHpvqZhbG_AX@ryzen>
References: <20250604113423.138595-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604113423.138595-2-phasta@kernel.org>

Hello Philipp,

On Wed, Jun 04, 2025 at 01:34:24PM +0200, Philipp Stanner wrote:
> macio enables its PCI device with pcim_enable_device(). This,
> implicitly, switches the function pci_request_regions() into managed
> mode, where it becomes a devres function.
> 
> The PCI subsystem wants to remove this hybrid nature from its
> interfaces. To do so, users of the aforementioned combination of
> functions must be ported to non-hybrid functions.
> 
> Replace the call to sometimes-managed pci_request_regions() with one to
> the always-managed pcim_request_all_regions().
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> Hi,
> seems I forgot sending this patch out a while ago. Mea culpa.
> 
> PCI has currently chained the changes mentioned above queued up for

chained?


> Linus, so it's probably a good idea to get this into macio relatively
> soonish. Otherwise the driver would likely fail to reload in v6.16,
> because the device's PCI regions remain blocked.

I can queue this up for 6.16, but then I think you need to rewrite the
commit message to motivate why it is a fix (i.e. why it deserves to go
in to 6.16-rc2).

Or, I can just queue it up for 6.17.

What do you prefer?


Kind regards,
Niklas
