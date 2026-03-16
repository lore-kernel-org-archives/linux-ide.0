Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68D9354AC7
	for <linux-ide@vger.kernel.org>; Mon, 16 Mar 2026 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773652489; cv=none; b=GOwZGibhz/mACmZphCQ0bfkjhErmeXLgp+zIE6e1OuPKKyX48FYxIwy5JFbYw7NwGA1rR6qB76bIYIS0pxmhQ0J1RZ3ugb7rwtZTWY5IGL4d1Bjq5WIa0mFFRG7+hISh+yy0UaA79ySE3NRaQeDUGCNaghgPDlsLt++lt8AfBEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773652489; c=relaxed/simple;
	bh=jnhnpFbeIW9A2ys8bJfrGrPKaBhsmLinfPaziiLR0J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOxhyEKmKBjsZKAq6RHqW1St26BUvbaV3idY7is0zbo83hITEErIEfQLzy9QyLEzzDIRIEIQ9ohEOFZf4MPnTthc6bRM6GLW2sr/6K/QuM+pOQYNWKDfqyUSd2mZD8sN+Mtu+HzTjHd8UKBwWJMg7lxDIf+mcoynYjWSmojyVV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgrReNGd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgrReNGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5203C19421;
	Mon, 16 Mar 2026 09:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773652489;
	bh=jnhnpFbeIW9A2ys8bJfrGrPKaBhsmLinfPaziiLR0J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgrReNGd5ngzyIHvsqFmQF0RZ6o7OFj7VEeqvkjKQux95+U0XxIbyZ5BrYWYOHwwX
	 /ph9Lr3C9XfZx3xB3UVS/Kw08SHiQkfyqYqNvkeVQLCKqN1G6XaZl2DH6z3diRD6LK
	 MCPV+asm96IQF/z+Jg+rpl8RWN1L1IhV5Cg5tHasrA+1XtSL88D8KTS24ntzY4MDGA
	 rH3uz/mThh2ndMukz7Ucb21atR+QXf23f0YPI0m48lFKvQBpr4rni5hG1Gpv9Rpzx9
	 fWSlOUXIuZ0S6VuHmA/72CWcAzv9Wgwi9omezFmX1VYA7XtWFEGDZINB80EoePYmin
	 uXujPYn/sCRlg==
Date: Mon, 16 Mar 2026 10:14:43 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Mohammad Khaled Bayan <mhd.khaled.bayan@gmail.com>
Subject: Re: [PATCH] ata: libata-core: disable LPM on ADATA SU680 SSD
Message-ID: <abfJ_u-ycYyTDgSf@ryzen>
References: <20260314222415.51176-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314222415.51176-1-dlemoal@kernel.org>

On Sun, Mar 15, 2026 at 07:24:15AM +0900, Damien Le Moal wrote:
> ADATA SU680 SSDs suffer from NCQ read and write commands timeouts or bus
> errors when link power management (LPM) is enabled. Flag these devices
> with the ATA_QUIRK_NOLPM quirk to prevent the use of LPM and avoid these
> command failures.
> 

Applied to libata/linux.git (for-7.0-fixes), thanks!

[1/1] ata: libata-core: disable LPM on ADATA SU680 SSD
      https://git.kernel.org/libata/linux/c/ce5ae93d

Kind regards,
Niklas
