Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369BD2D5C8A
	for <linux-ide@vger.kernel.org>; Thu,  3 Jul 2025 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534424; cv=none; b=VY6EUBSk7thjL9rzQxbtcDEbUd7x/tFDjunwKL0Y9z4i4RK0bC+cr6+nTIWYwct/K3Lq8O8w8rHH0FbstQwOaGD8YTDWUt7Sw1UTjJLIJDnhvn2RFMRCp6rg/qqrotZxWI2JxFgYKboQ8F5G2oKduWlM4wRrJGlvQ8i/CYcHKG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534424; c=relaxed/simple;
	bh=H+xHk1jF+LMSHF9O7adlRTUma9YxV/arnR/R+gFqrqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jmy6N8gOrC9DTojlOIicnzFAM3i55hHDDg+jOWpO2sIwBj3zj8FVywyBCZpa7fwY7vh1BVq7zAwnfercNHWJxIVOD4kR0AME6sHCW73N3I8A4JkiJrg/4ohmjPWc9a3Aurp2x2FMoJfRuihra5h0cT9sd104xQwdncQLrRV+uq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGL5zK9U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGL5zK9U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FBBC4CEE3;
	Thu,  3 Jul 2025 09:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751534422;
	bh=H+xHk1jF+LMSHF9O7adlRTUma9YxV/arnR/R+gFqrqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XGL5zK9UHkS+X2052yUxUEqYk22B96fW/fJEqTU6ePFD/Mc3wMGbjVimTVG72Ietj
	 lhSt47ffjzKnAMwwGmf0PCPpodzyxYlAzU9ZDIikvui/lNw+J7G3H/EiM8ERtfJXHj
	 CRn2xejQjHnah4Btz72ojZNijxM/5Pe43CCMe5OlQp7D6s+ABaRSq5T76hQTOWJCKf
	 jvM+2IFVJr9dLhbHTxMnmhBP0kYP/MdDLgjih46255JKprnX5BoJ4haGU1uUl8g69I
	 cFglN9A5tln+vWp/dvKo4odyMQsw8KWyIrRKtXLbTfk7fT3OtafiD/iqm09yhtMrhp
	 /540T6w/zetlA==
Date: Thu, 3 Jul 2025 11:20:19 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 2/3] ata: libata-core: Make
 ata_dev_cleanup_cdl_resources() static
Message-ID: <aGZLU7eAbyagCTvb@ryzen>
References: <20250703071541.278243-1-dlemoal@kernel.org>
 <20250703071541.278243-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703071541.278243-3-dlemoal@kernel.org>

On Thu, Jul 03, 2025 at 04:15:40PM +0900, Damien Le Moal wrote:
> The function ata_dev_cleanup_cdl_resources() is called only from
> ata_dev_init_cdl_resources() and ata_dev_free_resources() which are
> both defined in drivers/ata/libata-core.c. So there is no need for
> ata_dev_cleanup_cdl_resources() to be visible from outside of this
> file. Change this function definition to be a static function.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
