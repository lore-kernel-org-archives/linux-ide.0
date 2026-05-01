Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0377D3A5420
	for <linux-ide@vger.kernel.org>; Fri,  1 May 2026 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777640058; cv=none; b=TvEroaUhSjUfA82volUm0VAaR3s16dac6teWeiyq2Kfyq/nR4+iazpA2kbZ9a2h+q0q/04hNEVd3buJiS/iIQqx1sXHDzFnkjmMx3Oyd9oB8ObHheBQIqHvKRl4TEyrZut4/RUvxVKzgoX6mRq3oWOEsflq5guB5glDbWinfY74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777640058; c=relaxed/simple;
	bh=tRhne4xZO4vowxLhLEkRdR05M8fXX8vWoXpX2TXIvhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uj5QpsgOvIIi6LkzDx5KkYzUItmBVuFCreu6ejkrcVeKx9VzELyq6Qy1L/oTtmdQK3bpbRvYsSlDmNb10n33PY5ZPGNjhbYU3cV9qvPrQhPGYqUeXY4dZVCvlyo8ndvdW1GTYCGLHhL7kPpcHF+gM/DbNFhz7uRB2mXlpwDVxSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiy3OFNy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiy3OFNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27C8C2BCB4;
	Fri,  1 May 2026 12:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777640057;
	bh=tRhne4xZO4vowxLhLEkRdR05M8fXX8vWoXpX2TXIvhA=;
	h=From:To:Cc:Subject:Date:From;
	b=aiy3OFNyE91j7eSe1LZXV6sGf6LwpI1L4uqj4qn7weEknaGHNu8Quh0ywdbUOk/3s
	 4fV2YdFzO8ZFic9fug9S83G76yc9Rzko2Slclin69NQ5FoDecpXoe9Sz2orsi194M8
	 6vtFDW2XRrffLZSOD9J5n/zmZev0vd7n4k/BQZHZS6vOtVqrJZ+Td1rHJBlCk9BWNw
	 ctwApai3jLFukIaSXBeyj98Dh72o4VjSXLYEo9VGm1aTUdmyl3cZXPwDMH5gi8TI12
	 ENzzA0xelQ4Uy/k7N4utmjJkPqlXHHp1EmyMGhOpiBWClsRY4BAk5YvHDCdlhmBA5A
	 xb5lgUcaZLfyg==
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Tejun Heo <htejun@gmail.com>,
	Jeff Garzik <jeff@garzik.org>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH 0/3] ata: fix deferred QC handling for port multipliers
Date: Fri,  1 May 2026 14:54:10 +0200
Message-ID: <20260501125410.1204490-5-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; i=cassel@kernel.org; h=from:subject; bh=tRhne4xZO4vowxLhLEkRdR05M8fXX8vWoXpX2TXIvhA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDK/LCpKjiro7W/XVT6y9O7SR+tV43YcvpQ/9+q2XNvIX cmBN663d5SyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiqnUM/z1MRIxaN1tO+f3Y 5IuWxtlNWTZ3O6cyTin9J6laeNNcYSXD/9Irekw1ce8N5vBMmvDyG1N153YhntTlljV2L/5wfbB 6xgsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

Tommy Kelly reported a regression with PMP that use CBS:
https://lore.kernel.org/linux-ide/ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly/

To me, this appears to be a problem in ata_pmp_qc_defer_cmd_switch() that
has been there since this function was introduced. ap->excl_link did not
always get set. This is fixed in patch 1/3.

While looking at the code, when using a PMP with CBS, it turns out that we
are incorrectly using the deferred_qc feature that issues a QC via a
workqueue, even for non-NCQ commands that are issued to another link
(a link that is not the active link). This workqueue feature was meant to
avoid dealing with non-NCQ vs NCQ commands for a single drive, not to
duplicate the existing ap->excl_link logic. This is fixed in patch 2/3.

While looking at the code, it turns out that the deferred qc issuing via
workqueue is misdesigned. It assumed that we can't mix NCQ and non-NCQ
commands on the same port. The limitation is that you can not mix NCQ and
non-NCQ commands on the same drive. However, with a PMP with FBS, you can
issue (mixed NCQ and non-NCQ commands) to the different drives. Thus, move
the saved deferred QC from struct ata_port to struct ata_link. This is
fixed in patch 3/3.

Tommy, it would be nice if you could apply this series and see if it solves
your problem. Right now the series is compile tested only.


Niklas Cassel (3):
  ata: libata-pmp: fix ata_pmp_qc_defer_cmd_switch()
  ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
  ata: libata-scsi: do not needlessly defer commands when using PMP with
    FBS

 drivers/ata/libata-core.c | 16 +++++++---
 drivers/ata/libata-eh.c   |  8 ++---
 drivers/ata/libata-pmp.c  | 13 +++++---
 drivers/ata/libata-scsi.c | 66 ++++++++++++++++++++++-----------------
 include/linux/libata.h    |  6 ++--
 5 files changed, 64 insertions(+), 45 deletions(-)

-- 
2.54.0

