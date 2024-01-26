Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B602375D
	for <linux-ide@vger.kernel.org>; Fri, 26 Jan 2024 23:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311750; cv=none; b=cTkgyRBDAAxQhXLSSNmcWheIUTHvuavHvAom6866H4equQp7ld9lEUUOVxN06j7zxDuiUrG19RP7IZz2nG5gxskyA2JGqCusEiAhcGyDt2sB9dKawJQtWGz/J3P9vEQo44LHQ2Wlpg1Gw3Aj+EBLj5+fAYb1MrXLiEQP1P8PaJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311750; c=relaxed/simple;
	bh=W7QVFrinDVL+xZi4HWwSoAxDB5LSoB6jUd7NhcE/IYk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Zb5+oOItAsvl7IpfvwfGtJ6OrYG0g+JoRfegKP1h9Baco5leeRLZg9ILuii10cuUfzHD4sGk783Vpd014tJiPkPJ54bwtH6ygD5E5EY1Z/L4c0sXF3q5rByZCDdC+MzbFeqq07bj3dERWEF6TXiOB3RTBXbY2DS2K9PdaZ12Rwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGg8vU3W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGg8vU3W"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDAADC433C7;
	Fri, 26 Jan 2024 23:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706311749;
	bh=W7QVFrinDVL+xZi4HWwSoAxDB5LSoB6jUd7NhcE/IYk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hGg8vU3WSypcJB5ekrF+2LwD5gncwYlwLezQ90jWidotNLQzSpa85LLfFiWFo6lhs
	 2TFksjytIyNM84O/wRkDoSmuziRBPZ8xceMMkzDl+8oMIplnMilNlv2mgeT7g1UKDs
	 RskDbf2s/tx1MmoQCHGj7YId4tXnlksxzojp5ec7YUFWcnH0VKbaVByjtR5OK4of4u
	 q8bI7G9eTZIUipf2igbr0t6e2WkiAOZPJaGWLQdfHsscO624nCbh/866kKEF3KFvDB
	 9twdbanEcuwCWoLcEHSClK4h1Hw8qKujutw9HE5V75Db00XXJpPSDQOxpjPCo+0wgq
	 YrfA9nAGphQ1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5384DFF760;
	Fri, 26 Jan 2024 23:29:09 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240126204927.4168716-1-cassel@kernel.org>
References: <20240126204927.4168716-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240126204927.4168716-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.8-rc2
X-PR-Tracked-Commit-Id: 20730e9b277873deeb6637339edcba64468f3da3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a5879d495b226d0404098e3564462d5f1daa33b
Message-Id: <170631174979.8231.16751461089664136940.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jan 2024 23:29:09 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jan 2024 21:49:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a5879d495b226d0404098e3564462d5f1daa33b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
