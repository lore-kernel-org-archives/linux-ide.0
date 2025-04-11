Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0016FF44
	for <linux-ide@vger.kernel.org>; Fri, 11 Apr 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385983; cv=none; b=heXID6AewfqLzHYLGZ9mvy72P3vAzKxKwoeoZ7mLT1enC7ZU/MQOjewsdll4NF7AavaqQ7akVHhzBeCkViFgqGghdnklxtJ8p8wl9CUg7ZFBfRhkBqzD/tVIXV7N8pRQkoSLlfEIxyDs06to+lCGV9YQpsn1mYeXSBUKxCfGUHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385983; c=relaxed/simple;
	bh=8FkmoHq1y9waU/PPl7JR8zRjS/2eJLa7pRshMSFyzR0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ytwlr/KhBK2Lg9O213q4Y/0yHCDAfZeOIOlokxwI0VKK1FLVtcj87Yr7M3bGSdv5wify3OdaHHv2/T8lkfnEV7R7pyQv+FwAruTXv2PkMsvgFK2gwONNr11hgfKvAidCci4gxxpCeFcgxECBcizDHBWNRoUb8ySYoMPg7vOIYl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLt/sJpH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLt/sJpH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F0AC4CEE8;
	Fri, 11 Apr 2025 15:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744385983;
	bh=8FkmoHq1y9waU/PPl7JR8zRjS/2eJLa7pRshMSFyzR0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rLt/sJpHeTDqiFLTdtDHdvYJkVvNcVzUdihBx7XkI3A0msZ8aAu9zIsbhThvN0f57
	 yMXKWrrKOSZl6YhQKPMEn0rcoQl7PLU8F6+rGktB9tESoX7arjF5X/MUqn6QsRzi6u
	 LZZtWL9U1vVdRna9CZ2Kq/IcJpQjDDSkrfvcNTHdr+nmFPTLmy9xef9VuKo5E/dPt7
	 RMCFkbgUg+qjvr3Oqu+6pmNDb2ug5I7UjFluYNT9upuBu0k5MzppoIMzoCb6929+kQ
	 5J0hTU+q6iOi5vPuiydoRNdlqxWhTVz0+wZxvT0AHxkJAK6XeXxGCurtq0JLGDsGY2
	 YQdc5vaI2m3ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 35C4B38111E3;
	Fri, 11 Apr 2025 15:40:22 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.15-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250411055921.1072892-1-dlemoal@kernel.org>
References: <20250411055921.1072892-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250411055921.1072892-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.15-rc2
X-PR-Tracked-Commit-Id: 8d46a27085039158eb5e253ab8a35a0e33b5e864
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f3e5ef271e82836cefc3adbf4d1724a2c2aebbc
Message-Id: <174438602107.318080.132256282252956769.pr-tracker-bot@kernel.org>
Date: Fri, 11 Apr 2025 15:40:21 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Apr 2025 14:59:21 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.15-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f3e5ef271e82836cefc3adbf4d1724a2c2aebbc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
