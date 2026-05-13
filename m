Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67B647DD6C
	for <linux-ide@vger.kernel.org>; Wed, 13 May 2026 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685248; cv=none; b=F0qmiP5y2S7s55kZz+CByVl5Y+AlRy7rbdy/5wI4kIvqOegWmJPAQYECjwuuLVNR0OWn4uHHzo3dZcH8PXpl78+3uqOwbnykMB9RkuDQ+fimcLExk+nziEkk4jgDJMz2Ok+fmAu7G/uDYPsNVeiVL4tSNHF8uQpv6fHzSevgY44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685248; c=relaxed/simple;
	bh=z8EC+0OMMpKNhWCnLhzdFMqBpubOUN1ATs/CWHbs7e4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJgalxSzxZyj/FZRahWIudGxSkeyjE+FXcfjsAH8OHfAVRjV7bsDg3QhRv6gHQEl/EdOBBQNjjupPhys8zZKfzuUUfVhy0tdRnNSzmSu/eBMWM83IAG5CtTaBzO/S1VKjOgwEfQrTMhRh4zOP/h73dxm3I4p36qaECf64hlF8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0MwL8wO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0MwL8wO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A1AC19425;
	Wed, 13 May 2026 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778685248;
	bh=z8EC+0OMMpKNhWCnLhzdFMqBpubOUN1ATs/CWHbs7e4=;
	h=From:To:Cc:Subject:Date:From;
	b=A0MwL8wOZAZteeAs2FD0vem14M8MUiCm4jm5/ehWTMpUCEGKhacqh5RtSVVLO6qkf
	 GcV0sgTGPd2hyP/vjqsL6oRPutA47osA949IfyLlEVxUHv1BCDXrl3mfEL+KUNv0pf
	 odZmPUYdMvxp9gToxv4Wf93kLAWnZ3aO1XMFy6L53HE196ywGie7U8A9Bc88d5SGRq
	 hEPzGueZUGIpbVDDjYVA3WiZuzIadYCQL0kJJrjYkDcRXindmEu4b3J1qSp3ipZwm2
	 Jdh/L4fWJS3sR/au9Oum0sVM+e3lXnm75J4ITNjoANnBSfIswCjtR6clvwEoT1QX5i
	 B1SYfXaLpkNAg==
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH v4 0/4] ata: fix deferred QC handling for port multipliers
Date: Wed, 13 May 2026 17:13:59 +0200
Message-ID: <20260513151359.1075403-6-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846; i=cassel@kernel.org; h=from:subject; bh=z8EC+0OMMpKNhWCnLhzdFMqBpubOUN1ATs/CWHbs7e4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJYpppvPW0rdv4044X+LUYzSniucJlvKb3qvKThzIOk7 29vPZoR3VHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJuPxhZPjj3+p2oyuHa3tI Y6Itu/K6N7wxlYuzuh7t97OemjuXfwXD/xoBveygE33BV7mWa/9OqPoyqdauY8/fx8tyVwZaqR4 5zAwA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

Tommy Kelly reported a regression with PMP that use CBS:
https://lore.kernel.org/linux-ide/ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly/

It turns out that the ap->excl_link logic used for PMP that use CBS is
incompatible with the deferred qc issuing via a workqueue.
This is fixed in patch 3/4.

While looking at the code, it turns out that the deferred qc issuing via
workqueue is misdesigned. It assumed that we can't mix NCQ and non-NCQ
commands on the same port. The limitation is that you can not mix NCQ and
non-NCQ commands on the same drive. However, with a PMP with FBS, you can
issue (mixed NCQ and non-NCQ commands) to the different drives. Thus, move
the saved deferred QC from struct ata_port to struct ata_link. This is
fixed in patch 4/4.


Changes since v3:
-Use iter_mode PMP_FIRST rather than EDGE in ata_for_each_link(), such that
 the slave_link is included.
-Add patch 1/4 that is a cleanup patch.
-Add patch 2/4 that changes so that the deferred QC is only used for
 ATA_DEFER_LINK (i.e. not used for ATA_DEFER_PORT).
-Renamed ATA_DEFER_LINK_CBS to ATA_DEFER_LINK_EXCL.


Niklas Cassel (4):
  ata: libata-scsi: improve readability of ata_scsi_qc_issue()
  ata: libata-scsi: do not use the deferred QC feature for
    ATA_DEFER_PORT
  ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
  ata: libata-scsi: do not needlessly defer commands when using PMP with
    FBS

 drivers/ata/libata-core.c |  9 ++--
 drivers/ata/libata-eh.c   |  8 ++--
 drivers/ata/libata-pmp.c  | 18 +++++++-
 drivers/ata/libata-scsi.c | 89 +++++++++++++++++++++++----------------
 drivers/ata/sata_sil24.c  |  6 ++-
 include/linux/libata.h    |  7 +--
 6 files changed, 87 insertions(+), 50 deletions(-)


base-commit: 79b6e4dd96ec663ef51bb52b00e0bbbdf0ec9009
-- 
2.54.0

