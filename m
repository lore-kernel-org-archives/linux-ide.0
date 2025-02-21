Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACC61D514C
	for <linux-ide@vger.kernel.org>; Fri, 21 Feb 2025 02:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103967; cv=none; b=I4ZUlkbGEYl0zqpYDqVHC5JvG+xfJpJUF00y9xOMlkNVnb+qUCzLWFhwC8NB4Is19VQNwqoH3uYu+tCrzuS9V6H60pyA2tVTzl38KVfu4+6i2ljqB6N+oCg2xPn3s4g8aqAdn6KMsFxqVDOIso+fOb9BTH++3mWQEWV6SxJLjUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103967; c=relaxed/simple;
	bh=dFQPbWH8x/i+tv9Z0NuJ13dJHc7mA/pn4TqH6yVGf88=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KkRUf1AX4WpUgIioAMyW4LPAt8m3KEQo+lEuZ6hy260eeVGLsw1VxGH4hGlD5BI1+UMav76sQTVo7x+15ZRJGhGDrKF/e9ObpnWVCPDWUhFYDKmRcpbaFKebpaaCWChKH4Ccc23pYLLBWEIyxnJKos7zIDE/LsrfRXWSkRpJLZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxJoFmGG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxJoFmGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0914C4CED1;
	Fri, 21 Feb 2025 02:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740103966;
	bh=dFQPbWH8x/i+tv9Z0NuJ13dJHc7mA/pn4TqH6yVGf88=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UxJoFmGGgeV/NdV2v+3iGISGimDqsr0uGklOfrL/N0dt6GNw/PRnXe2iw37mv5jJR
	 /YhqUOYgrLGg9IN6wdl1OTTyC9jSZQboxZ47ftB/Kb9WWQWII3+I/4P/UUiW4BtrT6
	 HlyxghRGX3brNkqK2VzMv5NHiTpmCfqw7NLahLeASM6pXl83WlOu+xyqFphz1pfT8c
	 qIIFHaa6/0QJXio/Vd/6kR+4q5sy40TCA8A4pZNuajd+rwCizu3NGIkS08EE1Ml5tb
	 7dsbqkhF1vY2e1yZJGcPayWcRAxmAWuglehKd0kM/mJnGinE3zVhgcOuO5CUfXElFB
	 qs/3qguZGKCFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE03B3806641;
	Fri, 21 Feb 2025 02:13:18 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.14-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250220122455.56387-1-cassel@kernel.org>
References: <20250220122455.56387-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250220122455.56387-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.14-rc4
X-PR-Tracked-Commit-Id: 2c202e6c4f4dd19d2e8c1dfac9df05170aa3934f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74ee48a2b4afa152b2d7f741677f6ada3c11be51
Message-Id: <174010399724.1552538.13092743076537524851.pr-tracker-bot@kernel.org>
Date: Fri, 21 Feb 2025 02:13:17 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Feb 2025 13:24:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.14-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74ee48a2b4afa152b2d7f741677f6ada3c11be51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
