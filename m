Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395B82550C4
	for <linux-ide@vger.kernel.org>; Thu, 17 Apr 2025 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909592; cv=none; b=Y1PCGadAmUj7PCCPrM2AkBnAy8dsH7QTrUw9tSdmwDMopNcaxUPI4AF0dIlWVrrK/iIwuuFwH7N3JEb1hbWdhxU1xUrtSLNcDDeAqXwc71/8GQJbC3avbvpr2Imz3RmzOb3t9zzDl0PkQSkiyZE7h/cZW7TFHErAbY4Ipy07B0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909592; c=relaxed/simple;
	bh=86Oqz9rtTQmpGfN14C4Fg8yWMgaHPepqJUn631Rm6XE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CvQhoNoZ4nbjFt8N8nVe6ALS9xyW3FDf0i2wcSLo6qCTxLaUExHr32hcY/Wx6r56LSrOX5sp9iDCgcxdYGYEzeA4i6lxLkqnZWb3DNX4ov44/oX6ph6HdInYZLc+34LtKZvsm7BqScEAuNIGMStcHHr+lomyBvDVp+ANUYbgH+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSrU/C5H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSrU/C5H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96A3C4CEE4;
	Thu, 17 Apr 2025 17:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744909591;
	bh=86Oqz9rtTQmpGfN14C4Fg8yWMgaHPepqJUn631Rm6XE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YSrU/C5HaY48PC079kK8RzogR1nnios4K1T3IB/yYLVfba5nxWUJkqRGYJAcO348P
	 tuFmF/BKUucMbrFBX/BtSJM2xNaKh9ymwHmWmc68WGs9gQhIIffDNSaKQAAF8IxQnR
	 o3ZTsPcE68SfFDteIcW2F6xP9YJ91z5OhH7Gs2Zl7E6Ylr9SWv8eAqHepyX1WfQNTH
	 vHE2pQEAg7KZ4K36Kq3ByJn9iG7s5SUNb2BSMynxXpJdrtWQCHm0cu3NN9H8ZkG/1y
	 qPa5dwrMxSKsGaURDD5QLFba1v0IPN6+Upzots3Vr0XLsioSRNg2CVMlvF7RxJD60z
	 kOCjRoPRfdgbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADB1380664C;
	Thu, 17 Apr 2025 17:07:10 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.15-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250417113247.272720-1-dlemoal@kernel.org>
References: <20250417113247.272720-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250417113247.272720-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.15-rc3
X-PR-Tracked-Commit-Id: 399eab7f92fb73ffe621294a2d6bec8fc9f3b36b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec4c6d1ec4537bb41f57875e4929122e9160d01c
Message-Id: <174490962944.4147514.16835734031379435403.pr-tracker-bot@kernel.org>
Date: Thu, 17 Apr 2025 17:07:09 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Apr 2025 20:32:47 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec4c6d1ec4537bb41f57875e4929122e9160d01c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
