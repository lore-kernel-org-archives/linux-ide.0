Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360A383C6C
	for <linux-ide@vger.kernel.org>; Tue, 19 May 2026 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217408; cv=none; b=bg5W7Yyqu1Nz30HeljDtKcsh7QT05PP2Y9TkBWy+uC6xYJhSLoo66C+cjOs2Lv6RDQLdEfu6ZlwntbRIAD0p7qpOgaAKEsTy+EB3FeZK+IZ4mpo6JboV6IGJMTkihZWYQtbq6rBaERow6d4m0939dmF1ZzU2dd+RvNWSn5hrg0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217408; c=relaxed/simple;
	bh=70+ZkCG0VFE4r0uFw4non8cqAByIXo4Hrj4FrSFKeAM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LSu8rdkNU7hLOmU7qc9pGBmEGVw/of8RH31wV32A+NV/wcHs2a1AwuqGiz6bUSm+dmbsnhAAafxIumCvAWwPfWaapKR+/GpnXlaVt3BKyuTsOkGffuCf4Yk2xUjPfui9HO6Kvu30efwkmPvwmFxZjDib7rukC+aU7sOxvgLlNe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpJfJt7F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpJfJt7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D794A1F00897;
	Tue, 19 May 2026 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779217407;
	bh=bDTec6Ch3fFqnm8z0Xlg/XLpNCFL8pR1Zj1y9ymAF4A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=IpJfJt7FqJu5x6Z9O9/xAHeZ20LyC0FP1B8lIw8+um9tD5PXNtAUSdpiXnlC7fTod
	 BG6r66HcYpxxMrOdZToNi6EX+8EKDwND2s5SnWSYjFZdbsDVDx/BGBL7kzCqig9C+n
	 Bvifax08B60+G6W34m2lGYbH41fYB2WikE8euer4/Ucy2oRvEcgYNSJ7ZyWn2bY8ir
	 02kpDk3znlMrYVt+hzugGjpi6G/wVdRGiceapkh9u1WSQjSi2af/wo1GTO9EB5LgUi
	 qYCdfcK4a9YMWUXMHzm2Qlah7OmXed9e6LkejMAWsnGAYRbIUzgkO6h8Mqt8wcngri
	 TgOf6/NFW+fnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A39383B276;
	Tue, 19 May 2026 19:03:40 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 7.1-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260519160746.2087727-1-cassel@kernel.org>
References: <20260519160746.2087727-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260519160746.2087727-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.1-rc5
X-PR-Tracked-Commit-Id: 759e8756da00aa115d504a18155b1d1ee1cc12e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27fa82620cbaa89a7fc11ac3057701d598813e87
Message-Id: <177921741863.2846164.10787621454073743804.pr-tracker-bot@kernel.org>
Date: Tue, 19 May 2026 19:03:38 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 May 2026 18:07:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27fa82620cbaa89a7fc11ac3057701d598813e87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
