Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795209268;
	b=Of4557WgEyW9O+DJz/Uw3vnqfba45sE/y0oMvyS+U8QJgeZWAlN/RUJ/MlAc8FD3aw+n
	 A5HztWK865OiQ1Na/q6UlD4PpYTv9bxcdI/zIIyrNA09PiC+gLVXbQFkLVV9+JYjFz76M
	 2HeMH9k8QRrYZsy3MfBUsr3Kfi2OrVv2TIuj/JNJhKUHP4xmGLFyAZA/svvW9/CiLNCqA
	 YnPUKPimBOw1FC53lhioVGOxxqbx9/9QNhinIkGzPb+SSImpzpBWM50Nekq6yVqT8odos
	 2n2qgpRdQllgAonIOjB9D6x1QQEP/KMX9lDeM55R7Tiyrz9WevTNRVtyMW0WkAgMjjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209268;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=qCOMmmFh4bNJ3mEoXY6MdHjJH/ah4HvucJCelp5SvT0=;
	b=wUDSktZFELT6dcacZgzSZ32ba0f3TYYidFAB+LVwiPOat7L+cn4iFS62Sn2MpIit4bkP
	 NZcacQz/9rcmOJjmEGpiwpgQiR32CylGQjh/w+XpN+AC1AyhCPHVx4TC6MfQ9hT7EO4Ec
	 AqanBDz99vfqMqNnkZ7gZFlt3rO/1n4OvspcjIZ6Q7JPBe0AAHXD9CyI+ICnI7PR2SE4K
	 vMF2ev1Csse8qwsl4Rp5YY2rY8mrATCG6SK8R8ngHIlhkAvFPvqtFtoHFoScxYSWrdsFL
	 wH4PXDwDcARs7zGPSeXj+sPkMoqhWwuhGgffJMEf27WLhI+T3iPeeB3FoUoQ7VxOLpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fd2mNnkP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053D606A696
	for <linux-ide@vger.kernel.org>; Fri, 20 Nov 2026 21:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fd2mNnkP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1861F000C6;
	Fri, 20 Nov 2026 21:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795209267;
	bh=qCOMmmFh4bNJ3mEoXY6MdHjJH/ah4HvucJCelp5SvT0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=fd2mNnkPLwfh37Q2uRlorxkNqatfFOM/wi4kxqsotKTrAJtsu3UwE5qCrTnKhZePw
	 VXR53Gk9aA1ihS+uiJXlxzL6qhb+kXoNYtTUWFttEQQYzj36C1Xvoc9Y4yifMwKxFH
	 r90hFNfX/e0n/v3pA9mm1KCiJgOaTobfIQJeyURV7/lWqnHiECEnN7OBuXcznhdM9P
	 GKWBO5xYNDOxXOD3v4FmQjjw7eHuyGkRKjt8FSupeUbcBO1Qr7h7CVwls7NZFTlJ0d
	 p/ltrZ49GsPRBoD6MlV88aU8Xt3TbH31Fesa6FiBHRD1Bpv+B7kGOB9xrSGvxPutwI
	 Vv6hkAGsSUj0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773DC380A964;
	Fri, 20 Nov 2026 21:14:27 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 7.4-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261120111454.276280-1-cassel@kernel.org>
References: <20261120111454.276280-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261120111454.276280-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.4-rc4
X-PR-Tracked-Commit-Id: a12cc63129380a5364e787d92b30a3257f66c250
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7032230365d8093c9a63020732f2bf20d4a628cc
Message-Id: <179520926597.792202.15321545484796833350.pr-tracker-bot@kernel.org>
Date: Fri, 20 Nov 2026 21:14:25 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 20 Nov 2026 12:14:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7032230365d8093c9a63020732f2bf20d4a628cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
