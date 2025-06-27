Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F32264A3
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010856; cv=none; b=tUbidGeXnSWIyZa+0RA/mO7a4cTkmRZG2yNUe775AV3Okktp3M5CXTISTiV8ENPPZP240yJIXSx7nbpCJGLif4uPoH3pnadXgIzMEvrIIMBfBhxDol7vNlSyviwunzuevDJxFWeMqhVoCSCSApxEovcWh6YNf1/BIQ21Ot29b1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010856; c=relaxed/simple;
	bh=QZ5d25fTCEQxQjsl027mhOjJjK6uet1Jh+/EnDPWEVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJh/qP6vRMQM2w1Nnej0v4aROcJIe5A198WdScT8oygiA3knY0gSUIABXxnHX7KHxFHFUgPH46+MYrQ8OoOKEj8eOgE23YrkzhORP517uBUDI8siqIDYkFT0TO7rlzaNgZ/j//A15kPmeVODYeGsWL/yJj0BNHIilBDy8wu1SG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXe6NH50; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXe6NH50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7FAC4CEE3;
	Fri, 27 Jun 2025 07:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751010856;
	bh=QZ5d25fTCEQxQjsl027mhOjJjK6uet1Jh+/EnDPWEVA=;
	h=From:To:Cc:Subject:Date:From;
	b=OXe6NH50zAzp5O2nUQSot0tNF2V74UqIULVMcZlGn0Iff4J6WxIngVN8Mk5Jvn+oJ
	 svwJ2YQckS7lZolNpJhvnt/Bu+5enPD86BYb1fbMMCvXUFa/cswqLNl7PptrNOkY42
	 JFfbOz1QzK1v9eEopqCoLp2WsKBSvMu9WUoqIuNXoE/HaIcmxBojt/ziOGUnumFiSa
	 vx4lF5GcxYIpJPZZTr2v/UoYOCvBnO599BS0fayHZ7nN4zgxvv2a07MepxcXJBCI7n
	 6/UupVSyMqyqHthSio/BipoeHtSpPqN+LveFf+yPtl//LBQQErocup9fcEG4DZcDMP
	 qH17n1NMWDbTQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 0/6] Various cleanups
Date: Fri, 27 Jun 2025 16:52:01 +0900
Message-ID: <20250627075207.23969-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6 patches to clean libata code and better document parameters (config
and AHCI driver module parameters).

Overall, no functional changes are introduced.

Changes from v1:
 - Improved patch 4 as suggested by Hannes
 - Added Hannes'review tag

Damien Le Moal (6):
  ata: libata: Remove ATA_DFLAG_ZAC device flag
  ata: libata-scsi: Cleanup ata_scsi_offline_dev()
  ata: Fix SATA_MOBILE_LPM_POLICY description in Kconfig
  ata: libata: Improve LPM policies description
  ata: ahci: Clarify mobile_lpm_policy description
  ata: libata-eh: Move and rename ata_eh_set_lpm()

 drivers/ata/Kconfig       |  36 +++--
 drivers/ata/ahci.c        |   4 +-
 drivers/ata/libata-core.c |  13 +-
 drivers/ata/libata-eh.c   | 304 +++++++++++++++++++-------------------
 drivers/ata/libata-scsi.c |  20 ++-
 drivers/ata/libata.h      |   9 +-
 include/linux/libata.h    |  23 ++-
 7 files changed, 216 insertions(+), 193 deletions(-)

-- 
2.50.0

