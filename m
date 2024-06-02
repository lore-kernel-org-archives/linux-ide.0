Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B55A21
	for <linux-ide@vger.kernel.org>; Sun,  2 Jun 2024 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717368745; cv=none; b=HrNTjVuh/+zZZeOm/ujqtUroPGlx0TiY8sILr6iobee8GA95oF4iPDXhoizmWpAy1R0uxdIzeDtRSpnIh2Uk9u7f6smkQNkFqBgemX9X7HG1Dqebyx6D7sW+rJ3tTHa55z7xl/bmzcWU7INkbgXSCLUeeVXdwhLdAe61vIUV/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717368745; c=relaxed/simple;
	bh=Rgj/eN1avGIL0yONxmhNJxQP7vEHJx8XIU/d3JwwN5Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ikm/5eaVNC037T1t4+TMR3VkzEGSFM2S6jKESMzfurDb5nF3CZqO0ezJC1wB4YlD0VSqxCrlsJW1o8De0SHX8oXqenRq6/3fKMuMdxU4aqTEINUAv6p871KX4qS9GVXtKXHuCar9sPzh20USVMNbFhZOH3hhWJjpgeFK4q49kBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYJiDZHN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYJiDZHN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99F0EC2BBFC;
	Sun,  2 Jun 2024 22:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717368743;
	bh=Rgj/eN1avGIL0yONxmhNJxQP7vEHJx8XIU/d3JwwN5Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TYJiDZHN0EDWz+rkUXRfSYIRzyFXbYodepXa2rU2zZfr7I1XL1lwMVCo4oyBsybZ8
	 SYWw54W319LegsaCSSMMK2hIGDYwKjX0psWb/NWsWeqOUmh6DOpCZ0IZP5P7kRQm6B
	 fALjO2sv4qyBflKd6+d37hsaIEPDNpsl0l90Dn7tDhF7KdDe0b+zlI9q0g+cek7IWE
	 ZwSQI2tc5jQK6AJe65WI7G0pYdudgu0vVh73mWp6+MkBZUZI1qfAEepN5wO3IQVXlB
	 8++APEPmyO9NZesacxqffLfCS47PRG45t9iP/n0eNDoze2C5C3NoQtImArMqZeu9EG
	 KAChG0XiQ+6cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B373C4361B;
	Sun,  2 Jun 2024 22:52:23 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.10-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240602173829.886553-1-cassel@kernel.org>
References: <20240602173829.886553-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240602173829.886553-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc2
X-PR-Tracked-Commit-Id: 3cb648c4dd3e8dde800fb3659250ed11f2d9efa5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58d89ee81a0b264db6249a374b1264a475aef4ca
Message-Id: <171736874346.1822.4675445132379388653.pr-tracker-bot@kernel.org>
Date: Sun, 02 Jun 2024 22:52:23 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  2 Jun 2024 19:38:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58d89ee81a0b264db6249a374b1264a475aef4ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
