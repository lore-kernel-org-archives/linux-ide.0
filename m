Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012FF282EE
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725247258; cv=none; b=KU6M6mveV8X8QHMxekVd9p1Y7bLCeeuZAWPTxcjvySO3M2TY8sgUdminkae/z4D6OM6J1nwc9BJXnv0WaSuw4urDcQLpRWqgkz01FKuWFx/Ox39K9Uhj+IjLqQ8szcTVjSugHrmK8g41oQ1b/HP6PWrOra+CcskVGtHqp3lFSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725247258; c=relaxed/simple;
	bh=h/YLkOImr4TxuyGg/P03wETBKInOoDSxdBHZuwpTp9g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nkdSgvrhwC01cWw5+unGTf419oY1Lk81tyHUo5ZN2eai1U2PPumIzSgutie2r4ZsC5LeJQbYx+arKz4k7uYZ9sQLQoj24cIXt8GosMCANq2ueUKTfL+vOlBn5FfphzmjUOU866KkLPCdFW8Svjv7iAu/QPfiIvIEkhWGR2JGevU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxlHtzrC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxlHtzrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D31C4CEC2;
	Mon,  2 Sep 2024 03:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725247257;
	bh=h/YLkOImr4TxuyGg/P03wETBKInOoDSxdBHZuwpTp9g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oxlHtzrCJIvedQD/a9DJUK60YZVaLCqeXUwlUqWgiyQmaV29kCbz0+mlHpmnwVXvb
	 aoraZjF5N2yByc47yqlOjiSgTeKZUyFSiEqr3ALtRFVyNclustUR41o9mjAmDXApRA
	 9IINFUEKXNbQne6KKIfRaeOf483SHepA3X6D4CW36Z4VFwMgHdmM3mga3qBUyLbpl9
	 gfAZkYJtN/trk3JJrGKq8rMuxxGnrlmIJDcsn4Fpm/WQ649B4HXAtSJGKZKj9Q+55R
	 KuURFTzmyXiE8IHMH/XK76XS/TCH97bWtyWqT0yrVeXVfzuRHK/CcFMmSlvhbyLN4z
	 LCb6EJHzRTdXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 348383822C86;
	Mon,  2 Sep 2024 03:20:59 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240901230431.35937-1-dlemoal@kernel.org>
References: <20240901230431.35937-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240901230431.35937-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.11-rc7
X-PR-Tracked-Commit-Id: 284b75a3d83c7631586d98f6dede1d90f128f0db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67784a74e258a467225f0e68335df77acd67b7ab
Message-Id: <172524725779.3451149.18320305087541338620.pr-tracker-bot@kernel.org>
Date: Mon, 02 Sep 2024 03:20:57 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  2 Sep 2024 08:04:31 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67784a74e258a467225f0e68335df77acd67b7ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
