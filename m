Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86AE3921DC
	for <linux-ide@vger.kernel.org>; Tue,  7 Apr 2026 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550023; cv=none; b=mJVEQyMpX9kvtsBm82lw6tXlMcNZmrd+pIX/tvy7gwiARbHb0nDt/ZqMUqRHmRqMIyTTroExjY4w65UqrHUb3fHJKAD+Di/jLf7iHg/RMRe/Ey7v2YZ3sF3FOtIK/N5cBVGRra+lZBoLFi+op5QXqAnUCtKZmjcDXjG18Eab2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550023; c=relaxed/simple;
	bh=Zt/qbp7uAsD8rsdpJbvxF0gIbKuGAgNOrOXrL+EzK0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iMKHx9zg07+0TSy+0yHxEOMgoEPZSumK4vs2fOQzFLzzQnNUhz8WtRCR6zlnl85HBHxCNYz6hFDgmLVUHfjZH5hwgt5ySY8bdvR1Ox3ykyWwwnBbMYXjNKOs75NQ6Y4R2uS+1qUSHB6nJGqIBx62pp7D69gB54HlUCLdjbu62lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbJRm4Lo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbJRm4Lo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3514CC116C6;
	Tue,  7 Apr 2026 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775550023;
	bh=Zt/qbp7uAsD8rsdpJbvxF0gIbKuGAgNOrOXrL+EzK0k=;
	h=From:To:Cc:Subject:Date:From;
	b=hbJRm4Lo9gsbYLi7Sq0hp/+StdkgaxIWbzxwu6awYy8lm33VwcH+ePT0JqUoMd0gd
	 2+FNhQM2YwCcdg1BHDTddT8w1A7m2y0VjcpDb+8vxo66J1JfjnzmCpcDCy8BcCiR6I
	 e9U2NI5CDM0wA0aMeaj9tAo12o70a34Ml3KMTiniLCVqTgi74ya13qKiTVXL76OdFD
	 3GxPAh9k3Q8I7t0Az63GPPWD3dXUsKIF8kK4/AM9mBWBtMx1z/1wNpfYhNtCp4YEaP
	 8AwgrJ0mfWHHtSW5O3XGHTPSuLl9p+dtSSanr0z/SKVrEOoCkU5flM2Cu0PHEUhkIE
	 u2uA0Ur7w469g==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fix for 7.0-final
Date: Tue,  7 Apr 2026 10:20:18 +0200
Message-ID: <20260407082018.1205645-1-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit e6d7eba23b666d85cacee0643be280d6ce1ebffc:

  ata: libata-scsi: report correct sense field pointer in ata_scsiop_maint_in() (2026-03-20 09:59:30 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.0-final

for you to fetch changes up to 105c42566a550e2d05fc14f763216a8765ee5d0e:

  ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585 (2026-04-07 09:36:46 +0200)

----------------------------------------------------------------
ata fix for 7.0-final

 - Add a quirk for JMicron JMB582/JMB585 AHCI controllers such that they
   only use 32-bit DMA addresses. While these controllers do report that
   they support 64-bit DMA addresses, a user reports that using 64-bit
   DMA addresses cause silent corruption even on modern x86 systems
   (Arthur)

----------------------------------------------------------------
Arthur Husband (1):
      ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585

 drivers/ata/ahci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
