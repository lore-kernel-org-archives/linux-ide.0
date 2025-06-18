Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CBA2F5474
	for <linux-ide@vger.kernel.org>; Wed, 18 Jun 2025 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270069; cv=none; b=nrVBgpqDa+2bvcR6Ap+LwYFguNzw4EB338y3boLtDYJX/r7Ai2IZAUidgnqgZ3h03XohEu4feUNkeDMeKpxgEy0pp2CR0m/DCNL5PCR/q4Pmraw2gJOBsU5IKnXbwzSSMEnMou7wHytQ9NJ23u1FGbcfy43sDgeow3bC9NhL1w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270069; c=relaxed/simple;
	bh=8j1oBnc1KWLKXPA3OVm4Io5WTuY48pwO8cqFlLOnssA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ImifF1rez6+04TUTbLu1/942QI0kXND6oO2wCJa48dKFCE1xzTXEfkoMToErV+5XsK8tVcYz7AUWrQ01W7GceDLNJ2a7y8/KRhfo021QpGaq2Rmp8SQ6olMXD/yUT1nXhd7pghxvuClACJw4v/0wIqT0Jswx9iOTU04oydHqf5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6MkrwrG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6MkrwrG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30776C4CEE7;
	Wed, 18 Jun 2025 18:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750270069;
	bh=8j1oBnc1KWLKXPA3OVm4Io5WTuY48pwO8cqFlLOnssA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A6MkrwrGpR4Mla4aaX/8UlpG8Ru/FYki2ofdNoL+9ae5U138l+bYLNOJfVGM21Lu/
	 xLUM53dDQRE09Bfl6rJOhkMW3o2xJhyXSI/tdf4NfxeIBSFjCGa3snFe3CrQIKA+A4
	 e39NH4KGV3QCQf/Bwj8XKEjOKSNXh4NEnHbCYuG0MxfydO0MU8902kewtqFFWag53N
	 90i8zYG/am0XaHhixJDya3PCwBGseXWIS81reL5/QcvxwXhqLG7ma9N83fgtdmZZjr
	 wcF9yP7NUczbZO70WM2ICDj0dbk2z1fc35ItBEdqTf9UGd6FPwDKCbZ44pEMoEcB97
	 u4SAXzl8SEmJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD163806649;
	Wed, 18 Jun 2025 18:08:18 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.16-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250618101842.167712-1-cassel@kernel.org>
References: <20250618101842.167712-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250618101842.167712-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.16-rc3
X-PR-Tracked-Commit-Id: a7b3b77fd111d49f8e25624e4ea1046322a57baf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a3b583f2050870e0403ffed650f06c94d7968a4
Message-Id: <175027009719.206233.206425974005942502.pr-tracker-bot@kernel.org>
Date: Wed, 18 Jun 2025 18:08:17 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 18 Jun 2025 12:18:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.16-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a3b583f2050870e0403ffed650f06c94d7968a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
