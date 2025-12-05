Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC9284B26
	for <linux-ide@vger.kernel.org>; Fri,  5 Dec 2025 03:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764906640; cv=none; b=Wb34pm36Da8CRZYTjPVXRbo0FMTyee0Mgi/vRsyPVz3y7Kx0t+mpSwSqbMVZH5EnhmrgW4ePqF/Dg4VtJyadTL0Hh7SXpLLty6odafwAXZYGtE9SZCOYBPM+KosSfBhOfcEqXYlTjaDwFZ0cf97QaForo8DzIevg5HbxJKfYNFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764906640; c=relaxed/simple;
	bh=yVMlddv4HaqUxG/l9m4a/cNthFulBoel47D9AhLdjuY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lLLClChqsSFy4fu8+0tzvn8tTc7n52rpBnnwAwBrGiZJRQ18Kzq+WPfM17B7wxc3ChiXE1DY8/Z31HZPfHZasJ36L2xetf4AHkxGt7ZzvvFhTuPzEDnMykVAvsldRMDMvvrhyJvfE5jPVvKqOhkG+tEh3dxqT4/pgjZtqKIwWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl4pgF2d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl4pgF2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCA0C4CEF1;
	Fri,  5 Dec 2025 03:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764906640;
	bh=yVMlddv4HaqUxG/l9m4a/cNthFulBoel47D9AhLdjuY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Hl4pgF2d+Ax58UoEwavFR7Ia8DT9vcCfSGu7DBPWdbfzxrkKf3ya0Q15HC/sxAxTK
	 z1Y8bIrEtb7W5TfO5h/OIdHDC9Z72eAtmQ7OT9l5NgBK3z3/2VdCu5vcE3PpB1zURi
	 OsqNYg8ncw00dTR8BHl757/K0eez0Bdog8pR984hHjXyN48A5JQSFRj+w5gkuf9eEg
	 41CfAeV1EDODvgHkX4epcIBPfr5if5tJkb0qDqY/380z5+wEETL4Z7rM4G9hEvte3k
	 4CR2O2Il0rGxx30vOqg4R8vumeHBBUamUCMescmGphlU2kioWf38EWGhNutIa5mbW+
	 UGxiTLFJ/7NaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D5A43AA9A89;
	Fri,  5 Dec 2025 03:47:39 +0000 (UTC)
Subject: Re: [GIT PULL] ata changes for 6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251202101403.362869-1-cassel@kernel.org>
References: <20251202101403.362869-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251202101403.362869-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.19-rc1
X-PR-Tracked-Commit-Id: 6ce0dd9f54ea9773c0aedfaab7b858fc68a848ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16460bf96c31377c14d9f11a6da8c6f508e3443e
Message-Id: <176490645793.1091160.264317947381138373.pr-tracker-bot@kernel.org>
Date: Fri, 05 Dec 2025 03:47:37 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  2 Dec 2025 11:14:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16460bf96c31377c14d9f11a6da8c6f508e3443e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
