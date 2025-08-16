Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B642EBDEC
	for <linux-ide@vger.kernel.org>; Sat, 16 Aug 2025 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755353319; cv=none; b=Pth23wf9CIgNgXIpTGRsSpJSzhuYH31Lz/urxeKm2ce+muuzRZo12Z26FA1i3vJCI14MEBmEJVYtDuTB4BEDu4hbAsvqCS2lgd/JMFDqsdIHOf37OvFXdeVkcDZeEYExZQpu1w3K4LzJZpSkxWjEbHLQIuAExeMSC2zxPvhrMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755353319; c=relaxed/simple;
	bh=FHWI24qyy0ql3Ka4YnWmbtX2963CsUwM7n3rsDdIpvs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=X4zHvYw6V6HbL8ZIsnUroF3OnVeJc3g3v3aeBmNiC6KjvlbCy/xySYMHxJNUUgJkBZ1Q0VcBc0ZzX2rmX9h54IPwRnkCfst7AzyMmr4NL2h1zKeXqkZpuxnmJ0xuWyU2747laOHbgrGfuvshUvZegEJlJ4L/LoFcWZTHsjvt2B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FglprMWs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FglprMWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2140C4CEF5;
	Sat, 16 Aug 2025 14:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755353318;
	bh=FHWI24qyy0ql3Ka4YnWmbtX2963CsUwM7n3rsDdIpvs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FglprMWsT1Othb/4VUJqXBv3XoaDSxpcjbceBUxjJLnQ/ZYI5JkO2oqNGbo5XHDlW
	 Qxh4RypPEgYhBDf7cGXVmhB2F16HK+eu7CN2DtWm8ePJblPOJFAnPXrEuehcGxlACk
	 3/JjD1JHDzjO8hUXqbY1z42NTIMRnc2prbz1iwPWRjpR5bh9aVY7XK90UXdeRat/im
	 Q8akq8fhuFYcYZffEYOX8hOPF++vCZpFDsIeKtfMSNo2/8N0DCR7mQY0Yein9UnnOh
	 7pkUyxJ1JQvmTJ4ec77MDdsh3flhfz6URix0DIdyn80mtdw0p0ICZfQ2ToKOOw0HTw
	 JOCo02bRVAefg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC1839D0C3C;
	Sat, 16 Aug 2025 14:08:50 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for ata-6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250816122806.712563-1-dlemoal@kernel.org>
References: <20250816122806.712563-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250816122806.712563-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-ata-6.17-rc2
X-PR-Tracked-Commit-Id: 58768b0563916ddcb73d8ed26ede664915f8df31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90d970cade8e67e20b09bbfdc2f0b52064322921
Message-Id: <175535332920.1477675.2975482788825069632.pr-tracker-bot@kernel.org>
Date: Sat, 16 Aug 2025 14:08:49 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 16 Aug 2025 21:28:06 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-ata-6.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90d970cade8e67e20b09bbfdc2f0b52064322921

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
