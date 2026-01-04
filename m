Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6AD3A1E63
	for <linux-ide@vger.kernel.org>; Sun,  4 Jan 2026 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767515194; cv=none; b=JFZWAjwEW9aRSrCsqwWwP6LI/FmDVDt8TQOy6YujlbW0nR+eX0KWEPnME52Ae8Ti19L91D41TzUW5YfROKYIATlabmIeKzQnwvqFvbEl8uagHyen4yXnVF8urfYzgEHCP59S0me/gIjfNtt4r1ehMB5oWueG1X976b3GxhFgsmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767515194; c=relaxed/simple;
	bh=urkofYLfxJGFKjqbCxApCPNEPOTEAfvNekZ3nuFux54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HIlmXBDDKG/3CxCripBpjrv3dRpKPZPD/h72mRI8lVaHgfSlo9JQUjMpnh5uGxiaGSVphaDwtGKOA5VHQJf3qomXUP5KXGgNmzzdpJsiwkXpcUnK7RpWwhSFkuVYY/l7gkY/AsJa259DrCGzoLAYq+oWnnxEzEHbQV9Nrmxh3D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1wN6PSw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1wN6PSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF9FC4CEF7;
	Sun,  4 Jan 2026 08:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767515194;
	bh=urkofYLfxJGFKjqbCxApCPNEPOTEAfvNekZ3nuFux54=;
	h=From:To:Cc:Subject:Date:From;
	b=f1wN6PSwNshSvlPgcJlTWNCd9RLLeTj7BT6J2zMBfDwghTwwbKp8hXBMNfrkha8i8
	 6TnEkE0zbA06S0wjq+xbSyR3S4mhnYpyPLExl12W/AwuDWKKFO74ssf7sE58J+yV/I
	 ZfeL4iRysZ6I8p4hGoC7/puC6/qGNAxQxzbBpAf2/687rvxHmMLeINUJmV5/JXE0Fa
	 VJCah+zNRNK1VOHkED7XsBn95visFkHeIcOdvk36hEfjQ2q1WjedFh0nuCkR5qC1bs
	 OL7jzmgiRUa+OhU82Wi0uajafxZO7cKwDPKa9mcCJb3fFzM7ezYT8OE1PmgjA52SLU
	 uax/VLySVqhog==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 0/2] Prevent non-NCQ command starvation
Date: Sun,  4 Jan 2026 17:22:01 +0900
Message-ID: <20260104082203.1212962-1-dlemoal@kernel.org>
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

Changes from v4:
 - Changed patch 1 refactoring to create the helper function
   ata_scsi_qc_issue() to handle both deferral and issuing of commands,
   instead of the formet ata_scsi_qc_defer(9 helper which was handling
   only command deferral. this simplifies patch 2 by avoiding needing
   modifications in ata_scsi_translate()

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
 drivers/ata/libata-scsi.c | 170 +++++++++++++++++++++++++++++++-------
 drivers/ata/libata.h      |   2 +
 include/linux/libata.h    |   3 +
 5 files changed, 155 insertions(+), 31 deletions(-)

-- 
2.52.0

