Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1252253FF
	for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2025 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766013700; cv=none; b=ACmTgeyRgZQrjFDy/inRcH5/C2ou8W+R5XYAcFBd4SnDBwglbCvrvm6g2GdQKMDkFuDEoD/SfHs2B2PTIDJRpDJsCBqXpNR5UHp+kIfomao7r7nQjMCeuWdTCJUBBTdWukRiVxj6mU6aU9zJIPLZesS32KT5f8d4ol31dehvHRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766013700; c=relaxed/simple;
	bh=VShaO1r5jqQMKFIsBIp0/nv19vUvwe3VD2v6waRmvXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=raXfQbC2i6MtkteNUvOdw46fc5FrTKO6J4znkuykMeWXC6JdPIFZms3GoW9tXexXiSe9zYNWfofLoCX/Mex5Zu+AyAiFhUmF6aB+GD6Vta5CWD7yhii9/Wp8R+dPZgHKHqqsJGgIteuek4XdQDsrCeKA/Gs4Bse8UVOozINptsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2qjCmn0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2qjCmn0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28E3C4CEF5;
	Wed, 17 Dec 2025 23:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766013700;
	bh=VShaO1r5jqQMKFIsBIp0/nv19vUvwe3VD2v6waRmvXE=;
	h=From:To:Cc:Subject:Date:From;
	b=B2qjCmn04Um9x4i3iC0ndOL6tCzsDlHJAfAyS35gYGt+Apsi482KGu23BV+veppJ/
	 Y22jLyxwYjVcVkv+K2RJA41u10eyC9E1Przee1y/G4QMEfuvfCn0/EaL2igk44JB1E
	 sk2VgP3LsIVkFcVttmF3saIjXOw0hTI1EcgR36aIroeZffGy7pZosVU3LIlViOMaSO
	 5X2+AA1b6ZAsUNXSsaCcnpG7sxscbFPgVoPgM3FyHBMfO7vW8uXIn5ctlRsZZ8yojB
	 ugzWPpw/X7RECgFmDQFhTxdremef32Elvv3DinwDVYACXft3MeqsBUg1A/M88KBVt8
	 z1Jv+m3rWwBIA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>
Subject: [PATCH 0/2] Prevent non-NCQ command starvation
Date: Thu, 18 Dec 2025 08:17:10 +0900
Message-ID: <20251217231712.490765-1-dlemoal@kernel.org>
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

