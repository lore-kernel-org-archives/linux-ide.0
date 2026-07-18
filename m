Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620217BB21
	for <linux-ide@vger.kernel.org>; Sat, 18 Jul 2026 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784336253; cv=none; b=NHI12lVh4R4JbnXeIigk7WdppeIYX+QTkgLc9Av23iIhmvxgwH+fa8UA+RfJ0Mr0FLYexyLzP+qBu5LWixf/oD9x18OfVcJysJBn5RKFAD9fz6IcF3IEgw8wLSND9H03W+lki6UMy0qMAWz6ax7MirrEXiFhsXs6iPKLQHFmyqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784336253; c=relaxed/simple;
	bh=E4mRPBiUe0Ixjt4gwCHuUX7DfIBpDOiv3JalAVJqU98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A32XXAezzhwWNebIzN3pU3Pr2jj4456mqssTdsCiWmIgQd2xd+t85CUqHN9Uo3/M9w57JZUNRACCR1HazabjUWlsU4sMXo/2e/VCHjzqv/N1/R9vsjCRAaqTwzC6khnj47NNS4gsHrjm/P+tSt/ho7zEkLpMyY1L6u+2s7uOfP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBJ+v+NY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBJ+v+NY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFDD1F000E9;
	Sat, 18 Jul 2026 00:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784336251;
	bh=KBj9MznD9nMpaopgKrF5DDIAV1+8d0Ec4GfNF26tKGU=;
	h=From:To:Cc:Subject:Date;
	b=OBJ+v+NYAt7mheXgu+qHeH7wMju8mMDSsUXQNVvdUG65vyJIid3xW7bFd8mwMEnWs
	 mB35e7QTrNdUktI/Gcbx7E2Paur4YuVvVSniTIRdO4XZ8QVcMN+8oaIs+5t4VjBs9O
	 sU6zCv2HV9VVQg0uZn7Yv0WOCo+z+0YzKR0D0Zgj8w2SUIMslYwhWkOT51pR/LpHGn
	 2J90J7rWAgjtwB43cWlIcgPg1oqeFm5ws1KFJ95hL4xaxpHUhEpNfEI3XUJI527Zk6
	 TN7Ro+XrvavTQrSCIZk06T9ueDHBEnWMMSzbIb8zcbsf/96IRflyNU0+P2UDmTyhf8
	 7lbZwQ7FSI5vQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 7.2-rc4
Date: Sat, 18 Jul 2026 09:57:20 +0900
Message-ID: <20260718005720.1578823-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 793bf193b18e9bff6c4280268bbffd16a5b533e5:

  ata: libata-core: Allow capacity transition to zero for locked drives (2026-07-08 13:49:48 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc4

for you to fetch changes up to c2130f6553f4a5cbdc259de069600117a995f197:

  ata: sata_dwc_460ex: fix infinite loop in NCQ tag completion bit-scanning (2026-07-13 14:32:11 +0900)

----------------------------------------------------------------
ata fixes for 7.2-rc4

 - Interrupt initialization and handling Fixes for the Designware
   ahci_dwc driver (Rosen)

 - Avoid possible infinite loop when scanning completion in the
   Designware ahci_dwc driver (Rosen)

----------------------------------------------------------------
Rosen Penev (4):
      ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is registered
      ata: sata_dwc_460ex: use platform_get_irq()
      ata: sata_dwc_460ex: fix clear_interrupt_bit() clearing all pending interrupts
      ata: sata_dwc_460ex: fix infinite loop in NCQ tag completion bit-scanning

 drivers/ata/sata_dwc_460ex.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)
