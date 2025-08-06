Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CDEEACE
	for <linux-ide@vger.kernel.org>; Wed,  6 Aug 2025 05:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459798; cv=none; b=ukOOsK0FoOVVvUk5Irt8yitHe0VU8wbWbKDOkcSPvVMhQM3wf9uN9UeF/V69tF35SViVqTPOqXeMnCaNoj9VG+44u131bL3yHdMN0icrOHFbdDvl5wrV2Vw6ino9+sMBC/BxUEMy0ra5IYook7lrCWvWmAZW4KXQOkpdm5xIehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459798; c=relaxed/simple;
	bh=ToZPFki1R/d9SmVrWQaJebSXuJNgEwtsjRmGah5pPIw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CHEh9OqNtDag9CEZLzulzoTdRzb8FapEFyCFTu5/cdSX8WVoYN9W1X4NLu3rQodxuD0E8MVQgKGsGg5PHWTd7AlWoorB39gU6c88W8NVCYA8K+ARO/gtxT/9E8yM3Rzo3n9NF/FC8OJQ3nzqjqgv9+XRvPZr+5WmQxwwRAgggOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dD2aWJ/D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD2aWJ/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FC4C4CEE7;
	Wed,  6 Aug 2025 05:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754459798;
	bh=ToZPFki1R/d9SmVrWQaJebSXuJNgEwtsjRmGah5pPIw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dD2aWJ/DNjZ8shsi3wzsdIWLXlA21ZvzWcq84hhvP4NNts2aIiMyeyCC5S3+rT86E
	 5WpF85lMqEXHnJ9ndtDFixuglMbcauxY9OINL0r9qdZZJBe+CH//Zz7Oqh/NuK6u4M
	 Q0pMcbSOnIR68zMZ3lPQ5ndWjWGeCuCBpb2/o2T2eCclJFkUQinQQqguVv/dYmJpQD
	 zkjfJE0U2TtU+DuC+zIjvEEqJ/t8AsBpLhOQgmt4N76/rQn2cBX0zN84vbaJShpeVm
	 C+ilj75JedwawXv2FcH7D3+DsTSHBI/b3/q3Wfm+ZX3qMxX6ty2l5mylpKU5XiCcbC
	 G1F9G3SNV5LEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F36383BF63;
	Wed,  6 Aug 2025 05:56:53 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.17-rc1-fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250806045137.729300-1-dlemoal@kernel.org>
References: <20250806045137.729300-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250806045137.729300-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.17-rc1-fixes
X-PR-Tracked-Commit-Id: 6cb43739b93c64c4a2148222bd606e6920257752
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 479058002c32b77acac43e883b92174e22c4be2d
Message-Id: <175445981184.2650999.12198582076907354622.pr-tracker-bot@kernel.org>
Date: Wed, 06 Aug 2025 05:56:51 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  6 Aug 2025 13:51:37 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.17-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/479058002c32b77acac43e883b92174e22c4be2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
