Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234371991B8
	for <linux-ide@vger.kernel.org>; Thu, 19 Sep 2024 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732836; cv=none; b=pwsfwxv0pt2CXk4HRHtd0hwaaHFuEj7rjMziPGDuG3DSGyw4H95mARNnZMPJht+dbtVWvP81LbaxFFdsaZZI0bynmCvtWe23EPfaYyBg+pDkCMPVDb9Lx2IkM+hXkEHbkwAcu6Sbx0muSmLPyrGQlQdiVmSSp9YWccw6NgBElBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732836; c=relaxed/simple;
	bh=nJLlbb3aqQJ4TQwz8PxlBJJoGqj2mgqsGvhGsDl3EQE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P0//GHDYwhTH3vzdcwzVtq8dp7xgn21dnemxuX7SSAYN0wP/l0fUFrQs1NXR6Drxh7VGr/aeidyyFwZFNRGqDS14MiLihed48BQ2+kq90cb2ysKCTo2P8sVnRLSkZbMYi9RQ9oLNMbx+BeDYBtXHM+KpCvJKFBbEvK2SKbeSJJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiMQYy0o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiMQYy0o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0224BC4CEC5;
	Thu, 19 Sep 2024 08:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726732836;
	bh=nJLlbb3aqQJ4TQwz8PxlBJJoGqj2mgqsGvhGsDl3EQE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OiMQYy0o3Qq/sIfjMqEj6EaboXjRUIKmK4ZnB7GTl//ytdl7GCKgxQSkdNKWMhRXw
	 C65+OWAfM4l9jRmIrbaJcosTEhGlE3bvcUyAmEuDsgU9h/uEjHuN7UjUyXnYjEsnfJ
	 gcuj5sfc5k8cQNFaOj5dpApIw5Psgi9I7odBb6x91HuF8MK34Y5bCYmTGOaMiBT5ZE
	 I32Cvfz2l0oREHVkUpo+Tb/6b1e/FRDgnzS/D4E7he/pqZRDm18kaguoOZQMLQeOXk
	 eSJUD/xmMMAVT1T5avPYPSHX5qxrn7Hl0+W6c7oyA3dtCpsAVWUe/ktfyLBu2DoyPy
	 Qsz1Gh1da9Ang==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1BA903809A81;
	Thu, 19 Sep 2024 08:00:39 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240919065218.144785-1-dlemoal@kernel.org>
References: <20240919065218.144785-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240919065218.144785-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.12-rc1
X-PR-Tracked-Commit-Id: e5dd410acb34c7341a0a93b429dcf3dabf9e3323
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 176000734ee2978121fde22a954eb1eabb204329
Message-Id: <172673283792.1388805.5732860983098879070.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 08:00:37 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Sep 2024 15:52:18 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/176000734ee2978121fde22a954eb1eabb204329

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
