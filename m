Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF372C0268
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986686; cv=none; b=unDKqwdSBSOCbLKlykHOMRlsrimsEYh6PS94LdgVXQ2SNjN3wTNR2Gs1GL9tQxPhNW6e8P7u9Ma3vnvBNamK2wygiV/dkEb1aTquQr9T4IGZdjPYXFE1cb6+Ky/XsrQF9xVzJqR4aTy/R254gQO0/tbdcyKTTBmNGyd1U/GRU/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986686; c=relaxed/simple;
	bh=a3KOmGKZKIh5ppXhcQ6fg69FJruvTmuGshkjUAlNQ9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aavhsojcd934BGjl8OKAN1Avqo0Jc41m6/49zbIN+L1iK0jQBiOpoGPRm4gWGblrFQPvOsS4lsA5916n+jfZU/yoP4nlbY/pQX7l6a6vE/vKsA8NYpdD8RmcoiwSA48h1+H8Qk2QImWlz1DIhAT3IF8JM75aAUQH0z7GFQEeIlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfLYvJh3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfLYvJh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4946F1F00A3A;
	Thu,  2 Jul 2026 10:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782986685;
	bh=xdXlBHVq98ajCo6NO10FXhMr/Zevs8WTqlSzJx0FJ9s=;
	h=From:To:Cc:Subject:Date;
	b=CfLYvJh3ISB9nagc0BQ/Ora7CbndXjaggDSdnnv2k3n5mMxLYPbg7Ob/AEuC0AUte
	 SG6UkV6tzYr8j0EbRvpA4VRZofMqxjhgSXpo5avashwduSWywmUzkLMwgVynYubRTX
	 JBWM0TWGmXrjlSrpcBXq6Jflgm8WdZTbRtQ38nAjLJ6iqzJtjx47MSf1fIhX9X/CbL
	 9SUU1Qu5N9tD8OVA0n3j1rAsYnmD+H0pw4yX8gfWppW3SrWYST3KLH7L99UebpLOuV
	 dNjbdZa4zhlKQr9fJUPVphH7wqEFwLwxoRwJv8qat17zlgEtp4QCWinYiVaypa2Qdr
	 vvr1a7wrQByqA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Shaun Tancheff <shaun@tancheff.com>,
	Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH v2 0/2] ata: DSM TRIM fix and improvements
Date: Thu,  2 Jul 2026 12:04:11 +0200
Message-ID: <20260702100410.2039383-4-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1711; i=cassel@kernel.org; h=from:subject; bh=a3KOmGKZKIh5ppXhcQ6fg69FJruvTmuGshkjUAlNQ9E=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLLczGdNFLd8z1lu5mMjncijk+ekMXX3h635Z2uPPRYK5 WdRPmLVUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgIlw32Nk2ObC6JBx8vsO2wMV V8ISbq4pzpPoWvv3amXd5x97p24xW8Hwz5r7EfOj3PvtOREZ7Q13ExltZgu+5NKy/nHkjtqm36x 6HAA=
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


Changes since v1:
-Picked up tags from Hannes.
-Cast to u64 to avoid potential overflow when using 32-bit arithmetic.
-If no limit is reported, assume that only a single 512-byte page is
 supported.


Niklas Cassel (2):
  ata: libata-scsi: fix DSM TRIM for sector sizes larger than 2048 bytes
  ata: libata-scsi: scale DSM TRIM payload by MAX PAGES PER DSM COMMAND

 drivers/ata/libata-scsi.c | 137 ++++++++++++++++++++++++++------------
 include/linux/ata.h       |  13 ++++
 2 files changed, 108 insertions(+), 42 deletions(-)

-- 
2.55.0

