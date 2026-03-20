Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCCC3D1CDB
	for <linux-ide@vger.kernel.org>; Fri, 20 Mar 2026 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026849; cv=none; b=MY3KeSQwisReasDbdKSmhco1nvNXrDUWCnmRUPbbAtb/XLl+2JVu/qWTfuX0ryKMiNlWgFNeOXFgTST74J6MGkS+IZ+hrAVec95SRHJ5dBYlI3jiiQ/0grvH5A+5cxj1u6SSU0LVrDXZ1stJdWrIcXi6DwaLy7/Rlxz7Tl4H8is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026849; c=relaxed/simple;
	bh=vA6vWIjQovpieRMfb/Dp23ar16K6eJgrfPnzhEMWdhQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mV3QC7rt/6J7Sq5VV/x9S1j3/o1z1lXnSQuR5VkI2nXfrab2Wr2gKLJnwf77yu8Pa6gjsaZ8bvQLMQWSLrYPMkmZrf3yDcT1HbZSVJNOYzImuCtl7c6Y7zq5ABixeU1rGtUhXCObbUeBJefBXMgDPoxD247NRYVN/I+I/57JZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrquTqxa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrquTqxa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82548C4CEF7;
	Fri, 20 Mar 2026 17:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774026849;
	bh=vA6vWIjQovpieRMfb/Dp23ar16K6eJgrfPnzhEMWdhQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WrquTqxaEI1AqPXU1QjFltClYGyNNZ6AU/5qzd+4fjR7LcaOHG2h2ePmoKE2ox1uh
	 /gEGiSlsBJmPuOx3ty9IqF7jjKZHx1yzZd1SnONET4O2C2d3ZjErz4ADwrN/N9TYLk
	 kw+UaYvFyjAwyLqlkbt6u4RKRBFQN8z3SIz5ucn2f55xVfJXbVjbkvAaBVYvMC6RYw
	 8CCKOaLVMURoNuRfA8HvfpbpzVtMdTxEf1FQHS99Qns9OBIThmDeeYpQmZdLUcuoL6
	 iF243NT1cJQP++RWEBSjvMS1smsCNOt4shkz2Z2obYhcmO8iJePgKCNwtDdkys3rnQ
	 XlDxXdXuXopLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DB1380820D;
	Fri, 20 Mar 2026 17:14:01 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 7.0-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260320095538.133163-1-cassel@kernel.org>
References: <20260320095538.133163-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260320095538.133163-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.0-rc5
X-PR-Tracked-Commit-Id: e6d7eba23b666d85cacee0643be280d6ce1ebffc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f374ff79f4bc4615cb5e13f77f349cb7a45c1c54
Message-Id: <177402683949.2580860.6660778009245200945.pr-tracker-bot@kernel.org>
Date: Fri, 20 Mar 2026 17:13:59 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Mar 2026 10:55:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f374ff79f4bc4615cb5e13f77f349cb7a45c1c54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
