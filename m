Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA3A1A08CA
	for <linux-ide@vger.kernel.org>; Tue,  3 Jun 2025 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972738; cv=none; b=RWlTksct8s/RlYH6GTpU8qC73nIC+kch6T2cNnLb2E/pFcFFOIzUF+cg36fWGwmbBhA6KnkVL050bmJ8XbsRRdBVYwvr0krJp7UUsk7xa2UnQW/CMHbLcPSU3mZ1UcIkYvefWzuu9gNSAefQD5Wx6wRyB1hLVLkdfplNw7B93kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972738; c=relaxed/simple;
	bh=ceryW0dT6GixY6w++2+pg3u46GUp+u8UhuN42df11Xg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lAlr/znddE4/2a4PnMG9Omqz1f9Cr7JPVjIwST8bt7o2KZaiNngkZaJINPd8vb71A5/heXr0Kys/fMY7ATjJo3/S7UNEDJvMeldEQyFhoLuzu+SmtNxfKKc8GGg4AIGNrFlrqdk3GAUR0tlTVNt9IbtXqOADYCKmqdL2w6rm4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k21DCyaG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k21DCyaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F30CC4CEED;
	Tue,  3 Jun 2025 17:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748972738;
	bh=ceryW0dT6GixY6w++2+pg3u46GUp+u8UhuN42df11Xg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=k21DCyaGhQloHh0q8QJ1P8PsglZ/GXc+8t3iFX0ee8JpqOUW20uVUhmEnCYJxpYZU
	 AtAB7VKDpMnmgTxMUdqfMIob+A2t4PaiFtI2iK8TsrHTvXNwyaE/ZPHmWVP2N3jits
	 9Xuys0QKKwAjc9bf7ibkU+d6/L44ytWLMTKNM8ibkoL4QGoDbaeflBAxibaE4tPSHb
	 z6ehlIEuQeLI+4nXkzPJNe6KNFbcKOXD5zB9fDPUq4HqjnsAeeBJ4E7kE5cPGqRaIW
	 PoFQcmdSdA0+xY2sccaNPZiirNwZbgIYggtLF1UkEZp9cX42R9D7oYwq+XIHaLV+Rf
	 xWrv1KB1FyWJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADFF380DBEC;
	Tue,  3 Jun 2025 17:46:11 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250603060658.171254-1-dlemoal@kernel.org>
References: <20250603060658.171254-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250603060658.171254-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.16-rc1
X-PR-Tracked-Commit-Id: a374cfbf609017f77a985357656be07a2da22c5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efe19d34f6361c6fc90a2c249796af929db7d4a8
Message-Id: <174897277049.1603771.1510743713787631471.pr-tracker-bot@kernel.org>
Date: Tue, 03 Jun 2025 17:46:10 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  3 Jun 2025 15:06:58 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efe19d34f6361c6fc90a2c249796af929db7d4a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
