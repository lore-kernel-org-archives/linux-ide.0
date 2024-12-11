Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734D81F0E46;
	Wed, 11 Dec 2024 21:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733953775; cv=none; b=e4PpDMJC6h1xa9u725NuXmwTihoFrFfEgGSiQdpLjjqcJu3gOvJarhuR2e1kfCmAyN8OWhhZ7BYsZRZZ/IGaskYkbfAoqWdGGrUbbBPEJR6ElJp6P5UhYPaWTA86gAmqeVg51mmEkeRSAplsHAMXutw5eBp6PYrQl4XFoRBid84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733953775; c=relaxed/simple;
	bh=M3VYE1fkYXJOpTlxEoXKr0jePHi6WHdNKQA6iivFvdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtmO1rGJhT4w0b/Fhu6C7Imwv2nbt2j/G/Z+c7lLRmNaCtqTREJHLAy4Hb8hdxYUq/dNJC48oXiVJLbwIedEQpq/F+YzwIc0DlrAhsXinlofKXFVrwyyX+WXnI0eZaTDWNVpaCbYeRno8/2LAgDtHNgPbq24ELn/YwcSf7V74gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ESMRf68M; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ESMRf68M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=YvFl5vXBOHL4Yiib0tLp9DkGN23UexMQ09qm1i2a69I=; b=ESMRf68MbRX49I6y
	OA1xFHdtcc+HfksK2R9XVUHqsSepvZKBV1DsoVMc8NG1vniU+0bmF1mxOOcVM49LGlZhxCtxxNfq1
	HhI5XmDtaBzsd8MrCLNLGpcfbjtncg7seWhnQlmicOCLpKhAHY3lok5ZIQW6rm5ff9ARvfYy7tEdx
	x2MYeEXCyE0iG2lCvB5VNpNKxBUIPQpT4ziaS0LgRRa1IUybVIHQ6y4/az77tdyvz3FQSmur0VGio
	pCcYDlB29YE9RqYgZ9FrALqUByhmK1E6/2J1kIkiCvEgvoG7d6E2cHMwNmh1Cj/A6wQRqML1xCC5U
	S0WceRwfo10bRWFCcQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tLUaH-004rZO-2V;
	Wed, 11 Dec 2024 21:49:29 +0000
Date: Wed, 11 Dec 2024 21:49:29 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: dlemoal@kernel.org, cassel@kernel.org, p.zabel@pengutronix.de,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: sata_gemini: Remove unused
 gemini_sata_reset_bridge()
Message-ID: <Z1oI6cAAhGrcIVw9@gallifrey>
References: <20241211011201.261935-1-linux@treblig.org>
 <CACRpkdaarPM3vx6vAVhdSv+KHDZq6MTDo0JpQYGj1gJnaE7OrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaarPM3vx6vAVhdSv+KHDZq6MTDo0JpQYGj1gJnaE7OrQ@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 21:48:15 up 217 days,  9:02,  1 user,  load average: 0.13, 0.06,
 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

* Linus Walleij (linus.walleij@linaro.org) wrote:
> On Wed, Dec 11, 2024 at 2:12 AM <linux@treblig.org> wrote:
> 
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > gemini_sata_reset_bridge() was added in 2017 by the initial
> > commit be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
> > but has never been used.
> >
> > Remove it.
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Right it was never used because the corresponding reset in
> the low-level PATA driver didn't work so I patched it out before
> submitting.

Ah right.

> But should you not also remove sata0_reset and
> sata1_reset from struct sata_gemini and the code fetching
> the two reset lines? And even #include <linux/reset.h>?

Oh I see, I was just looking for entirely unreferenced functions
but that takes a little more following to notice.

I'm happy to do that; are you OK with it as a follow up patch or
do you want a v2? (And can you test it, I don't have the hardware).

Dave

> Yours,
> Linus Walleij
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
