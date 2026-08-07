Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89864281532
	for <linux-ide@vger.kernel.org>; Fri,  7 Aug 2026 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145826; cv=none; b=Fv0fksKREriYqtdCem8gtWyGLTUzmHWh7+CEc2p3x37YF4D3pL5OE5J2VipDZu72rhmYeaN4uIT+MXMl4EO+pFBSkFaqg5PspbL8qUXHpKXhkozCY/1EuIYlNrm9j7rMH73gRdgk8QxJtk7nlBJpVRtAPWqDp7bNhism1k4J8dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145826; c=relaxed/simple;
	bh=FgUf0gfaaCM+cmMljIAqGleurtwSRgpa4pLsB9dHp+c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b63mv1PfJ1htOB73W0MIwUsrNi1FjaEgOu6pvhBUNAbbd9Q5cqZrhwAHn2IMe8N9r+ld/whMkAHDMLeDqqPFSvWrE42feZJ01YZRuh25d6L2rSAZepublAsygqWLVq7l+uEUwE6lq7Ft526LHajkUkwr9VHYuCA58Exvj+oVCm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZcO03q2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZcO03q2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299321F000E9;
	Fri,  7 Aug 2026 23:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786145825;
	bh=0XdcBYkIivlbsPGL1Oo8VJiC6aQ1G3ul9/r03hDBo0I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=iZcO03q2mJg6qDkVdbCM4fB4rifJgJg8HVyYxCmSbajqj7v7L6e/3Yk2+76YLuj3E
	 exdGJio9f2wnwU+YS+75OHI4ue98/CcpEOWAU3vlwIOoqCFB0Hg7zMviBk5WtYs2a4
	 LC+fTIArOMHFRdT9kTyN2VvriyaHuxs513h1Gyf3njNvVOGNvqmxDlqfEfKPy2U89x
	 MtZRfwYYx74HuhLLmbSjlhsau2JUkvNxa2fomxCH+N7nN9azPhitJPSVM/Ior3qdq6
	 CVtdXW9GsYiJJ166Uoe+OwnbsaN/vj1Ib3v66wm9CcDsJW1O4jzpV2RuWSo/7xd423
	 LIy2/SdRyCCUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B19380CEF9;
	Fri,  7 Aug 2026 23:36:24 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 7.2-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260807232818.860137-1-dlemoal@kernel.org>
References: <20260807232818.860137-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260807232818.860137-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc7
X-PR-Tracked-Commit-Id: 7700a31039cdc6715cb6cce7e7a664ee4e945f67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a143525f62bd6a871a49a61a5b3e07f5d54f654
Message-Id: <178614578329.2464369.7771196896619017333.pr-tracker-bot@kernel.org>
Date: Fri, 07 Aug 2026 23:36:23 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  8 Aug 2026 08:28:17 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a143525f62bd6a871a49a61a5b3e07f5d54f654

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
