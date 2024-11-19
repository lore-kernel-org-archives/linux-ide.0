Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C90C149
	for <linux-ide@vger.kernel.org>; Tue, 19 Nov 2024 01:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978604; cv=none; b=SaY+OXkVm1ccOmyrOPWqm/lJ3XFXov+bdUKi8+gIKsqY1Jr5pj1JRcvttNrgOpFMpplbt4FdFYz2jdud4eX5m9hN5HWVd9t3P9oEfymr6r+vKAxq/l7HRqxTthl1v/fI7zVVfa7b+vJODzKvX+qHT5F+POUM68wnMacVpA5NPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978604; c=relaxed/simple;
	bh=FswRULbnZ9O6GlchWhNgayKn7Mo9SaQ0pTvxfKzPnyc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=o9KBBL//DhI9md4KyGYd0HlT9TJkNQzBb73S9n+ymJA5boLyuzpzVq65216B9cKryhAGjp84sLBv/j1h61Dnxc9Kf+LHa7+vsiPNTHBnVz4wL0F1SkMqpmJ7dn+hVOHZjoi8P2YUBsR/L/wD2l946DixjmYw/lxdkIGKle3Vh1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2BAFYcK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2BAFYcK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EB4C4CECC;
	Tue, 19 Nov 2024 01:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731978604;
	bh=FswRULbnZ9O6GlchWhNgayKn7Mo9SaQ0pTvxfKzPnyc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N2BAFYcKK+CZHiseZdcmRdXFcxvjkAehohI7kq4kR1FRsd0hqJo3ehDV+1fEO+hID
	 9O4xfkqKyTQORvpMPyQyALZFd4gPiRM8U91P535XJDV462mX4EB2SKODoE7LEX4rrV
	 JbiQawIsq1VHvdbnGaMPUlvqOjeP9z09NFOQ/2cdCC4oiE5TVQ3PuxXfPQiWK6XT1F
	 L2nWe5bkkV9EWzdvAHAaDRJGT+kQhepAYYelLLKf6YlQFqDp59vfERC3nwG6GgZXRa
	 +Z8EQMeZzlB+8Pyo3Evt2ArGIE1CaG/V9cHS8fepPZoZG+Cwth4c6ozHAb/Jy9OlNZ
	 Vepe1OE8dF2wQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341363809A80;
	Tue, 19 Nov 2024 01:10:17 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118155013.2706907-1-cassel@kernel.org>
References: <20241118155013.2706907-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118155013.2706907-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.13-rc1
X-PR-Tracked-Commit-Id: e8a2389ea808c3902d9938b20e40e2df36c3702b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d1b536c13f7cd966aa660d1730855b26d01c9ae
Message-Id: <173197861577.48692.13221626540506369269.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 01:10:15 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 16:50:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d1b536c13f7cd966aa660d1730855b26d01c9ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
