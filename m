Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3376F51CF74
	for <linux-ide@vger.kernel.org>; Fri, 18 Sep 2026 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755127; cv=none; b=O0BUVXQxz6R8UB1xQ4xpLWXQj2tOKgSCRfXeu5lYdIv4kHu/FUUH4Mh2oHFIZPu4WK7kEPXVvJvUi6PtIhAiAv7tTBckOQDOITFfxEk0C65hlhKmFtT1FgF37cSLQvnBWeCnEfn2ALG5mbbcqwxP9i2uhjeGHtRetqIbOFFJ43U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755127; c=relaxed/simple;
	bh=4+mFoLr2zosVL7heCi/JcPsVlQeq48u+ak68ZdNcPtk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cboVydtq1hinxQ4SmrN6RI6/xVlmOoAAaHbv8AKKHLJSd/posrBDfw26VASu1cul3OIrz6JNZxqvKFtJCtdcqnRat8ThgC/bmeIVIc4ludDohhrwCxmUNAin7riCl2k0yUTSKbVUo7xNvlWxS7U++7xrn0e3XUch8Yyt0kOJ0I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRhjPNle; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRhjPNle"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087371F000FF;
	Fri, 18 Sep 2026 18:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789755126;
	bh=sDk8ThuzhGHEfsipMf53q9jMaaq34u5aPeTedXCaa80=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=LRhjPNleUIxT54jckJSDAq4huIWLdjrJbuZQDTXOkef5Tml4fKx7OV9xnm3GiY2iu
	 BX4/b+pi2KUT+9QW7QNKAbZcMLc9NuseLuVN0ainsfaSfJzzxqoSQd0fQRRpMp4knY
	 8Cd4wD9OrSScF5fFZGI4Qzn9cdYV821MMTR3G5d6KyLSFFiEopV6mQL+JyLFf8x+9l
	 TUlE0QXX8tn2MyO8ukZUeSvkLTgszBTxGsQJxepHesYE8NwAEA/9APnGnnj84v51rJ
	 nUjRUH0n0bf5Q2sLr6lNsAl6y9eB0XNlhK56KzfPL4nBZA5CWs+MAxqaEAxeCJhZ3d
	 eEkmxS9+6wkgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A9E380DBEC;
	Fri, 18 Sep 2026 18:11:00 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 7.3-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260918113708.1894735-1-cassel@kernel.org>
References: <20260918113708.1894735-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260918113708.1894735-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3-rc4
X-PR-Tracked-Commit-Id: 8d836581f9b1f57ceaa2b47654754ef1260b410b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae09f35bd358b926916bd2b9f1d409b0d1924344
Message-Id: <178975505889.1083250.3690857135042919421.pr-tracker-bot@kernel.org>
Date: Fri, 18 Sep 2026 18:10:58 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Sep 2026 13:37:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae09f35bd358b926916bd2b9f1d409b0d1924344

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
