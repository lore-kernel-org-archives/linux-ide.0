Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179AF625
	for <linux-ide@vger.kernel.org>; Fri, 24 Nov 2023 01:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8RjPJUE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EEA0C433C8;
	Fri, 24 Nov 2023 01:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700790685;
	bh=yTqOVWis/n7iNezUROwK0SZXWY+b6X5eZBTUNaczXok=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=l8RjPJUEfRTuntA5d3KHszjBwjlngqMnATnCYrfVW6VVebhh3xmje3NyOLlrMLxfO
	 Lg6iAP395Wlqt078IIh+FuHe0Dyqnr9cPgzSbQR8YbHW/tSptL9bIaHrvA2/MMYFI0
	 Ro1doXtiPHNg4UA4Gy75rbBH1boyFUIFFZ2Uxi+W75MdobnmmMdON+PBm898uchHfP
	 PUu8/cor+YY/Ms2EUMwMi57S+bdDaTL5Qib7svngaC2/XJ4DsbMjC5h6Lh4vgM5s4t
	 T382WSlgdxhqQ6SsJRMef0G+HwlyaqeuWWq5xXPpzISw7AoD7ammPjuc/g4C2qKTys
	 kkUAueyCwn2lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53EE3EAA95A;
	Fri, 24 Nov 2023 01:51:25 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.7-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231123234715.35765-1-dlemoal@kernel.org>
References: <20231123234715.35765-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231123234715.35765-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.7-rc3
X-PR-Tracked-Commit-Id: a6925165ea82b7765269ddd8dcad57c731aa00de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1a09972a45ae63efbd1587337c4be13b1893330
Message-Id: <170079068534.3340.6994740604338426232.pr-tracker-bot@kernel.org>
Date: Fri, 24 Nov 2023 01:51:25 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Nov 2023 08:47:14 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1a09972a45ae63efbd1587337c4be13b1893330

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
