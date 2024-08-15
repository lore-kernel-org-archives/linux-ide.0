Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37511714AC
	for <linux-ide@vger.kernel.org>; Thu, 15 Aug 2024 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743757; cv=none; b=kuKbIEmtkjja1FutbH641vm7sX+DUrU2Om+MJOaVkpni4AnXbLpQ4H0OatRWJWEDwIyTu1y2lFJ5Ptv3GWn/YfchSlMlfMHGCfB/jJULdzMK/IKbpODdpB9UWGX/bY+SG87nN/x9xpl/V681CdaIE9NOtuiLehdC/wAynQFmeUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743757; c=relaxed/simple;
	bh=8D16D7Ckbh5AIdyw/lvCNWESGIvwNNP9T4b8xuV73ZA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uyk32RoJi7ekgVXdnyTyZc2T2IqPu/qYuJ1bHi8UP6vUrg6w9MJJP4p3MK8ZwNLKUY5jv1J3PR/zyvTILHANgxdynzULfBIkR7nP5x/TuekcrcIUBSZWL2xMhAKYgAjOnjln4aCNzKHqPWPxz5hOWrOQY8XOf9eeOYP4anco77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1dFeavo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1dFeavo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B677CC32786;
	Thu, 15 Aug 2024 17:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723743757;
	bh=8D16D7Ckbh5AIdyw/lvCNWESGIvwNNP9T4b8xuV73ZA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=m1dFeavo4zJLK5v7GwEIRfo5yKC9a0h28kZ6UHODc1nPnMeR8t92VI3ANJzi5ocEQ
	 uBpfMKBFVQsbCWGfa8fJsu6DhRoWxqYmJLF4iBPMBtThNeTAkS080xeJOdxG07xh2d
	 872XDYwdBr1u+w/oyjSXAs0EXMPfKDXT8h8aO/FX7gnbo5+MJiQ6AdStIJlsJdnN8C
	 qYIL0ZvnutQnmP6fg8pgZN5GnSvamttRGKGdq9EffxW7eDhaGpERuYhhxDqgNWFBJF
	 Xxfjeg69Wv+x0cjlT1hkAC7lF28eo5JkSBFJr2W78+6JjLNHoD4TTcYzcx2jsN0/M6
	 s9y0hlKrpc6yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C99382327A;
	Thu, 15 Aug 2024 17:42:38 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240815124310.1349324-1-cassel@kernel.org>
References: <20240815124310.1349324-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240815124310.1349324-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.11-rc4
X-PR-Tracked-Commit-Id: fa0db8e568787c665384430eaf2221b299b85367
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e80a1fd99fd71a2e104f45f2aeafb0cb19da44a
Message-Id: <172374375692.2961867.4243596611320477422.pr-tracker-bot@kernel.org>
Date: Thu, 15 Aug 2024 17:42:36 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Aug 2024 14:43:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e80a1fd99fd71a2e104f45f2aeafb0cb19da44a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
