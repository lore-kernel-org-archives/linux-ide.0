Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0A180A82
	for <linux-ide@vger.kernel.org>; Sun, 16 Jun 2024 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718530026; cv=none; b=QfMsXHo9vTDMRLAL8uild3SU6VYbmFrD5md27/zU1dz5dBEVIl5nwaAAj9RhS4ayvuTk9idTfC7UONOPmbdJpQz2mKv6o+hZuy0ABXQeBVX8exLVE9CySlRsvgYUqfpBR8YTDD6u0OZsmT4UWZXOPZPVYZuiOGbFnPuCh71nJFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718530026; c=relaxed/simple;
	bh=Alb7ucNOOkuWsEhJ4TYDmxUJPijeaAHdQLyeg+Ov36g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NcyESy2vgX6nP420NI2SdzOerkgxdUZhY3cSzs82+Ka66UIiZW04rqlgrpXOnPBl5YJqwBd/xK2nmysxA2BQFX2P7RW1AO6SwpYq7SugUr+A3OiRhqSTmX0c9kL7NUZBmKKm2ugY4J8n+399nmvrHuEFCfR0j2f11cmggsxNkdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqrPvieJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqrPvieJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A60EC2BBFC;
	Sun, 16 Jun 2024 09:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718530025;
	bh=Alb7ucNOOkuWsEhJ4TYDmxUJPijeaAHdQLyeg+Ov36g=;
	h=From:To:Cc:Subject:Date:From;
	b=cqrPvieJFe6ZYFVaWV4csYO3ezwXUKgfsYadJOg+/OH9SRVtaZv1260Ux1WtnvIOg
	 DiWYy1/XPg7styNCT2tF8u72aWjWUK1TC/In+QuYG1ryPP16Hs5jQJjiNxJQbGlVCL
	 ZXreMHk7Wu41MUSsEEQYVON1LhpqwjFPxC2OHHPaN8ddI7NRzBOASYSMedzeW2kPoC
	 w2Zzulo064BkKK186Qro17lqvZvX3ciUwV7GHBnYVovpIGGnTrSeW+hV8xWwNz4HVC
	 PVCo3HMwUJtYIdE0Ex1dBe8ivhc1QnMat665jWxHPTVgcThB6GglIAR5mkHuNkvnUg
	 +SiCsGwLbPkCA==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.10-rc4
Date: Sun, 16 Jun 2024 11:26:59 +0200
Message-ID: <20240616092659.1798613-1-cassel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 09fe2bfa6b83f865126ce3964744863f69a4a030:

  ata: pata_macio: Fix max_segment_size with PAGE_SIZE == 64K (2024-06-06 14:53:34 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc4

for you to fetch changes up to a6a75edc8669a4f030546c7390808ef0cc034742:

  ata: libata-scsi: Set the RMB bit only for removable media devices (2024-06-14 14:18:46 +0200)

----------------------------------------------------------------
ata fixes for 6.10-rc4

 - Fix a bug where the SCSI Removable Media Bit (RMB) was incorrectly set
   for hot-plug capable (and eSATA) ports. The RMB bit means that the
   media is removable (e.g. floppy or CD-ROM), not that the device server
   is removable. If the RMB bit is set, SCSI will set the removable media
   sysfs attribute.
   If the removable media sysfs attribute is set on a device, GNOME/udisks
   will automatically mount the device on boot.
   We only want to set the SCSI RMB bit (and thus the removable media
   sysfs attribute) for devices where the ATA removable media device bit
   is set.

----------------------------------------------------------------
Damien Le Moal (1):
      ata: libata-scsi: Set the RMB bit only for removable media devices

 drivers/ata/libata-scsi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
