Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C61A1D4153
	for <linux-ide@vger.kernel.org>; Fri, 25 Oct 2024 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848057; cv=none; b=jW+F43ZGbSOrLNrkvfLtX0Ly/NRtOgVB674OddVQqmFJ0+kmXxpIzOwovu+layK0w/1BVci/IuZUZRc1mRiMxkI1FbfHjqqsKUDRgHXAunA8fSUKZJmxxIH+rUqSqrpkwpgEczJM4GI2PW0tyBHiDW+S6cwuN0sEiUI16HnT+a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848057; c=relaxed/simple;
	bh=TZgCPr2gP29czfGYKZl7tfjGmKgta4g3mWpxEEpNlVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mFvHk+LSSkylxuaFbgsNNNkzgWpNxCjwPMb7t8eyYQqZvQNRBB+WHGQLWCAiOpZA9TKXxx4CRRmwfCklDhyBimYyliRHqaIwnAMMcD3DiTbwNPEfuzWZZgrZ72ePBNzSngs8HprBiWQLe5AvexE9+KJWY0crB3/1e3LCXD3nzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPSOUNxb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPSOUNxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E3EC4CEC3;
	Fri, 25 Oct 2024 09:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729848056;
	bh=TZgCPr2gP29czfGYKZl7tfjGmKgta4g3mWpxEEpNlVY=;
	h=From:To:Cc:Subject:Date:From;
	b=lPSOUNxbw9qUJLVs9FZRaD3oHYh9tTe+Ki6kfJL2pE9cURFB18ruvyFXjrhWcT36Y
	 0n6nK01K74c7GcUPZMbcKNku1I+KWBiaoyE+nvyym8Y8aOE27FTi8gaJKoWW5mDuht
	 tujb9OSElQa0NM22wgKmt0n/e5E0t1R4mxwWUpXMk+iqQpPxO5BXo0KkIGY6Q538SA
	 1FvZrJ3NFU97Zix7utqMPGgZZqUfLoxmwkP2E2Ixzg5f6jkeb+rPS27qbhFpo57iDq
	 chjgmlMm+nYoVA6KMJ2/KAKD8uGuZqSjszytQrqwP00c7icVwN+emoQT35OPb1rkXS
	 uxCk6PVwqEdhg==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.12-rc5
Date: Fri, 25 Oct 2024 11:20:43 +0200
Message-ID: <20241025092043.3962056-1-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 0df4b9d91488922859db8dde4ee56936e01d547c:

  ata: libata: Update MAINTAINERS file (2024-10-10 10:58:27 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.12-rc5

for you to fetch changes up to 8e59a2a5459fd9840dbe2cbde85fe154b11e1727:

  ata: libata: Set DID_TIME_OUT for commands that actually timed out (2024-10-24 11:14:00 +0200)

----------------------------------------------------------------
ata fix for 6.12-rc5

 - Fix the handling of ATA commands that timeout (command that did not
   receive a completion interrupt within the configured timeout time).

   Commands that timeout, while also having either the FAILFAST flag
   set, or the command being a passthrough command, should never be
   retried. Restore this behavior (as it was before v6.12-rc1).

----------------------------------------------------------------
Niklas Cassel (1):
      ata: libata: Set DID_TIME_OUT for commands that actually timed out

 drivers/ata/libata-eh.c | 1 +
 1 file changed, 1 insertion(+)
