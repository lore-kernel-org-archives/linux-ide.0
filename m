Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1CC1CD00
	for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2024 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705425185; cv=none; b=MqAx+EdVEw+lLDmY8NwXPlIhUMlPw1Ovcj+0JNuJrcnyBSzy98JBdWvcZotuLfZWVDPS46LDJpzoFCQvVQxMQ/0qdiSP8k22Ox2MFoVhWqIlkndahXgzxXcqujusJrKqy+gGuc70jBo1NXOrkzqTYcOGQisA4x4hLjQ7IdtXQz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705425185; c=relaxed/simple;
	bh=SnDEBiJXSHRS0Cw2yrYXGF1BI15W/Y+Yk7GBylDkXkI=;
	h=Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:MIME-Version:Content-Type; b=DhjuWEQNonXf+HUSwOEfSkKFP+/xAMMDVydl4DXbionqL25HqvDiIq5PqnibCWK4wOHMdgqyMX/5tMCcdVYHMlv1lqsKcwNatL9Fz7rA9Q58l7fDfZdZDUQ9THXgB0+OKVjEy6h7UqRds0mRX8iYeUtB0zJT+pILh7cdgUzhwCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 65F231537B3; Tue, 16 Jan 2024 12:13:03 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 3/3] libata: don't start PuiS disks on resume
In-Reply-To: <b76a1b51-7dc4-4055-b7ac-a8265a3957bc@kernel.org>
References: <87msthdo11.fsf@vps.thesusis.net>
 <20240107180258.360886-1-phill@thesusis.net>
 <20240107180258.360886-4-phill@thesusis.net>
 <e6f6aebf-0566-4113-8304-bccd88926f20@kernel.org>
 <871qasuepz.fsf@vps.thesusis.net>
 <b76a1b51-7dc4-4055-b7ac-a8265a3957bc@kernel.org>
Date: Tue, 16 Jan 2024 12:13:03 -0500
Message-ID: <877ck9b3s0.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Damien Le Moal <dlemoal@kernel.org> writes:

> We never add dead code. And code under a "#if 0" is by design dead...
> So please do not do that.

I left it that way temporarily so you could switch it to an #if 1 if you
wanted to test it with your army of drives to see if any of them don't
like it, and to see where I was proposing a runtime selection knob to
switch which branch the code would take there.

Would you be OK with leaving the PuiS -> SLEEP transition code in, but
disabled by default?  Then people who know their drives are OK with it
can choose to enable it.
