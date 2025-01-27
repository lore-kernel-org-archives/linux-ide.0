Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AE75227
	for <linux-ide@vger.kernel.org>; Mon, 27 Jan 2025 00:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737938160; cv=none; b=Ai5n6H4+ilZEr9ObM151sUh3SUPOMUkBfx7KZnCNv2obqWP3jmQ1dQcmghuoHI1ar0ZVtNIInUjrviBKhV6+OOmcuoVyF5or7SNWxGL+4wO+8IjoD8oSbGpP7BlR9WiCDnxRbIPJKfx+sYCwWGNhuHnAgvQAgIZYPtVfrXruN94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737938160; c=relaxed/simple;
	bh=JQY2MucpxUMJEZYPMEy9EKB64R7WU/tBLvVrohlZyAk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c2JDbTISZounewP4zpD1ZSwUvmwhj6U6qe6cihWlaCly6Vo850djdxBPmbz+2Du+2Cjywb3OFOnDMHg4XQ9KxyR2Ny894iSCYhdV4i1qmBOo69i69Bxl4G9142xe3CiaCMQbhj725jv427Jp3SZB5nISAuxBjpjUOwwCZpeM0NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiQ8lHK7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiQ8lHK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18195C4CED3;
	Mon, 27 Jan 2025 00:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737938160;
	bh=JQY2MucpxUMJEZYPMEy9EKB64R7WU/tBLvVrohlZyAk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qiQ8lHK7thvHYB9iK1tL9zjIbT+V3TybhTFvnqnw3tPqKpYXv4qmnRE5HGTwnbqVo
	 qOa4qG3kFQ40k8Jc3k/PmtO6HKpvZeLbUez01CzxluZCZdj/fQlDAfaIkipQ/uo2j1
	 7lbIpDz6f6tmpP55wVJJ9y0xTXtGC0JWgitscTiSZfWmOoZ2x2kLusXH5UwOAAUiH0
	 qhKsA8whr4gjsNguRdxv/14rK11aGpGFMZrPcTj3nvSwGWJ8G46HPtvdn3n+OlFFgL
	 JTFwg7xJavXkwwWpjRQbrfFsR4Cpd8f9Fa2bT5vGbVoSvDfZYpfknO6k8ih9l7eEDz
	 F7+9JVxGdKTww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF11380AA79;
	Mon, 27 Jan 2025 00:36:26 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250127000238.1682504-1-dlemoal@kernel.org>
References: <20250127000238.1682504-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250127000238.1682504-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.14-rc1
X-PR-Tracked-Commit-Id: f2809aa4f591d98e4c560a23d7eaca804a8afc54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: baf29cc16e18e621a05340695d333fa5d0d001ce
Message-Id: <173793818517.2914332.9300591868989791058.pr-tracker-bot@kernel.org>
Date: Mon, 27 Jan 2025 00:36:25 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 27 Jan 2025 09:02:38 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/baf29cc16e18e621a05340695d333fa5d0d001ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
