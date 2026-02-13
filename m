Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812372F872
	for <linux-ide@vger.kernel.org>; Fri, 13 Feb 2026 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770945499; cv=none; b=klPSU5BE5dfVOmqqARv/NpUA6tc54xPB/B0TceIzIBewyrkoUcdwN3DfTj5yCd/4S01b07BP6w79qHQ/3YaFk4jmXmtrj5wf/VGzCtW0zpT551MAZ8l0RD6SH2wVlOrYA3D2OpexQLQZpMekYOyjoo6bzuQgq/m4IPe8u7Ke/5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770945499; c=relaxed/simple;
	bh=4zmIs3pkM4aFFwWlzvv1oDTrJ211ijWabZw/EuHaPus=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bMmwOFwe90NyECVCHG19GrQ0vzQk45BYSjHnZUb/sTGlXRK6xKqYXM2nMx+Mqmv5PIkp2dvLxC758ts546dNNiOONqS8GS7EUPw/9nEIheb25ukYUUXY037pE/OiIIObUzXwKR27XTxqBmw0HN3oB9olDbeHfb3EATpRqF11/gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzyBF9C2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzyBF9C2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66768C19421;
	Fri, 13 Feb 2026 01:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770945499;
	bh=4zmIs3pkM4aFFwWlzvv1oDTrJ211ijWabZw/EuHaPus=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pzyBF9C2DPo9rLdku46Hgbr35EhbNYCVd2A3jPV1HTlZlf/413eiZvwjup7qBBfoQ
	 NB4uKFiLYo6PDWSaz+JhUnM2jPw3MaIsQasnUO8gCV/dqCpU760d0Aq+K40dLStFM6
	 QsuIycpoCs6wVIhuuZE3EJTqo/OxfOmY49Rvq/bdAcaCdR7qfob7GoVCHc9WXtZuUk
	 qC3pjQ4hUI3QUyGLxt5GGcQRqhPF1qBEkl7vA2ENoClQgmpINzjmHkO+kv1Gt88DUK
	 uuBWTeHSQg99BUIQOni1S17P+1NEE/JCkmI7CK4XBv1pcE47c4khz9u7VWbULU4OW+
	 4FdYjZ97sBxxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C23A5393108D;
	Fri, 13 Feb 2026 01:18:14 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.20-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260213002425.113971-1-dlemoal@kernel.org>
References: <20260213002425.113971-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260213002425.113971-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.20-rc1
X-PR-Tracked-Commit-Id: ff4a46c278ac6a4b3f39be1492a4568b6dcc6105
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c75a8d92cf173113d1e43a41cb472cd93561bf8
Message-Id: <177094549337.1792804.12198387286510992095.pr-tracker-bot@kernel.org>
Date: Fri, 13 Feb 2026 01:18:13 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Feb 2026 09:24:25 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c75a8d92cf173113d1e43a41cb472cd93561bf8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
