Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9382170CC8
	for <linux-ide@vger.kernel.org>; Sun, 16 Jun 2024 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718562274; cv=none; b=kkYGxjxgT1Yx1Vujxevd4qXJWvVBTsCrnmgN6HNCD1bwPNO436xAaTUL+OylweTirJRCR82beWBYB9NFgyqZ+IqHuFH3di2YkMmnzmKuiMx7KlRUtxLSf72BIjL4XEbw+OZ8bVndhGJou5P1zFBpyVsjG6LEINFv8n4IGDDt1aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718562274; c=relaxed/simple;
	bh=oL9rkyLNYo7MK4F26izQSACReKt7btfXqIuFMXWEonU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E4eK3u68E7iUTgxkkl8C5WFvLvpqdoHRp2H/f7KEwTcP8Ec+YDoLAD/jz79+gZmuweNkpSzZ0bkrxmj4BaR1+KhbvIoEyxResPvc7ZNiYKe/9ncArO7KXua+muVTdL3utFLicYl9yEdnhsO+jvvbBEOGCFzEh1yW6VFgNvWQnUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzS0y3xf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzS0y3xf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77B0AC4AF49;
	Sun, 16 Jun 2024 18:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718562274;
	bh=oL9rkyLNYo7MK4F26izQSACReKt7btfXqIuFMXWEonU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pzS0y3xfmHHYsDWmr0p96n/r54yWofej7/ORt3q5TQlFTtlloEQnADvREBjEQaOvt
	 0DmmNZthVCRWm4qHihGtk21k1AtUAqNaZOntqiEJ7IQ9nDkJGI6xVUgAJrc5pMn4eR
	 g1cyyauCZtO5WV633XZ/N/W/x8kmlWnNM31GWcuOniADSSquArzBIqOIMcJHDYcOom
	 Cp23NZ3OW/9kkyTcNbl288YXczde5gUTFO075JJkmT8uIX4uXynT5AWn68xMqkchQ+
	 +YCKV9jU7fbsWjsSzPMx8OaW0oeDoBiXhu4rO0/ICmuEzsVXYyABmPWA76lQARWrpk
	 kMzlzvm4u+wxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69E09C43612;
	Sun, 16 Jun 2024 18:24:34 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240616092659.1798613-1-cassel@kernel.org>
References: <20240616092659.1798613-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240616092659.1798613-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc4
X-PR-Tracked-Commit-Id: a6a75edc8669a4f030546c7390808ef0cc034742
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8b0264d6fdf98cd90cfedfdf60c8ad665f056fe
Message-Id: <171856227442.1143.13572753599648338171.pr-tracker-bot@kernel.org>
Date: Sun, 16 Jun 2024 18:24:34 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Jun 2024 11:26:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8b0264d6fdf98cd90cfedfdf60c8ad665f056fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
