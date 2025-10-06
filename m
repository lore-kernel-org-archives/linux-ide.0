Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF17F3595C
	for <linux-ide@vger.kernel.org>; Mon,  6 Oct 2025 04:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759723803; cv=none; b=vGKRvC47hhOrHERRnXh2Lv7MyuNOSysbvjX2a/3I+FLCNa6BUG9j0rk/C4dsgNpjl+kZ6DfOp1XQruFDG/uAeDGiPDFz0HtXFTklEttpIfGBi9zM/3u1xgsez5kxkvwjGu6O0wnzgVFQfSj8WUjUG7wZItt1YMK0K0Bms2ETU6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759723803; c=relaxed/simple;
	bh=FpDJCeR4lWc7mM8qFnLBjGI0M5H1E/Sm6fE5lW264Zs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=V2dfDTQ5T1bwrb/x9gQFi+4c892r27yKy2w4AxtE7LRXcWbtTKU5bR1FnPK9oTEJt0HUiKtzdWLBM4gl55Dho85jQLc9OfBrrQTDxbohAXvPg+ATdaKNJC8mh93UbLdFKGNYahcd8XwgjbpCRrWWooibJq/7PvjIrZqylBQ9iVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ciu2xEgO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ciu2xEgO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DE7C4CEF5;
	Mon,  6 Oct 2025 04:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759723802;
	bh=FpDJCeR4lWc7mM8qFnLBjGI0M5H1E/Sm6fE5lW264Zs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ciu2xEgOuShdLOjBVA2e51rf0U3sYcxfD54Dr3mbRZH7DHl2QY1M8WZDNUy+lOqp0
	 GacU7zSxx5V1L6eriFdo6HFTHj/RHX5+LjS6bSBmYNp9v6MW5I3qmt6r2KVtCP2/Bl
	 KvlmwDVX/ws50P3zPzKu2VUqK+8V8+hXo7WV0rtEdTzLVeqEIJPkMi+M3mLonn8XtG
	 9MCvKTLYjAgSC9c63/wQgPywcbeikIPwQDe7GEdCzusymn+VGBXZ0/OsrtefBLK+iN
	 Hri9XfcgYOvMnvLj61FE+gI7ULFYnte8ynN6BpTBZJ2RFKCuTDAjnTXwXlNaThGDWE
	 52n/p0a2iCZog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB08739D0C1A;
	Mon,  6 Oct 2025 04:09:53 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251006023543.271842-1-dlemoal@kernel.org>
References: <20251006023543.271842-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251006023543.271842-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.18-rc1
X-PR-Tracked-Commit-Id: f145845d8348c9b6288df41cb7904fd9fde566dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b616669d1d8e91d0964b0861b51a3bca5f678c1
Message-Id: <175972379240.829897.10542514403699498117.pr-tracker-bot@kernel.org>
Date: Mon, 06 Oct 2025 04:09:52 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  6 Oct 2025 11:35:43 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b616669d1d8e91d0964b0861b51a3bca5f678c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
