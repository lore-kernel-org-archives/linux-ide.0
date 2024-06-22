Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D42CB660
	for <linux-ide@vger.kernel.org>; Sat, 22 Jun 2024 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719069668; cv=none; b=kIk4HLZrPcmzuzHpTn9I2m3CB/5xFzuUvUOBeqv4Kt2mbEjx++4DggPhUZtBqbOxUOMuq0NNhrn274Pe41lNqqZTs3Y+5i+8to6iYHoHhpTZzftqwYrJ4XFkZXp7byjp9SoBwgPJaA+5HTdwfMj6Y0GKe4FjdJFdNBzEgJap6RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719069668; c=relaxed/simple;
	bh=KfhybojJQbCC5LjhLZ+UMtPvGMwP6V3r7EMnHD5QFqQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t/pJSrvF8uPa49HwfdcaGSt5MIxlHAFP0CKHZLdYLuucFjVV2zRLjdyjOF15MhSTKtuo/VYWI7wf+cP8nFrEXevCvKLaL6zjyjN/BbzsQbDuvIrXHHmyljSZmSDKQEUvfZwjby3b1rJTLuoZP7rq1O6aVIG3MGjK7t3TGRajEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHP06Ej5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHP06Ej5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20C44C3277B;
	Sat, 22 Jun 2024 15:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719069668;
	bh=KfhybojJQbCC5LjhLZ+UMtPvGMwP6V3r7EMnHD5QFqQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IHP06Ej5eXLHcL0wUGu0U8akg8Mkcu71jl0PTECSJzIsfNDgo1rBgIN4Tac5o6SJd
	 IbPF/A+SpZlwWolfXpNYTcUNpio/1pVzwQIaf6RwgwKQqZvigvs7DV9ncHqTMNsYm9
	 otwCt/UqbZ5jcEJAbtyG9AY4ZZocKh/eZR2EZHrRB72Indnpjar4iIk0dNbob95E4m
	 U+W5H4LT8NgOWMjAOrZrouGSNC5hWbYHURZcx3c+o3uY8CeRQZk1hp2DwBHAnGWqps
	 Uzb/dZGox1x+uJl49COldNbPFgiAP6FMYTyZg1zT1xdAcqhmZjOwLXfYDaMVumS5ai
	 9RLBlK/C25k7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10CD6C43619;
	Sat, 22 Jun 2024 15:21:08 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.10-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240622145915.2929583-1-cassel@kernel.org>
References: <20240622145915.2929583-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240622145915.2929583-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc5
X-PR-Tracked-Commit-Id: fa997b0576c9df635ee363406f5e014dba0f9264
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da3b6ef17658160ad59cbc56c3c1f8f9a38337bd
Message-Id: <171906966805.9703.14225765970961917048.pr-tracker-bot@kernel.org>
Date: Sat, 22 Jun 2024 15:21:08 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Jun 2024 16:59:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da3b6ef17658160ad59cbc56c3c1f8f9a38337bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
