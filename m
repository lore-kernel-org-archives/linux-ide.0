Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C893CF5B
	for <linux-ide@vger.kernel.org>; Fri,  2 Feb 2024 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906626; cv=none; b=atopvcZABnFsRHAKRTlE0aaFt98T2orIEboyGNwdK5b9FCclUhxTWHbUG6QeywZlC9r3l5qFB9lRWcXj9ruuSAaYI2gEYIaGdHIL+afKJ0dqu5VE2CwiSaP882G+Sos7Ru/XWRunOn1Y30t8AjzBE/pDxAXVbIgXsNpavsG0a6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906626; c=relaxed/simple;
	bh=ohguyQyowtAwxjLnNeJ/VDgYi8jZeDtuUV4zK0o9E8s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FZdNkMx6HOTsXH5kh63m8e3Aj+voRrdpPilJIXRTgeRV4TJkbqUHeDEZSO9RdmqAFZOkLNsXghKfEq7Kc7bVa/m9YnKD4IZm0Nh9ipREQsd1TqqYqR9f0heh8ooP5T9fgDi53tT/8rTdbjXw+fqx3MtbAmeRHCAK+m+qZPk5YaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHyMmVwX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHyMmVwX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6ADF2C433F1;
	Fri,  2 Feb 2024 20:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706906626;
	bh=ohguyQyowtAwxjLnNeJ/VDgYi8jZeDtuUV4zK0o9E8s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HHyMmVwX1gxTq3fhxVlnOI7ZhXbFnTxF/8MS22X/0hEuTmr2CnKKwzZF1cts0+zPd
	 CqhgjigWZE9GNJpf4ihQZ9HdxNU6H98DGgxV63ZZEpDDFG+UgdcigR5FvUn+7dsBiK
	 2ibI/1in3GelL7JaLkcUPrgan4x/HeSOxWj8oB/1rE3lCNNASbsodIZy+JmVGiYAO3
	 2QJkqw3BhvYHvhrA3eCvNT+lAxYkBJoPHuyrV6qmHJRo3B9ZrhTuq5XVIjsro0Bx95
	 iT7AzodkBdq9HCuosLeuN0SvRx2LA6CVDjnNjML0xINLrvGIxHWmZofXdVi1pc8gMk
	 kbgh1i5mUkr+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D7D6C04E27;
	Fri,  2 Feb 2024 20:43:46 +0000 (UTC)
Subject: Re: [GIT PULL] ata fixes for 6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240202171146.1299344-1-cassel@kernel.org>
References: <20240202171146.1299344-1-cassel@kernel.org>
X-PR-Tracked-List-Id: <linux-ide.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240202171146.1299344-1-cassel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.8-rc3
X-PR-Tracked-Commit-Id: 51af8f255bdaca6d501afc0d085b808f67b44d91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 035032753bfcf0a1bb8875de79449ad996dd96eb
Message-Id: <170690662631.32059.4949605633050732937.pr-tracker-bot@kernel.org>
Date: Fri, 02 Feb 2024 20:43:46 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  2 Feb 2024 18:11:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/035032753bfcf0a1bb8875de79449ad996dd96eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
