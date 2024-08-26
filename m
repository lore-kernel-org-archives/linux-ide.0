Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C34985654
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657468; cv=none; b=EG53IlDX+JC0uyiesFLojuSM5HgmNvjRNRvY7L6AcsjHfBgBBTwiSIVU1tZNig8Ayv59+aAemWjOXhKJ13JRA/CMggx67IO9CBNcA/RKbby2xH09dXd5jw4u1zZDNLWu5MDtyU/0wZdWRHQK7sWphGKui3SRs44rxrcgc6nUrUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657468; c=relaxed/simple;
	bh=tHgoOd4xmle0+rSzH6nKo9m6bRb6O44YfCjWJwI4afk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FoP9QVgV8t0CiKc431lNtsgkFqDsI/n8CuRrYmSkGvX6ajuTKjBZo7BvmsPlH0HaNTqzD9/nnbJ19i7mTXOPXuKEtxP4e/9DKYBetHBnqJyau2uPwdTi0BmzRJxCl8mBIQV9W2r6aair5stqjK2UWB7wlhYs1ut/+x8Xj1fVLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moOhd8t/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moOhd8t/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC2DC8CDC1;
	Mon, 26 Aug 2024 07:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724657467;
	bh=tHgoOd4xmle0+rSzH6nKo9m6bRb6O44YfCjWJwI4afk=;
	h=From:To:Subject:Date:From;
	b=moOhd8t/vvtxS45wqM/AoI9yHiga4z0xerJEpXYPjubQK1aclwJa6z3h55chHDYzd
	 nP3hFnzstMovsTTzKkxRJtVRk0WLNr4I/JGB77jDKjFTSAuNrZVjl9xvyjvByoeCtB
	 9NJVg4gXChYdKyvkkV+bAPVxoNsw8wJaK+S08CHc1f6sLIiNuN8s0U4zcrjizQugHP
	 +KzfmHWGWynW7Dn7sImaPNx2ja9quo2j3s26WJM59uNdz+wYc9HbumEYBsxeD7ziK1
	 hDQeqJjTDy7HuP2BaSjM8/s6LBZHjweHd5WtOQfs9TJ6cB5gpOQkJhABDIcFyQTyMw
	 8G8ok5Q0KOSag==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/7] Code cleanup and CDL memory usage reduction
Date: Mon, 26 Aug 2024 16:30:59 +0900
Message-ID: <20240826073106.56918-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series starts by moving code that is SATA specific from
libata-core.c to libata-sata.c, without any functional change. The
benefit is a smaller ata code for hosts that do not support SATA. This
is done in patch 1 to 4.

The second part of the series (patch 5 to 7) cleanup the CDL support
code by moving device resources from struct ata_port to struct ata_dev
and reduce the size of struct ata_dev by allocating buffers needed for
CDL only for drives that actually support this feature.

Damien Le Moal (7):
  ata: libata: Fix ata_tdev_free() kdoc comment
  ata: libata: Improve __ata_qc_complete()
  ata: libata: Move sata_down_spd_limit() to libata-sata.c
  ata: libata: Move sata_std_hardreset() definition to libata-sata.c
  ata: libata: Rename ata_eh_read_sense_success_ncq_log()
  ata: libata: Move ncq_sense_buf to struct ata_device
  ata: libata: Improve CDL resource management

 drivers/ata/libata-core.c      | 189 +++++++--------------------------
 drivers/ata/libata-eh.c        |   6 +-
 drivers/ata/libata-sata.c      | 125 +++++++++++++++++++++-
 drivers/ata/libata-scsi.c      |   2 +-
 drivers/ata/libata-transport.c |  11 +-
 drivers/ata/libata.h           |  23 +++-
 include/linux/libata.h         |  34 ++++--
 7 files changed, 217 insertions(+), 173 deletions(-)

-- 
2.46.0

