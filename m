Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ACB32ED34
	for <linux-ide@vger.kernel.org>; Wed,  1 Jul 2026 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946019; cv=none; b=fSdeHwU+zg890v+rvx6Z4/oXCkKACKZwbsQOqGph6URawWB9Rws+Cg/NQspKa6RYNK9x2a2/zcIMBZgA/4P6sZR5zMrX1ImBttyGk/ozxx8l3/0rdzy64VRZMbYqm0Q5Wxx1NL7F095uIX3F8SOp1TZDywSmwLz+c5QRpWaVTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946019; c=relaxed/simple;
	bh=AnBqWlJ+zWccp7JNWTgeVMhF3JTqg22sklDssKyoiuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J2cEj2Ke51t4L3CanJ9gn5DSGboq7e4piLr1/7Wf0Hum1uV3zPHN+EHuqZb2QwZglxl937i01Ps4IqfVNfZ0M3UOSCHkaARxAPvBkU2vLZV2P04E25kKJ5ANg5fbH3SOzTlxoGh1ysSdJxqm3+rJa2cfuBCZtBB+0Crp6f3t7qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsJCE6bX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsJCE6bX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D09C1F000E9;
	Wed,  1 Jul 2026 22:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782946017;
	bh=tmj9waaiEEtF0G1Orj1XHEYjS1A2yvVEELunrFyP46E=;
	h=From:To:Cc:Subject:Date;
	b=nsJCE6bXA9ZKwDnT6HgLbGeFKCXb6WborZQOBm1NNFvJ05Ui6qS2uw/O4tNG3mmsm
	 qUczw35t+FRLeIObdHJAO5ivualgp1gAPSLRIGxFFNg6sTmOLlilsu0fsGXPtW7o/K
	 /zmCgLTZnfyNFQrSqV20kV9nkN60Y5n1T/r7bt994/XckM9E1iLv0KUUoi5wwVCfxp
	 yGTjZb0o8w63iXZ9OHTet9Lur5w4Wy1iYuywB+3AOqJGIu1K+dTNCUMW1TdMZBtqUC
	 l0buwtLCT3slo+VJwgH7XAtqCiZw9GSYZlEJGO40Pr0ME+RGlY9nYCC3OiF2Jpu5bW
	 gZ863YrVvKqXQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Shaun Tancheff <shaun@tancheff.com>,
	Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH 0/2] ata: DSM TRIM fix and improvements
Date: Thu,  2 Jul 2026 00:46:39 +0200
Message-ID: <20260701224638.1835123-4-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503; i=cassel@kernel.org; h=from:subject; bh=AnBqWlJ+zWccp7JNWTgeVMhF3JTqg22sklDssKyoiuk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJcZ5zjZms+rvfshWz/j7CzuoavQp0FJ8xWUDjuf9Vfa dt+zSijjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEykLYrhN0vaoePmrmJqi54e Tn/fO0/+2bcXR7RlE+t7Hms9uO7h/IzhN0vK9V/zu6T12E2SGU402RRUHZR/bhkSyvQq1/x1j1w iCwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

This fixes DSM TRIM for 4Kn devices, which has ironically been broken
since commit ef2d7392c4ec ("libata: SCT Write Same / DSM Trim"), which
claimed to correct the DSM TRIM handling for 4Kn devices.


The first commit is a small fix that can be backported, which limits
the DSM TRIM to what we currently report in the Block Limits VPD page.
We currently report a single 512 byte page of entries, i.e. 64 Entries,
where each entry has a maximum of U16_MAX logical blocks.

The second commit:
-Improves the support by reading the MAX PAGES PER DSM COMMAND limit and
 populates the Block Limits VPD page accordingly.
-Modifies ata_scsi_write_same_xlat() to properly support up to this amount
 of pages.
-Removed the intermediate copying to ata_scsi_rbuf, writes to the scsi
 buffer directly.

Practically, sd still caps n_block at SD_MAX_WS16_BLOCKS
(~3 pages actually used on 4Kn), so while removing the limit on
ATA_SCSI_RBUF_SIZE (2048) - i.e. 4 pages), we will still be limited
by SD_MAX_WS16_BLOCKS. The main improvement is not longer taking the
ata_scsi_rbuf_lock and doing and extra copy from ata_scsi_rbuf.


Niklas Cassel (2):
  ata: libata-scsi: fix DSM TRIM for sector sizes larger than 2048 bytes
  ata: libata-scsi: scale DSM TRIM payload by MAX PAGES PER DSM COMMAND

 drivers/ata/libata-scsi.c | 134 ++++++++++++++++++++++++++------------
 include/linux/ata.h       |  13 ++++
 2 files changed, 105 insertions(+), 42 deletions(-)

-- 
2.54.0

