Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35FD4399ED
	for <linux-ide@vger.kernel.org>; Sun, 27 Sep 2026 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790538570; cv=none; b=ZOdO+GPlbHaLYb9TxH+ytPlIosUuBexqGFKxgrjttheU4J7dArKbOpQm2oak1Lfr4WIcAq2bIDX6eJqp3r1NjlZcVs1HSET+V05Ih6DWlwNwHu7xWGXYHl4xhucK3KzF+MY35ubq3VKGIDwmhKCaWof0L70dTFnFIyM5hznm99g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790538570; c=relaxed/simple;
	bh=fcN3TapuXUzHPy4ihXBpkp421vdPW7h1CF2rYTTXskM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OcUtOMIGivDaOy3bX71emeNCnF05qxGdliTklDR9EolArkZ74JXfLpwd/tzpe9hWj1fHzGCz9cPbSvjtlzPK/bamUzud+BswJFl+GNbBA9qQ1f05XHnVTMURDNvGSW9nwuLTwb5pdZyS085iDFJfPu1dCyxqrzo1rsdxP4p8s9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3w3jC+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3w3jC+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407FE1F00899;
	Sun, 27 Sep 2026 19:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790538568;
	bh=WxXi1XYyDK9kh/MbRMzALYutyC/IgswTjxfdTFdhpsI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=J3w3jC+58bczv3OJZvFNzCkyZDBcalNWzok8QMZP1pXK43naV+RQ3faK3UupSV4aM
	 /X95J3a5fq8JVSWMwO0mGJneekn/bUANfOx+iZXGzn9LEwJwC1plIvcAYFXVSC8ghv
	 NwfrTNKxsCtxygW7KEnvamty2hZ2/bxjO8WknBfcL6Ng3xQf1FYLbEfExrIyGj7i5L
	 qHRKXeUvYmcZ7AMIy3i09U/CXxp3RXFRIym7Vw6TKPSLu0sDWnV2y0ILrBynoRj4tM
	 IDYtulaJkWJtOERT3PchI5zKYedhBNf/gFysEafPRa1PZccc2Fj2xf852injHtTF3U
	 3sSA6KUcQDoMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 22F3D380AA5F;
	Sun, 27 Sep 2026 19:48:15 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 7.3-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260926174849.501378-1-cassel@kernel.org>
References: <20260926174849.501378-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260926174849.501378-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3-rc5
X-PR-Tracked-Commit-Id: 113dcdfadf30ea11fbbdfcd4f6ea87687655cc5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd179f8a05be3ccae366b9b96e176b51fbe54aab
Message-Id: <179053849381.2777566.10357676969363579204.pr-tracker-bot@kernel.org>
Date: Sun, 27 Sep 2026 19:48:13 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Sep 2026 19:48:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd179f8a05be3ccae366b9b96e176b51fbe54aab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
