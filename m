Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50233397E64
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778744348; cv=none; b=m3RMjMH+b2dPmY3IHfZgDxhNRT5n122ylkQruRQkACEsxgJpsYHmcHQ84fzfQr9EzSGeH8lwHWsOiOxH32Q7ANWNGqoB8vSAh4NRl45W+yBRAjYvVMWQAZbQfHc2LUVqZhnwEqB1l35TnjZCM1VZyREuJNZFV9jQdY4a5bx8wC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778744348; c=relaxed/simple;
	bh=ykhJTdX3ao0AwDkXE2+3pEu7hCe1+FzvAglRuhDRf4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RN4i8Pt/QmcUCuZx/dGDPX8y0fCX+JLmNWYeY+mHfggYAKgJDu2WmnJUdYK53O5uFgEuuG9Ir7fUGeSthZVSzvCCTT64neJZz9e+Dd736TmF7G4TEDgA8S1aQec/mFwGodBWC9sKI8wh51MbqFqcA4w5Q9ujPsRyFizwUnnoMm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEUeV3Ok; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEUeV3Ok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E020C2BCB7;
	Thu, 14 May 2026 07:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778744347;
	bh=ykhJTdX3ao0AwDkXE2+3pEu7hCe1+FzvAglRuhDRf4o=;
	h=From:To:Cc:Subject:Date:From;
	b=cEUeV3Okj9e227xr2475AKCEcV+sn6fHolfAlotMshAbLNXfARVyk1Nap3LwysDbU
	 WZFABoTqkZZWerTMygesfOuIuWrha91LwCmwd5mbRtcNCom8XS20oeUbGCQX0m0NW1
	 CeYrmrrdpokNZM322ap4KrcwUzONkr0NnSac+++578kpWN9G6ydGfLheDXlN1Hs8cn
	 RahW8IXr8ZKwHisBcIjq2rj2lIr2XQMAxN9Oz5tEuuCG8FIfPFmo3igymjxhU8NBsY
	 QyF/oPQxmARhPzqV2XyO9renb5l1TWfoR9IxFS8FTNcWYx54i+D9v5IrINe/FLzwbg
	 IkQmB44Vl30XQ==
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH v5 0/4] ata: fix deferred QC handling for port multipliers
Date: Thu, 14 May 2026 09:38:58 +0200
Message-ID: <20260514073858.1175072-6-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714; i=cassel@kernel.org; h=from:subject; bh=ykhJTdX3ao0AwDkXE2+3pEu7hCe1+FzvAglRuhDRf4o=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJYa4RWn2Dn+rr/40pFvxyrSc8NXnLUZxteKGNbVr3w2 b7Zm2yvdJSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiH04z/HdydNj65UWk/y8O P9Wkhs/sM3aurF4U/MU2/f6yl63KVWYM/ytOz106Xd9O9+/kyUlPzv9wdF+s1Tvps9OU7h2z/Db Up7ICAA==
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


Changes since v4:
-Fix ATA_DEFER_LINK_EXCL to use the correct goto label. While refactoring,
 I accidentally used the wrong label goto defer_qc instead of goto free_qc,
 which of course broke PMP CBS in v4.


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


base-commit: 0926c1b731b73e7296e4ad4f7d055918e16ae6ab
-- 
2.54.0

