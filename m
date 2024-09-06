Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F9A1581F0
	for <linux-ide@vger.kernel.org>; Fri,  6 Sep 2024 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612102; cv=none; b=bNa2tGkn0GOPWDdacAqN868ho5n7bUO//5vvDwF83pVWjDrXw/a/Z2oGOhN8R9fobYiUgx3aV2ZqvffcJaPn2Ilr9yveVhSxCOu187LGPduSeGyA+yO6YZLc1XwFvP0kyq7fIogRzYHsoXWjrG8bUnFMoQgi6j/+JWw52W4IRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612102; c=relaxed/simple;
	bh=71/dkBxSdf+jFgxh0lnfbc2fpc5x/JzHjlTFNIgeEfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKXQJCQNOTSrRUNzHGimjPmF0vJJuklYgbGXApGhqwceEWP6Px9GyqFyeM+T/pzF8tcsD3EUlF4Yg30yFX/0DO2xq8kvRpjxO6j5rAyP8c0W9kQyR8bmjrFTYU4sGqmzcS3RnhtXpOiubgRH8qpPPpJmKIZJu2h7qFPdB3vh1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtKDi8Z9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtKDi8Z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8329EC4CEC4;
	Fri,  6 Sep 2024 08:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725612102;
	bh=71/dkBxSdf+jFgxh0lnfbc2fpc5x/JzHjlTFNIgeEfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtKDi8Z9p5ARWbqs5HviWbavNwsX7DNRcLDxMw7TIUnx/BT8Py6tspe580NrmplP3
	 kDEODIBmhwVt7q3GZzL44raNzOt4OiQcq5yv5iZtx4cj9l0p2b8ac+LRjOQQWm9E3J
	 xX8UExpgx5vtz9lEwQPJ3DTtFZOnsmLKDxAc5udV4kVoBLgboxX7WvpR9+Sdk/6zeu
	 LvAQoei5hJq345WHh7wW4SIk1DOnDv+07whjUvR58qmOcK/Lv0eTo0s5NPCLmmGrod
	 Wn82iG44RaNrs4wu7a5RzEOmGkUTFrRgvQy53upREvHpfWfEzDM2kyxkdkcV8/u8r1
	 UhXSpTXjT6+nQ==
Date: Fri, 6 Sep 2024 10:41:38 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v5 8/9] ata: libata: Introduce ata_dev_free_resources
Message-ID: <ZtrAQglvS_6ZKzhq@ryzen.lan>
References: <20240906015847.229539-1-dlemoal@kernel.org>
 <20240906015847.229539-9-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906015847.229539-9-dlemoal@kernel.org>

On Fri, Sep 06, 2024 at 10:58:46AM +0900, Damien Le Moal wrote:
> Introduce the function ata_dev_free_resources() to free the resources
> allocated to support a device features. For now, this function is
> reduced to calling zpodd_exit() for devices that have this feature
> enabled.
> 
> ata_dev_free_resources() is called from ata_eh_dev_disable() as this
> function is always called for all devices attached to a port that is
> being detached and for devices that are being disabled due to being
> removed (detached) from the system or due to errors.
> 
> With this change, the call to zpodd_exit() done in ata_port_detach() is
> removed as that function starts by removing all devices attached to the
> port using libata EH, thus resulting in ata_eh_dev_disable() being
> called and the zpodd_exit() function being executed.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
