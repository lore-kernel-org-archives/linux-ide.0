Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157731537A1
	for <linux-ide@vger.kernel.org>; Fri,  2 Aug 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617604; cv=none; b=Y0n5eaOpir52ZVgLFKh7/hR4D1PGQYJ345TUUo/6tixVo/TCO3TFCVfYpwvReziUHmC+1UmQYSo5bhH7hEwI4C5Kx5Am7nU/0roPi0hytJvGtcpvElmVcn7PhNeaKr0r4bgI38kj/DVDTqJQHl20JkEe93qjTV1r6UuDq7X0/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617604; c=relaxed/simple;
	bh=IrSMNiS3eqreNTXIZYaqbuPiaQvSX/F1VDq5LE1ClPc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pJ0UArknj6fIIOFHmqQPxcKAtl/bs3VYwMtmcLRq2sI3OJDblYUHaW3MSBspJz+iG8Ja0Mo173IUiCcqNc/GZ9FTO9fSlYK0TsbbS7krbZsS9MLuJzNDlI8do0nab2JZ/4xsw3Asbgw3sop4fK/jyYBkBoPlCBmW+iZ/08BuxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoFuJQzl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoFuJQzl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC4CCC4AF09;
	Fri,  2 Aug 2024 16:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722617604;
	bh=IrSMNiS3eqreNTXIZYaqbuPiaQvSX/F1VDq5LE1ClPc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XoFuJQzlSLZQebZaj0jbRE0uWaf2j7W4LrxusXdTBYNlQ8AGvh0vztKO+wWGuhBY8
	 l6Idi8Jx8ZmCzNTM3qCgoe2ydGGFKrhAdeFA7YaHeF5j9iC0WMldJU0wXqPOxynFDG
	 s/+mRaCENjaO3PL08AeBq1/BTSoobmHdoZNjLw6j008+JGFR5RaXQN0SKZh4z8F+zY
	 Ff9VRcgN3xj5p0aJHj8nzE9ywn5ekAU5FHBHPR2ytgxVRlTj3N/P+Jfpxc2fBDQbuK
	 rRa/QFkj9c4vgrh6GTZjrVYKcR13r2ZP2kmU1oA8Qql5fb2e0oXcxOHPHqfve7pXjW
	 3JK7O4lwURxTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD649D0C60C;
	Fri,  2 Aug 2024 16:53:23 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240802003825.19420-1-dlemoal@kernel.org>
References: <20240802003825.19420-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240802003825.19420-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.11-rc2
X-PR-Tracked-Commit-Id: 89fb4dfacbb33750e0243848f4c54d73e558ba9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 454e2370b9851519a8f27d1965fe25a9a38b5ac5
Message-Id: <172261760390.28369.6295017908691454264.pr-tracker-bot@kernel.org>
Date: Fri, 02 Aug 2024 16:53:23 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  2 Aug 2024 09:38:25 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.11-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/454e2370b9851519a8f27d1965fe25a9a38b5ac5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
