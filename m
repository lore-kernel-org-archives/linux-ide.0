Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7CB30F95F
	for <linux-ide@vger.kernel.org>; Tue, 20 Jan 2026 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934255; cv=none; b=cfCqO+EePK3Np4DkpF1H+4UPa52ZN3sFf3+5d+c3cKqv21LVksI8Yl82V1LyBnPHL78w+8fAjuJ5CGAwegzPeykJQvF+KyCuXQDWzlQAjxdUoamNVJFNZLEDn1YRHxrRk/uLoS2WznmQU0H3/Ovn6WtjVjZtXC1QS0Itrz3ju/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934255; c=relaxed/simple;
	bh=NtBUq5uJMrzb8SdzDrX26I9E1EXb1sgk961Fl2GVetQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XJgfIjqEaRyXauG/+2bBDarlZ137oQyi4lTq7geSZr0lybewH+sBNhOZrM5knhpXKmdIjxo7SLqUVPVYBojfm+4h1x+0iGcomOW/s0tUbs20w8uTFYk2MaZfVbjOWOFEX2K9weFmzWPNykIuYQMR8Pg4nJco3quy5ZdjsgAF49c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO+FB8MC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO+FB8MC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD09C2BC86;
	Tue, 20 Jan 2026 18:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768934254;
	bh=NtBUq5uJMrzb8SdzDrX26I9E1EXb1sgk961Fl2GVetQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PO+FB8MCY/CB7dd8FMyMk3KsgdjSHlMbVTDPt4/ApNFxgBUdDFaKdqPWOKPoklpfJ
	 Mn6tSvD7U+zzmm2y4iWHK9yivzTLMQiHFuCN63Y+N4C1LdHgwOaiNSzIFykGi39Csa
	 amuPGOirqJ++OvkE6cs/q6WO5Udx0DPiI0Ob/vtbZg+vqqZvXdKpJCatdXWbh9EZgO
	 9QdW94xHUdoPcfmbfJexLPMAyhf0dib88trK7XD3lbotsQsCLH31ZcJd91SnY6nJHu
	 toznBYo0QhnYW+/tpS9e9lUwp57EfRclzQdkhmCBCVpR6MCaqEhgj6u9DMDCdXST5s
	 St6/0DasbPoXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BDEB3810935;
	Tue, 20 Jan 2026 18:37:33 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.19-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260119195742.320390-1-dlemoal@kernel.org>
References: <20260119195742.320390-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260119195742.320390-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.19-rc7
X-PR-Tracked-Commit-Id: c8c6fb886f57d5bf71fb6de6334a143608d35707
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73c9007d9b94065cbb60f318ff0d3637d1c8283e
Message-Id: <176893425208.562471.10102863880873839511.pr-tracker-bot@kernel.org>
Date: Tue, 20 Jan 2026 18:37:32 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 20 Jan 2026 04:57:42 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73c9007d9b94065cbb60f318ff0d3637d1c8283e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
