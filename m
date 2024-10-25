Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DABE20BB5F
	for <linux-ide@vger.kernel.org>; Fri, 25 Oct 2024 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879867; cv=none; b=FgyktjxUsf4R/bFvclDNnrQZuEIxPWG94tDFUkFAYKoBire7K7SmRHwmgDi8zQL6ZavJwK2REQg03yaHkfzSBmf744DdumZ6iza4LU3VVslagqx6nTuGVXNyPCm3xBgzr8Q3tB6odLAEkx03cq3OcZnYwd2G2KHM5EB/1qT0aPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879867; c=relaxed/simple;
	bh=r9GbrJRkuyJsJewaHHVgVlGA5uigdW5HZaA3u/J7Pzo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qgGlhlG73R+zdFb3BSDPDtRVcG0xkPY8quuDs5+Xr5JIF/IVXv2QUjf9znVF4H2DWFzB9wXvoS5KPC39F5P9aSIt+hCXwZY/SVjgwS62Uz2DWs4ENI7NXjqRHIsbIXp2A3hZLgJMw8bdgybp83woSYx7wHrQ7twu6nnsXF68ZS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntaX7O0S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntaX7O0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21823C4CEC3;
	Fri, 25 Oct 2024 18:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729879867;
	bh=r9GbrJRkuyJsJewaHHVgVlGA5uigdW5HZaA3u/J7Pzo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ntaX7O0SkfUHn3yoLiPxZhpFuz5ndRxaAxiaTeM2vA4muLiJYkihpfIYrr/eTVc4r
	 WiXCuASfCvYQb1ijgm0PRVGRIwNNnbb9JAzIruUD+GcyDCUr+tEXWbwlVBfx+LcdMm
	 VPOZQcGPTQ9upGYsJ36Tcs5N4ePGNP14Hb4CF8vXZ4NgXA30cp0YGZ0orZtPqu8VRr
	 W6DetRXZI7f/CgUWoAMmo1JEJTjC8/mx/DVg4QVQD2WcDYVj0TI3E6grYmdNL14BO2
	 gzn8Xof29vdJl+qx/2M3WZWqneWiKs2bJ8X8IPa+QA897ehj4XSiots2a/gTG0qDy2
	 Aon11glAxe3Ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D9C3809A8A;
	Fri, 25 Oct 2024 18:11:15 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241025092043.3962056-1-cassel@kernel.org>
References: <20241025092043.3962056-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241025092043.3962056-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.12-rc5
X-PR-Tracked-Commit-Id: 8e59a2a5459fd9840dbe2cbde85fe154b11e1727
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a7aecd9c031c25988d0e123750674e6d6a876ec
Message-Id: <172987987371.2995179.11820032063854410590.pr-tracker-bot@kernel.org>
Date: Fri, 25 Oct 2024 18:11:13 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Oct 2024 11:20:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.12-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a7aecd9c031c25988d0e123750674e6d6a876ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
