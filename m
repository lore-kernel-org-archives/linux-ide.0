Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD393B287
	for <linux-ide@vger.kernel.org>; Fri, 10 Nov 2023 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3S0cl2p"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2FF9C433CB;
	Fri, 10 Nov 2023 19:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699644540;
	bh=1Xudd74lmkRdV+oVlQW8oZ3ugpXjdMWPgyEue+Gi9E8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=M3S0cl2pioTuQW2F3GZ7zHUQ0SA/+tCKHqyKngFjX8ss/qDFQloel6QAdPWgSpstx
	 wMORO+s0LllX8s5ENoVER1CDY05UD3LcHMUdQov6YsO0lxdXRbINLVooqFbCrhGAUG
	 IuWqjbX/zo8EqhwlQ9Kn7wxyCOdOpFlde5cTh7oenKxwQy/HW7ZnGHAJOTMXDedfod
	 N8WgUrWxn9uFzNOaRQuIinL2Tm+CEZTXqeCZCPMzHp3JavfcNC7Vm1BFHzxepn7f4M
	 TTn0rh64u9Sw/RnuxKTLazAGGopITdHVH0kKX5a1jkB5O+Y4/nJn5je8f2KBP+X9r1
	 aJpfFfJgLIR3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB022C4166E;
	Fri, 10 Nov 2023 19:29:00 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.7-rc1-2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231109230831.141450-1-dlemoal@kernel.org>
References: <20231109230831.141450-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231109230831.141450-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.7-rc1-2
X-PR-Tracked-Commit-Id: 99bce5182d8fe90e5c57e9d99f831baaa94f90cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d035e4eb38b3ea5ae9ead342f888fd3c394b0fe0
Message-Id: <169964454082.4685.9101703368639639154.pr-tracker-bot@kernel.org>
Date: Fri, 10 Nov 2023 19:29:00 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Nov 2023 08:08:21 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.7-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d035e4eb38b3ea5ae9ead342f888fd3c394b0fe0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
