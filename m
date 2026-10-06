Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC16846A5E8
	for <linux-ide@vger.kernel.org>; Tue,  6 Oct 2026 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296082; cv=none; b=Qc3DNTw2tvfNW9pnQZd4gRAxNtlvSG1gBK4enbBehNdJv+wKoQfCcNLlMerPGMDHlLfPt9cuN1nTqAEmk8fJCA/Blb6h9xO+fzjty4cWiu1gaki0beuu5M+V0XojO/MfJ9ciaQwsqRpnIQSriWsxlBk1kqY9r4UzV8DUf39vZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296082; c=relaxed/simple;
	bh=vBec7vNGgF7Bkz8FmX1cnzwbb/tDtn1zgrOdEPBbXUc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aE3eMdIps+FDrHJB3MP6iFmJSNnaFDQ2scEosyGdd61gcHXRdbTCB2ZR6WNlseyRXwuJwEo8uMi4pi4eHUlISYuxRv6rEpt7GEqbepCidB2oGAbvnMAAdUwSduKiacZoIzwRDAN7Z0PKhlOhQNMb4DLafciLp2n/vVajK7rnpcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBd7RDMc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBd7RDMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819601F000FF;
	Tue,  6 Oct 2026 14:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791296081;
	bh=r3B5/JrJuhZOolOAAq6731E0mdnN5IbaMOo/DpXGi3o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=EBd7RDMcr/OPD2u5+D2cOanU4vn0xsJGVKh+8jA/5XqjGxZDio6WDe64kelGvHQXU
	 8hDk4a0w7AIwtQeek2OZEKa7XWSrz9Mivb9iAUh5SkeRMw7pTWPQZfrYUYMxfA0u1d
	 4BjM1C7j/x+BwcSELBuf8lihjKQWNzLFu30tuSFtb4PSt+P8kmr9yGzdQWd1ho6qiw
	 d08VOHIwbuXAMcyi1DZ/0KPCR7RWdbnyUbr3VvIhcXK4tZreHfhQRrincA5Lji6dPC
	 CjL6c7Yuq00jjboULIC3gYXVJY14a3QkIGOpGSpnDMlqsUJ6E8M01ZcZc0OFIiYBb7
	 0Gn5+rmwSuOrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7759D39D5FF3;
	Tue,  6 Oct 2026 14:14:41 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 7.3-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261006104516.2347588-1-cassel@kernel.org>
References: <20261006104516.2347588-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261006104516.2347588-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3-rc7
X-PR-Tracked-Commit-Id: bc8ce2cea5f77c4bd1a5184705e300e83546c0c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69f80fef3153299d9c72c53d1d71eef6354b6926
Message-Id: <179129607999.2650572.16898592006368053426.pr-tracker-bot@kernel.org>
Date: Tue, 06 Oct 2026 14:14:39 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  6 Oct 2026 12:45:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69f80fef3153299d9c72c53d1d71eef6354b6926

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
