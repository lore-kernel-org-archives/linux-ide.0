Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986723D5C2C
	for <linux-ide@vger.kernel.org>; Wed, 19 Aug 2026 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169348; cv=none; b=nEkQ6qhPY7eSSXrrj8VJC4cMjwVPjWOBMfNrlw7YrVX9FtYVOS9jPigHcaeHDS/qV2623q12y2ggthVIfZF1p2RCcGh6BIzs8+/R6OfNEbnG65laIOFnA7LtnAxW7oMaxZfcQzRBevePiWgPU5bWpPWcqSuvUopEAW4nNQCvyO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169348; c=relaxed/simple;
	bh=2PkJlFFad8yClt7vv2hPO26DJRbn3bUFrgpr/WsGDN8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E3Qcd/JYRpqMZc2dYIYMdeadtkg/kLzJoOYkWjY2oWGTGEGIRpnN9GKihuQHw68+d6MHq6NODpp18FmAB5zWLly2yK/scJro+eXb+/dvOF9M4+OH0O2uHZx09iV5fh8Z+YeTr7jXSVEU3cNJqko/+6J5F3aEinzbt8/VbBo9lTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zhb09jT5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zhb09jT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5071F000E9;
	Wed, 19 Aug 2026 19:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787169347;
	bh=Hzgpka7O7MI5CKq3yy50nnIu81VEfU98t1+d68rlw38=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Zhb09jT51JCjwP7f3GeOXNBPuALL4XybegOzxjKV2UID129poBQdYMExJhvf36ZDQ
	 /Zz+iHEZP9S3hWbQqMcYbv3KXlWo1iO6wUuCSWP5MN70AiSt+P9Fy3RpnOj4H7J7rA
	 IjST4byC6UUkyGF0F0DZKbLg4TLM9YPwNgo8Kh/sgdjpgiJCaybtTVRISKDfdRMu23
	 Do61CDbq/IWRKJTWZa5y2pvM4vGzblSfTUz+PmKd7rC0wBl8C9FUKxn/e9vWUSNTzH
	 zHf8AFir5t2GtOgrLdgpfIQ039Y5Gue9JAj+N+l3OISakGwKaupHaeNxHfjNJ1nysf
	 iKOzTNV/TpygQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A7C3811A47;
	Wed, 19 Aug 2026 19:54:59 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260817040635.133736-1-dlemoal@kernel.org>
References: <20260817040635.133736-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260817040635.133736-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3
X-PR-Tracked-Commit-Id: 73b6bf3c314ad34a9fd389f84de6e8dbfc204880
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: faabe2db712e8310dbe38fb81d33e5313ff0f059
Message-Id: <178716929820.3672948.11363788878438260519.pr-tracker-bot@kernel.org>
Date: Wed, 19 Aug 2026 19:54:58 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Aug 2026 13:06:35 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/faabe2db712e8310dbe38fb81d33e5313ff0f059

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
