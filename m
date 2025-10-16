Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6142F2F9D8C
	for <linux-ide@vger.kernel.org>; Thu, 16 Oct 2025 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608262; cv=none; b=qKigILo/7RWc9/y3yGZKW2h4/M+egboemzOSyA1hYPuQJVt3DtFEQIssaiYUZWE+pyMCTvNPXHPMAjKgucpua+xKsDanuA5l/ylOcwkFmd/HDi/bPc7cQjpLKbUGo1olV+9Vgi5oJS0MJ5jg9dC5v3ZUboLyAAD+fDqcezDMRk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608262; c=relaxed/simple;
	bh=7FzzaUl+fQssZsCRfwN+vQt7HSiNQhJRdXCkP1RvyjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DYYcg59NHoi/QqVc3cX9Q3o3/Slr3/4kc8pyBIxoNCJemZ4Z94q5Ywy0nc/FTsbHszkce0fdRF2hCjbqlXIcs2uuPeRS4NxIQxEI1i9SfgsQEB9iu8QYS7HOHC0nA2tvG+I40/Ds2T63hmvBVqQDU5CLt3wUlL5EW/4e0s04HfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVpdCv8E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVpdCv8E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78B2C4AF0D;
	Thu, 16 Oct 2025 09:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760608259;
	bh=7FzzaUl+fQssZsCRfwN+vQt7HSiNQhJRdXCkP1RvyjE=;
	h=From:To:Cc:Subject:Date:From;
	b=GVpdCv8EY5tCTqKNvyNfMn427Y9xdRGw84plLwzgbnB3YxsF6QRZDeVgonoRu7OZO
	 IgCAR8HDlBjDu6GPjs5MSiwJXNJSae8IzQXaHt89syMpqNhUiCCpoYKHsjWFO5Hvm5
	 XxyakhcT+bntnxfIjTLXrOsLBcW4UWLXDlYQXFYEXEC310wSKOlJtL1KePB1KNeKGZ
	 UYxuUhBAghwbiURc+NAnbr2v6L+O21dX03sFZgFRD0Ql3qU6fvtT5XIixAF7AoEp1G
	 dyTmXqJLSuqwuF5v39OWvfgUgZKQ25HDz4pBljvS+DyMJwZCRdonT+v9savk92x4Uv
	 HDkt97NZNmu1w==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.18-rc2
Date: Thu, 16 Oct 2025 11:50:53 +0200
Message-ID: <20251016095053.457176-1-cassel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.18-rc2

for you to fetch changes up to 12d724f2852d094d68dccaf5101e0ef89a971cde:

  ata: libata-core: relax checks in ata_read_log_directory() (2025-10-13 09:12:36 +0200)

----------------------------------------------------------------
ata fix for 6.18-rc2

 - Do not print an error message (and assume that the General Purpose Log
   Directory log page is not supported) for a device that reports a bogus
   General Purpose Logging Version. Unsurprisingly, many vendors fail to
   report the only valid General Purpose Logging Version (Damien)

----------------------------------------------------------------
Damien Le Moal (1):
      ata: libata-core: relax checks in ata_read_log_directory()

 drivers/ata/libata-core.c | 11 ++++-------
 include/linux/libata.h    |  6 ++++++
 2 files changed, 10 insertions(+), 7 deletions(-)
