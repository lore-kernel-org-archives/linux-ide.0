Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FE943C05B
	for <linux-ide@vger.kernel.org>; Fri, 10 Jul 2026 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703125; cv=none; b=N5BlEDQBQLW3sY/ESqcwZRmE8uRtndo2o50bnN+gRceb8nuo6kLfZhVks+kM4icIUfsbMLoe+2BxtKnJx7dgr9vlbUUaHxW/o9RN9AeoIH2o5Kg9dnuJzt5wbWCjqfGp6jrey0FHjRtia77Hoebl16usFixbaaIXoCW/TF1E/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703125; c=relaxed/simple;
	bh=+wo6Gu2LRxoaMy9rOAXnrtsNmVnnISXA+olPRUyWwHY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y1KvJ33JXl7go29k3C+2gSa18XVXdXXGtzPIfmyUEMz6ZMQ2Mlnr7aDS+TktwrJjgpCW6brJ7HwgkmIvXD3gN3fx5zNxGwYxgftLpt77aOpWK4DJu0DJ976+H2gLFCZTCLr0V2by/ZwVne8LMdAuXcTrYSUhAGVnpf5pubPA4JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgDDVNxV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgDDVNxV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCA11F000E9;
	Fri, 10 Jul 2026 17:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783703124;
	bh=nSdf6td6U+tUANPYfQrEY6IzuhToOra5vb1IPPX/Rxs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=AgDDVNxV0g57YRKMY6nup4ffZHo6XtghFDnyLiAAG1RGfUhAWKGPWNrEXZxRn5yh8
	 8PgMG8Lic7sGoIfB2LQ6stg8dV0FClznoMMnSQ77xN4WwoRN9QfW8ZSIlZfrEdCHq2
	 2zQub1FNnSgndOfP+ZmHb8sIHYtr0F43zFmJ90/HMn4V+J1lvMGMik58X4Qt2cd239
	 vY1/ZSefrFT78npTQSIRnHygvi0LXhY+eMUIbo5rhvaH7raxuBs2k8B/jPCGVCX4a8
	 z8jZ2U/z/rHGAvHw1+Ndxwk6W+Vuf9T/19zvfLgz1AubT0E94TlHkf+n3fqeilWTaM
	 ov7MPTEJzPefA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569743924FB2;
	Fri, 10 Jul 2026 17:05:03 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 7.2-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260710071938.1624639-1-dlemoal@kernel.org>
References: <20260710071938.1624639-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260710071938.1624639-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc3
X-PR-Tracked-Commit-Id: 793bf193b18e9bff6c4280268bbffd16a5b533e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f964d992ee0ea1c0aca689b8b7d5607300f5e2a
Message-Id: <178370310198.779204.1226430518838868014.pr-tracker-bot@kernel.org>
Date: Fri, 10 Jul 2026 17:05:01 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Jul 2026 16:19:38 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f964d992ee0ea1c0aca689b8b7d5607300f5e2a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
