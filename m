Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A81E5B68
	for <linux-ide@vger.kernel.org>; Sat, 18 Jul 2026 04:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784350510; cv=none; b=AHbULjcVoj7TBqVwCeJS4hR/I3WpJYhtZpwuk1jpgoKWacOXGBztDlcVg9cFdruzIGwvZ5VYz3mDpLFLMmeJikQUQQ6IiyO2h8rZaiR8d7TjJLV04LipYQYS25MIjE5FOVHwhLuI1qs7x1VSAY92bUMdHDqhEFcZJca+R4cXenk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784350510; c=relaxed/simple;
	bh=kVPnYHTCJUTXwncBbpvf9PHEOjV/NsyG1YqrDGFn5lY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VJAWf8aL9nAPb1ue6OroaK22LrQg/MmvIQUFMRWFjdv3rOVnyLzDnwLhYY0F8ltaJVf4R7draszO47FrBP1Mg9V1jX46hSz0gMolKlkgkAp7UaH63bR5d+iny/PRTMJpVGXBqMSbqqFG/LZTfyA2a+ta7qiZK5nZFOwBIgXrYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i02bYA9/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i02bYA9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDC81F000E9;
	Sat, 18 Jul 2026 04:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784350509;
	bh=v6zUtoePlXO16t3CGakCfB0JYmxjLXdM6DARVrLyD64=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=i02bYA9/gonX6ZUgcZSRLxFazOh3kEqbnlg9RekVElF0uipzxj/mrFMsTjszBmJDR
	 Nl4KInEwggR8p4dXpCdzz0tcmHVobmwAvvDlxa6BBvzRhV/cTh5zfdu0KMqmG+dlCz
	 GmEE/FY5taZ+r1LGXP/2azjc3ZcwVZ7AZtue9ReCf0+KI/Po8pM6xRR6Mre0LWs140
	 h3ROjNyE/KFINUbI/Tk+Y9gXAeeBuZlx2vKvtoosGuBQEkfawSyH5FK7lxrVES+9LL
	 qCnTjw0STKZ1iUVXxo8KhjnkNMKoh6JhyrT3wK30qdaSRwVjv7ZmcL2K7WiS0xijIE
	 78ZprLHuUpJ9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A1F3811955;
	Sat, 18 Jul 2026 04:54:42 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 7.2-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260718005720.1578823-1-dlemoal@kernel.org>
References: <20260718005720.1578823-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260718005720.1578823-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc4
X-PR-Tracked-Commit-Id: c2130f6553f4a5cbdc259de069600117a995f197
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94dc07d6d99a9e4e3e2422c1c486cc4349e9e5a7
Message-Id: <178435048144.2413748.16627547885704434622.pr-tracker-bot@kernel.org>
Date: Sat, 18 Jul 2026 04:54:41 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Jul 2026 09:57:20 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94dc07d6d99a9e4e3e2422c1c486cc4349e9e5a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
