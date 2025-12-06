Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9780136358
	for <linux-ide@vger.kernel.org>; Sat,  6 Dec 2025 05:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765000001; cv=none; b=RVE+317XXKRN85Naf/Vi73EMIQnCd1YzB4LcjGmNjSM797YsolQNgDe2vroiw03pSoGVdtTBTyff9pze4xrO+7J+rJHnA4iBwEoFvEk+bHN7eq2n3llSh5x3laRIE+/v11WzVYgTDgEJvhNgUsmCXaOessX51la8P5KQv9/GaaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765000001; c=relaxed/simple;
	bh=wutfK7Jwc8wHfcyTZh2LVSzqKRsVyxUGhBvkG2W4Gu8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Na16zfbvnX9wkbthD6s+N0U12zJlmYkD9aAEgdwFogBaQOiPJjPjXy0/VhSrxz1i0sjbvSRyBtlstlnfn25JkxkPcfUcjGjYoCqA+QqbzFMF27DNbh+LofuUdudk13rgeyyHQN/WVAuZdlaqsmo2zpBoyk6wwASx5vhrC3qKoTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt/xQAL9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt/xQAL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CDBC4CEF5;
	Sat,  6 Dec 2025 05:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765000001;
	bh=wutfK7Jwc8wHfcyTZh2LVSzqKRsVyxUGhBvkG2W4Gu8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Vt/xQAL9huf+TdMf/GRYowI5yC4Lq5SdzWlUQBM2iERIfwUNz+bh1BYOZM9itWNJU
	 QWaDgCRU/SDviVnfnDO2EtljOu9PVXBTL4+Mpf7Gw2AHH5oUvasmXuNsiJjZL/EQ5T
	 OZqWs4GjMv7H/7qYZdqXUtA6FNrqDYRmLtF4EDASgSFPZvbA0NMF5SXHmmVBrvS/Aw
	 wuTnvLuL3yJ5J2/6TaFz2O28moDVW7Ac0bhI1iEtTohFdo3aVOK3BISYqlsWqsapGl
	 bql0z6MoA0f/HpMAV3DnMmrcFtI9SScsSp9NheoJf1sxJ1W9BzTJeuT2FosHqhtG2r
	 eX7Lc5mhSFyTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B73313808200;
	Sat,  6 Dec 2025 05:43:39 +0000 (UTC)
Subject: Re: [GIT PULL] ata fix for 6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251205094339.1032996-1-cassel@kernel.org>
References: <20251205094339.1032996-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251205094339.1032996-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.19-rc1-part2
X-PR-Tracked-Commit-Id: 2e983271363108b3813b38754eb96d9b1cb252bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 096571bb893b3777ae1d752b7e1d5679bcf4edfc
Message-Id: <176499981832.1994707.17387183446557708705.pr-tracker-bot@kernel.org>
Date: Sat, 06 Dec 2025 05:43:38 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  5 Dec 2025 10:43:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.19-rc1-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/096571bb893b3777ae1d752b7e1d5679bcf4edfc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
