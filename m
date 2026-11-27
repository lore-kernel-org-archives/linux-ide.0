Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809489;
	b=JcgOIBAgd/eWXPqjJgR5AsVnqqx4Q64cE4FnGMj0xapGfcVQuAagh+bQGYsshicMQ0Jj
	 AYfr9KsdiU9akF2qSRje/HVp4SrxM+D8K08Hb+cO3r70ghkCtAk5aQ3ziMuPUvbfXmzc/
	 d9HfjU7NaqAlODknlVYFfXASE3+MntNN5bKsLrMRMVf/AAN3cmBaApH5/QvLJVAX0FOsV
	 NNLKGs6YewKKsn9CKE1Y3PlDuyRCqnxPepqK2iivZjpYm8C58fK+lbsEhXw9B2SuGdfKx
	 rY/MfNsJffuYpTGes2swdSIe1nHH21jmn3AaQ8A/xDgb+OrQcRqhcxmtONugVEYrBbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809489;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=c627uwyuCvv0gyrqwOVnE1YiIWwwKHnqphHOednVnDk=;
	b=hFko/5YXhzstMJl+OTOzyurTxBNMmYsvArjIi8B3j7oCWKRpyHkS/EKmZS9rYyTX2kDb
	 0Dop0EVQBoC5Q/r8h+2GmXtSaSas5j9Fli9q/pVB7DBeq16pIH20ydr9OHvRY5TGSXwt+
	 BB+FsjwJpp/Zqp4WGWceBtFILIaUqLlFWDyRht50z/lkmnoCoUFRidonsWclUeQJKp4es
	 11+gBdJ3cEiqq5ZNTI571p1II28KXkAiP6e1ItatmbcGkdNytCVXkH9iuE/hSbAyjzbvI
	 71hqCEX6P/3FSZmtNpdYN2zseivtvbsEg6BIC7fztDGyDY4WJOnBBGErdcVGojiOQwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c4T1rFqR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7F606A31C
	for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c4T1rFqR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CFE1F000C1;
	Fri, 27 Nov 2026 19:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809489;
	bh=c627uwyuCvv0gyrqwOVnE1YiIWwwKHnqphHOednVnDk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=c4T1rFqRIVcN8LWpeGHgR7WWqdIFYwfiuz7oI1RNElibX69IqKRtLFoFzDgIUj0ZF
	 jOui3o3Z7FDrKll6ZVHfeftYSixwHBi09ihv3ICO9na+GvgjnhE4hQZbUk0vc5rRSU
	 nHZ3tmKbnJxl3gHOIdV8jrxhuuSuaex/t39aIimhKwTvw13vy5USVFZCp2MmNXE5Z0
	 iveYUW9qQZbvX0Ms8aUkZ/y+G48HGBznPotOwQD+ibPGK3Fyw51TvEzneUAbrhL/ox
	 3OuDxRAse4HnhuF75GYVunTn5PBtcKP+ATYIl/lA4JR66lRi3sd4UoF+n2FjdMC8Y8
	 WMBvheCrU8t3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE971392705F;
	Fri, 27 Nov 2026 19:58:09 +0000 (UTC)
Subject: Re: [GIT PULL] ata fix for 7.4-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261127103310.3005442-1-cassel@kernel.org>
References: <20261127103310.3005442-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261127103310.3005442-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.4-rc5
X-PR-Tracked-Commit-Id: eca06bf5923526338291ef62501b359596d2ac9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35a0b61ac2f0cbbbc14756d3d2e20e3ab04d0f79
Message-Id: <179580948828.1663999.4722437392476245400.pr-tracker-bot@kernel.org>
Date: Fri, 27 Nov 2026 19:58:08 +0000
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

The pull request you sent on Fri, 27 Nov 2026 11:33:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35a0b61ac2f0cbbbc14756d3d2e20e3ab04d0f79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
