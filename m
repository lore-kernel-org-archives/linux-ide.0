Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BD4A01
	for <linux-ide@vger.kernel.org>; Tue, 29 Jul 2025 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753747957; cv=none; b=AoA7qSZulg4gJthi3oT8d9cgmO1X23HeRUG/yKZrXmoINoG5Xvbde7bMr2xJvRTz1UUO7DBOKNF+Fwm+I7XtXn+Tl9fGH+KP9TF79KANqVwgaMQpLutIpUKeU/zBRnVO+dNBd9pghRUPTQW4K/8efJj2dIys+VVm+bFPucKoCfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753747957; c=relaxed/simple;
	bh=umSlwj7bqhn199+2RfrSayPtfFdjOH6Ph4ABLGO4/y0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t9DxBV8VFXKj0KvGPUX7sx7SJVUv9t0kG2ui3NdFnTEN3m/kMGlUoMVZCGXFaMF3hfaxyC8117Yn7a07nZ3HmOGIdlgCxEr+KzA6Be0n1ZUFeOh7MQ42msFP47ZWjTJ+ZHF6z7qFP/w1qmc0f172LhdqOyAJa8qw8iwJwbL6Y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rg7PVeHX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rg7PVeHX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF32C4CEE7;
	Tue, 29 Jul 2025 00:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753747957;
	bh=umSlwj7bqhn199+2RfrSayPtfFdjOH6Ph4ABLGO4/y0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Rg7PVeHXvz1YAXchLWxil0jDNY50B407O0DIRldb2CSd+IuUOfMRtjQ4Yba6PY4j9
	 t0nqxEdgQZM06JT3ep+ctbn8iXlzIuisOOFYGZdDt8TM6o0N1CR1Ibk6OW7m2N9Xql
	 6bsk7Z3dRpiIZ9P9S5zpt8GBWFQgfLC+fHbaqoE4jwgGaGtE1rYEWGMDUsVGx5fWru
	 qiMaebfx+wU5Gntqp51po0EwCJD+85IBBNuMzOF1L/iSEcIViMjTuzCRvjjXrSDqRp
	 MRPPNyYgD6sIxkDRo7eueLXK4HxA2HvddsiRpZ24ZebTWFeETzLbIGXnTNnjIIEnDY
	 LjGRNFHwL7FoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BDB383BF5F;
	Tue, 29 Jul 2025 00:12:54 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250728060623.187416-1-dlemoal@kernel.org>
References: <20250728060623.187416-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250728060623.187416-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.17-rc1
X-PR-Tracked-Commit-Id: 546527b92d7e72dcd827675a2d3e580002b09cc1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ced1b9e0392d981a7317c605b402c06650947a34
Message-Id: <175374797320.902610.7071262880122663328.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 00:12:53 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 15:06:23 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ced1b9e0392d981a7317c605b402c06650947a34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
