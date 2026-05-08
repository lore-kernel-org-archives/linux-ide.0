Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3914C34DB4A
	for <linux-ide@vger.kernel.org>; Fri,  8 May 2026 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778269870; cv=none; b=GNMIeeN5zYgPJ2OZWS9g3e42ZsFmy2Sg36i06dNc/Zrbnz/rqV8ieZU/PK73fBYUvmV5ZUAg2554/mqQmcdKi6EWnTtUvqNnnNP2Ku3MvCL84puO3IK7kkCkj2aIKx8lzwNbsXHECOTfbjZCdNZdR232q1+cznUxM85xYX/SxSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778269870; c=relaxed/simple;
	bh=rYsTj0M1yvVHhMG8UlQsWNxYUfAz08kCQBbBRkaHjfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MaYCI85Jbl11ywY4/6EXmtxrfnyv9Rx7L58qEu7CSIIb2JCkyULSgR3Tk7bT9l+d12Jr2dfWoo4dg4r8LftpxEG/WJ9eHp3LgaGc7TjjSxvwAewBGRWVTW9MSUWneTH0/SYKHQMLN6UxMXbVGEoenycMs788bnNgQRO7RpPGgMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxYfdv3B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxYfdv3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AFDC2BCB0;
	Fri,  8 May 2026 19:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778269870;
	bh=rYsTj0M1yvVHhMG8UlQsWNxYUfAz08kCQBbBRkaHjfg=;
	h=From:To:Cc:Subject:Date:From;
	b=TxYfdv3BIwqC52E/B5q1Z3FGds0JeGDdZSdVvPvwBpC9Vu57eIXg679LbvqhrXiAj
	 Vq9GRJg2taSt0vYA+7xgpj/V0pKvfQaywN5IITFzf91tOGrW+HC4YP3U2amlLxjIOt
	 IiZby+yIirCZXD2OkVOFmZEPUdR9blYbvCuSaSLUfRtNc6bV2Rz2vTqj2zl6PJ/6Ul
	 HqEbpjdSnuQgfGEEuVGyCBlsDXLekej+ddjkijgNu/On7r38GYyC24Bk0DVuqtoLKd
	 XyEaOSXG/fNSZ8WY23TJjXOZwsbiSSVIGqGdCwjH3d4OG17EFlH+MgYLTZNCMF1ZBr
	 dyzc79rCKzqfw==
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH v3 0/2] ata: fix deferred QC handling for port multipliers
Date: Fri,  8 May 2026 21:50:51 +0200
Message-ID: <20260508195051.188207-4-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1492; i=cassel@kernel.org; h=from:subject; bh=rYsTj0M1yvVHhMG8UlQsWNxYUfAz08kCQBbBRkaHjfg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDL/2c1e2V9QrMYdu+LPj6I4rd4m3xNdz5MFdL48PnTrw sbtW3zud5SyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiumcZ/kpunhR7s9nq4Ckl LZWkvGnWZ+7MudG5+86ZHaEH7Zg2LZVhZLicxhN+7Emybfvf5pl7WloVuU0EzKxnXcl6Xbj40PS ApewA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

Tommy Kelly reported a regression with PMP that use CBS:
https://lore.kernel.org/linux-ide/ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly/

It turns out that the ap->excl_link logic used for PMP that use CBS is
incompatible with the deferred qc issuing via a workqueue.
This is fixed in patch 1/2.

While looking at the code, it turns out that the deferred qc issuing via
workqueue is misdesigned. It assumed that we can't mix NCQ and non-NCQ
commands on the same port. The limitation is that you can not mix NCQ and
non-NCQ commands on the same drive. However, with a PMP with FBS, you can
issue (mixed NCQ and non-NCQ commands) to the different drives. Thus, move
the saved deferred QC from struct ata_port to struct ata_link. This is
fixed in patch 2/2.


Changes since v1:
-Avoid a local variable in sata_pmp_qc_defer_cmd_switch(), call
 ata_std_qc_defer(qc) inside the switch() directly instead.
-Fix a typo, such that the the code actually compiles... Sorry for that.


Niklas Cassel (2):
  ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
  ata: libata-scsi: do not needlessly defer commands when using PMP with
    FBS

 drivers/ata/libata-core.c | 16 ++++---
 drivers/ata/libata-eh.c   |  8 ++--
 drivers/ata/libata-pmp.c  | 26 +++++++++--
 drivers/ata/libata-scsi.c | 95 ++++++++++++++++++++++++---------------
 include/linux/libata.h    |  8 ++--
 5 files changed, 101 insertions(+), 52 deletions(-)

-- 
2.54.0

