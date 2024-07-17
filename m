Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416FB1CAA6
	for <linux-ide@vger.kernel.org>; Wed, 17 Jul 2024 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721248397; cv=none; b=YV9D4kGsbsdc4p3z60+RvON9Ira1slBdl3l0//Fj5kHomPshqns/AqNGzH6VpFeZnL/XUFqJM7jKq2vX5Vq7yLgul8Kq2ernE88npcFYK8RDjwntFvCEH3zzeAcr8afAunl+pctVwgSpenYJ9mzbx/J6dRoFj0SebQvtUMRn3D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721248397; c=relaxed/simple;
	bh=N09sRNUpE//voqhXYIG8ynGv81GqVKc2atSBkOUmk9k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HR9eeaGmf81s1pqDGjD7zVXKpu9UsYMcKE3dCYjcXA2vv054IxSZBsmUOp4c9I8Cz9/5147zmo44I2uzVb8YG/mBV527bMHdXhuB+wpE959tVY08BCCrJuRQI90eF6sz19avqFAL66gGOwEJrXnTIcYP09hj0r9m+Ax9Xub1wls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQ3ybpie; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQ3ybpie"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1551FC2BD10;
	Wed, 17 Jul 2024 20:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721248397;
	bh=N09sRNUpE//voqhXYIG8ynGv81GqVKc2atSBkOUmk9k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iQ3ybpietMm+Tv60yT0o6FrAJcOdUGI1/U5ybgLJ+7WYOe+mZ3aC9adgdJZBY9juu
	 b0aG2TL0Ju8MITXSxm4RJ7tkiw2cv7zBfHuCFfyCexKkTJdxltKlfZ2GR3lYmchmqo
	 SgiCiF7/0I53oVCfrQK7k2gSkQsiSTES1JdtL29lSElRZ6rSdV6BqayBsB/8qrT9Cp
	 KwN+2VL3/iZk99J7PVMBeW7UOwzXT0ZIupcmplQcv7zcgebm+ZJiDekvpd0GI6SbsR
	 +pH2du8Jc9/ZFyuT9K7TxbPNQIhtWp0doEE00rhnr6qJ4KBiXLjLKDbwJBIz5HSIY3
	 AjYIhbhfFcepA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03D5CC433E9;
	Wed, 17 Jul 2024 20:33:17 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240716123201.145960-1-cassel@kernel.org>
References: <20240716123201.145960-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240716123201.145960-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.11-rc1
X-PR-Tracked-Commit-Id: 6739fad42af2e5eb87417283278a13a57f69c0de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2f710f97f3544df08ebe608c8157536e0ffb494
Message-Id: <172124839700.22374.8655295063633828297.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 20:33:17 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 14:32:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2f710f97f3544df08ebe608c8157536e0ffb494

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
