Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43BF286A2
	for <linux-ide@vger.kernel.org>; Fri, 23 Aug 2024 03:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724382729; cv=none; b=sOpGFMkv8OFrnWurmuKpqR0L/5qVyyVSgvceH9Slr4UrOi3uyGytDK13tlqycRJAenaY0PQaL+wVFnQL0Iu/eEXOA2soaJgBygNcAXMDwUIarKJiyKWiw3Oh3BHlnccWfJQkT0IAq58SVdXIJqVHsq87nTQYex4cugGITHt5LFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724382729; c=relaxed/simple;
	bh=49lT7geJno/ZG50BMon8IAJTKIrUW/3+Cx8hQfvOwaI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DEQw27CZx2zVwkRWUHhdU3aQgwuQYtWB8mTvOtTG8vW5QnlhXcP7gmL97eq3Zzez3ELNuiZ7s+GIRRbiAxxIf6QFoT/vm2QUHVcTCzhpQ4DiAJaytOXevcI174IZ2rmb0uBCxtgNSZbgDK9rUmsQHlGIqn7PbQztjsTZ0uM2sQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIbRuBc3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIbRuBc3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19223C4AF09;
	Fri, 23 Aug 2024 03:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724382729;
	bh=49lT7geJno/ZG50BMon8IAJTKIrUW/3+Cx8hQfvOwaI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KIbRuBc3i1J/zjnb8mvrs1DPj0ITON4K3NkNjtl9GgaNy2J3j5U9qUncQhEvm46QY
	 CDLmKVLITDfwTV7rIICleVi26BP6GEMwR84lLoXUQJGZ0/LhYMmT/cIHxJXY+b5sDe
	 w33oVusj6lpKUBk47X1i+jRM7Uddsy1AKLJCuWG0nZK6hEX/UiLEdgEQMx4ax7lxpC
	 quvtAYz+0U8LS0MMgcYBM34w9nEw2CzXZYYBdmg7lAtmU+t0o9NUqXueJmvZXpMuDf
	 aBToPCbDDpkBdaUuX1RPpVGncK30iMwqxHezXRj+9mQ0JCMFRLRpjjiohISRo3wn78
	 mkqV1ay/yUUzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB21D3809A81;
	Fri, 23 Aug 2024 03:12:09 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.11-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240823003723.89539-1-dlemoal@kernel.org>
References: <20240823003723.89539-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240823003723.89539-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.11-rc5
X-PR-Tracked-Commit-Id: d4bc0a264fb482b019c84fbc7202dd3cab059087
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b78b25f69a1dfa79798f684ad34707b1da10a48f
Message-Id: <172438272847.2544362.11230244452880864955.pr-tracker-bot@kernel.org>
Date: Fri, 23 Aug 2024 03:12:08 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Aug 2024 09:37:23 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b78b25f69a1dfa79798f684ad34707b1da10a48f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
