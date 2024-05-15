Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EDB38382
	for <linux-ide@vger.kernel.org>; Wed, 15 May 2024 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715737756; cv=none; b=Kjl03sfDoh17AutyTyq65CWrTa5QJ4v7X7/Ilu1v7+MpnDuWKci59pqpRTX9E7IQ6nJlUYF17G/6scaPKrKakwPMjutQ94uVZNiikhi2XqbdfoSbLmXAA7gCTHjecbzL75ZqktpSmqkcnOei1dJE+xXHDmn6dVMcS/HD7QAB1uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715737756; c=relaxed/simple;
	bh=PsKOCv9iDT5uZzwZKbKGdx37MS5VBjk5Rm315NCnzpM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FSzcf3FJnPnPBiQFbJdo3byeUDRTgYk9q1NXzBu+Aap8M6T7+f4aZ577m3vyBbtFDzvEVm+qDLJemBWivSdef+919MsWYxyy5srVhbk1GDCc1QX1j5itye0flKSS773UbWiKrESFiPgNybsID/2nBgpn4t9jmIC2ZxTZAXYC008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPHlPHlp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPHlPHlp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BE42C32781;
	Wed, 15 May 2024 01:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715737756;
	bh=PsKOCv9iDT5uZzwZKbKGdx37MS5VBjk5Rm315NCnzpM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gPHlPHlpieS9Rd91eOfjtr+C9rHLr9GS0XVrQ5yxv4IRzDpc3JrwQcMBtbnM12I5T
	 VjQ8jqiwHRJc4c5o3RjRE7q7PU/s5AnTUSmD+UnfCLdkE7gS+N7FI6Oy2qtAJY2TVv
	 BOhwCpi9kL3bHBfXq3Bn3ng4GkZgMqtim4SPcavWwuKS4Zp44LF8zRnJu5L/it9L8X
	 XIcDCw8kXyw9hqX5KnHCSyV4pztzmjP85Xw/ut5HnxIJm/eJ7cyplSa2aSTYA/H9ae
	 owifNdbumF/xtXxwwV3Lf8JcaLxLqww2HlY+Y4zMUpG2FmGbu2vEfP20ROF3lYRGko
	 uz3TYAAPa/omA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF408C43339;
	Wed, 15 May 2024 01:49:15 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240513132512.159143-1-dlemoal@kernel.org>
References: <20240513132512.159143-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240513132512.159143-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc1
X-PR-Tracked-Commit-Id: d4a89339f17c87c4990070e9116462d16e75894f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2665fe61d8a51ef70b27e1a830635a72dcc6ad8
Message-Id: <171573775597.23667.3207652485745768188.pr-tracker-bot@kernel.org>
Date: Wed, 15 May 2024 01:49:15 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 22:25:11 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2665fe61d8a51ef70b27e1a830635a72dcc6ad8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
