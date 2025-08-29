Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAAB32BF26
	for <linux-ide@vger.kernel.org>; Fri, 29 Aug 2025 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485562; cv=none; b=JQ7zPc4kFGHaWg2eY5DEXmbTA8w55qJByBxdlS6MT2l/RLx3r0at7g6MbG0ikgAM4Iuusi3zEmMoAb6rsnPhr2BAUb6cHmC7GDrX7OlRC9U/Zg+OAbZZqZMoughVCUDclYO7cY3Sscd0QUddtvqWkGhX3IKpWqnW43zrfICDQcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485562; c=relaxed/simple;
	bh=wsRjllEgLqBAtGABIvFNQTdOMzI0NI8OcBHkg1kVi9Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=buynZ1e1/dFBBMJcIfMah7B85I6nIHt/CO2mmu76pHbJCTJb7yyXm7xB860bYcB9VQ/iVChP3C+SQZZbhG3dnqm8S91UScoK9gGTLcn21Jq3Sx2Jvo5OSF8zmsjSFV5fOikjGEabA41kWnqSvjIOj4wzul1y9wZUY5Qbj1oucys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYbpJ7fO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYbpJ7fO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAFFC4CEF0;
	Fri, 29 Aug 2025 16:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756485562;
	bh=wsRjllEgLqBAtGABIvFNQTdOMzI0NI8OcBHkg1kVi9Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iYbpJ7fObKLAbx0h8/o+ib/P86R4FCzGb6nvNrARXNvSW9V2UMKUkXQXdARxmL3mI
	 kHlpvPZ2Q58TzTjqy/9n4t46JfoYwIRnFlJjEA2v0WuQJviojPnvee2CUVyRWOEYaI
	 0dDrPSAHjTBArzWkAUdp0hDJLJVk/GtP1w35o1PK2yBVpj0rFj4lWPGC2tmkbXhuB8
	 4dEIPYTshwjRBbUxe1l0kfXsWOxBIBqIvPhVAfsa8kU5A2PADQUuoCEOLjse5DLDfa
	 gz1FzBpuMWqGYkZ00Z7dboVYdxe/+EAwfUahP9QrYDo1u0KU8JYF/QAxzE+bHZn9sr
	 Dkke0IzdRIrBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE304383BF75;
	Fri, 29 Aug 2025 16:39:30 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.17-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250829080247.32183-1-dlemoal@kernel.org>
References: <20250829080247.32183-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250829080247.32183-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.17-rc4
X-PR-Tracked-Commit-Id: 82b8166171bdebbc74717e4a0cfb4b89cd0510aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2bd3731542af4d32402fdc0e247153a94efeb682
Message-Id: <175648556916.2275621.6701694832136710120.pr-tracker-bot@kernel.org>
Date: Fri, 29 Aug 2025 16:39:29 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Aug 2025 17:02:47 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2bd3731542af4d32402fdc0e247153a94efeb682

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
