Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7C736F430
	for <linux-ide@vger.kernel.org>; Fri,  6 Mar 2026 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822286; cv=none; b=cIVhnZdMsVUtzDkGQcGqrS4FxzAivoV5bon78ybaUZ//cSjEaVTMjeInmljoVoKArCfwkcdzIbSAMA2PfMoEsSCI6stCp/wqvqi70hQyXpfBYF3FxMX/RCZ+JQva7+FMXYUhfweucdNez/ELeh3/yx3eg58oW2x1FM/Uv219d0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822286; c=relaxed/simple;
	bh=P7ulgJ+A8alOrVwhOTdfqowbT1aBXhXa0CE/Eqsphhw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZgqftEEcZ0+SPr9knmQvuSyqgoY3DRh72Abm1YT95DoYwCLE/rNSeiz5pyLPS17N/J1A7VIneH8sm+JYxoOQohx4unlls+glRrONpF+3w+3rOiK9/nRcvki0JtxxceD21b9i9QdmkbwpVBRZ+bNZWfuYTWNsM0PlcY79j/no9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tloo+SbA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tloo+SbA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43196C4CEF7;
	Fri,  6 Mar 2026 18:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772822286;
	bh=P7ulgJ+A8alOrVwhOTdfqowbT1aBXhXa0CE/Eqsphhw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tloo+SbASDGzRIo+xcULI/1WNnVbc3b0J1/y4LInvFhtmZKaqRBu6m9hvMIciPbBd
	 UxezJzId+O4b0Rxum7STmAYVl90vO8q3ZtYRzL2l5oqxJrZ+7CvUbOozakdT2s2LSc
	 TrMFq43iwRSoDUwpj7uUxlz0b6wHN3SD+UEU06phiWet0uqW/Yy/iqAqqo61F+y3ZI
	 Cal8YtfZApHwZIPexxi0BSfIfxPz71KZwNkKJsSMZJt5qrJ9lVOb0bF+x4OVUidPZa
	 bA2gYzBaxi7IzRFM19oWZdik7Xsr0VRhJxigc0//c/YZOosD06PQbnd9RXv8gT9D1I
	 QNEilV2H3J3TA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA03F3808200;
	Fri,  6 Mar 2026 18:38:06 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 7.0-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260306123832.991363-1-cassel@kernel.org>
References: <20260306123832.991363-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260306123832.991363-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.0-rc3
X-PR-Tracked-Commit-Id: ee0e6e69a772d601e152e5368a1da25d656122a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 723b5c93aaffe05cd2cb6585c3b4bc9fd131df27
Message-Id: <177282228544.7628.5320778141457272584.pr-tracker-bot@kernel.org>
Date: Fri, 06 Mar 2026 18:38:05 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  6 Mar 2026 13:38:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/723b5c93aaffe05cd2cb6585c3b4bc9fd131df27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
