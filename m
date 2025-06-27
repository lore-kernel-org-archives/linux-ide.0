Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBC92EA730
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041741; cv=none; b=XNPpbEaRJDDd19ktABEIBOgrklAnJdfaxAf3eA7095BCH9IApQNE2FPhfU3DVrUGR/ginSjEYRLgsLBZ1hFCEVGozyaRUvHWhJV4M+Fv3e0Lj8A6Murw4x9q3Dm4LXke0zzS3ZJPWcBI62dGg89btXEbOu3yqxmdy7KWxtp4s4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041741; c=relaxed/simple;
	bh=tQv0uG9vlPyBMTkv2aymItbRQdI3Dq0M0BXXy0gHtRM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LyzBiAZt/xFUWLwqnU26GOamOv2sXZKilsFsx8LN3GMyKoWo9N8ICUpoIB/4OZEFzhDuiLLt6+4KDh41oQhUWm+M9+tnip4pSu7mkSeZE6gLUMa9KiSJ5J+Tr5EH11pxOSENbWtNFJQHTw0PJVxhRh8HeTxn+ts0bsnq1JEoys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NImShCWH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NImShCWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5D3C4CEE3;
	Fri, 27 Jun 2025 16:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751041741;
	bh=tQv0uG9vlPyBMTkv2aymItbRQdI3Dq0M0BXXy0gHtRM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NImShCWH3Knhvrr3ES6St+2q0SaF6JACyXrP3PyiuQR4pFMzG749qc5KBDPL2c609
	 dYLTNbNFjwHdWWDSEhtE4c/2FwhNXJkEskbmPXVS3QJ0kcV9Up7Tv59h9At8IrB8Z9
	 k7VRIKa2KDEXJLbk0n0Bt+qNjNfB8+QiF9LoKQig9Lt44zkIkLJwe8fWszC6L9mIOy
	 eDHVOpdwsnZ9a83QYngWPRd8zDRssPPYwaPVgG7EbCFFt0ZTR/73JAT/ApEuW1aFq8
	 iApOEQhu7bPjJ8qpPT9sQ+HJZilDHBuSZ7Oz2Wr+xDmQlcvBXlYYwWs4jnJDm9HUpy
	 KkNcgpXdtyX2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC6D380DBEE;
	Fri, 27 Jun 2025 16:29:28 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.16-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250627101431.1667919-1-cassel@kernel.org>
References: <20250627101431.1667919-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250627101431.1667919-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.16-rc4
X-PR-Tracked-Commit-Id: 3e0809b1664b9dc650d9dbca9a2d3ac690d4f661
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c7331f150549d3c724051aa11c5dcb51bf3aa99
Message-Id: <175104176722.1986529.13209263976410403882.pr-tracker-bot@kernel.org>
Date: Fri, 27 Jun 2025 16:29:27 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Jun 2025 12:14:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.16-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c7331f150549d3c724051aa11c5dcb51bf3aa99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
