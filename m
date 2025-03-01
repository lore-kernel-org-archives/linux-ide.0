Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD391519BE
	for <linux-ide@vger.kernel.org>; Sat,  1 Mar 2025 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740854209; cv=none; b=pO+XZ6MrACQh4FvFNtwCy49DehGqupvIoEsG668OxLUkLFnuk17zDHVSv0fFwOF++AJiiFXzmHWKLXGZVqOKqpdvScmjvzQjnz8FjHyD+2j6AUp5SOaVJTLcE1N82oQhHMhWhgeIkqO01wkw1B9heifI9S96aEOyRqMcYhSuE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740854209; c=relaxed/simple;
	bh=jv1tVcCpQnXiCYQRBVyGvoNVb6WubafDSyM8hgrm8Bw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DLTz/gtAJdfZ58YJCyNASq4ADFWgwPQvoIityMkeKmk2h1O27nJaRxIi+w+19dC1HqSrmpHfvSeHbTQRs/bNgpjgQktZRQr1X5/WvcENAv/WIBAY11eQTueoqfdhVsAxmHvWdIv4MyHio/3DVUw4GED59geYC3IR2l/UVucnIqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuDdr3/z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuDdr3/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594FDC4CEDD;
	Sat,  1 Mar 2025 18:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740854209;
	bh=jv1tVcCpQnXiCYQRBVyGvoNVb6WubafDSyM8hgrm8Bw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XuDdr3/zUjXqGvNLJaK1A5c3oOMT9s0nWqm98v2eS9XQERWGaZM4GyMjJBOE4EPXJ
	 LkpyutE6nOPQB8kBRF1Svm+Y1sUuO7mSoqCZIPz7uygfLspJ2ZhdAYSLiOnCXhk2oR
	 ta6vCEUnPyo+6UsL0UJ5CfvIk8jEB2SwXscUvV5COVvlSkWHhGQf9EWO3skjKVRPcr
	 1v2TX5Sh+rOF6e0kty7NsmLiiZ6Ob1TLN/XLL91nAxFYydrGLI+ZZJ4MrIQ3aNrkHl
	 RWeEoP2ELwj1xF8SwvFFFx8pXiIQlrf0wxSSwQH5//TbFYPIm0++xd9CA15W3TaOmI
	 4Wt8leZN2biwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF75380AACF;
	Sat,  1 Mar 2025 18:37:22 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.14-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250301094839.260353-1-cassel@kernel.org>
References: <20250301094839.260353-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250301094839.260353-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.14-rc5
X-PR-Tracked-Commit-Id: a2f925a2f62254119cdaa360cfc9c0424bccd531
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df87d843c6eb4dad31b7bf63614549dd3521fe71
Message-Id: <174085424155.2484297.12186649767993997215.pr-tracker-bot@kernel.org>
Date: Sat, 01 Mar 2025 18:37:21 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  1 Mar 2025 10:48:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.14-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df87d843c6eb4dad31b7bf63614549dd3521fe71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
