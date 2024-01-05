Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DBD2E821
	for <linux-ide@vger.kernel.org>; Fri,  5 Jan 2024 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id D3ACC151F3D; Fri,  5 Jan 2024 11:18:22 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 2/4] libata: don't wake sleeping disk during system suspend
In-Reply-To: <864cd267-b113-417e-82ea-c760d5e8c664@kernel.org>
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
 <20240104223940.339290-2-phill@thesusis.net>
 <864cd267-b113-417e-82ea-c760d5e8c664@kernel.org>
Date: Fri, 05 Jan 2024 11:18:22 -0500
Message-ID: <87a5pju52p.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Damien Le Moal <dlemoal@kernel.org> writes:

> The comment should also be improved. It is more than a "no need" given that a
> sleeping disk will not respond to any command... So something like:

Good point.

> 	/*
> 	 * If the devices is in SLEEP state, issuing a STANDBY IMMEDIATE
> 	 * command will fail. But given that the drive is already in a low
> 	 * power state, we do not need to do anything.
> 	 */

It didn't fail, it just caused the drive to spin up, only to spin right
back down again.

> Other than the above comments, this looks OK. And this probably should go first
> in the series with a fixes tag.

I'm not sure what I'd point a fixes tag at.  I think it's been this way
forever.  Well, at least as long as SLEEP support has been in, which is
basically forever.
