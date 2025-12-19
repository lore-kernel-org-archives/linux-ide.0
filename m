Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D68246BBA
	for <linux-ide@vger.kernel.org>; Fri, 19 Dec 2025 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766130963; cv=none; b=BocANYtXoIkDxsqv7dpNZ36BcuuAKWfdMbQmGLOGtFwXjv9AoU38pO8HWZ4ZZwg+ctAgwVAVtnNGidTdUpjL0DGKPcix/YK+h/KlZRr2L3HPCP/xSwe8m7scJHGiZ+HJajRUTmDFALvPTJ6f7WF7LbB29OTWrY7f1p/06hWEbD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766130963; c=relaxed/simple;
	bh=AIQk4X6JTJ2itdxzkjIxo0J1p1QI9N1upJO2vlnBsSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JjZCsoxo7zczBdpDzWMUxxs46kWtbLjrEOZgT1YsVgkHebWWOZOXLDBPrhsgggOmsGEn/10inoOlbg1Zqe4cb/+vULA8vMInDrA++exLOZCH34LN4ZkmdRV3XCNPizoCylvquNtMko+2lJw6Db6d5s0/ga5EG26W6wxv1B6PF4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgNmPJM5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgNmPJM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52078C4CEF1;
	Fri, 19 Dec 2025 07:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766130962;
	bh=AIQk4X6JTJ2itdxzkjIxo0J1p1QI9N1upJO2vlnBsSs=;
	h=From:To:Cc:Subject:Date:From;
	b=HgNmPJM5uvOpZLee/xrG4NCmaxgs56kfcsh2MUqCNVO81GaPWacwgnoAX2HxcGA+p
	 DuSiXzLJhUUj1EgGsK3Om7UbXDUiqk3f9rOwmPWfkmnqJzjWGJ0KVvTePJ7i/w/PKU
	 cG2N81Kq0LfyO20ftEm9Ywl9mn2r7m8LchU2uLepa5duq/CSkJ3JCwEtCsnRzbN62m
	 OjowSQVWM+Nd56UW1KFruLC/isMWM4j4y7T+KTOBmO+gtf1soYJ8ohZ+T20UqoFy1A
	 XTuyG43nzJA/3lA/jSIczeZcxts3zk6kYJNPJuUjpNMBemYFgIJxwmsKVl0c+sYYyv
	 z805HTOnq0sBw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>
Subject: [PATCH v2 0/2] Prevent non-NCQ command starvation
Date: Fri, 19 Dec 2025 16:51:32 +0900
Message-ID: <20251219075134.501727-1-dlemoal@kernel.org>
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

Changes from v1:
 - Fixed ac leak in ata_scsi_defer() in patch 2.
 - Added Hannes review tag

Damien Le Moal (2):
  ata: libata-scsi: refactor ata_scsi_translate()
  ata: libata-scsi: avoid passthrough command starvation

 drivers/ata/libata-core.c |   1 +
 drivers/ata/libata-eh.c   |   6 ++
 drivers/ata/libata-scsi.c | 157 ++++++++++++++++++++++++++++++++------
 drivers/ata/libata.h      |   2 +
 include/linux/libata.h    |   3 +
 5 files changed, 144 insertions(+), 25 deletions(-)

-- 
2.52.0

