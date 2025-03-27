Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3568197A8A
	for <linux-ide@vger.kernel.org>; Thu, 27 Mar 2025 04:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743048001; cv=none; b=Tqs/8ddJWzGuYXXzNph+T4a+GNpxMf0NjNTKcnoshmWeLPYcfTxgYlPkF2Y4ywEqwBpV71T7uCnMlE3jHlearq44RxjQomthq1BlecjtqV0790LR6t3WEBU5w+oPuWrYKcYFdwNEFdbGUxbbfkZz0Ty9Zmgu+A6j4NDODQ001i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743048001; c=relaxed/simple;
	bh=t462fCWZOD7vQhUEa3Gu4svSXWHcxXtakEalDSwUoJA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FUlJNgg3DQ9/FKfcqyMn3uaJaiu4Spg1+Thr+VlxXxuw2yGdyX1tw14EHLC1qtyeIb1D0APSNpAHg6l2vt3yptvHoUZjnQWt5/8rEQU+ZgUkEVnsk4cdRAOiGiaot19WOEQhqDnwRIO2v6shXoXiSvBvaXpWm795DGizrelBYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRlRAJL+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRlRAJL+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C7DC4CEEA;
	Thu, 27 Mar 2025 04:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743048000;
	bh=t462fCWZOD7vQhUEa3Gu4svSXWHcxXtakEalDSwUoJA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jRlRAJL+q+wbGMz58zmU8giS9Hfg61cQoP6+5j/BjxShmxrX/k1tx7OmAEYroW5Th
	 ZO3UB6c3QFoFgk4WVUiOczwjvNxyudplM5c+XcUNWP0Y9r4G/l2adDaDfMYqPICUO9
	 ar0bA5QbtJmB6DYkqmdRnImqTrwG0QPy0YNr8ATU4ZU3x34KSOm/sQYGa7fMzGhz7r
	 oCar8/LO8TRKeLudATiDrLbmTtZLt3GjD7BbZWd7zZ6UIo1ilF3BfJ9FtSkuG8O8Tp
	 6ajn4EHX2jU4hxGYjIt6ml/KjIoRwul2FfSlIy25Gj5jb2G0IDyQ9prAM578ffL36H
	 sVQKaAIPglkgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 75BDC380AAFE;
	Thu, 27 Mar 2025 04:00:38 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250325193004.3777124-1-cassel@kernel.org>
References: <20250325193004.3777124-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250325193004.3777124-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.15-rc1
X-PR-Tracked-Commit-Id: 565d065acd7ea871874ac32e54e58af2d15a182a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22093997ac9220d3c606313efbf4ce564962d095
Message-Id: <174304803733.1563585.7449795364427709698.pr-tracker-bot@kernel.org>
Date: Thu, 27 Mar 2025 04:00:37 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Mar 2025 20:29:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22093997ac9220d3c606313efbf4ce564962d095

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
