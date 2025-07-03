Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4940924B26
	for <linux-ide@vger.kernel.org>; Thu,  3 Jul 2025 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539113; cv=none; b=sjh1aRoMjWmu0nqAsDKd24tXYd1rMRC5922BmHSbihxihRrgSWP1RCQEepVJ0fa2UHJHuDfbxBLXT70bx0WNCfamLFg/5Vjx4q4ZrxdXRBIFHK93fb6pKUOIDrKKxhG8ntMkhZ8k5uJo37WR6H29InC/0YuEMB48fb+OwgvHIX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539113; c=relaxed/simple;
	bh=xnWhiN/OxyMUali3DHnrtIqH7yRpq7cQf3G57gn7VpQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Z3+UtetxKn3/diWQLbf++wQe4sD3gU+sTH2eX2yeFqcauvIpDIWk4qlmX1Ts8WrfEydpHEV0kiSTdzqW7kFJ74v/p6uZQJy6AkXUjgdGPX9Mh/kmMDrfKHF/nzkovWWEumMugX5IfEIEtzet2G3kkBdAs4rwmVMhPqtutahkJKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW0qwZ/+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW0qwZ/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A331C4CEE3;
	Thu,  3 Jul 2025 10:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751539112;
	bh=xnWhiN/OxyMUali3DHnrtIqH7yRpq7cQf3G57gn7VpQ=;
	h=From:To:Subject:Date:From;
	b=cW0qwZ/+gXhZXt1gw8x3zXmBLljAF0NMyYv9J1/vjNxBAY3FOV6tI2QaOiVvvmxId
	 OLOHXtvBfl7Pe65P52+n1QHfmLxi1k0dGfIMGe8OM+CRRJFahDQnbsgFM+oHiV/Zzf
	 KD0HmnhS7jd25EMfDo+P6GfzgWkecwxsbsJ8JmifBK75fgdD1gVnjK5nzKhDePu4Yp
	 WZP38qNLqK+3asZBSyQx4/7wiWUeGosYbZQ92bHiF3iOxkjCKbafZlcqRx2TbrNedo
	 +gsmNrK2ucZNbumfCTK0m7UUeVmaJkTDj5oGZ/mTQMlwNGWGaU0n7fGvzBy9vGt3e1
	 ZYaQrbSnRR8fw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 0/4] Improve log directory handling and some cleanups
Date: Thu,  3 Jul 2025 19:36:18 +0900
Message-ID: <20250703103622.291272-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch improves handling of a device general purpose log
directory log page by avoiding repeated accesses to it using a cache.

The following 3 patches are simple cleanups that do not introduce
functional changes.

Changes from v1:
 - Improved error handling in patch 1
 - Added review tag to patch 2
 - Split former patch 3 into current patch 3 and 4

Damien Le Moal (4):
  ata: libata-core: Cache the general purpose log directory
  ata: libata-core: Make ata_dev_cleanup_cdl_resources() static
  ata: libata-eh: Rename and make ata_set_mode() static
  ata: libata-core: Rename ata_do_set_mode()

 drivers/ata/libata-core.c   | 47 ++++++++++++++++++++++++++++++++-----
 drivers/ata/libata-eh.c     | 11 +++++----
 drivers/ata/libata.h        |  2 --
 drivers/ata/pata_optidma.c  |  4 +++-
 drivers/ata/pata_pcmcia.c   |  4 ++--
 drivers/ata/pata_pdc2027x.c |  2 +-
 drivers/ata/sata_sil.c      |  2 +-
 include/linux/libata.h      |  5 +++-
 8 files changed, 58 insertions(+), 19 deletions(-)

-- 
2.50.0

