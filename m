Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767C25234
	for <linux-ide@vger.kernel.org>; Fri, 27 Sep 2024 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454927; cv=none; b=LJGNRXRNVZvwgXfPvnQrOwpJs7SouZiQ71hYZ73Hr+ATQPLFVCP3jjMzPlFiLOS64dxTJbM6MNDM7IR2/ArjqDdSfOThJbOAmUULvSbm80tVhlwSlRdo9utmtQCBRkguQuAQWkZntV4/RtfAD0h8ZdXsqRnyZxMPOSNCNHEMrOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454927; c=relaxed/simple;
	bh=VjW+6+98nPLdshOAe1JnPJe7/dWepBRitZKyMDr6OCQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l6ZegCMuUhrDTt3jfyosDN5M4byUsnq5Nhk1M+IJCPQwqGjrz6DW1MBEHvnuH2OqUEp+zY9dBuD2UPhrBrIwR9xIUTLBY5zN3sE3EZlmi6gp8G/asQWsJvCl/9G3AwBSGnw5QUk4nIfDSEo0KsHyFPczkLQxkLcrwPRciqhFvrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpmT48HT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpmT48HT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56323C4CEC4;
	Fri, 27 Sep 2024 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727454927;
	bh=VjW+6+98nPLdshOAe1JnPJe7/dWepBRitZKyMDr6OCQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZpmT48HTwsFIoKTkGYgZn1CDUk5zcpF5zr90iuz7jhnLaNFSlYNFLfoKxUf/b+JCW
	 yj6KDaxp1dtNih9Pf4734kyKUmSHMisDup/IMq/JjyvgWjhqsGDsSdrUlA6Oy1u2Qq
	 b8speqaRWs+Fbjj+R+lRfYWU6aBtZYY3I2DCNxQlPXQp9pUgiLg47O4bJfvsiunbb6
	 w6YDdS7mEe+8a7MZWW79Fnf4GdIVNdOvNRVGr0avCksTFoTUJDZGbPUL+wMLATCsBV
	 ByufnW4m8DUnN4BaOpAhgEglTXtnkF9atr7IJ1O2VQvWaHAn5Y3D+LR1PoW3XdVCu0
	 Mkr66FzM2xZcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C723809A80;
	Fri, 27 Sep 2024 16:35:31 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.12-rc1-part2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240927122430.333750-1-dlemoal@kernel.org>
References: <20240927122430.333750-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240927122430.333750-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.12-rc1-part2
X-PR-Tracked-Commit-Id: 0e9a2990a93f27daa643b6fa73cfa47b128947a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6c49fca9f810c7279ea59937dd3a01a2906d11a
Message-Id: <172745492975.2017197.11617321950991278224.pr-tracker-bot@kernel.org>
Date: Fri, 27 Sep 2024 16:35:29 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Sep 2024 21:24:30 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.12-rc1-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6c49fca9f810c7279ea59937dd3a01a2906d11a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
