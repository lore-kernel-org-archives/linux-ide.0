Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B40229408
	for <linux-ide@vger.kernel.org>; Fri,  2 Jan 2026 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767318004; cv=none; b=C+PAo5xTScdvJcR0qr2i5YUjDRB3JuQxyiyludk3KvgU2vu+k/aSfnHZyC/qYTbQU+Eqj2LMyPl8aVv9X4m3du0kOTqsRc7wjebkoaOhZc+F7rWLaThaSfCd7j6xBSXLmMkflCD++qbDCQF6ToDvS7pq799yM5fXZTh16sM9RzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767318004; c=relaxed/simple;
	bh=kL8irZwoYsP+FPh4AvTPCZm8Z30+KfYp1cMxOpQV9N8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1KmKjO2hA1QC7o+zsdL5JG46FPQ6VCA/Q7C6I50BlObA+H98Ou5IygMwqHLvO2wutNebi4/PbVCKBA3ALBJAC5FbHQ0FZgqB/quZF1+KnASeqn58rEn7VaVa34fiVyoCEd26vR/AfnJG2qleHNboYOGfta4uktKfk0k0sraRQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGgvLQsi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGgvLQsi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D78C4CEF7;
	Fri,  2 Jan 2026 01:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767318004;
	bh=kL8irZwoYsP+FPh4AvTPCZm8Z30+KfYp1cMxOpQV9N8=;
	h=From:To:Cc:Subject:Date:From;
	b=SGgvLQsiycpGfYMeFd24uEWvbhfSNf3QNlCGCJRZBQjFKoDSrIIL7g0pKWAIujTS4
	 GUM3Qpv+tU71V+WSl0NetJ1NTMs7Wshz0/hbE7tJwsRGzeo/IEWha2zJjm6o1752PB
	 MAvQKlqzPwrHvj4YzhQRYJ6NqAii8E+qBzskyg6mgrMSRhd13uH3DrNnsXAedJGsuo
	 8EfyvBKmvlmjniEa1Fjalg2G1XNYNReA8m/bajq+voBNNzEemliaFEfc/BwfwKrypa
	 sAC4kbKgJAiTv2luPnvMGWzeNCOevftRdeFui/HG5nGs8t/MZ/0mGCHUwI83LhzdJ0
	 Q1E+TE+J9Ms/Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 0/2] Prevent non-NCQ command starvation
Date: Fri,  2 Jan 2026 10:35:31 +0900
Message-ID: <20260102013533.1131768-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small patch series addresses potential command starvation issues
with non-NCQ commands issued to a device accessed through a multi-queue
libsas HBA. In such setup, a non-NCQ command issued to a device may
suffer long delays and even complete starvation if the device is under
a constant workload of NCQ commands issued from multiple queues.

This issue is avoided by limiting requeing request through the block
layer and instead explicitly waiting for the device command queue to
drain before issuing the non-NCQ command. This is done reliably by not
trying to second guess ata EH in case of error or device reset, by
always requeuing a deferred command whenever EH is scheduled for the
device port.

When a non-ncq command is deferred waiting for the device queue to
drain, all new incoming commands are always requeued through the regular
busy mechanism, thus avoiding the need to manage an internal command
queue.

With this, the long latencies observed when executing non-NCQ commands
under a heavy workload of NCQ commands at high queue depth is resolved:
the non-NCQ command latency only depends on how long it takes for all
in-flight NCQ commands to complete.

Changes from v3:
 - Added review and test tags
 - Improved patch 2 commit message
 - Added a comment in ata_scsi_translate() to clarify the handling of
   ata_scsi_defer() return value.

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
  ata: libata-scsi: avoid Non-NCQ command starvation

 drivers/ata/libata-core.c |   5 ++
 drivers/ata/libata-eh.c   |   6 ++
 drivers/ata/libata-scsi.c | 163 ++++++++++++++++++++++++++++++++------
 drivers/ata/libata.h      |   2 +
 include/linux/libata.h    |   3 +
 5 files changed, 154 insertions(+), 25 deletions(-)

-- 
2.52.0

