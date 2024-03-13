Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF5660DFB
	for <linux-ide@vger.kernel.org>; Wed, 13 Mar 2024 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349469; cv=none; b=KgrWuAD7mSfhZgKl93j3JTr0nbmPnpwarkiQId7yR64A/FFy6OJwICtn9HhEtlkGYOfNAOpI78yZdXbPnGXGZfkrqlngt19523E8mHLgdLz/rXN/jClbchyTdAqcGsuvqjCbFciQ2Dm8yjZl3noxvGQXbRUjRHked0SbMo4aJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349469; c=relaxed/simple;
	bh=kf3bo3/CHCagHnC+CoBJT/qIt1zEiNSE2yq9fQkZiGY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KAoIAv5AV9wZl5saj5Aon+UbBy19KZxuF3B42mYVDTfr6aYnrP3NwIA/f2J4imTlJg1kBooXHZI64tc7fP6i7fx5H4fP+ZhPmAPkTDmvOIfyzX4KXr0ODudy0AEETSrdk+M9np2EEBoYl90Nj1ppotjUPfQyCM2u98y2OEX+Zy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQWpHg59; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQWpHg59"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21928C433F1;
	Wed, 13 Mar 2024 17:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349469;
	bh=kf3bo3/CHCagHnC+CoBJT/qIt1zEiNSE2yq9fQkZiGY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sQWpHg59w5TKH/8riBBNR/uNtXL1R+bEYjNIqyDQ/+8QqcueAxx9nBz1KaBHJefIN
	 KLZdcKFtUVzfwkcJuVKCL0RrGih4Xk3HNeizPtkY2QOMzBhm57qSXTnziilZqTjpa4
	 rD5nkyw1suSu0rwgkg/JgcpgoFNsxwdKhPMaohIusG8wNcSl/8II9wMtfQibDUekVN
	 LFZxvlr5hF3UPDh/qZybahu68L2BDSdP9G3yj5D/wCaFIkOxXUGt/+aFGJO0dNsxCP
	 eVztF1GLtgWUWFMXGgJOFoxdi6P3Htn6tHzsar9GJMhFNVVNHMafOVTfZje5tghlHh
	 WPPe1d7HZb/0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0632AD95054;
	Wed, 13 Mar 2024 17:04:29 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311121929.3420655-1-cassel@kernel.org>
References: <20240311121929.3420655-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311121929.3420655-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.9-rc1
X-PR-Tracked-Commit-Id: 13ec4098d8032b0e8d2b2548803002df80d7f9c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57aaf9134c033dc5caaaf70facac529bb9d3d20b
Message-Id: <171034946902.7471.9638546631583727814.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 17:04:29 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 13:19:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57aaf9134c033dc5caaaf70facac529bb9d3d20b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
