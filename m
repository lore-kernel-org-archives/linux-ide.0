Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7623BB25
	for <linux-ide@vger.kernel.org>; Tue, 19 Mar 2024 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876582; cv=none; b=q++Utns5nsRdHeOgGT+ope74GIlJe3dKZsWd8FAdRxRLz/uUg2Ynoo7XL+dBziLynsOjnP9KZM643PBE5C6EwGuwmeQaZ9UQLAr5aMfoV8filxwL0TdCEqHBzPbxHR9ZsBGTRqvbpd8pgofB7NyQpwWF99k0/R7lWcXhiqwey7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876582; c=relaxed/simple;
	bh=tvpo4+inSI4nqUbRitSu0lGRjn3jZMQDu8KbxBLioOY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TM544hMeyObH6cFyYgMjfxK69IMSZFEbrEBpSdvUXoqW9/roMHRnouHcaV9ax4PlE3x528qGUeqfv/jAj5bcAafp4Wo0jPE9fVnmAKyxBk6M82fYRw+DmCcqkP9v/zE0ikUDpZ8Xfts94L8GbK1qo98wXN1uR9dcES6U0aIATLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuMp2RqH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuMp2RqH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0ADA6C43394;
	Tue, 19 Mar 2024 19:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710876581;
	bh=tvpo4+inSI4nqUbRitSu0lGRjn3jZMQDu8KbxBLioOY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BuMp2RqHpGNpzcE9/1oarbMuQ5Qz96FGphj26qGQbQvhm7omVHanwwPXgfBXe7w6Q
	 HLXRUEi4lbeb1aRbYOT/UrwebRb7QBoewBnsYRAj/MLfFccFJ05V5NacKsnz6pPIyT
	 9NjhZz7QbK/xMAMjbEleTZWnzOxErEAv4eW73JBal0PL5nUeD9HiplacYFuIZuZwTc
	 CETUqDLDLcazgPwgrVSe5kByHYbfLTVT+JXv1I2iV+8Nu14CIm4gGjKmuf7nj85W1b
	 O92ohme4TKxU1NOc3XqDs6+iH6xzZyg6lgCpaov8ruPIUAt5A3HO3W19GiAbD87R6Y
	 wiBb1T5CguqEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8C94D84BB3;
	Tue, 19 Mar 2024 19:29:40 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240319113758.197709-1-cassel@kernel.org>
References: <20240319113758.197709-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240319113758.197709-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.9-rc1-2
X-PR-Tracked-Commit-Id: 6cd8adc3e18960f6e59d797285ed34ef473cc896
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f3c2b39768d2c0ccf0f6712a4b27453674e5de7
Message-Id: <171087658094.21820.15365015832308818327.pr-tracker-bot@kernel.org>
Date: Tue, 19 Mar 2024 19:29:40 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Mar 2024 12:37:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.9-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f3c2b39768d2c0ccf0f6712a4b27453674e5de7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
