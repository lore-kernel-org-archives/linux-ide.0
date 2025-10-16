Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC823EAB3
	for <linux-ide@vger.kernel.org>; Thu, 16 Oct 2025 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635075; cv=none; b=DinHSKweYorMr30QOl142hbAAcHhXAjXbykKWW+4M3RqA+FFMt0Yi1i7BKEgPjgePftBUZCBwc718Ah0zzu5Tmpab+b57ZKoMR1HkJdkbe0gMbSOQsH+DWS82H1r+IfDlW7AajjyoM5wcWuIsNfb8s4DpKw7IOvFezVVdgv609o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635075; c=relaxed/simple;
	bh=7Rqlf52/HehVU1eWd39XRYy4LRW4FEZkgNfxtzxAOYE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Bb0brC4dZXd3wgoBjnknfo8jb1+nxWMy+lb//UY6r4vNqecWbp0nOrNvd+CMtgZv8TR+X9Ihc/6VA8kF5yw8hY+HizYwDU7VuDf7+pbXTc9gxBAlgj/ifG/YJZQm5tFw1mBrfywGOyOU9OyvP0mhVSYPfQCOLDD5+AyLomiUd64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpTGWhrf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpTGWhrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AA8C4CEF1;
	Thu, 16 Oct 2025 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760635074;
	bh=7Rqlf52/HehVU1eWd39XRYy4LRW4FEZkgNfxtzxAOYE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QpTGWhrfGxCB5xKga7YjZRUo6yuCQin4PgEPLiAiTNbPw+iOGdrWqk6Dm8AhBkCcl
	 /3POXYJ+ObB44JIQSTPn4lxqK1yWUssF1jjHn5XeJSpZsk2eVt7j8eGyRQVvo+eNt5
	 XvMvdPSxOT3OcOtas181iG8yejvhRI28oh+FNmRT2xR+fp4CYKdkZyqt9oMwW6wk3D
	 WAaOrBf7XGAJzyPjxPcvJlhChQuNZ9rkPgOZGoj9hDQADn+ZmmU+fgYZ8MKfLvLB25
	 5RDlyxaaliyf209vz2iSTAoQ2zyfQAG/7EcqbpjKEmY1FwYIIML6WdKZYsjXfVf1hT
	 ovhtke9+YddPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E77383BF62;
	Thu, 16 Oct 2025 17:17:40 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251016095053.457176-1-cassel@kernel.org>
References: <20251016095053.457176-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251016095053.457176-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.18-rc2
X-PR-Tracked-Commit-Id: 12d724f2852d094d68dccaf5101e0ef89a971cde
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef25485516b09db57493f5e78b3358db7cbdcaa0
Message-Id: <176063505891.1828004.550008199051945929.pr-tracker-bot@kernel.org>
Date: Thu, 16 Oct 2025 17:17:38 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 Oct 2025 11:50:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef25485516b09db57493f5e78b3358db7cbdcaa0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
