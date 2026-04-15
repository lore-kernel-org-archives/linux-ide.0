Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDCB248166
	for <linux-ide@vger.kernel.org>; Wed, 15 Apr 2026 22:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776292788; cv=none; b=gifjrJL5XY6AD+8ksMwWWmmcmxOjM6nF1fDYSJ29FmOx29ECMNvMGcczRKOc/g2Hb7n/B7tRRPjaI9yEaynZcmglc3J4KCzV8xXE4/TaBB5ZgvdOglx/7/bAg5lkTZLJSILgoEwScpjcwYDBTv5XDYF+fkiocp21NQsoUcV51JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776292788; c=relaxed/simple;
	bh=+oEYHx9A2ahs/20DwwyTOStSUB0YWi1jlCRcGEG5oCE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Q8VsbMNIgf8P5ANHkXXLy31d2xemLwp2ZhWsWq/Gg1w/eDVU4CFRwhl/hckrznIcMVxjIU6MJHkGIdryJZQjIyruLh0Kta4lgCs7+mwIrnGuK5hdMeAw4An/TfOHZ6hlS5Yj/kWX2pseZpDgNprqzb+7PC2Iik2FfOWvgR3pB3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqorTwc4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqorTwc4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF9AC19424;
	Wed, 15 Apr 2026 22:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776292787;
	bh=+oEYHx9A2ahs/20DwwyTOStSUB0YWi1jlCRcGEG5oCE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qqorTwc42nMaYmhuuPovqrTYJRHzr2y479FhwTkM8QEyOlRg8x1ZbNux6mtCCFqYQ
	 y2ectTW30RaXtW8mjg5HO0KTdhnQYAC2qU0QVrOkpy2Hnl1ML0NN+Oot3QaMSbvbGr
	 8EH6QoFhYIfTxaTVs2yfKkk+oclQy0dc7aq3CifO5/bjpXTt9IWWx+0qKCbcUrOGaR
	 GAcR99fBBjM3gs2bwyIVrWpZmtpzzzIJQsfdsHNOkdbefWuwrwQKE80R/llsAA5ehn
	 Le5EKjQgEz/kdyB+ZT9YeGv2ge1H9AbFCy2IN+lqO9S/zIUnUUQrJqzWd+5UPsyhp9
	 wUb9E9O4Yu2bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D2A380A963;
	Wed, 15 Apr 2026 22:39:18 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260413152700.2656409-1-cassel@kernel.org>
References: <20260413152700.2656409-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260413152700.2656409-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.1-rc1
X-PR-Tracked-Commit-Id: 8ebf408e7d463eee02c348a3c8277b95587b710d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a69195686d5b874ac5a4c7f809ecb75fbc535ef
Message-Id: <177629275643.2482053.398561162324131288.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 22:39:16 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 Apr 2026 17:27:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a69195686d5b874ac5a4c7f809ecb75fbc535ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
