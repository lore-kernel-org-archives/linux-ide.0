Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035545;
	b=JC0VvopM+i6c87GprQRIi3v5EykorgGhTSv4noN5pUvEQu1u1OkklH+2j6w5z77yFu0+
	 QeulsXFElCFDgcNhSFKKc9nlESJDgbCi1HpKzQvme4A90CSwatWLCoQgZs3Z4dxdrk+or
	 D9U49klx8rPdfKluOZRp1askVrnLeq3pzUTMAcCJ0BIpFc0BMWjzF+0wWarpVgVZz12Q7
	 zoJrx5zmx3hc1Uzx5s/Y9aB/ciCo9JoM2CHBo+oTsNfElJAjcEMobRgJX7xckKkcNWACk
	 PIR/v5VaT7bfTV0tD1u3FHLr2bk/XFNbKO4Z6LpLYnmOj4SJ4+YHNVATd5z+cXO/Vyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035545;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=uoHYt0sZZOmv5tzdbRQs5mwSBuo0Hx/NsN7WOWtY7NE=;
	b=sZYITmj8kWbHhMFaUbiQvS5cge7jPBepYtljVzGgZbBj0xyI2UkAd9o4BewACYLIef00
	 fJ8SveUKoiZHfGu8rnA2q5RmtcRLMfgWOuEhgzNtklxdexdx1soGLqoWwoaYq0p7mdYrt
	 HNDrxeVTtR1so2cvi3KT7atqPzou2xg0GgN6K3Qan8ngQJdb2dTLd/7O1QRReSyr+7Dch
	 hikhwoqJF2GGvjlLh8Tx+H1vycLbb3aNSfbfOBjtx9b1j2T1zVuRyPGVXq8+Yi3/Dct5T
	 wwZxgPAL76L1shicPYx2vh/kk/Tmt/+jUf/xhibVtNY315IY3kuHH8NnptYz8mFDjww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdJCrRAl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39272606A337
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdJCrRAl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B6E1F031E0;
	Mon, 26 Oct 2026 17:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793035545;
	bh=uoHYt0sZZOmv5tzdbRQs5mwSBuo0Hx/NsN7WOWtY7NE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=kdJCrRAl5Vcjd6zy2rSKGp7Zuo+qS6Kk98IaHxmGd1CLxzUW7/fJhLXuPu/aQwjxQ
	 UShMpMlJ6SsXCjjF0d2qyTaB9ClvkBiRVxsP+pVJ+D9Qe1nleMLJdiTVUFwcbc3fYX
	 P/XJp/cxiwssOt/zIkr1anPb8LHojnLu81A0/tcllKbVJ5gge4FHfLujIPZYs8BXMG
	 FzjNF0oIFvOwqJFbBqGH1dBMm+lyH0xh5Csyt9czKyhHkg+BIxKb9XtrwUQFqq3bRL
	 ctDJc1VpGY/1FTCI7GgrFZIJ5Oo7+5G6XxCveVnfH98x4tjepRggScpgHklvayIWvT
	 M+bf6aA3Y/DaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 073F83AA58BF;
	Mon, 26 Oct 2026 17:25:45 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261026095418.3270238-1-cassel@kernel.org>
References: <20261026095418.3270238-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261026095418.3270238-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.4-rc1
X-PR-Tracked-Commit-Id: 69be770908ae57354a41d7e1cc99ab46278d2e86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb2c3f44a7e14627b9dca8e6b568e6cdc234b40b
Message-Id: <179303554350.3291751.2175785593791897600.pr-tracker-bot@kernel.org>
Date: Mon, 26 Oct 2026 17:25:43 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Mon, 26 Oct 2026 10:54:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb2c3f44a7e14627b9dca8e6b568e6cdc234b40b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
