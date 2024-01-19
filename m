Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EDB56465
	for <linux-ide@vger.kernel.org>; Fri, 19 Jan 2024 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705697011; cv=none; b=hTJHOYHM/erfpGwyBPJpQcSgvyYDJyWfT43/M01iAhOiEQbhCfLZa2loLFGol4WJMFeylkAXaFMsJM0Po1cHc5aWDDM8mrqVw3knCcPM2g3/nkpXtNPvyPYGp1Qnw/B4QBRHWjT4kpJhwwkLLw2PdZE7omDErzKnM7ufYfl6CkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705697011; c=relaxed/simple;
	bh=e9kZ1nQKlsjJSGWkAEn2x8ylfEDanUogZpdmM561sig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WqQ9p/BIRF39MUkMhgx6h82KNs74pfD9AfHNNJPAhdlHHKvYqB1yUsuQBnbsKtNNZaOK3k3JQEcCVswtXEzO0rSm3gBLdIhIjg4sguErDN2guurBv5Jw0yE2ERwgPB32WFTXd5+5/PFoxWrTggd5mrTuhvNFZnxzxBEr4RjI3+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 0254E154103; Fri, 19 Jan 2024 15:43:22 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 1/3] libata: avoid waking disk for several commands
In-Reply-To: <87a5p5b426.fsf@vps.thesusis.net>
References: <87msthdo11.fsf@vps.thesusis.net>
 <20240107180258.360886-1-phill@thesusis.net>
 <20240107180258.360886-2-phill@thesusis.net>
 <f6110204-338d-42b5-8ec2-153dd862e799@kernel.org>
 <878r50uf97.fsf@vps.thesusis.net>
 <abd85855-0767-4e48-a8a7-8046cd339f9c@kernel.org>
 <87a5p5b426.fsf@vps.thesusis.net>
Date: Fri, 19 Jan 2024 15:43:22 -0500
Message-ID: <878r4l12c5.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Susi <phill@thesusis.net> writes:

> The block layer also would need patched to avoid turning a barrier into
> a FLUSH CACHE if the disk is runtime suspended, and also the sync()
> path.  Is that even sensible to do?  It is true that for all block
> devices, their caches do not need flushed while they are runtime
> suspended?  It seems like it may be, but I'm not certain.

I was trying to do this.  I think the right place is in
blkdev_issue_flush(), but apparently bdev->bd_device is not the same
struct device that gets suspended.  I can't seem to work out where the
right struct device is to pass to pm_runtime_suspended() and skip the
flush operation.

