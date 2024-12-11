Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED1C1F0E3F;
	Wed, 11 Dec 2024 23:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733961212; cv=none; b=BYDuMtK8SpeaK20MgUoVF7kuDVZPA0ZiE7UrqGPCrQNcYjtWe9kb/hXOS0bSoLe2JpKDryG54NNdy9cZ2Nyu6MvSIzZtvGCyTcFm1NYXSE70u+88XXknFPgR2qGx6DY6fs9UM/Gx1gm9v8SrOHIkl0LDQCSjQAO2H/6P2Wdtopc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733961212; c=relaxed/simple;
	bh=Z0qFz66WY89Gie8Jf7Vxb27a5pOyS61O6jv2c3z8Kwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvAPOTIOEiei7dSYWNxuamsOq7CtEETgFZ9jPA5b+HDY+7SueFJZX3DUmJf7uJIRtTZMZRXAUcVQNbXnYO2+Kk/5XuYACOinrVoRoEv2e9rxcYk+9LftwJ+/pfDHzDUbufoYEoHhiaR1qmUnkiF9Nn0eHN/E6E4j7JelYwpz2Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=BtFb0JiA; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="BtFb0JiA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=qMiEpycpET3Y3oNa+qzI9tLw4Jim77ikPqU3nrk3vKs=; b=BtFb0JiAU1ItkLVi
	PJ+Y/ubCSr1WD3leYshfATnSNQe5c79YXeumayX94Hg9e91bPr9G6IQY9XHmeX5w/NXk1ilk9s0Yz
	pJrYD675UwjUZF3KdlnwKsZWXAd7Ku5sZZi98gwfqhqKuAqRcH2vSy3V/eOfKVt+KrfpuCSkVHZhH
	ssGpzUYKfmZNiYjL7u/jPls6kKVwuXof9cDvbvq2f7yafTheuNEm347ZIvDlJPjxYpoGwanMkXfwz
	/qhxVSamKyLsd/aSwmjLwXBCN6JLMspSrufXhlSXr7MBhzENYE7hUN0JuYAybPmagcHCy1p4KVS0g
	7CHnpPlizw4w7H36Bw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tLWWF-004tTE-33;
	Wed, 11 Dec 2024 23:53:27 +0000
Date: Wed, 11 Dec 2024 23:53:27 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, cassel@kernel.org,
	p.zabel@pengutronix.de, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: sata_gemini: Remove unused
 gemini_sata_reset_bridge()
Message-ID: <Z1ol91qRiLu4vZES@gallifrey>
References: <20241211011201.261935-1-linux@treblig.org>
 <CACRpkdaarPM3vx6vAVhdSv+KHDZq6MTDo0JpQYGj1gJnaE7OrQ@mail.gmail.com>
 <Z1oI6cAAhGrcIVw9@gallifrey>
 <d74c3d02-e4e2-4f78-bf30-3940f50af39b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d74c3d02-e4e2-4f78-bf30-3940f50af39b@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 23:53:01 up 217 days, 11:07,  1 user,  load average: 0.00, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Damien Le Moal (dlemoal@kernel.org) wrote:
> On 12/12/24 06:49, Dr. David Alan Gilbert wrote:
> > * Linus Walleij (linus.walleij@linaro.org) wrote:
> >> On Wed, Dec 11, 2024 at 2:12 AM <linux@treblig.org> wrote:
> >>
> >>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >>>
> >>> gemini_sata_reset_bridge() was added in 2017 by the initial
> >>> commit be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
> >>> but has never been used.
> >>>
> >>> Remove it.
> >>>
> >>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> >>
> >> Right it was never used because the corresponding reset in
> >> the low-level PATA driver didn't work so I patched it out before
> >> submitting.
> > 
> > Ah right.
> > 
> >> But should you not also remove sata0_reset and
> >> sata1_reset from struct sata_gemini and the code fetching
> >> the two reset lines? And even #include <linux/reset.h>?
> > 
> > Oh I see, I was just looking for entirely unreferenced functions
> > but that takes a little more following to notice.
> > 
> > I'm happy to do that; are you OK with it as a follow up patch or
> > do you want a v2? (And can you test it, I don't have the hardware).
> 
> I already applied your previous patch. But I can replace it. So either an
> incremental patch or a v2 is fine with me. Thanks.

Follow up patch posted as

Subject: [PATCH] ata: sata_gemini: Remove remaining reset glue
Date: Wed, 11 Dec 2024 23:52:50 +0000
Message-ID: <20241211235250.136985-1-linux@treblig.org>

Thanks,

Dave

> > 

> > Dave
> > 
> >> Yours,
> >> Linus Walleij
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
