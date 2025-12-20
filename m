Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515A51B0F19
	for <linux-ide@vger.kernel.org>; Sat, 20 Dec 2025 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766190373; cv=none; b=FatN2JQg7YYKbGr2UpJCw0ShKnpUxU5h8hqUiNMK+Zjr8oFWB8zUS6CKJR0vrhgQhPeJhDlOgGg/M5nDB6sbyllHCfpuVboALXhshC6iLfy2CEYEhtRU89Xd0focYzkRrR+lTuVg0K5oYA6uUEcUTY2t9TF95vzz82DH19z0sIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766190373; c=relaxed/simple;
	bh=IDk21KECJrCCTWwlq6eF3Pv0h7ShioYS2lK4THs0v24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vFRv3DuihWI1Ew7d3TnXJ0fVucIsXFwRb+pr+yF+k0ZKv2tRxqBA4Q7jq8/hotKeLOJxLCj0hIaqmOM888z2kMKS8Qtyb5uIzV6HiHYXl5YVDj9Dg/llj9qZw9HRMbHBqjNS9M9HK97g2M9LrMGEEEcJti2PD5OSqyTyFIjPDF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEVAcso4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEVAcso4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CB4C116C6;
	Sat, 20 Dec 2025 00:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766190372;
	bh=IDk21KECJrCCTWwlq6eF3Pv0h7ShioYS2lK4THs0v24=;
	h=From:To:Cc:Subject:Date:From;
	b=vEVAcso4OToR+8MlkkMcWHCMYNxNU+MJa8CMJzXo+EwgPQy8MIwtXc+4fpjI8LGbd
	 CUHAv+Ryz5Z3JT6L1OWFDafWXJawEYGPB+rRvpvX740wh74XC+Lb0easPltY0SVh30
	 3yfPAabZ/eyThp6Sli20D4cIr2Xx4XmTtGmluQF5KapSTSZqLX7QW2ViTwXl/PUnOl
	 fXq7YYMSKTYG02Dq+I4qJ+Gkf95BYEAzggA1LHf6vFnHrisQ6Gby7MkNFpqa5fkNbt
	 gutt+oeoa16G44GMx/tTDbn80A5bDUayTrVFdLw5i/GLP6p8suOxJTE1L23r1UdXH7
	 xvF5lgzBfLSeQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 0/2] Prevent non-NCQ command starvation
Date: Sat, 20 Dec 2025 09:21:38 +0900
Message-ID: <20251220002140.148854-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small patch series addresses potential command starvation issues
with non-NCQ passthrough commands issued to a device accessed through
a multi-queue libsas HBA. In such setup, a non-NCQ passthrough command
issued by an application may suffer long delays and even complete
starvation if the device is under constant NCQ read/write workload.

This issue is avoided by limiting the requeing through the block layer
and instead explicitly waiting for the device command queue to drain
before issuing the non-NCQ command. This is done reliably by not trying
to second guess ata EH in case of error or device reset, by always
requeuing a deferred command whenever EH is scheduled for the device
port.

When a non-ncq command is deferred waiting for the device queue to
drain, all new incoming commands are always requeued through the regular
busy mechanism, thus avoiding the need to manage an internal command
queue.

With this, the long latencies observed when executing non-NCQ
passthrough commands under a heavy NCQ read/write workload at high queue
depth is resolved: the non-NCQ command latency only depends on how long
it takes for all in-flight commands to complete.

Changes from v2:
 - Improved comment about ata_scsi_qc_new() behavior in patch 1
   (suggested by Garry).
 - Removed some lockdep annotations from patch 2 as they have little
   value.
 - In patch 2, change ata_scsi_requeue_deferred_qc() and
   ata_scsi_schedule_deferred_qc() to return early as suggested by
   Garry.
 - Fixed comments typo in patch 2.

Changes from v1:
 - Fixed ac leak in ata_scsi_defer() in patch 2.
 - Added Hannes review tag

Damien Le Moal (2):
  ata: libata-scsi: refactor ata_scsi_translate()
  ata: libata-scsi: avoid passthrough command starvation

 drivers/ata/libata-core.c |   1 +
 drivers/ata/libata-eh.c   |   6 ++
 drivers/ata/libata-scsi.c | 155 ++++++++++++++++++++++++++++++++------
 drivers/ata/libata.h      |   2 +
 include/linux/libata.h    |   3 +
 5 files changed, 142 insertions(+), 25 deletions(-)

-- 
2.52.0

