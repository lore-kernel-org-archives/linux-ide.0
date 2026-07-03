Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F034C134
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064284; cv=none; b=KMOOh1H+FwexaNflwTU3HQQI2rKrJCd1OawMWsBBuaBiRH6eVSsMGFyDbc3dQDlBdZq3kAAdqMMbQPhsTY43u8KuKo2tAs3E8OATioBBv3OaQF+NcaZhrCotnTfkQq5xLH1widw44nCvZ3c5GZvKbBRJCSZVIBcuePByEAv7wHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064284; c=relaxed/simple;
	bh=tI5S8GNQV4J0/eDmyifnD+2ihDQNUeo5fEBJ+Ef5/FM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DsYe4t4G+x5ixEm1AONQNGR5y3Tsp76hgJYAEQ267wwqDvexBY3FO7iZ/HVIek/YeSQVaCtEzjmsudmaOIULHEBiV0+rNNdNmrzpX48scJwhm+ncCi8VvtoPrUdVcQvyOXFCTGKqyKz8lC+3rfiFDIeIDwlMA0Rct0PGFwIFlXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIkQaI5Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIkQaI5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654F21F00A3E;
	Fri,  3 Jul 2026 07:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783064283;
	bh=kVBx/u9bdzmIh20wLC61BrgRcpzxpZnFd1kzYJfbYM4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=bIkQaI5YvDsYdTyvYo6mMVC/HJl0ptXmuM+kot3+a7D//4bEe4OfNixfwmIr8KjMm
	 n8feCud1KMsjtH9tw3JMmvvtobGFSM/4O31yKAt3MRcdytT8u61mxZ8GnzLEXSeDbB
	 XRSwa45zcTwrkZT7etAQveQ/K5r9rBerdKzQ3Wnp7ANVYxSn25FGDeR8CZUuIovvdV
	 xlFdXA67MayjtLFwh0aGrdobh7aQJgATLwgfI7RiY7yWyk11FUrZ9MJjlfdQBVsj1m
	 c6eWeqJAXCZKaKfXn4O4uU2F+gNCi9wd7wqMN46075E5d6AyWKOn37ERX3LoyzmXzb
	 D+OgCJ0J5PC2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A2B39389CB;
	Fri,  3 Jul 2026 07:37:47 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 7.2-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260703050513.2276742-1-dlemoal@kernel.org>
References: <20260703050513.2276742-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260703050513.2276742-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc2
X-PR-Tracked-Commit-Id: cd64be0ecd399fa2b1ab60b3aaf2b2b744243467
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c85167c926e0b1a9213ecc9040eb355f90426832
Message-Id: <178306426559.2510133.13765184410666960565.pr-tracker-bot@kernel.org>
Date: Fri, 03 Jul 2026 07:37:45 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  3 Jul 2026 14:05:13 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c85167c926e0b1a9213ecc9040eb355f90426832

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
