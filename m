Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728BE7F8
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721991474; cv=none; b=OwaIJDIspwIS32lH7LCMqc9xmLR7DiKrUzPKjzRz3FS751rdSu8fX9CeDneKN3zoMPRT9gAZfcUamP75TOusYLM/De9iWQ2rSsoKASeROT7HEE2aJYZmNU4H6pgf5oc4MY20OYeC/gZqwxzBJWeDvZv0k7I+QwIFMe9V+pHXJcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721991474; c=relaxed/simple;
	bh=TwPlYKNsL9q6uWxj/sya5WR2OFSkrlll1WLma2fs0/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5Ic10ZcjLXVmjRdZtvWW1Mjmxzzj9ZjyOij1hL9xg+LdsjYAkEM98QTdQxYu4K3Gbecm62Kt+cCwx4i8X57+TD5hYv15R9eOqT6l6AJ1oNcs1ziYNE0a6ADcoa7TDn/TztmEcWEpV7EGNbCcKNBTJjZfXTnjTaGW8Xjduij+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCsR9KnA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCsR9KnA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7D4C32782;
	Fri, 26 Jul 2024 10:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721991474;
	bh=TwPlYKNsL9q6uWxj/sya5WR2OFSkrlll1WLma2fs0/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCsR9KnANN4lvnULwsIiN5QjQjfz0KsEN0UUy1CSx2BY/jFjDSthZ9/BfJB5iCH9P
	 Jp6yPnVdQeBGix4oUAnq8vK2+nnAFy/nkFEvL2H76+hYze9s1qkkD5bU0ekiUO2ico
	 76NGQ4hUi0N+cMYYpmuu4nDACmwIN52Or525X+4u3d8ohJ9LZpLZ/OYZYG2isjOQiQ
	 wmNfsESrdqjeut6VLQROmzKN5yBGtPVLQgAGxPvdPvQtbAQDG2WCMgDXKfNo35338t
	 2rZ3nTvhCyKbgSR6doSMom+E7Q9TH1CZ4qrtZetufKjQEAOHah6yFdeozwZNwkboYp
	 2iqqidTjcD5bQ==
Date: Fri, 26 Jul 2024 12:57:50 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v6 06/11] ata: ahci: Rephrase comment to not use the term
 blacklist
Message-ID: <ZqOBLpfV96Fd4LKL@ryzen.lan>
References: <20240726031954.566882-1-dlemoal@kernel.org>
 <20240726031954.566882-7-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726031954.566882-7-dlemoal@kernel.org>

On Fri, Jul 26, 2024 at 12:19:49PM +0900, Damien Le Moal wrote:
> Rephrase the comment for the eMachines entry in the sysids array of
> ahci_broken_suspend() to not use the term blacklist.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/ahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index a05c17249448..45f63b09828a 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1370,7 +1370,7 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
>  		 * V1.03 is known to be broken.  V3.04 is known to
>  		 * work.  Between, there are V1.06, V2.06 and V3.03
>  		 * that we don't have much idea about.  For now,
> -		 * blacklist anything older than V3.04.
> +		 * assume that anything older than V3.04 is broken.
>  		 *
>  		 * http://bugzilla.kernel.org/show_bug.cgi?id=15104
>  		 */
> -- 
> 2.45.2
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
