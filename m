Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169232;
	b=0gCucIdLe6BeTn8TknnlBUspaPxTNPG2gg549YTI0vGl07bEb7fW7BNTySBAZOisSp5r
	 DB9xteiL3aYKRa3PqJPJS5glTUVd/nLytJ46ne5QYOv0RevD+jnS9hFyKcimuOhyC/kGw
	 f2zX4i2GGS+zs9UNMphHk8joAe12mZot51l3tikGl1fsdwjZtD405jzOba6l51yYCG+SY
	 QyCYHwhy3zzfrz8ywvwdg0qMiTqg2zl695Lt14MtB+LSZGcSNBq+9UXqfmD62twsgcCQb
	 FTcuY9a1623yG45i7KFzTUmGoJG3CMwVo9iBAKpAz5hpYoeuGgPrQv6Mc3Ul47sVO5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169232;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=+GGggpB5LKK4wgp89dLthXpBCu1PDcpYeDNN6NrO0Sk=;
	b=G1BTW2P192xRs7HVkR8CghwIKB0VeKiamNgysk3Ugby1FsXfh8wTU9FAD7fdO7bTIf1Q
	 rrjP5SCxi9OMNQ68SvDU3gnLVNW6h3HGNf2EHyEUtPZpoOePUvb8/ibSQkcf3m9hePgwG
	 GoGCd3PMik+QV9s4w7xbxtINcyuDlUevvbw+8GaRjkxk3qSYljXPnN5WWb3AIl+z0ha+5
	 GCMD8lJFwM0P1T/EhorvY/ct4VvdFAD7U3kAe7KH9uN1CuHtS6I/PSm5kXrsO2VwRlPdE
	 5zhhT5qNDDCBS0x6vszNC74sCksaZqPZO/yOpyyKaL33je+mlnXDxW9cyhwK7COj2ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c62mqO2a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C6606A31C
	for <linux-ide@vger.kernel.org>; Sun,  8 Nov 2026 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c62mqO2a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687111F0089F;
	Sun,  8 Nov 2026 20:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169232;
	bh=+GGggpB5LKK4wgp89dLthXpBCu1PDcpYeDNN6NrO0Sk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=c62mqO2a9ua1VFONjVRGon4kYwshgHYs1utyJ5o/XxrpLczU35QGAVOQfmoMHsBpb
	 i/zvNKBsugQ6OQ44jG1VI0Epa/BWs26Ei0KIYcEYuDW8KwpE0aTQ9OfZdahSHrD1Z9
	 nXD5AyAWC3OeRGy0gOJ88zALJid99Sow25Yxzsec2/egdD6u0CWiA8M0lMvkwEUhNC
	 +BwLPZZ4shoF5C+/4HdPeRl7nNXQIAjmG2MOZs51QzkzfVfJ+bOB+Bp7etI4m3z5yP
	 C9ke7AdZBmMmwVWGx3wFbnlikDiR/i3hV1nL4K9i3zayv1/Wq2Yckb7fRmE+l3Zqx/
	 WapolwEF6n8Ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E1AB380821F;
	Sun,  8 Nov 2026 20:20:32 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 7.4-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261108110435.1028471-1-cassel@kernel.org>
References: <20261108110435.1028471-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261108110435.1028471-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.4-rc2
X-PR-Tracked-Commit-Id: a4845f077415ef32fe672c841e2fc58ae9e28273
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6f836ef7865fb454641febe080cf88a3c677186
Message-Id: <179416923085.1696319.3724385687469052546.pr-tracker-bot@kernel.org>
Date: Sun, 08 Nov 2026 20:20:30 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Sun,  8 Nov 2026 12:04:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6f836ef7865fb454641febe080cf88a3c677186

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
