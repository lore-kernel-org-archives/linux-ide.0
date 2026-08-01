Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151AC385D90
	for <linux-ide@vger.kernel.org>; Sat,  1 Aug 2026 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785545878; cv=none; b=B9HwJkgUKJTo3rlRvdgdZEotXS3RSdFKaxS/dzCw/kwZEndNrCkTUyeUcuaQpsXci82DzKe6VP5SuThoxb6njz9DqNaTaW0pN7KKTdYXazN237MTvzb838qRNDmuPuesh8ZHtFAGyCilZi8I8VqmzQFn+9+DoSxcL5NTJYliDbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785545878; c=relaxed/simple;
	bh=M2f9xA8ICElUAUlLTetsCO/sKr7T5H78CVaGxqY4imY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BE2qK8gkBa6BRrhPrGiWs+t66IXArXAFGcMmm3puEOpT1EC/ecYoUniCQ7Vs3G5tCzVKCrKe2XNc2p8MMiY0rvnhLjDzLf9CAkzg0DTRtQnuHJEQfFvJIDjVUiJRz1v/2XvFvjbsM1/orFmGbBXNMfhWwBdMAbuDaAVKEV01XM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fu31JQyV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fu31JQyV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1061F00ACA;
	Sat,  1 Aug 2026 00:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785545876;
	bh=o2FWmD7ywwWRwiTAC3F9ErTDuu1N4AXPLztT3C8hBjw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=fu31JQyVBa8VThbus9n2XQmINJVAmQkXX/WViiMERepo2e5aNWOIYSiGvsdiQSq7G
	 AQjAfzDKMZgr1b21EkCoGvbLoDhj4/RqFXw3MfLiXEeFv7K7/LIfB4aotYziRCJ5Jk
	 HVlB7otYXztvGDxoIdgx3mvS5Sn6zglmbpcZp0XFFmBqj2z3H2+GtbLlFbue0D2pem
	 SEU3TrOZluQSnUBifC5pl3yRombPxRGwfUV87G+C1CQscNfBwms1yTzw07qeY3oDdr
	 7nrUExy5B8lw/ZxWmDut+4jCBh379dip0wB5JNdD45LEu4cOqozCucMT9GQ8ugncNK
	 k/f2SMC5LGAdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93954392665F;
	Sat,  1 Aug 2026 00:57:20 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 7.2-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260731235249.273921-1-dlemoal@kernel.org>
References: <20260731235249.273921-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260731235249.273921-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc6
X-PR-Tracked-Commit-Id: 3fd70e96914d761c17c376aadd0b0d1a3c9badba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f30ca2ce7d5e2739773f00eeeb22daf6f7b18dd9
Message-Id: <178554583923.970149.6727319819631117766.pr-tracker-bot@kernel.org>
Date: Sat, 01 Aug 2026 00:57:19 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  1 Aug 2026 08:52:49 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f30ca2ce7d5e2739773f00eeeb22daf6f7b18dd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
