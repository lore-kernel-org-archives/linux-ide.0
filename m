Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95281F3D37
	for <linux-ide@vger.kernel.org>; Fri, 31 Jan 2025 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355145; cv=none; b=a5QsX9F8K+mkPrOdjcADL1XvmBuZicPgbzdjw1W8N4y0haAxFI9X2mSx3e3bP69Ut5qRkQFuIiFqTSHkb/T+Qh5x1mvMbJzmsAZGkHbbSQ3bqcXb4AjwQiaVaqvxEoJLnOt3BaVWLmElsaVM2Bl1peGQ5WrzZ9SqnVWfYbeA9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355145; c=relaxed/simple;
	bh=bNcOLz5c0tejivXYZlz/Eh1rQFpB8J/xFgea8YBwNUE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JPKEhmUkUfwkdvcCVWlZ1vF6fZRh+YTWUuZYnQB5pUU9+X+uuEblJPEjpX10rcVyEe5wLwfj4dkhDMzMqcTTNIYFYewdymWskWqEJkFiDzF6+AOtsP0FsH+AQBpFlfmsqnr0olq3KRQ78ozMu3hF0BWZOcTt8n1YuE8Ee8ae2hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtOG9Yxv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtOG9Yxv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA997C4CED1;
	Fri, 31 Jan 2025 20:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738355145;
	bh=bNcOLz5c0tejivXYZlz/Eh1rQFpB8J/xFgea8YBwNUE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jtOG9YxvIQvvfcy9y3Gd43KW/iVDyvIExYFI8DhR8IfkrXPC5PqQfi1OBcWLtYRG6
	 IGxWQ0wApdAXSWuHstfg3dnLZflaaI8VsuPCd823oeZhEVpKymx9RbkpWVGDmmwT+C
	 DnGn1z0pdY7WUcV3yq2SGSnZ/NF2NcqCrrTFJKRM6xdX0/jhsog3CKnLOyPLufSBYj
	 ULJl2870BD5uecBn5QvplUGF+G+K/UGxLX9KmaZ0rnb89UNNSm32ILYgDpc+FkIzBg
	 SwROM7LcmuCeb3XBJ0VTVADjXGyKEvcFcFs6jNstHK0dr0+RvAmCEj86BdRCVFcWHc
	 SLCXTTiRC/F9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AF0380AA7D;
	Fri, 31 Jan 2025 20:26:13 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.14-rc1-part2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250131110036.389139-1-cassel@kernel.org>
References: <20250131110036.389139-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250131110036.389139-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.14-rc1-part2
X-PR-Tracked-Commit-Id: 6e74e53b34b6dec5a50e1404e2680852ec6768d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95d7e8226106e3445b0d877015f4192c47d23637
Message-Id: <173835517201.1719808.11923869479790614392.pr-tracker-bot@kernel.org>
Date: Fri, 31 Jan 2025 20:26:12 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 Jan 2025 12:00:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.14-rc1-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95d7e8226106e3445b0d877015f4192c47d23637

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
