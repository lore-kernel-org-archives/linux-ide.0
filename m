Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933CB5336A
	for <linux-ide@vger.kernel.org>; Sat, 13 Apr 2024 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713032620; cv=none; b=fcOwsJ9lLQBnbZH3IKaYs3HC6LbFDmeOdsc4V2b3fWaFkbwQuOQQSnUp42PFYTqoA72SzSGs+9VUT1/B9C3zcWXeu2uzPXFSXp7k/S6q++o3y5bQ/dpSOq5QWzfKbAsYwNyPWG/ahhnEKFWtvOvbxqyxRxHDmg6GVVHQqEy39eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713032620; c=relaxed/simple;
	bh=nDqk90weJCL/0GQlr8me/PaiPbXv5e2aDAsiIQOQDhk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hkdjaw6/EslrkWq5zzJOIYxxXUWlX8OB293RshF63kA1nOaYnXZGUshCfROBdTvMOh6MmsofAqW0LVyT6F5gsb7VHrhDcKhKZHiLBJUCWa0cQcwr4bBTS2CcENE0qXJGQHjF68QmSfeYItPQJuYRGbYDkUfVpaxwyFVwrvtLLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdxIlA+X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdxIlA+X"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2208EC113CD;
	Sat, 13 Apr 2024 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713032620;
	bh=nDqk90weJCL/0GQlr8me/PaiPbXv5e2aDAsiIQOQDhk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZdxIlA+XSHe6xE3DeR/Gs5p4LjbX0SDY9BoDzGm7Ig40djFaJMW61x0fQCxxOnodP
	 k0NHXsFnmLwyPZCRNmKKwygk3OQ+Ts5c+ZMhMzYkUje5xl6T1XuEvHBNQIxtEB0hUl
	 ak6HRw/mXN/ZitxAxVsBOCbpPzUzjXbFj282Qc39Ydvx1YZjtDy0uNcEdjOh65oQw/
	 hp+Qo+OsPMiUQ2sbhUgOdrQLFlD4O+zcf0QTTS7pVgh9Vp2UwHp2b366abQwAl91ol
	 lEyb9aTVktWoq+dnLpbefZv7Y7LlRu27czMKkSnsvGKktRYx7lDjtQ1goR17rlCYeV
	 poaik81zKGnIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D97BC43140;
	Sat, 13 Apr 2024 18:23:40 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240413081531.1158825-1-dlemoal@kernel.org>
References: <20240413081531.1158825-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240413081531.1158825-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.9-rc4
X-PR-Tracked-Commit-Id: c0297e7dd50795d559f3534887a6de1756b35d0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7efd0a74039fb6b584be2cb91c1d0ef0bd796ee1
Message-Id: <171303262004.6704.6891399261180288774.pr-tracker-bot@kernel.org>
Date: Sat, 13 Apr 2024 18:23:40 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 13 Apr 2024 17:15:31 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7efd0a74039fb6b584be2cb91c1d0ef0bd796ee1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
