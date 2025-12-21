Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9717026FA67
	for <linux-ide@vger.kernel.org>; Sun, 21 Dec 2025 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766309053; cv=none; b=ZWLVdArWFj3bKHUPDBjUP1ofpsMYesSrPJgf3MOoEZoGoYh4edYveQgIk5A3b5Dl1UIC53Dc5XItOlnNE6Tbd66b47WRhbx04JlPgP4dE9cJ9aYAcY2y1gwn5xoqNf36o6IEbeU5unK4C64poZqVp9bew6Wa+t10c8B73rEF0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766309053; c=relaxed/simple;
	bh=rXuFj7zB74t/tXLHn6z7RRinogDI09H2X5C/9LeRMa8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Q2BWoci/X3Mop4yZQ2oOa/Gh5GDUV9LCZ1Ja8kd2jGN4vSnGpJl4JM/IDIm1LsV1ZU0gwLDvuGxYuMgHoYw2OWskmzIZ4aKzjvKeqhfOFRjOWxz6eQQmKh8AbIgICPTAslyKX9AR54sw1rRAYieyq02zQlQ+yWfuAEPrPD85+RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yk3r7yHc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yk3r7yHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8DCC4CEFB;
	Sun, 21 Dec 2025 09:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766309052;
	bh=rXuFj7zB74t/tXLHn6z7RRinogDI09H2X5C/9LeRMa8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Yk3r7yHcjONi1lSXdPvD91BtypRGcXfUvl7Ew2tLrFg5B6+Dyzl/r3gbcu/Uu+du3
	 7GAWabMweCKp+jIwSz5ISGjHibHXnebOk8eM+RaOd2EQbMBkYFMgNvfgtGuusyERrK
	 9G0K/AaCaPPf58P6t6NH+q52qbxwjUzv+HP/z33HN3QVQF7I7OZmuljD4+WojOsVEN
	 WFNRaN9cfBf35xqtF9zBHjjAqd4fDOBx8glLrgTcPfteXULwvI423w9IEHY5R/KnuO
	 W910aVyaltGVzVZKnWe01mt0ZC8AcS+WDlsqQm/uTqmhGnbtwzcOZRsuKXAtFZj8PA
	 VCMg88RR9NI7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4830B3809A08;
	Sun, 21 Dec 2025 09:21:01 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.19-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251221064210.283344-1-dlemoal@kernel.org>
References: <20251221064210.283344-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251221064210.283344-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.19-rc2
X-PR-Tracked-Commit-Id: ba624ba88d9f5c3e2ace9bb6697dbeb05b2dbc44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9094662f6707d1d4b53d18baba459604e8bb0783
Message-Id: <176630885912.232877.13412355892875284180.pr-tracker-bot@kernel.org>
Date: Sun, 21 Dec 2025 09:20:59 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 21 Dec 2025 15:42:10 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.19-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9094662f6707d1d4b53d18baba459604e8bb0783

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
