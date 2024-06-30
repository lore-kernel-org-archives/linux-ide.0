Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1C39ADD
	for <linux-ide@vger.kernel.org>; Sun, 30 Jun 2024 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719784026; cv=none; b=usCoWMW5Dn+EMsvfNxN/JsJkb7s3QqB1ThFCskEQCBdD1t1ln5LuDlM3E0yRdm4dyZBgKK7u99MqrDYAx8w+ZeC/8NEcvPdvY1bnYtnDhMFZK2ToLP6GvwYZ0ed33g7k8lqExekkOjKpwqn9gWNAcn9s4S/6OZYZetdHBza9yDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719784026; c=relaxed/simple;
	bh=YZiYC4H03bgkkYEtK6HdZIHWgXWG8u8tdS5eVLI5whc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UbCBBiac5veTskDN2F0wo6lNJK1fVUrjW8hATN+uwFpHf6Jqr30utIenNu5YzCJQ873c9o1Pnzb+scg9MhDgQbrJfcnClhISiTBaMq47dJriPPtc9WPzctpRqLu5iCOyBJvVkMlzEmgBnFrxyQzgBXEhIwrteAFETRktj283w7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yl3+SRyH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yl3+SRyH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C052C2BD10;
	Sun, 30 Jun 2024 21:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719784026;
	bh=YZiYC4H03bgkkYEtK6HdZIHWgXWG8u8tdS5eVLI5whc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Yl3+SRyH0xYCijqGdGF0WC2QDCaX6X9l2PN2if3d94zH7WJkd5EfGhevo7nR7u6m7
	 TkxCdrUmx9bhS9gne1CpUbG5nf8wXfiUgN0Ma5QsFDqKu4TaX4ecvOwUvn5LAL0LsK
	 EP5Lyjek5q67Nh+khQOYdTmKczjUEZZ4IvJasBBu/ghGImdE1/TfZSeko8WQ4ek5sx
	 qoXGvkgkGFq8e3eV0uxajJhdYe8fEcJlG1A2XOGG3a/aOprpijLMxw2UCxQNpMpzFX
	 h6O/3Vch+vctErapbLYvkEta4nX5P4grsXaCgMAO1nns+UCpUXLvzOTDMfuS1vxT2T
	 qYoupeTtBwZ+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EFF1C433E9;
	Sun, 30 Jun 2024 21:47:06 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240630212754.207691-1-cassel@kernel.org>
References: <20240630212754.207691-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240630212754.207691-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc6
X-PR-Tracked-Commit-Id: eeb25a09c5e0805d92e4ebd12c4b0ad0df1b0295
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aca7c377d8cacc1d2181345fafa94f63ab1ff39f
Message-Id: <171978402609.10779.4867238342493428175.pr-tracker-bot@kernel.org>
Date: Sun, 30 Jun 2024 21:47:06 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 30 Jun 2024 23:27:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aca7c377d8cacc1d2181345fafa94f63ab1ff39f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
