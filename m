Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6D117556F
	for <linux-ide@vger.kernel.org>; Fri,  5 Apr 2024 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347821; cv=none; b=U1nDvbNaZn1FK0n3s13YFB2DVkjk2iMuxNagrd3SwA0R9gmXWVT9J8YjAej3DV+sjtli0gBhhLwFVYGGwlBluEPcZnnw64S29+3AnhjlFbFCw2CPltVCnyvMtrAZIE0ru/8DmENLfSCoI04GDmdFzB1aEdxHKxokjXXA7SSw40A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347821; c=relaxed/simple;
	bh=oxvcS9XzsYrjX2TkloKfjrZsYMuMiS4eD5cpsYNsZvE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bsPueAXJQ03wD/sLxcE9MHQqDjw21Hp0R7YwtlUBozhONfZ2LDEYJV1OtTzkVGfMiqpaAjhNXQxKu53F9lCLpZopBzf+JorH7HLrxo4536/fXUvdym3fAgx87wcfu1e8fETTs/sLWdGpZJ+gKIMxF1ewHUANyK7lduy6aF7BFck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh9rqph4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh9rqph4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C77BC43399;
	Fri,  5 Apr 2024 20:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712347820;
	bh=oxvcS9XzsYrjX2TkloKfjrZsYMuMiS4eD5cpsYNsZvE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Hh9rqph4DiVuN/xSZVluNkZtVpYmXaEtKOBi60rBmQzJMo/5WUCg9TwQR3Fj/iI5o
	 6nNVeC0HevzasFaPSRW1aowXstHpmjjK443fjY28oikt2/O8QOUNHsz+mCQvryi3ok
	 vClXZsaHgFeMWioB0+dJWdjnU5pHZb/mIx48S3PgvTbcKbE+XNxHHToBM3xabZB18v
	 D4V+4C/H/tRpItsw7LkMrJvTK2xJUk4vjUoj5YWHrpSKAzyXP4CcPYCp3srVb01LYj
	 +GGsTpqb+yVIPm3Mf0cDzEuEQSDOln5i44mTc3vRAbzgU02v4l30tFbPPNGoofbHt4
	 w7MHDeBa51Ovw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A7D9D8A100;
	Fri,  5 Apr 2024 20:10:20 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240405130548.1135183-1-dlemoal@kernel.org>
References: <20240405130548.1135183-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240405130548.1135183-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.9-rc3
X-PR-Tracked-Commit-Id: e85006ae7430aef780cc4f0849692e266a102ec0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c3fc3459b4a48281b79f66d3ba01f6d8324282a
Message-Id: <171234782042.2800.17336880640944351543.pr-tracker-bot@kernel.org>
Date: Fri, 05 Apr 2024 20:10:20 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  5 Apr 2024 22:05:48 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c3fc3459b4a48281b79f66d3ba01f6d8324282a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
