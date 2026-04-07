Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8250344020
	for <linux-ide@vger.kernel.org>; Tue,  7 Apr 2026 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590048; cv=none; b=QzaTDquQ8ayk5R9dJzpFXotgbmqDg30i0ie0FpmfzM+g5z5/HtTe0sbIn9qyuqnVc2T9MGDVkd0Ucq86ogfF8hNHbffHlGxe1WoFqiez8J0b+FzRe/Uua+Do3zeL/qgCnJv8OrAtVma0Ifx1fReT7beqMYMxkYFb6P/SIJYTc10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590048; c=relaxed/simple;
	bh=VcaH+JwHYEQtYJPpoHfxG5vrkqGMW7ZJYtfkdtA+/0U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aRi/4q2b0s5FhPrGHAqKP6xRZqUsTOJoelc6WbH7flBbFBay4igo83tWf/2WFdTSv0L4RkcAskP6UBHqSPzBhUcz5EXKiMpvCgsc32d68hGJAoSCnn8SXat68FyqIOSMVALjl2mdlqsgDr2P4E8r+GRv7GObZlRzzIWCK4u7soQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+0JMCJf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+0JMCJf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB96C116C6;
	Tue,  7 Apr 2026 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775590048;
	bh=VcaH+JwHYEQtYJPpoHfxG5vrkqGMW7ZJYtfkdtA+/0U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=R+0JMCJf+SIkptP6WoggOtzDjrQy4kGAZEjPTs87ijc1WPwMauKgdn0E/2s9AcEtL
	 Tof3ETemD6OniMhMj/OJS7m47XPB1BZDXsep13DkoIbLmo7whmrH7d/1PCkC2xV3Oe
	 lVs0IrHrPeW0r+MAoURLkV4OCkcJFw9WREB2iRJ/tb8wqvAtcOQgRMfg36XX38wfEF
	 7glcuS1i5qu+AE1tSU2fK2Gc28Bz/M2bjhGpAVEUcPUwIpsfKfCtqoLAdJSB3jLhcB
	 SBlsOBlNIM5o4F9tHgq8Zu9YLnKy5vJ8yKbHTqsRnaunTYJCSEgrbshUP2yLIzfX7l
	 MAnlpNgcD8tGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF753809A33;
	Tue,  7 Apr 2026 19:27:07 +0000 (UTC)
Subject: Re: [GIT PULL] ata fix for 7.0-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260407082018.1205645-1-cassel@kernel.org>
References: <20260407082018.1205645-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260407082018.1205645-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.0-final
X-PR-Tracked-Commit-Id: 105c42566a550e2d05fc14f763216a8765ee5d0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3036cd0d3328220a1858b1ab390be8b562774e8a
Message-Id: <177559002598.4123438.12163817755454537914.pr-tracker-bot@kernel.org>
Date: Tue, 07 Apr 2026 19:27:05 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  7 Apr 2026 10:20:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.0-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3036cd0d3328220a1858b1ab390be8b562774e8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
