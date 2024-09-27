Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A84D1779BD
	for <linux-ide@vger.kernel.org>; Fri, 27 Sep 2024 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439873; cv=none; b=SQgqxLLrc2GVLuQ1c0Y41JGDm0bBo80Qo/LzuPSB5vuX/BhqPhDlzgNCQOugMlCfPYm09lGLCDCy4u5lzIESHQjNlgl2mM6XWM7YF7p4W9GpKoeDiCHdwxnHSLuH6vbrjpezfQmflEzwRbKkMICCEKLnPcdlKbu2hvyeOtS85wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439873; c=relaxed/simple;
	bh=lLRlLHTGFAzfe3QAcwAcjf1OUb/blY8cDZ30WqONeuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rN2PO/UgHJZTileaLVf4SxbgAB2rPFsOMPzdmmqPOWgS+ancgEW0UjprGdDCtJ3BoTDb8Ia5GVjLWjb2nYzVpupfbF0FzbeUM5cQ+szaTh93UU9W2OzbyD+i7o+i3GtAybZ1nzq8n67cNOoaviXiUSSplpr9UWvJ46zQHRxeW/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlw3Ep0y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlw3Ep0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07148C4CEC4;
	Fri, 27 Sep 2024 12:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727439872;
	bh=lLRlLHTGFAzfe3QAcwAcjf1OUb/blY8cDZ30WqONeuU=;
	h=From:To:Cc:Subject:Date:From;
	b=qlw3Ep0yxKdFzAMeTjqc2QJ3W3Vw72aqkOj1VZIv+x6TgQDtFhAfDptyPUZ0ZIVYt
	 MjYDXRWcZ2l7+oYgVdEPk7xp8gz6jdj/ZBzwATZDIp0oQNgW1Hrsx/ih+uv1casGOh
	 uoh1nXTvKbWVgbmPDbbgRmoLvZL3668xnljvCKcSGJiXYzs0xGh35KRsCGvVNVXASJ
	 BjGB51aMF1bb/TQ2y7gPjrfivViZ6I0eNq5mB7x0mWhYheOOuzBg702x987/8GplbL
	 MJv9Kl6C7Shz658ZjNiRAAqicFhCxR588+lXhHakqzW8YnvOj7LJTF1iNQk4gcU/CS
	 r1XdBisOyN1IA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 6.12-rc1-part2
Date: Fri, 27 Sep 2024 21:24:30 +0900
Message-ID: <20240927122430.333750-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit e5dd410acb34c7341a0a93b429dcf3dabf9e3323:

  ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data (2024-09-11 08:03:43 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.12-rc1-part2

for you to fetch changes up to 0e9a2990a93f27daa643b6fa73cfa47b128947a7:

  ata: libata-scsi: Fix ata_msense_control() CDL page reporting (2024-09-24 16:56:51 +0900)

----------------------------------------------------------------
ata fixes for 6.12-rc1

 - Fix a NULL pointer dereference introduced by the recent cleanups of
   the command duration limits feature handling (from me)

 - Fix incorrect generation of the mode sense data for the
   ALL_SUB_MPAGES page (from me)

----------------------------------------------------------------
Damien Le Moal (2):
      ata: libata-scsi: Fix ata_msense_control_spgt2()
      ata: libata-scsi: Fix ata_msense_control() CDL page reporting

 drivers/ata/libata-scsi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)
