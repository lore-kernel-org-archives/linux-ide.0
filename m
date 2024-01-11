Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C5252F83
	for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2024 22:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9Tyh68P"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AF6CC433C7;
	Thu, 11 Jan 2024 22:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705013875;
	bh=5P0QYRcEKIPL6WDsq+CcOdbV9eVRjonRuNa40RApq3Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S9Tyh68PA95XfeTZk3NPP2vdUwuai8rsMk8Glnjl5hudlyefwqgTpFyiWSkTJXtiV
	 GXzY3I8ScSSpZliTKRgFxq4LovtXQZeAE2VeWcXaBGXkcONwknmr9A4qSRiMgyg3p1
	 SMCmdrNNi9CC9Cn+YBQ3R3bhapGux/G+ZSHIXrUa/8+9zAKYHuP+8kTiSeL13rWoP0
	 847gBXxlM6thcg3ZnVWGcPRZiVDRAoA5c2MLZTleEwD7tIK0AyjIvvOFfcnXGOUc0s
	 sav/iQSBwl1MheuCgkZ/12y73XXDBO44dD1nDIdAIxK/M3CmtTLkwyJixc2GLqn2LF
	 pr6VxLE4Bw3ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43831D8C96C;
	Thu, 11 Jan 2024 22:57:55 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240102233858.150598-1-dlemoal@kernel.org>
References: <20240102233858.150598-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240102233858.150598-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.8-rc1
X-PR-Tracked-Commit-Id: fa7280e5dd815363af147dc5358b25f5a06c9c68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d05e626603d57936314816433db8bf1d34b5a504
Message-Id: <170501387526.24643.1710342727688581261.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 22:57:55 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  3 Jan 2024 08:38:58 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d05e626603d57936314816433db8bf1d34b5a504

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
