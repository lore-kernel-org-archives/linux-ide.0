Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FD81D07AE
	for <linux-ide@vger.kernel.org>; Fri, 11 Oct 2024 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675231; cv=none; b=B6eOB4vmbP0RUGoSMz7Xazh15w2RroiJKu4FZJX0EbTNUyOQKdsDPFbWjMFlhlUHjkJ1+SKQQFHbIoaddtm/rhCcXYITpIZ8ZykImbANLhtBmuLkQbMH0em7Vitd6UHgMlPmMdwOQSCxh0Qciyirl1Fqr5HKaGyt8yrwpsKOpe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675231; c=relaxed/simple;
	bh=YhYWaLjQKNmij/3Nj9SDwhdBbLPouYMEKhABsgcPZ80=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OIDLiOBRaOWPSiu/0k6i+oYBtvoqE2rLC3+dAyVbDrNxex4PSBXuK/bJO6h847+D5BRPak/StUaqTxtK9nl9L0hhhl9fMXOvToacHLIXbhK50R4TDJuODuC3mLoSRN6wt47ty7r9252aZ3v8CZ+LgYwKumpmNDifz7y1DXMXz5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1XUjmD5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1XUjmD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A228DC4CECE;
	Fri, 11 Oct 2024 19:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728675231;
	bh=YhYWaLjQKNmij/3Nj9SDwhdBbLPouYMEKhABsgcPZ80=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V1XUjmD5OXTweGxlStbg81OHLz/d38qQsjUAxddtL6ZMqKxMBRLsxbxqiY0Cp10na
	 6gSF9NBTLZr1Ed5ZKg55ctgXweITep/pcRvKl0NV1kFTPDph2maEwotOzqbUjb9TzL
	 g2BDHQo7L69rJYE2l/BnYPJP3mgItLKFnOl4u/6yeWK2/Y2Hgz5/k+n2uTHvkNK4ip
	 PAFmanlLQa1I/6VjN+iP9C/4Aq8JvXhm8WbdY7+PFe+vjZvWjQAqw57D7utJAaDDXh
	 6+aaDPze9sDl6dLRbolaL3DXJvl5Ikqmzvx4uVPr3L3fGX2kDNZ6wBQoR18sJ8EIBS
	 I9UuxW9nEt2OA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7277238363FB;
	Fri, 11 Oct 2024 19:33:57 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241011100241.1825849-1-cassel@kernel.org>
References: <20241011100241.1825849-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241011100241.1825849-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.12-rc3
X-PR-Tracked-Commit-Id: 0df4b9d91488922859db8dde4ee56936e01d547c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3700dc91b39aa9675047f7aae232b9d4a1b70e20
Message-Id: <172867523597.2975359.12148725086834980561.pr-tracker-bot@kernel.org>
Date: Fri, 11 Oct 2024 19:33:55 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Oct 2024 12:02:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3700dc91b39aa9675047f7aae232b9d4a1b70e20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
