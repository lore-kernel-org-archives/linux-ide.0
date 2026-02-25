Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA5D31196C
	for <linux-ide@vger.kernel.org>; Wed, 25 Feb 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045476; cv=none; b=fDW9soenEFDqseXypUSjK5M1hpVKqoi9aqPV6DXBWAJHq44rNXPoUfYgsVxamyEuADdaFb+7NLAxGDN3rQiu7G8TYNMAD2ALCSgHL93u4SysyfsstGzVAI34eeYU5MwTm4eSsHwII3xdA0KH1Pm1KlhKCGnam4KpdA4LsJXSt7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045476; c=relaxed/simple;
	bh=iC9R+XaSqnX3G0/QdOnZn6SKh6fj6IECa90Qwrj0d/0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DZxiTnm7G9uonRGFYsrAPmY8PBsQ7eeZOh8tcmjjUp0SJwA1+jKtaEE0/wcoP7Z475Z/aSZYqDQno9opRVaCqhttzG4alxj2Pm0kusJMlz22ljiMm1g+o6HS29qjLyqiJLea1EhDucVZl+EzQEYvdwdyj02NirHKm6jAGnNDoeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U38LHtVX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U38LHtVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C20C116D0;
	Wed, 25 Feb 2026 18:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772045476;
	bh=iC9R+XaSqnX3G0/QdOnZn6SKh6fj6IECa90Qwrj0d/0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U38LHtVXadGf8gx3U6XCKKc301UVKZWTtwcWN4I9J/C0ApgF3Ko3OXZJqJSC+ejJ5
	 7SZfJJUFJnjYyANTz3xlurssprYmJp/DwMKT2vmvoI/vCcrDndNmOp9g26Nda6dU6s
	 1hm9s3yBw9gRRTjRW8se/G+Y8zhKjIhmZgm5ioNZudtsA/QFnCcQmDEUHiAgdujCnY
	 Zaxrfyz5eWKhBEymoMB1l6C1gkd9pRL31uenAQ4b8KNPo7oPM8Ne+HU7jPKToS0y+i
	 4EArWs8iuRVEZKcRkjZfBdhS6g7bmzQMDla67BSwcKCLTJgzWBuz90d0Ytvq4Xu1ul
	 T7gTSquztNwLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 400923809A90;
	Wed, 25 Feb 2026 18:51:22 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 7.0-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260225141956.3947017-1-cassel@kernel.org>
References: <20260225141956.3947017-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260225141956.3947017-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.0-rc2
X-PR-Tracked-Commit-Id: 55db009926634b20955bd8abbee921adbc8d2cb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9d32e5bd5a4e57675f2b70ddf73c3dc5cf44fc2
Message-Id: <177204548083.869939.9055625184506234618.pr-tracker-bot@kernel.org>
Date: Wed, 25 Feb 2026 18:51:20 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 25 Feb 2026 15:19:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9d32e5bd5a4e57675f2b70ddf73c3dc5cf44fc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
