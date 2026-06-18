Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF18E31E827
	for <linux-ide@vger.kernel.org>; Thu, 18 Jun 2026 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796194; cv=none; b=XiGGzq7GMgShrWDuBae9o3cOEKVjbMq/olFYDdsKEP3E8jT2bQrqfO9opSAfEgPXJJaVCU+2hT303nTBvkm3zLsc0YTgg80OSSVhP6woYG7UZr7uKWL3JUTe9C5XLV62HCI1aJwVzuQzf22q8dSJyMHAXgdoMci4OBVJJ6reA+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796194; c=relaxed/simple;
	bh=Z0+X6eNEvlbSaLa4isBimtrDECbWzG67DN0TgUIeZLU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SRNcsKbKTcq+zD/Lkb8AoWD8ZiingSqzhdh/MXp2iGRWj1LURRgZdUUo2/yHB9bfSKCEFIBk1Q7tQS6ixRF37THdj6EP2TYitxYcmaZT2EjjZQgl9e1K/Y79eXAhTj4XYGIETBAibHRLJRas6LqO84sS6jT68wqZR7ziU8TCWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzMdDQmh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzMdDQmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A581F000E9;
	Thu, 18 Jun 2026 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781796193;
	bh=z+wJseJ3itV7vIIIL6lQaRaW3v3XyAaA9EgElw6NyA8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=KzMdDQmhOQIxZnonTcRs2Ahgobc3ghvb77IPiROyzg/UfyYpTXzZ3o11sBW+H2JSz
	 EQozf7T+HEchaoB0UiOw13Cr+m2k3qL0IlhvXAwUdLF+H2Z7HIjHZLfGe4CQWfRrFt
	 dbFTMm6pc3jv0hn4+hUv4W38WQ+1fAhJ6MiDowYbwkELKqU6++wPBfX1y+o+R4jHdH
	 RHel3RHDEanhovEBTj/y/g3rFQKDPpWZclNM0JzQAVP7jTOul1xyCLn8BvXPaMjlbF
	 F2liDQpGVXsQptHEuzSR6tio4z5Yg/R54HGKWuoImBAHHFI0Im4nLieirjjfIyEL4J
	 VC0Yin4iF9Aug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1999E3A566DE;
	Thu, 18 Jun 2026 15:23:08 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260616143223.1829869-1-cassel@kernel.org>
References: <20260616143223.1829869-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260616143223.1829869-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc1
X-PR-Tracked-Commit-Id: 21e7b9710a24bd7688c02f136923c89bee2fda5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00d07402df810b4dce0ae6828f4a292c20bab916
Message-Id: <178179618666.2947725.8657249240678838828.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jun 2026 15:23:06 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jun 2026 16:32:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00d07402df810b4dce0ae6828f4a292c20bab916

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
