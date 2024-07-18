Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300DB1EA80
	for <linux-ide@vger.kernel.org>; Thu, 18 Jul 2024 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721298840; cv=none; b=tRVPg/DPjayBZYD8nXcsWOsuMApqPPh5nrYg/aOO4mjKQLCcwt454cOnrSSGgiKVr2HMGbI80pVBeWmtXJ1wGEhSnInQDnF/s/SJKGilUJLFosYy5uMKuADZ0kPsckaKcFJi2axN9gH+Fh/LlVZpxoHUraASbEHWG5J4xr5clDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721298840; c=relaxed/simple;
	bh=/MR2EQwq1pyu4tXas8JwS6xRXkeVx13yLsvgdB/bkmU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tHU5wToC0cdjQLxoDTScm1j0LzxGQB7/iYiOvsgJlnBWT6q4YoB4u6sviAgNOglBKY2ndIWA8GNFDeWWPUZhzUel+B7q5QA12I3i4pE2YGYZoWQxloJWTvHSmF1V4mi05nC9QOfMzU3Id0+MiU8AXiYvpRXRenaxuX3e1CkAY+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd28l3hy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd28l3hy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BC5C116B1;
	Thu, 18 Jul 2024 10:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721298839;
	bh=/MR2EQwq1pyu4tXas8JwS6xRXkeVx13yLsvgdB/bkmU=;
	h=From:To:Subject:Date:From;
	b=bd28l3hy9mz7sLqikJEGSeOh8BDBF82f7WrXNPFV6lvsjdty0EeXX7WJltFba/ntQ
	 241/iE03Ox7JKQdeHsAm0N8zGVKSfeukcUFKHJSJkC+ywnuxcW+kI/UTNhvaJ+P0hz
	 bQu563Q6aGhDXfPEOm5sXXr55j1GT79N9okGOq5UH/sTEEIsy9XoN/lzCc2oACLQX5
	 ItcU5etAUAM77W0laeyYltFUC+gI7Kk5UHMUw2+BNNzFm4rnuAZaJ2q5kfzA2lgUBP
	 sN/6jt3aAAbu0+rwXN9rmH+cIZatAwo29yVTkVg5u5+L5MP2A0hUc5BXfbgFI6C0Ps
	 b7xPF8UYENNig==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 0/3] Some renaming and horkage improvements
Date: Thu, 18 Jul 2024 19:33:55 +0900
Message-ID: <20240718103358.176260-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first 2 patches removes the use of the term "blacklist" from
libata-core.

The third patch adds printing on device scan of the horkage flags that
will be applied to the device to help with debugging.

Changes from v1:
 - Remove unused macro definition in patch 3
 - Use unsigned int for horkage flags (patch 3)

Damien Le Moal (3):
  ata: libata: Rename ata_dma_blacklisted()
  ata: libata: Rename ata_dev_blacklisted()
  ata: libata: Print horkages applied to devices

 drivers/ata/libata-core.c | 109 +++++++++++++++++++++++++++++++-------
 include/linux/libata.h    | 108 ++++++++++++++++++++++++-------------
 2 files changed, 160 insertions(+), 57 deletions(-)

-- 
2.45.2

