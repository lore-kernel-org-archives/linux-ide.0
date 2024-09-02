Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9880913C918
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725318437; cv=none; b=g8tSoQ79gNAvdFZbh210gts9gVvYs8tI531m1hfTAnLfe2lbnWDIcl4Km4eb8cYalHP6Y5P7OqkGkOqfsWMTbG+pOEpU3bHalXUCaHVeWJ6EhRUtAa+Y3WhkI4gag9VXZCnXeGBQziAH7MYTx5y6VM8StD7Z4s+wMIdfNRzFFww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725318437; c=relaxed/simple;
	bh=IxIjZl+KgrR7rToddLmuGSA4J8HFa/OQmqZoM5xfuvA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KzOLG7qi6M/BYSaHmgQoyD+fheRNpzNTlZgi6bA2WR6zSq1mvs/ABAF1dwczna3CBGtK8pjbeBE6UM+DWRIs+svYmFYi4VDUkv8Gb+3d4vp+Jc9GK0BA6EmLRvLFfRwmroljsho/qnVhxVe6isprNHv5i1kRhLT2pB/p0nZWHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGgrumQD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGgrumQD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8D4C4CEC2;
	Mon,  2 Sep 2024 23:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725318437;
	bh=IxIjZl+KgrR7rToddLmuGSA4J8HFa/OQmqZoM5xfuvA=;
	h=From:To:Subject:Date:From;
	b=ZGgrumQDD401f/DOsYY6bTXe0JRdC8WuRUPmZqlEDJ46L/O6OUBJ+LiyXj+N2fyta
	 eY6FCQHRqx/l+WcWzgbaawjRx8CPYHsaPiw+mFXRF1C9PogX86oJqHpqMMWL7/DUOV
	 ZWSrjbFczgftEkx0mblpBwoiGuuE3qyoRk2D9GTG6tKwPXzlti2GVQZizZCzMasacj
	 C59H5L6ygqnchjfRFq2wN+hOaMKjBP9y7Q+O2CkamQduzP0VHkCnkPdmATehdGgbvS
	 ZIEQu6wIyOJM692IEvZMzdxAoXmyVp0OWcX3eMrNTJ4F2GOfb2z7+YUKOwqhgFGaoe
	 /U0r/B5FhbC+Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 0/7] Code cleanup and memory usage reduction
Date: Tue,  3 Sep 2024 08:07:08 +0900
Message-ID: <20240902230715.176522-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 of this series cleans up libata-transport (avoid forward
declarations and improved kdoc comments).

Patch 2 introduces a small simplification/improvement of
__ata_qc_complete().

Patches 3 and 4 move code that is SATA specific from libata-core.c to
libata-sata.c, without any functional change. The benefits of this code
reorganization is a smaller libata binary size for hosts that do not
support SATA.

Patch 5 renames some functions to make it clearer what the functions do.

Finally, patch 6 and 7 reduce memory usage of libata by:
 - Moving the sector_buf buffer from struct ata_port to struct
   ata_device
 - Agregating CDL related buffers together into a new ata_cdl structure
   and referencing this new structure from struct ata_device only for
   devices that support CDL.

Changes from V3:
 - Small change to struct ata_cdl kzalloc() call as suggested by Niklas
 - Removed bogus call to ata_dev_cleanup_cdl_resources() in patch 7
 - Added review tags

Changes from V2:
 - Reworked patch 1 to address Hannes' comments
 - Added Hannes' review tags

Changes from V1:
 - Reworked patch 1 to do more cleanups
 - Added patch 6. The former patch 6 of v1 is now squashed into patch 7
 - Added Niklas review tags

Damien Le Moal (7):
  ata: libata: Cleanup libata-transport
  ata: libata: Improve __ata_qc_complete()
  ata: libata: Move sata_down_spd_limit() to libata-sata.c
  ata: libata: Move sata_std_hardreset() definition to libata-sata.c
  ata: libata: Rename ata_eh_read_sense_success_ncq_log()
  ata: libata: Move sector_buf from struct ata_port to struct ata_device
  ata: libata: Improve CDL resource management

 drivers/ata/libata-core.c      | 264 +++++++++--------------------
 drivers/ata/libata-eh.c        |  10 +-
 drivers/ata/libata-pmp.c       |   3 +-
 drivers/ata/libata-sata.c      | 127 +++++++++++++-
 drivers/ata/libata-scsi.c      |   2 +-
 drivers/ata/libata-transport.c | 299 ++++++++++++++++-----------------
 drivers/ata/libata-zpodd.c     |   2 +-
 drivers/ata/libata.h           |  23 ++-
 include/linux/libata.h         |  39 +++--
 9 files changed, 406 insertions(+), 363 deletions(-)

-- 
2.46.0

