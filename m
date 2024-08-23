Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B561512E7F
	for <linux-ide@vger.kernel.org>; Fri, 23 Aug 2024 00:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724373445; cv=none; b=LwkFnZ+iPdkRtfFQqdRX/WVJd4nwaSDwURldE3g8KiM9vlgbHxpaqz2g3s3ZkDcQEClPQUKW5nz1O1CRQZ6xn+ptlkXkPG+zrHZA5gSSXqhauEwDeaDMgOhPERpXx8KM2EouyrHTkXC4hYvVgIe43ucX8HamQe9yAEIgD+Xwaow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724373445; c=relaxed/simple;
	bh=vvwtb0RzH7xabC7onAiV+fk30Zurr1kLoRpc9dW8cX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OVzypWGqQ+U0LhOy5NDDVzrN9/iDd5QJ/hQIMccaUzwR7p9rFdAvx+IWw36h7imM+SJTH1ionFbAUGSXlYB45Bb+6oIbdqxm/o1KwxE8vOp2MjxuZfMHqLDtXJ9fp1+Gp2HpAIIF6Gl4I3UzTvKUCNdVWXojV7r0D7kqavbmowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWuDBigI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWuDBigI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47CAC32782;
	Fri, 23 Aug 2024 00:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724373445;
	bh=vvwtb0RzH7xabC7onAiV+fk30Zurr1kLoRpc9dW8cX0=;
	h=From:To:Cc:Subject:Date:From;
	b=gWuDBigIH0gG5wyf1IclfRSIrxftEyAivpd7UaEUrdLDMr5nyCaq7f4muWoy56Pff
	 d7wogbJ0EiX3trd9Wi9Sdixacn16IS/Sravc2nSxuYu3Fp31t5U6l/XJXApEPCTd1z
	 7rHKTEuqW76JsrIkIEzhIgUK2LZP16hNYxkoB5bi+1nf8azNbEkwg3szlOKjWxU1zQ
	 rq0xM7bcpWBmWQ1hzHcDXuWfv7fYhTx+U+AcRMTP20BMIofB8u8Jmv60sxE8vnIne3
	 A5/pv0nNvL6JjR0orJFOYm4wICKYdHqSzbX0FBlUDmskJeJExuqrQu929K7q0ZPiDE
	 BYYmevE5/2OYw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.11-rc5
Date: Fri, 23 Aug 2024 09:37:23 +0900
Message-ID: <20240823003723.89539-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit fa0db8e568787c665384430eaf2221b299b85367:

  Revert "ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error" (2024-08-14 15:49:37 +0200)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.11-rc5

for you to fetch changes up to d4bc0a264fb482b019c84fbc7202dd3cab059087:

  ata: pata_macio: Use WARN instead of BUG (2024-08-21 14:33:23 +0900)

----------------------------------------------------------------
ata fixes for 6.11-rc5

 - Fix the max segment size and max number of segments supported by the
   pata_macio driver to fix issues with BIO splitting leading to an
   overflow of the adapter DMA table (from Michael).

 - Related to the previous fix, change BUG_ON() calls for incorrect
   command buffer segmentation into WARN_ON() and an error return (from
   Michael).

----------------------------------------------------------------
Michael Ellerman (2):
      ata: pata_macio: Fix DMA table overflow
      ata: pata_macio: Use WARN instead of BUG

 drivers/ata/pata_macio.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)
