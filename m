Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E5244675
	for <linux-ide@vger.kernel.org>; Thu,  3 Jul 2025 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539731; cv=none; b=McDmDfw+zLwaH6eZ5Wn4TSujsfVdgNIisxevZ8qCYRwYHvoZBG22Y5U+jB73mBQjCK7TgkRfHm1YnyhAFaPvN4SCRwzPZniYk3T3Gvic6c9xEORWUlQwaL5tIAIdihCl8250o/ytdm1gohFX/zkDAtjqIZl567ztdUMEeavKxho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539731; c=relaxed/simple;
	bh=dEIB7crh0LFH3N4L2w9Q7d9IARaxRs0jythsX1Ax7xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntflaJaQByXpPCPmmft1dtR+IcNJE0gLigytUQW2RNi4oIPwHim9QRlO826B/1D/Lv0HjC3joq9X08xLkmolO8xO9r+BIn2etq5b1BnVZfJUBenHsY8A3dkyiq1xo1dPNViBcB6Vy1ykiqS+wpysvSs31HvZR5tdGPissGFB6o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5bsZuJW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5bsZuJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EDDC4CEE3;
	Thu,  3 Jul 2025 10:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751539730;
	bh=dEIB7crh0LFH3N4L2w9Q7d9IARaxRs0jythsX1Ax7xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D5bsZuJWMI/AmX73v7H22qfW0E5k1ft5CCwgR2GKtBl4ug0qfY71N77jSZr90qxFM
	 tJ2/ZNKp0iq8jZKPhLkEM9U0ZwGno0sd2MU9DSuLwszKKVPgvklM14XNj1EenMQPmR
	 SR4lzvdVEOXRQ4jqvDnGP7mJsoPsYlPrb4JW+VrkfS/PdqhDBIFiZbHeyjWP83VWjs
	 UKiPStoyi/ZSnpn/GHbxmE4ZK3rrZ+zmSuWkP+7pN9xZ9/m3W7Vjak21gaR3awbwi6
	 qBveXNf6OHRJLrZ4EPbi3+wgtgpET44EPZjhQfNb7PdtA0t+Gih1v3GtURQql4Iayx
	 TCyYO4fWDcl2w==
Date: Thu, 3 Jul 2025 12:48:47 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ata: libata-eh: Rename and make ata_set_mode()
 static
Message-ID: <aGZgD0GhYZFQvTsS@ryzen>
References: <20250703103622.291272-1-dlemoal@kernel.org>
 <20250703103622.291272-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703103622.291272-4-dlemoal@kernel.org>

On Thu, Jul 03, 2025 at 07:36:21PM +0900, Damien Le Moal wrote:
> The function ata_set_mode() is defined and used only in libata-eh.c.
> Make this function static and rename it ata_eh_set_mode() to make it
> clear where its definition is.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
