Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530566;
	b=e7Hh/JpkwChIObCRlzbOF696bjTwZyX+oCG7RJu0DUjicywQgUa4gJuXWfqniXPL1uN/
	 ///HHBSbhD3SiWvEI1W47/x/0+KNiUX5hnUccAUcBBK9roJMZaA0lAvBf+OY7uuAEjNvS
	 /qFED39l25z/HYQwicfGH3uBs6aMRqKlUPO7ZzEWjKAU7tlvjFLpN5vFYHj6OIRRl/Luv
	 F4BJPTZaH6RZ8RmEYgnmLMpbYiZLJRChbOWvRjeuy/1nB2NuqGnHSb3Kkt+KnOLz4wg7b
	 nrNtVpIwGIsSTHiSi9EiY68XzLBWgEIS/645YHA3gjH0Cygpw77uK4qHoiS4VcgJNzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530566;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PxxCaJIqknia6ac+c48SkpD1XjTsEIo4lgcRMWH37Yk=;
	b=Qf6S4sIH/QEmf7ijJGdz0noZdJhGLJEsTyiB28KWY4e4sPNGc6mkD+FYDFi8RjRQhTOn
	 vWGidtyb34ip3FFGc7x5+tKzATk9oA0dhR8DoazOVu9cbOS3WSJXESXmhtWxvjT2SmCwn
	 m3iZt3Cuzif07jlPCMavTdHrKj6/uVJ9zR+KclATCQJDxFfMRO95fgqdqjhipN/Q/7+up
	 PCghJ2ETRqxaf1B1XPluUvKeCyAcoxgud3kc9fKw4igpitTBigMp/mA3SYpb5lOcCUK3C
	 PX3KxOj+h+/My3KljA3vEAFpzqVeRCIuXe3nRMJfGXusbDbz63mF6VgmxfHA1Sjtyxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AgObrhSV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFAF606A319;
	Tue, 20 Oct 2026 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AgObrhSV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5531F000C9;
	Tue, 20 Oct 2026 21:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792530566;
	bh=PxxCaJIqknia6ac+c48SkpD1XjTsEIo4lgcRMWH37Yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AgObrhSVaJxNZ80VKxl2eRuQF9ugO8W4sZOnTK7scklsSWN/U+M/sTZu2gEZoKO2X
	 rVXXtEie5oznqTMl9DK17yFTRYCXBO1YxXVYQkiafLVoHs0QHFpFouppgky8hXqKh4
	 DgiNSt3W2zWMlkj22DrzMzjfxHuOB0qPjJxlEnKoZcDOYIGAi9nMTN5LHQa3FViIfp
	 GV8dTcgQA4+ONmfh9EvHgobPHWmow/2dWwTo5fQOlexfCU0td0NlBTQxu5wmiGrYSt
	 TFJkgfHlmULKfx1L+GU6tYjHWO+OHxxkoqzlZ6zGfQFYLEKdjwMmOLy/lWh1EfN4j7
	 Df76/YZ0nYLmA==
From: Imre Kaloz <kaloz@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 46/53] mfd: ioc3: Add IOC4 ATA/ATAPI cell
Date: Tue, 20 Oct 2026 23:08:17 +0200
Message-ID: <20261020210818.27215-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179198336665.839288.12369537253671309518@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org> <754bae380c938b63eeaa87e3dccf9755314675ed.1791890466.git.kaloz@kernel.org> <179198336665.839288.12369537253671309518@kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


On Tue, 20 Oct 2026, Lee Jones wrote:

> > +	{
> > +		.name = "pata_sgiioc4",
> > +		.resources = ioc4_ata_resources,
> > +		.num_resources = ARRAY_SIZE(ioc4_ata_resources),
> > +	},
>
> Shouldn't this have been added in Patch 31?

It should have, yes. In v3 the ATA cell, its resources and the
level-triggered other_ir bit move into the patch that adds the IOC4
cells (part of the split of 31 I described in my other reply) and
this one goes away.


Thanks for catching it,

Imre
