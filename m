Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421A5A514E
	for <linux-ide@vger.kernel.org>; Fri, 11 Sep 2026 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789158355; cv=none; b=GxIeScm7j1yQ6b/Wu1hGM3BRyThI7Pubhq093TQM5eUsV7mxVaGYWpQY6YrclkqxZNGpjBAiVRGD9k8P2zlrxhBBhP1VfF6dW6pJ37AUWlyZzNAk/78O+Q3KBQeKkUqTXZVE/3upORXEVp1pZ9uWYTus3k94WjuAThpY4DD77b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789158355; c=relaxed/simple;
	bh=jy1r9ndoJGOycwOUG3yCWJ99zxjhkwkji+g6EDytb6A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RDV9oz1p+Wh3xf31JOCuoOE09Gk2+fXgvldyQ1uHhldfPxxrgZ8++cE3sB4vBQw+LSFYnESBcdRsBxzxSi9zvWAuViTgQhyo5HXglRLZ6is9BaoK09dwnvCVRb0PvRjR78sgKbtkuKdn9q1xTcc4pIzw82lvG7n2rqGqLmimvpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cK0fQf9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cK0fQf9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B351F00893;
	Fri, 11 Sep 2026 20:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789158345;
	bh=Ak8PNjeyF/ySVtCoKVSLsVC2sMAcuq2sIvdD28mBiP0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=cK0fQf9cySLdPhKRZExH9M2f+pdYGvzLUAxjcrdAoNa3NrI1X9PcY44/jGMrYJHiF
	 jaNntB7Nt4l1d16Xbg1EBMlb5jWq0ehUR3fYO9U0gB3273V4LshKrAZz8t+Wt9KgKz
	 eCKbMEiLw8ohuq7h7hLN1PWbDzesKYFKwFpBQGxB4HZuPOG6Xh661FTpqdHqBbfgpV
	 yb0fFeZvri8f3D6ZRyGlwy5qQgOe2vwoa/2O+0XHfnHd75+u43m7f/8J5Z/YyDGABd
	 kR3e4POmV6NRWxgOsdZzQ5uBQ2PR1qGk94PDL7O+xhKWz3oUXkqEblEzHPGq3rNLER
	 NZ0Rfgz7vEw8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CF33924451;
	Fri, 11 Sep 2026 20:24:43 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 7.3-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260911190644.55161-1-cassel@kernel.org>
References: <20260911190644.55161-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260911190644.55161-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3-rc3
X-PR-Tracked-Commit-Id: a19d4f9b8befdcfcd5a87bab91312fe64af3bbb8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 707662b40a82c96e416fe17f3c116a4d648f1fdb
Message-Id: <178915828227.3095760.9647997575998533593.pr-tracker-bot@kernel.org>
Date: Fri, 11 Sep 2026 20:24:42 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Sep 2026 21:06:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/707662b40a82c96e416fe17f3c116a4d648f1fdb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
