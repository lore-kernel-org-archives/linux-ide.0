Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7B32989BC
	for <linux-ide@vger.kernel.org>; Tue,  8 Jul 2025 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960344; cv=none; b=nzNNRJJ2jAJoV6bYEhgWA2UnwYYZw80FwMbwD/pSw+8BR0gkCgIsUs+KNsvRbRQACPEH2WKSC2yxzDpsfDdyn/eQykRNfMBf/d5Z9XDgBDzekc1dzw+MiS1mCO/p6itJ5zssEESrTjIcqA9nQkyEUn1UzcETzmBo6pUoHP7OoVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960344; c=relaxed/simple;
	bh=UsUVi/hAqfvkf2vUcGN4PTLNycMc9pyfUZ/AR6h6+pk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pms2q0GJsMeWBXVIw/8Jwn1rXOqwEE8RIlzfOxeCZbxKGCDDb6Sg9Y/WztHln7sbuzHgOrw4R6a6SZ5Yg4iExTdTexh0RV/uDNp+cBUn5hECKNCc4mOa8JJOeWV2PMwGPsjA0XAQ0WlotARHCC8IsmUcc/X+H1NklCepB3vv9b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMy4lOiU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMy4lOiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D428DC4CEED;
	Tue,  8 Jul 2025 07:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751960344;
	bh=UsUVi/hAqfvkf2vUcGN4PTLNycMc9pyfUZ/AR6h6+pk=;
	h=From:To:Subject:Date:From;
	b=YMy4lOiUh2oB0wvGt5S4HAz2gOaO4tQERtTRT5eOO8qkzkwWW1kyEzgDHuvMTlnBd
	 9FPRB7ysrJim2qaVif0xjFu3h7G+lWAhllXq/XfmE0qBZYYhmWhssCE+cFxIp8S122
	 AJDcj15MMN8wI37XSohDp2i7lbqZmlOO1Zi6AlhoC1Tr43FCFkqSyd9Ptr2gsI6YCb
	 U7FtR4szxgBKMbgJCWVDzgbWnJIVeRnfSY6N5lk66dCjcurkv7SUDqYVnKXTIVAqgN
	 VbUY+PIDS4dq742vsOnZAjnqlyCsivfuSL0M0TgdgbXOzMuAaOZaibYZBl0/fpewrm
	 9/db2ioKtTvxQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 0/3] libata-eh cleanups
Date: Tue,  8 Jul 2025 16:36:45 +0900
Message-ID: <20250708073648.45171-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

3 patches to cleanup libata-eh code and its documentation.
No functional changes are introduced.

Changes from v1:
 - Correct compilation error when CONFIG_ATA_SFF is not enabled by
   defining a stub for sata_sff_hardreset().

Damien Le Moal (3):
  ata: libata-eh: Make ata_eh_followup_srst_needed() return a bool
  ata: libata-eh: Remove ata_do_eh()
  Documentation: driver-api: Update libata error handler information

 Documentation/driver-api/libata.rst | 21 ++++++-----
 drivers/ata/libata-eh.c             | 56 ++++++++++-------------------
 drivers/ata/libata-sff.c            | 10 +-----
 include/linux/libata.h              | 11 ++++--
 4 files changed, 39 insertions(+), 59 deletions(-)

-- 
2.50.0

