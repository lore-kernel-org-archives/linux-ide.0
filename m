Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595004779B3
	for <linux-ide@vger.kernel.org>; Thu, 30 Apr 2026 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566873; cv=none; b=aZ8MOLvT3JB2GRSIXRlDwxrI7dPoE2t3CkUR7+6o/VweDXndLiP4D6rqMe3c/oh5ZEnFTn3oDtfVtjWM892iW8m2c+5zzs3xRNjn+iGXuc3xtRcMgGNJm9dJ0RMPlxNbw9Op0Q4R+6r5Njd68lsMHzMhS/niDgAKIhHarRpq0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566873; c=relaxed/simple;
	bh=gMrG5tnBz0dCaC2htrUDhsDEXLGHAXaaAoIWnQvsjfA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NIykagnzlD9vXVvjfvoFejFZYGQWhnysluweBp4635682XfgiTgzfI4vUckmT3G8jEXxfBk9f6dygJLKaDDJ26N0JIu4RNtfrVte5otnbBGKV3y0vl2yTpVrTvytow4GQHk14S1JIpeojdAv/17fJBaUBaIJlbrssxCAMhjsakE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dElz+L/c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dElz+L/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35419C2BCB9;
	Thu, 30 Apr 2026 16:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777566873;
	bh=gMrG5tnBz0dCaC2htrUDhsDEXLGHAXaaAoIWnQvsjfA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dElz+L/caSaWCs5+AxQy/RsOl5emrztTna15YtXaoYIcAEg54CCgZ82N7xlWqcYQS
	 G31UvadMEMYro996erNhMUgwfLrw0Xc1TZGNchvsH9+wOSorJu/9wQfPhtGHwoTLG5
	 dNWIxdPn3PVijIbM/gq6naUDOIqqXOoC+Dkrt/oZ9mmYkfAMl4r41Pq7WFkK7w2pvE
	 sBBAiQA3e1iKtyEc0n34ZBGrhR9ib2MyKjJ5DQbve9MdcxhJJBTRPi0ykn65j84iBd
	 lg3qSRB9lhplMrqmXayjfBuwb0U3L/klg6d2Td2AgL8DcSDkXKdI0NH/n7dx4owxzT
	 qFLCLh52jtFAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E67380AA61;
	Thu, 30 Apr 2026 16:33:49 +0000 (UTC)
Subject: Re: [GIT PULL] ata fix for 7.1-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260430125638.854389-1-cassel@kernel.org>
References: <20260430125638.854389-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260430125638.854389-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.1-rc2
X-PR-Tracked-Commit-Id: 163f6494233e1679ec6fa6a4803f74ae7b1c94db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cd70263a6c6ceb677a679eba61a0a798d2338d5
Message-Id: <177756682759.3088538.9919510464851641788.pr-tracker-bot@kernel.org>
Date: Thu, 30 Apr 2026 16:33:47 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Apr 2026 14:56:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cd70263a6c6ceb677a679eba61a0a798d2338d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
