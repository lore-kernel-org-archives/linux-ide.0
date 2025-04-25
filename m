Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E2E297A70
	for <linux-ide@vger.kernel.org>; Fri, 25 Apr 2025 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745624113; cv=none; b=sFTm52mEuUMnyusC9z/9hTkCqXwV3e19tRylS/4T45GZfKMOm/LvAnbgENqQ/FQQDr4185Mut9o2370hh7iI8LBLwVfNXwPVlROGmTOewcwcsDDPlQvSFI4BAweU5wJP/kAep5vfPIDBaEYLCLdQJ02Z3TyYnE/RjuDboORJkKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745624113; c=relaxed/simple;
	bh=4qe1Mrf6toFYri5QSTH+q4tn1BBQxnOSIKRPLxaTSmM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HkxYlzRFOGVoaE6fRLVfDtLxaC8lW2MwSnqHZjYB6olAZc4V4FjGIuSvIBzeZp0kKZNFC4oTjgaNj2unTrxQxd2Vsjedei3DpoosbXD4p21vuE5AzPBLKpfCLYkT1PBg+FdwK1Zd6Vv/vUPRJk9Nyms6ebKzEiEmW4r4jzSPagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWON5UKQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWON5UKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4DEC4CEE4;
	Fri, 25 Apr 2025 23:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745624113;
	bh=4qe1Mrf6toFYri5QSTH+q4tn1BBQxnOSIKRPLxaTSmM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aWON5UKQdx9Np4NcvULGzUHUHD6I/CxCfj7odWgq3qxjWg/NzcDMnFYEBZG00Iymk
	 dFfbAv4wHm9w0s0JFae4WmVsk94TZDZ2kWzvTAV+fBCXFRM4faS/0y+0mVRNQHwne4
	 y/ECFoLMr6qWPzcNosdyAoozAUsYPzYrg6SOklKLHwNlAzO/hknpVSBXUvxllUzzFG
	 EAoqCunBXkxGftPeRNpPw19fQGELwdR4yOHmB/gLFTAKey9BXnpr1giVsVbfV6IIDX
	 JQwTQiqFWNHyyZkSZ+20XWK0oUkF62N1bGvoe8qgcEirX38poaVosJQlicDpAh85Fh
	 pCyCBAcz0Jocg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD0C380CFD7;
	Fri, 25 Apr 2025 23:35:52 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.15-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250425225521.2178472-1-dlemoal@kernel.org>
References: <20250425225521.2178472-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250425225521.2178472-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.15-rc4
X-PR-Tracked-Commit-Id: 14a3cc755825ef7b34c986aa2786ea815023e9c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1eb09e624f69a619947f262259b3eb90f56ff7f1
Message-Id: <174562415146.3874874.16297351955475479850.pr-tracker-bot@kernel.org>
Date: Fri, 25 Apr 2025 23:35:51 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Apr 2025 07:55:21 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.15-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1eb09e624f69a619947f262259b3eb90f56ff7f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
