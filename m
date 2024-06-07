Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831FE13DDC5
	for <linux-ide@vger.kernel.org>; Fri,  7 Jun 2024 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717795022; cv=none; b=VyfQOTJ/lVj8TYTEUjlfwRAjQ8F9diIKHUJOQquARGVBzbezvnKyu7pjchbpm5wsKPKHWzg3ZZr4ozU9PGSG8bLx4pQpfNkUlL+pox6m11xybSSVcf6ByOcqJnZaAAPtMBbJnr1XdtvxTbGufPhYEkEl7gVCo7rmQ3AcO255RoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717795022; c=relaxed/simple;
	bh=4fS8E85h2t7yCBQrfCOj4muD/PvtTFZyEUhn97OQTTQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fjr2p5LWDtEF/2aUnOXPGmODvMwQRv5T6dfVfZknwKMbBgo2EfDIWRSQYMBfooZAvxOcF5z+9NEd8NOn8kErr9XGk0SROy/6TgfpkakxmXeTvwykHWT1uIAJYxUi0bXgtNYKDdQ2L05OAf9munQeV8R2OGbnJeepsu68YNcxJuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgaOxsxA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgaOxsxA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63471C2BBFC;
	Fri,  7 Jun 2024 21:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717795022;
	bh=4fS8E85h2t7yCBQrfCOj4muD/PvtTFZyEUhn97OQTTQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DgaOxsxACYlicGyw3q3/GSQlv52CGa63uBKShu0m0tFZwMTEagxDXHttYV4EQd9lm
	 5H8Sbbz5OHdZSgwrEnZjVmztHmUTe8PicsBLHebYBaW30jD3JSDZ4EcKcO3Oj7s991
	 neycO8F4k0Jd7mvadRgW/+bO2k6dyKgIEwyw6s46AJd5tN80zI8QQTV7hcJS26PUL8
	 ZVc/a9iBxR2YOJh2GGkuyqeCXbn+2s5P+6EcPDp6nh/CPIYne2tDPJY2J1j0EcjxLC
	 9c8qMD95DTRjgUs/SHI40fTLuEfzNGDD3L+kf8JpBE1SaYGoms+uDbnv4r2w36gg+V
	 echJA7sg/d+Qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53542C43168;
	Fri,  7 Jun 2024 21:17:02 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.10-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240607083023.1163249-1-cassel@kernel.org>
References: <20240607083023.1163249-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240607083023.1163249-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc3
X-PR-Tracked-Commit-Id: 09fe2bfa6b83f865126ce3964744863f69a4a030
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e693c5026c28ab2ca1f718f66f47a6a041ec8f3a
Message-Id: <171779502232.6230.940432864674014331.pr-tracker-bot@kernel.org>
Date: Fri, 07 Jun 2024 21:17:02 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  7 Jun 2024 10:30:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e693c5026c28ab2ca1f718f66f47a6a041ec8f3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
