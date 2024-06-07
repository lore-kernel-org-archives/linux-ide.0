Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABD147A6B
	for <linux-ide@vger.kernel.org>; Fri,  7 Jun 2024 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749034; cv=none; b=uMFiG1XOcEQgTFlC3xSB8sAv/TBwWedav4TmhwkEMiUSWAdQ1xuo1bVIWv99PhysdnYsRJZnnruJCL84ZO1bG7zYCE8n60hO6j+Y/OekUHZPgHA+nzhswvxrDOCdmaaJr2pmuBkta2+S57mdzTc2q7El6cqOLO+OumDdT5k8FoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749034; c=relaxed/simple;
	bh=KqXsdmSOqWFLT4VrZHxerWP/ttaUQaUe9ub1lnQeWRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kvm/JV7Z3+y6JmAFJbzvE2Gotq/pUbjHWa6frIeHYy33kO/lFE6r8llqQevinbLe7+z3DNn5e2I6vyhuuZpHHp46ra9akDojaEdslOYVregZy/kCLUafiwziFXhnGijo9SV1ATQ1QhpXm+LYgG7QyL7p+jV5h1V+piP3YaJCvm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rvm9hvuj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rvm9hvuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9267C2BBFC;
	Fri,  7 Jun 2024 08:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717749033;
	bh=KqXsdmSOqWFLT4VrZHxerWP/ttaUQaUe9ub1lnQeWRo=;
	h=From:To:Cc:Subject:Date:From;
	b=Rvm9hvujJ7gDEc8EGqROkXAkQWiAhDJeIfgKD6Ag4xggxWgYavgQSlf2Zr1h0VaFF
	 I9eYEXGKpS0oPH0Z0TjfZip0qdpgHHGV1+8DxS2ZhW07eXzWt8pyrgUV/XF9VdINLA
	 zZzm26CWapAt0I0D/dq6/u6Ljo3iNnetCqDvul7zYTP9O/q2Cvgp5VVuDZrVsn88k8
	 OFHJGsLh/2idqhDTssl1M/4f+YiuoZkOM1AOV6pKFf1IwYq3B4WjuVHb+rpE7qQMcy
	 sZYmx2Qw8BsmhtcoEr2xDDG/ICuhoZY5eAdXUgUzGrNXeBlqdAC1EaxmR3p+4uz8ch
	 1IJL5vwYNp9iw==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.10-rc3
Date: Fri,  7 Jun 2024 10:30:23 +0200
Message-ID: <20240607083023.1163249-1-cassel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 3cb648c4dd3e8dde800fb3659250ed11f2d9efa5:

  ata: libata-core: Add ATA_HORKAGE_NOLPM for Apacer AS340 (2024-05-31 15:14:06 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc3

for you to fetch changes up to 09fe2bfa6b83f865126ce3964744863f69a4a030:

  ata: pata_macio: Fix max_segment_size with PAGE_SIZE == 64K (2024-06-06 14:53:34 +0200)

----------------------------------------------------------------
ata fixes for 6.10-rc3

 - Fix a regression for the PATA MacIO driver were it would fail to probe
   because of the recent changes of initializing the limits in SCSI core.

----------------------------------------------------------------
Michael Ellerman (1):
      ata: pata_macio: Fix max_segment_size with PAGE_SIZE == 64K

 drivers/ata/pata_macio.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
