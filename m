Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98E633985
	for <linux-ide@vger.kernel.org>; Wed, 19 Mar 2025 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742415740; cv=none; b=BDe4pee/6PUrPjtjgitmlKfPzvSOFtMZDLijejkuCWjeV3NR+hlr6KMQjIAZktg4XnQhJ42v/R7A05fEXbM0lxvtfHRhzcqoqFz2uYJ3h/1AQ8BCTZOn4RycTSR4o9koCx7uEjVIg5F5OKDpgeBNOQBRXLHSCVr48GZMIO29KdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742415740; c=relaxed/simple;
	bh=XJdstNocPpWqsAcKy3MvAU1tO2sJVTuKyoL8DNp4EmU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W+Wc+s0RbII6MeIUkO8bg1rxFsICKyz4rUSKd/5VNQgatkseWax6lMYC+WlS7C29vStoAHv4XQbNUkXjMowxbRIspOshdmS3lxXYsmYrINbOKK6Zn3Dr8PQpoY+DuNVMTHj9YLTMghHKhf3l5j63aG9S9wE8Imqzgq38uM7qz48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJLCygtL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJLCygtL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FCAC4CEE4;
	Wed, 19 Mar 2025 20:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742415739;
	bh=XJdstNocPpWqsAcKy3MvAU1tO2sJVTuKyoL8DNp4EmU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KJLCygtL9TsApaN/3XSNzrP/8x5bw1cgq4A9oStKsv6AaaW5y45BnUi7ILCDScMle
	 clNkiLqLXnfpch9pN2RmV+XDhn1v4tbsjfda26Qp7NupmLvIZUFFPsUs88h4EecKT/
	 QdAgqilakqOEHqt6pp5dgsOQziaEnBH9h0lbZv44skyKgVxLQBi9yINzXqLJOFHFJw
	 9ROCzi2uEXoNJNSn8L77scQeHZ1k5s27iOh1axqVxtopegwvKGT2f0Ymcg0kw/5vEI
	 0k7kVIgfH9ZA4LrR1u+BZ390TxS/sszc1uUHLbY9sbFeQMfRlKBPwONtfyoywPoPHD
	 moWaRH/J8ejiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0793806654;
	Wed, 19 Mar 2025 20:22:56 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.14-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250319094950.2576556-1-cassel@kernel.org>
References: <20250319094950.2576556-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250319094950.2576556-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.14-final
X-PR-Tracked-Commit-Id: f2aac4c73c9945cce156fd58a9a2f31f2c8a90c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 281e239698357d60e1e2acd9eef1308c2ae2d73f
Message-Id: <174241577522.1182345.7749511367966354928.pr-tracker-bot@kernel.org>
Date: Wed, 19 Mar 2025 20:22:55 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 19 Mar 2025 10:49:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.14-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/281e239698357d60e1e2acd9eef1308c2ae2d73f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
