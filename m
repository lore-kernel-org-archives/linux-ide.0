Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AA421FF29
	for <linux-ide@vger.kernel.org>; Tue,  8 Jul 2025 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976165; cv=none; b=rs+fNzZgPaYG1+/oQ6j8MSBFScoa4Hrp0pfs8NTHWnMLUpiPTr/y6v8oRB9A+Cuxw2eHHgBfdJ2JXxXdF/SqBR/feNKcc40mSfHKugr8NPZNK6FQOHXRFtJWE+9lI4nIY1FnFZo+sDm56wEa1xaVMvdDBGctSwcdSqkLigp/bMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976165; c=relaxed/simple;
	bh=nmUfLPOKqyz1DsYnqSK/giyges6nhberJgfzupjKl+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1LToBXRIzqw3tGOzB4uLpcdjGY+dhsKEJmFe4ie9pNnXScBBfDV9gmAKKx4f3aev+zK8zxpQgTdZach6me/h63tHL33iiGnA32xdpoTcq81ukUq8T3IAPPtRYkFMJTQyLPBsNYgEDvpkgsXt3ynm6fXU0nd9lh2Bwzob3xSKwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kimgHucY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kimgHucY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9FAC4CEED;
	Tue,  8 Jul 2025 12:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751976164;
	bh=nmUfLPOKqyz1DsYnqSK/giyges6nhberJgfzupjKl+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kimgHucYWk7+P5K1QUI9kwF4PKRBv4NVnvC3qvLMMLsV5+RKRJOR/SBftK/yXdunw
	 zrrZqXIFwkC5BWJbT9qUSwL75P2p5PPqK9Kz9Co2ui2efGLkGDfKyG2iQvMzAhR8UX
	 7eKdSA1qtD4sKSqOPIkqsf989PlP6gD1Zbs0GQkGavV0ZGBXp6f4ENtohl0paRax96
	 cCmCeiSkElXrfNcdgj4CmKA6N5eGpH398B7wuJq3ZSsnTBvM3AyjOWHNJSo7Cm835S
	 qoAsIKyzXweGm1qltF2+23BzMw4hH839NGKrJs0sN3bSTxnVrcn4bXpJumMGfPCfcY
	 CB8CNsupZ2cQg==
Date: Tue, 8 Jul 2025 14:02:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Documentation: driver-api: Update libata error
 handler information
Message-ID: <aG0I4WqMn6vM8aSc@ryzen>
References: <20250708073648.45171-1-dlemoal@kernel.org>
 <20250708073648.45171-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708073648.45171-4-dlemoal@kernel.org>

On Tue, Jul 08, 2025 at 04:36:48PM +0900, Damien Le Moal wrote:
> Update ``->error_handler()`` section of the libata documentation file
> Documentation/driver-api/libata.rst to remove the reference to the
> function ata_do_eh() as that function was removed. The reference to the
> function ata_bmdma_drive_eh() is also removed as that function does not
> exist at all. And while at it, cleanup the description of the various
> port reset operations using a bullet list.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  Documentation/driver-api/libata.rst | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/driver-api/libata.rst b/Documentation/driver-api/libata.rst
> index 5da27a749246..e160ef2e0791 100644
> --- a/Documentation/driver-api/libata.rst
> +++ b/Documentation/driver-api/libata.rst
> @@ -283,18 +283,21 @@ interrupts, start DMA engine, etc.
>  
>  ``->error_handler()`` is a driver's hook into probe, hotplug, and recovery
>  and other exceptional conditions. The primary responsibility of an
> -implementation is to call :c:func:`ata_do_eh` or :c:func:`ata_bmdma_drive_eh`
> -with a set of EH hooks as arguments:
> +implementation is to call :c:func:`ata_std_error_handler`.
>  
> -'prereset' hook (may be NULL) is called during an EH reset, before any
> -other actions are taken.
> +:c:func:`ata_std_error_handler` will call the various port reset operations as
> +needed.
>  
> -'postreset' hook (may be NULL) is called after the EH reset is
> -performed. Based on existing conditions, severity of the problem, and
> -hardware capabilities,
> +* The 'prereset' operation (may be NULL) is called during an EH reset, before
> +  any other action is taken.
>  
> -Either 'softreset' (may be NULL) or 'hardreset' (may be NULL) will be
> -called to perform the low-level EH reset.
> +* The 'postreset' hook (may be NULL) is called after the EH reset is performed.
> +  Based on existing conditions, severity of the problem, and hardware
> +  capabilities,
> +
> +* Either the 'softreset' operation (may be NULL) or the 'hardreset' operation
> +  (may be NULL) will be called to perform the low-level EH reset. If both
> +  operations are defined, 'hardreset' is preferred and used.

Since you are mentioning what happens when both are defined, should we mention
what happens when none are defined? (None of the callbacks will be called.)


Reviewed-by: Niklas Cassel <cassel@kernel.org>
