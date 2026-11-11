Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386312;
	b=e3XKS3Y4c4hQSYOxLYSiU6FWxLyx9mMFL8Hu7lQaM0oMss3uRktWaJmXym6texLfMnKU
	 gv+V7XCE0+w6OZ1AmqrxNYwDLr3teMFP/T2oFF3V67OA1To/4tRqPZoPKlfzzACb/BVAM
	 XcxtBsnl88bZNYzaGbA8OgczWYI7zxB3pkZQFXTG/tAyjWzw7lLmbN+3792tqA1CcEKZt
	 PhewE6g2rcyU9teV8sbukVO6CvTZFdt4dkYSmnC7mowwlHYqZ3lUclecT3GK0Z4kvU4hE
	 rwuYzBhRI3O8+oAGEl2i1OZmoFPiemYZM5rEig7SbcvRp+F0ttvcU8hhzJv3o7VbCmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386312;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tnRZdc6pPanIFGOHFfotmOvahDjRevBjIUfUi8ZUfS8=;
	b=Q2JysQ1yDssSMJj1IL5IQPPHFN0Iepmq1IXn3cI6d0ERqHJV6hsfOCfhqwUBdVA7GUnf
	 VUBU5jj0ZaXkpJW04S4jiLhYYidXCCBUOqbsK8D+HpIiUIlwvLXjw5eYMVE3lyeUzeFYm
	 DKwhN48jG6OwnsuX9Z9R5Dro7wsIzsL4aS+ff8oHkQJ/jpnIjmz1p9o6+MnvLzpgtHmDq
	 eHjhipZM9NvycgamaQapkm+QRgr7358fwCBwzQeqAVpIFC0AMNL6EJGH4s/gWQ1up9mET
	 MaropPDEMaAGfXLEeuYRfi6j5wtazpl53C8PP4vlUXRYaPPn0PLgebrFP0NApqlrWSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXudsq1e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BE8606A320;
	Wed, 11 Nov 2026 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXudsq1e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912C31F00A05;
	Wed, 11 Nov 2026 08:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794386312;
	bh=tnRZdc6pPanIFGOHFfotmOvahDjRevBjIUfUi8ZUfS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bXudsq1eylol36ELo3+1fX+VipPgsFy3hzS7QavXUEdIjQh1BqkZow775WPpUm6jQ
	 Ij1FwBoPNUPBg1O8AZAWL88Cy86ZEBgkN44QnwEz2/dslPnlrnXof0azDiauHVH2dU
	 gsGp4S05XBa2raFRmwsCxFgnxwN5Ff1dpYibsdyY7PF9fgfQR2iPBtwXE7JWLAvRaI
	 n1lg50IUt/hs6cejAfRCsiwAqTTuExvl9dGOrpPE9pMeFGm+Ul70U2hIpEUjMXmUdV
	 qYuupUiGGGF2zga6u/GMHUBsagiKkZaV1TyT/YlvH53PGMNHya4g/Gj0aNDwaw5akg
	 OWg/Anelx4lIA==
Date: Wed, 11 Nov 2026 09:38:27 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-ide@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3] ata: ahci_tegra: use devm_kzalloc_flex()
Message-ID: <avQpg7e6cVWhXjHM@ryzen>
References: <20261111023939.75386-1-rosenp@gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111023939.75386-1-rosenp@gmail.com>

Hello Rosen,

On Tue, Nov 10, 2026 at 06:39:39PM -0800, Rosen Penev wrote:
> Combine allocations into one by using a flexible array member.

Thanks for adding the comment and fixing the subject.

However, the commit log still does not explain the benefit, so my
reply to V2 still applies:
https://lore.kernel.org/linux-ide/ah1HD1aOyTnMBEqD@ryzen/

A flexible array member also has disadvantages: nothing can be added
after it, and there can be only one per struct.

If we use one anyway, it should be annotated with __counted_by(), as
Damien and I asked for in V1. devm_kzalloc_flex() calls
__set_flex_counter(), so that should mostly be a matter of adding a
counter member.

Since neither Jon nor I am a fan of this change, I will only apply a
V4 if Jon explicitly asks for it.

Kind regards,
Niklas
