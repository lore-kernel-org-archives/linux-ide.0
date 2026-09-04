Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D87150AC30
	for <linux-ide@vger.kernel.org>; Fri,  4 Sep 2026 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539488; cv=none; b=U/f0HDSXlvzaYAr6plIJjblzZLnpGQpXfKWRH8fI9/DXzMVdiyp3chmyM6HF4u4gx8gvXwTZFcfy2QsNLE/oXeZzwNzjcF3zdbzf4CQP5WXPLSbJcdQ/9zG5I/eqXwQjNGKb88TR/8gVA6nH74F3ZD9pxsaMUDR6oLhBX5WZRxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539488; c=relaxed/simple;
	bh=zXf67mspmdgsYc9VraKMgAH7CP1n3597UizpMU0kOEw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kfxvM4/KC0HUvmVnpx9bLpZ+6sGUJF6jbh4IUcpW9dFdNLoVa+Xi7sCA9afeuI4iIzVPazGD+7nlcnf7tor82Nb8dHLUJ+9ydiskWJlnKnBgF2TxAr4yYonMxSHFZLUbZSG74yEnkSbN94u4TPE3EvgIAz9YZFrWI83xbGk4oJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zm+pdij7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zm+pdij7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD191F00A3E;
	Fri,  4 Sep 2026 16:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788539486;
	bh=HZfuajxHAN/YT2jS3gCOSDMlRSYDWrBk3IwOgMa0gpU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Zm+pdij7v3+kbpX0roVgSgSt4BN4QXWiz/zelE08EXVIpIiFpRCDOcUZ8m85oYxAS
	 TjkQI8wMowFvkffCARrGBdShk5452ug1m35Me0iDmxsN9Nd0iKYw/Phe2euPeld9u4
	 woa0VFer47b/X9yB73+QO7bBs9IDF8RepNxzkOvHwpbGR6okAqtFaAXGCnMjvBEU8L
	 OCgSg2va2x26YR5KT/as2aF3XigohWm9tOT5Dq++43qLSU8FRK7Wf5wGPf81tyOA6S
	 987fQZz1b7Yx48URGkWhpk+RmeJv0M3ob5fvqekTDGPTsscUMb5ServjpQO5MDHstq
	 bs39bvkoRZ1+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D9A7F3924A4D;
	Fri,  4 Sep 2026 16:30:28 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 7.3-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260904144228.1473602-1-cassel@kernel.org>
References: <20260904144228.1473602-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260904144228.1473602-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3-rc2
X-PR-Tracked-Commit-Id: 6d81700ad7c4871f94fb72e469cb0f3f55843ef7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e66602704746dd59543b62820a3b86ec19218a5
Message-Id: <178853942768.415389.1381608803684490064.pr-tracker-bot@kernel.org>
Date: Fri, 04 Sep 2026 16:30:27 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  4 Sep 2026 16:42:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e66602704746dd59543b62820a3b86ec19218a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
