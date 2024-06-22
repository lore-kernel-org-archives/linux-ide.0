Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825191E488
	for <linux-ide@vger.kernel.org>; Sat, 22 Jun 2024 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719068377; cv=none; b=Amp9aWTq+MCnPKMrKqyX3EzsLLtADRwi2YpqzlH6eABVt5iN4lI5+WClkSudmsdUMG9Qcgcr/dsJpDB7NY/M/atrPaYcNqJPWQDjxZiIJeWMgxqP7Da2IjxP3kLF+cxPhtKoEUbi71Ym49zecIB/hraenZ5hq7x3UU7YFd1EVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719068377; c=relaxed/simple;
	bh=uFCg7TAFRvLKOlc9gbFNLZ5Ui7+lDDWwR6CkQumwL8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dMqhAz/HbudASjpFG5Jkte1NrZJtMmdsivfCG7lMxLZaG0kcmTLvWnk27/1i9PmjdxPEoq7ai2Fftg/IJljkZREQxJIDz74pNMBUA65SNEEegpCI9bScR5m6ymhQOzRDR5Xhf5quks086sYs84qrgkD7xG9/QooIm+PmgAU13uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbaT6wOx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbaT6wOx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99F8C3277B;
	Sat, 22 Jun 2024 14:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719068377;
	bh=uFCg7TAFRvLKOlc9gbFNLZ5Ui7+lDDWwR6CkQumwL8Y=;
	h=From:To:Cc:Subject:Date:From;
	b=ZbaT6wOxzEgqBKHfvrqQ+0TuwtT3QOOpTuMIRSN2kPJejx6gLdzid2A9+8rMflT+C
	 Kod27I+CTsR2sHG7dwjTOPgSOS78wQ4FkXW3xczLfNP8I3iwcK72oOtWgsk8bfo5U5
	 DM+vTJ8lcIAp059ev7kwLu9KRdTRsgJprqXYfAtLSQU+L8/TyofhIpwty722iK2B9a
	 JX7qwY/vpuJOPwgPV1I37WDpFj+x6gndD1IQFAY29Ds1PT/U/Fs/tY+diXKEa+Vp7G
	 BI3EEFh/4WbMFeSD1+iNnr2+BBTL4m2OmyCJi+lj5SAJrBMzTmx9szBBUqMs2VEFrz
	 0AfSxzzFfjNFQ==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.10-rc5
Date: Sat, 22 Jun 2024 16:59:15 +0200
Message-ID: <20240622145915.2929583-1-cassel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit a6a75edc8669a4f030546c7390808ef0cc034742:

  ata: libata-scsi: Set the RMB bit only for removable media devices (2024-06-14 14:18:46 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc5

for you to fetch changes up to fa997b0576c9df635ee363406f5e014dba0f9264:

  ata: ahci: Do not enable LPM if no LPM states are supported by the HBA (2024-06-19 13:19:38 +0200)

----------------------------------------------------------------
ata fixes for 6.10-rc5

- We currently enable DIPM (device initiated power management) in the
  device (using a SET FEATURES call to the device), regardless if the
  HBA supports any LPM states or not. It seems counter intuitive, and
  potentially dangerous to enable a device side feature, when the HBA
  does not have the corresponding support. Thus, make sure that we do
  not enable DIPM if the HBA does not support any LPM states.

----------------------------------------------------------------
Niklas Cassel (1):
      ata: ahci: Do not enable LPM if no LPM states are supported by the HBA

 drivers/ata/ahci.c | 8 ++++++++
 1 file changed, 8 insertions(+)
