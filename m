Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2605512D21D
	for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2024 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708304; cv=none; b=nGWBekmphUMJqyJkwKkWFG8X2nu7Nuzp9r/BJjKan6YktIfPyYzjz7GMA3cvgowjHzWvKTp83fAJwm/NMhQvSvrm6ZEMux5Vy36Mv8dZZuzn87PhXpgNqNaa2yMhRwry8yrlYTbdK0HNBdu4qJ6bC3MMVdp9So5Mh4GyuV689Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708304; c=relaxed/simple;
	bh=0zrhxNsyKD+bGNSEufwy8046BNznlqjeQoNCNNGz1dA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Xsir0tcKl2/TZEn8imcQCzhZxF7n+ZemXaaqMTp1fQLh1O4F4VVbXTPbZ/c5TF2FM8JgwuFqH4AZEuNBdXr9EvWqk6rNbX7G43XSmUAnBARYHYdfcOsu9RDPJutTXP/PcULCoK775PhXb3y4x864C6TCnwK4HLTLR+tBiXv+Fs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeC6UBPK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeC6UBPK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0403BC43399;
	Fri, 23 Feb 2024 17:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708708304;
	bh=0zrhxNsyKD+bGNSEufwy8046BNznlqjeQoNCNNGz1dA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jeC6UBPK3fWj2OLrFDF5TyjXIHb2DbPzQzNdFVMmUI82jArUzK62nkONFHmtcqJNy
	 HR78gq1Yo1PyyQxWwwoUvBULoT7xBkYCL1h0bUeho11YnxNroun7JtfKYU+D0HDKWU
	 luDuR9Z3RfEwngdFf8iH7I3uE+lLD4Z2QFztKM4wkAvU26V43ItX5/KeZyAmyET99N
	 P6jplJflixNkjKTqxgdEjfkPHlyWiQZK5U5mtRZGwWHWDdXrs+X9bbomuZDbclLfy4
	 dpT2kUoDzSxN6jDyuQ+Fyba4rHRWW5oDGAnEYiUY4FL+9gbFsNm8uk9kok+hB/NdAZ
	 2rXs7KmeIGPoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0560C39563;
	Fri, 23 Feb 2024 17:11:43 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240223164302.193697-1-cassel@kernel.org>
References: <20240223164302.193697-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240223164302.193697-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.8-rc6
X-PR-Tracked-Commit-Id: 9cec467d0502b24660f413a0e8fc782903b46d5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6d69282db550689ab5980e06eedd23b64584a73
Message-Id: <170870830391.25757.680399675973472374.pr-tracker-bot@kernel.org>
Date: Fri, 23 Feb 2024 17:11:43 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Feb 2024 17:43:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6d69282db550689ab5980e06eedd23b64584a73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
