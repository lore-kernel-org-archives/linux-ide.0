Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDE2219E8
	for <linux-ide@vger.kernel.org>; Tue, 17 Jun 2025 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750163458; cv=none; b=ougi5FLpT/B6dV0tRKdnW4K7YjhxHlnSdZ3NKjwobFX3YUPesKV/rkAhdzl+b7AO9oHQ93Ga0q1WOpDAq0pezWGVG7jFqMMNdwWLQ2o5Jz/a+lMiDH6P0JuvyfxAWcC+MfUamEUO8gZ24flLD8DGKyhu6pmdCqKDpKaR8YZeG30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750163458; c=relaxed/simple;
	bh=4h7sor+TvIylcvz0KOltkQDGzig8hYD68YSGB4DhfGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Joyvu529lbA58tFSdr5XwHBdH0M+YZK9a7s5lEBUQzyAGhqX0Trs723b/ZIHSsmkkMKFPfYmHbv3kiQIz1VSzC9MTSbt60upo047U3bzMLLULmjL20Ef9bdOxzHwy4DQbs68wOebTJYzphW7fr2lNRJ43NO0ujbPrXFvDXIAvBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8QVud0i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8QVud0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71A4C4CEEE;
	Tue, 17 Jun 2025 12:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750163457;
	bh=4h7sor+TvIylcvz0KOltkQDGzig8hYD68YSGB4DhfGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q8QVud0iwgkAwxKQy6Aa14s8R6OdLEsZgb17/N15qChvy77OcIDASG148RbneILyM
	 G3PN1gfnrY80Gq7V0tmrXbZH0XbOmL7n1PRONn/JThzMBTQtfi0Hs0Wh+mAV7Jh72D
	 L3T5R9bBLzMa0qC/z6yjhbS5F6BppRK4ynsygmPro9oKiP8wrfmyyBrvfunLoKGZ1O
	 SA6fb8m/biPzy6ePQncHjBYNDsz9OjufFmePWjy8/kcH9/BDdWxDI6zhoIkBkNfX/l
	 VF1S1HZqgq29ADfu6B9PeClpH1GUYolC/a+XABokmDgsl7z5Xy+sagJs2dbVULx9mW
	 +v6ErgCSRj0Ow==
Date: Tue, 17 Jun 2025 14:30:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mikko Korhonen <mjkorhon@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ata: ahci: Disallow LPM for Asus B550-F motherboard
Message-ID: <aFFf_n9C0Qf-L5Qu@ryzen>
References: <20250617122609.6818-1-mjkorhon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617122609.6818-1-mjkorhon@gmail.com>

Hello Mikko,

On Tue, Jun 17, 2025 at 03:15:48PM +0300, Mikko Korhonen wrote:
> Asus ROG STRIX B550-F GAMING (WI-FI) motherboard has problems on some
> SATA ports with at least one hard drive model (WDC WD20EFAX-68FB5N0)
> when LPM is enabled. Disabling LPM solves the issue.
> 
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Signed-off-by: Mikko Korhonen <mjkorhon@gmail.com>
> ---
> I think we might include the comment about the non working drive model, as
> we have tested only one model and in principle this could also be an
> interoperation issue. If one would need to enable LPM for the motherboard
> and happens to have a working hard drive model, he/she would know
> why we have made the patch in the first place.
> 
> Changes since v1:
> - Fix typo and one line comment style issue.
>

I have already applied your patch:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/commit/?h=for-6.16-fixes&id=a7b3b77fd111d49f8e25624e4ea1046322a57baf


Kind regards,
Niklas
