Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1B2249E4
	for <linux-ide@vger.kernel.org>; Fri, 26 Jan 2024 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706302180; cv=none; b=ORK/XnS3tzikCDQgtUhYUXfrifBG/Z1s+fY37YDBdnDcWw8NNBvWMmm3HkcQGbg2T5kQchlEsp/ro6/Aj3vTh+KHbwi3z1kbsZpN2KsxLGkm3ZGf+y5KFXaZ2kKJorneNZgNM79J0wyocrxN+WCg8iBukiOKXdbYvE8ns4Dnfyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706302180; c=relaxed/simple;
	bh=3ydZ5tIbcCXuAo9x7kv38IAl8givWLC8zTksHbzEZr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRFz5eiSi9NobvaJHbDWeIi3WHyy0i7L36dJHQjN0ek2MA/MqgcHKcmQm7bpb9CCN8+i3fvVXqrCiMFKgF+xbgpjdb9aBCFdtqzHmDDAb7zD4g0maVvjvXY+YpPBXeIPKswmHpD9bx847Lz4T7q3gWEPJzOLuZerOW9KbWW8qO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O49M5YdQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O49M5YdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A58C433C7;
	Fri, 26 Jan 2024 20:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706302180;
	bh=3ydZ5tIbcCXuAo9x7kv38IAl8givWLC8zTksHbzEZr8=;
	h=From:To:Cc:Subject:Date:From;
	b=O49M5YdQQZOpCG9S+k+D7H99F6F6IMYAv3mOzXlWwsRB5EAuLTPNchQuGLk4y6OuP
	 OqMJQCDIcMrtGC2d25PAKPwX1UbX0mKb0Ln/t1rnyf06IE+PhGrFWwWtNzHXljFDbc
	 ompPHzVM8urRiXb7Q/OIPaE+pME3jwUgM8j1P/waWyoggSxlNdBwNFMpspz2x3lNlK
	 iZgYYTFrQD6ald5oJ6HvMd+JG4A1R3NX8ibwvpm4aWFAL4/X1GpkLUcz2V3wfL37e2
	 nQJT79W7wHRBLp1FsRwF51NlYvFzczjTa+BWMFVtXwfSBT5O2fk4yPD0FlDnKOpVEN
	 XNKkaNCiTnoRQ==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.8-rc2
Date: Fri, 26 Jan 2024 21:49:27 +0100
Message-ID: <20240126204927.4168716-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.8-rc2

for you to fetch changes up to 20730e9b277873deeb6637339edcba64468f3da3:

  ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers (2024-01-25 16:59:09 +0100)

----------------------------------------------------------------
ata changes for 6.8-rc2

 - Fix an incorrect link_power_management_policy sysfs attribute
   value. We were previously using the same attribute value for
   two different LPM policies (me).

 - Add a ASMedia ASM1166 quirk. The SATA host controller always
   reports that it has 32 ports, even though it only has six ports.
   Add a quirk that overrides the value reported by the controller
   (Conrad).

 - Add a ASMedia ASM1061 quirk. The SATA host controller completely
   ignores the upper 21 bits of the DMA address. This causes IOMMU
   error events when a (valid) DMA address actually has any of the
   upper 21 bits set. Add a quirk that limits the dma_mask to
   43-bits (Lennert).

----------------------------------------------------------------
Conrad Kostecki (1):
      ahci: asm1166: correct count of reported ports

Lennert Buytenhek (1):
      ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers

Niklas Cassel (1):
      ata: libata-sata: improve sysfs description for ATA_LPM_UNKNOWN

 drivers/ata/ahci.c        | 34 ++++++++++++++++++++++++++++------
 drivers/ata/ahci.h        |  1 +
 drivers/ata/libata-sata.c |  2 +-
 include/linux/libata.h    |  2 +-
 4 files changed, 31 insertions(+), 8 deletions(-)
