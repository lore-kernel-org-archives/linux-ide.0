Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA8955E51
	for <linux-ide@vger.kernel.org>; Fri, 12 Apr 2024 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923165; cv=none; b=tSYSQwNtu1G9Rs2FjluRrMqAQtzuk8gDRX2xTg8mtKf+PTAoPsYkd8e+qmEi28+OY2UI5ZUD9kw7RAaxp6fhgxk2SHVB1XBWMOxCpRm3M/y33eTfL7ZBMQ9EYokNwJio5Q55ruV6xMdpHbnuRf/i7sf6xqWL+KxabNT0Nej4V8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923165; c=relaxed/simple;
	bh=rMs1Y+mNd76snuyENNjI5XbjO/GXg2eX9Q81eU4FGLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMWANS9bNCsIjQslbdrxyYFkEshEOUNosjxKb1Td66UGZbcd8UWZh6QhEUrfwAuf4BiiLPnd/LqJWq578iDkb+CcC15ilb27g8BcNsYf12kqIsTNfnV/udZ9XVXdrFr941kfVy4qpXfFmNFc8RzLTxefM7SfCnWti2UGu7lDn/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDDKlLHM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDDKlLHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0E7C113CC;
	Fri, 12 Apr 2024 11:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712923164;
	bh=rMs1Y+mNd76snuyENNjI5XbjO/GXg2eX9Q81eU4FGLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BDDKlLHMjvBwZErTMfQh0WMHq9zaj97F0zYuFerkgyPzTRxyyUP+/WxdTBVp67OTM
	 l5f4anD+oAdrPXfPo7BmcmW4ivsLRzAAoaaxHj7XXRAhMRxS1flNGamPk6WVJLdj5p
	 DOAgMA9hAAbLLGRs+gwQawor0tBG6IN6c7EoH/rPqo9+Nlot7xJZjVQ4z31tRvYyS+
	 7dwEalUrrJVEqPMlZaVvi7NJ4qeLkA/hdMc13PZpXLdujUPT3W5lW2nrr4Mt12W161
	 5cZ9dw79omWDLHKdQOriE0+3TUvPZD+Mh1F5CG97egYjQfnFiaNQYE0nj6AYkOpNrC
	 SFm6TaMWCB9jQ==
Date: Fri, 12 Apr 2024 13:59:20 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-core: Remove ata_exec_internal_sg()
Message-ID: <ZhkiGJAzXjn6cc2s@ryzen>
References: <20240412001528.964063-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412001528.964063-1-dlemoal@kernel.org>

On Fri, Apr 12, 2024 at 09:15:28AM +0900, Damien Le Moal wrote:
> ata_exec_internal() is the only caller of ata_exec_internal_sg() and
> always calls this function with a single element scattergather list.
> Remove ata_exec_internal_sg() and code it directly in
> ata_exec_internal(), simplifying a little the sgl handling for the
> command.
> 
> While at it, change the function signature to use the proper enum
> dma_data_direction type for the dma_dir argument, cleanup comments
> (capitalization and remove useless comments) and change the variable
> auto_timeout type to a boolean.
> 
> No functional change.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
