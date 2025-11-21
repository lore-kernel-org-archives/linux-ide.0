Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5189F2BEFFF
	for <linux-ide@vger.kernel.org>; Fri, 21 Nov 2025 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763752817; cv=none; b=WKsZcF3U2ECIt5nS8deqpNId4i22vcg5OjZDsOwk2KJvUD95vazuiG1e9m/iplVwzAExQzzcKPxwRu/sO7DRI9rneSKcb2h/4JQcpVEU4SkacG1dfNoP2e/WcbRnX9bL+AJIa7tgn8KbVF0eG62TFAVVgL5lVAuc4eMhcLiWdhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763752817; c=relaxed/simple;
	bh=CM9jW74lQBwtSbqikzLRI3bNIgmLBeV1ArZpPQYQ/Jw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LH39nwpVN9l1eCTjglQOSKd/fpQZR+SZFYD+BLA9IrxIdKeHJAzNtQep0JZGhY7d00qbBYK495qFQeH8aZqse6V1rTzV5yjEUP19lthLL3vDKktmPjC0/UwRhbsvDhnYLhN2JJucxi8xRsOEKaoFkXB2iyk90Zqvwb898tHeTVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQoWr7PU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQoWr7PU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B4DC4CEF1;
	Fri, 21 Nov 2025 19:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763752816;
	bh=CM9jW74lQBwtSbqikzLRI3bNIgmLBeV1ArZpPQYQ/Jw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LQoWr7PUHTY5pXFCBs4Is0RvAAb2oNR50q/ZM1Oedm4AFGcW6G65YhhEm9N9O19mv
	 RKEf9xTpxNhRd+eF39h3fystpjkzc9GbhHpsA5CnwN3vqzwWB0Dr8qX1Uhz6rqpQ+s
	 qbsvedxB0h05osJJ6uXdfrlimzOxZSw9WvL+Fyv1o7iTKZOiAgZKqbgLY1HBcMqaAP
	 zryahegJj5lMyjHEuTYkvzw23go+Fr1ZSbV9virb2CMawD9YAjWJ/BIfqVIZvJdzvB
	 /KC4OsnZq7D5yy4XqqvqOf/MiR+ryBIxCawMnXZQBZbfTjaCPQ0eLcucGRUCkEPR/1
	 mOoDWPpqUUrNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0163A78A5F;
	Fri, 21 Nov 2025 19:19:42 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.18-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251121151104.2645094-1-cassel@kernel.org>
References: <20251121151104.2645094-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251121151104.2645094-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.18-rc7
X-PR-Tracked-Commit-Id: 91842ed844a068a41a38f97a1ac5535b909279cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 317c4d8a2a320a58997f30a5b2a8eca57e0990fc
Message-Id: <176375278122.2554018.13828079635474020698.pr-tracker-bot@kernel.org>
Date: Fri, 21 Nov 2025 19:19:41 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Nov 2025 16:11:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.18-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/317c4d8a2a320a58997f30a5b2a8eca57e0990fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
