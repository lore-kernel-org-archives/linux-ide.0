Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B45628F1
	for <linux-ide@vger.kernel.org>; Sat, 14 Dec 2024 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734195968; cv=none; b=ptfYC0MJDK0m97zG1mm3yKelkZh87YB6goUrSRw/wGi2nlxMLSVr10FVgpSMzwiszbnU+S0CHPpOHOF7TAtAp3r8uFfP8cy7YbP58G09xIC3aHOo/RKWvOHm9J2EWxFBxWzPTMey5G+sIbbJanqw3M6YDaDi9nKaeYTmBa+OODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734195968; c=relaxed/simple;
	bh=h8fAqpYEZBzbx+A9Q1v68iXYg12CjOR7ctpGh9KTP7s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eX6it6KMs3jd8BcGrjLgQKosedTLGyOGXb1+JDtQvcMkrYP6foFnqitTiA5vQcWYK8p9JkkRPlF0kxR4EN1d77tF+K/YoS9rkMQ4l0JvbppM06uZIe5PnH1Wsi+BA+F95SmB9TMDFi3dcScUDSrcGphIYP7HBiurlJU8e44Rbtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPuENtm7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPuENtm7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ABFC4CED1;
	Sat, 14 Dec 2024 17:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734195965;
	bh=h8fAqpYEZBzbx+A9Q1v68iXYg12CjOR7ctpGh9KTP7s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MPuENtm7ZPyMGMaFq/udO2dNvwIPciQL74O+CcDTpkIOUU6TNTLEuMuocfMEZBFwL
	 9l3/Y7ixjkf6mTDApIfPODVdN4sawigZpNbjNWHCy7Rhyc76Qz1ocrOS2SKfiv+4A7
	 l8jkqP0qFaFH+7Qbl0yRgexOU8s8UB3DoHVWdKnR81EVf7oihRONJ+YEpLQou2YqFP
	 vzF1Q4hLemDqdde50zJN9RUylXd4XZUJAvqsUt4jR2QU1pDsnDYnOS20o0Ob/VBAE1
	 imijN5QcdWKxAjmqKKKak6MvizcBmtWDsDn2b3jsuHiijRyMjF8PMM8uLXFxEUorpF
	 y5vxKrTeRwY0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF10380A959;
	Sat, 14 Dec 2024 17:06:23 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241214053748.162468-1-dlemoal@kernel.org>
References: <20241214053748.162468-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241214053748.162468-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.13-rc3
X-PR-Tracked-Commit-Id: 676fe1f6f74db988191dab5df3bf256908177072
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d97859e17750073052a45d127cdaec446843838
Message-Id: <173419598240.3359607.11723047048406420162.pr-tracker-bot@kernel.org>
Date: Sat, 14 Dec 2024 17:06:22 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Dec 2024 14:37:48 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d97859e17750073052a45d127cdaec446843838

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
