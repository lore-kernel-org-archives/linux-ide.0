Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391DA17F394
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278043; cv=none; b=HN07dYHKl62N56TZSWQvsD/s8ITAntzPLRbs/HWUIROYc836rl4OSwJvAJ8nWuXX1Npg6qUksoGsHs/IpA/NJ7sI5f/2dXoCDodmc+ag1RBTCo+Z1PDxcKMLg/TPtZKoEtL23K+Tli+2dvpNLCoZMfN/WcAItHpFP+r9RmvXG1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278043; c=relaxed/simple;
	bh=iczuvAVid6K1VTQg+5QTqNcDN2JNqKERO2DGM8kXFSE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cE9GjAm+2a/3PgBXGXBI+Kgx33/RR6UvHShJJiCQiQUo17dhmeNL7GdoM42I3ldiVRciRwcTCnh/6m1Kyu7UyDrww3iWyGbbwjdwyp74W7cREzmHBoWCcmPfqWlTP8qZF3zmkHVFlqvH5iqZpJe6vnUjCduh/Tn/rhIQp51FkcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2woZe7A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2woZe7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520C0C4CEC2;
	Mon,  2 Sep 2024 11:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725278042;
	bh=iczuvAVid6K1VTQg+5QTqNcDN2JNqKERO2DGM8kXFSE=;
	h=From:To:Subject:Date:From;
	b=B2woZe7AKduGo2Tm4Uqmgp7yYVkBex01ev2qQjJVMVcow9bIOYxNHKtYp9Y+LaKi3
	 nOlGVqkELJcKggpq5DIJJIL5HEbmQAnibVUVQyNJE4yH7Ej0UOVJ1aWeyQxvFEte3I
	 MHPLkhnRBZ18LKJzfyPeEciPvpB9PzqE5Zo2HJOBmGqn88uL7cthprIA9Cqv5mWayg
	 WRHf4Zhq4Zg6vm1UtJyECjGcBRmXIa3Fo40M9IugZHFzUovlo+s1eDA+IpE3HgtXLb
	 tql0ztNNHoNHSTYzPLWQ2s2LA9OqFcj2gHk2pptA4pDi+eHPoG6cwK33ed5i0MWigo
	 lkuefFhktbHDw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 0/7] Code cleanup and memory usage reduction
Date: Mon,  2 Sep 2024 20:53:53 +0900
Message-ID: <20240902115400.166881-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 of this series cleans up libata-transport (avoid forward
declarations and improved kdoc comments).

Patch 2 introduces a small simplification/improvement of
__ata_qc_complete().

Patches 3 and 4 move code that is SATA specific from libata-core.c to
libata-sata.c, without any functional change. The benefits of this code
reorganization is a smaller libata binary size for hosts that do not
support SATA.

Patch 5 renames some functions to make it clearer what the functions do.

Finally, patch 6 and 7 reduce memory usage of libata by:
 - Moving the sector_buf buffer from struct ata_port to struct
   ata_device
 - Agregating CDL related buffers together into a new ata_cdl structure
   and referencing this new structure from struct ata_device only for
   devices that support CDL.

Changes from V2:
 - Reworked patch 1 to address Hannes' comments
 - Added Hannes' review tags

Changes from V1:
 - Reworked patch 1 to do more cleanups
 - Added patch 6. The former patch 6 of v1 is now squashed into patch 7
 - Added Niklas review tags

Damien Le Moal (7):
  ata: libata: Cleanup libata-transport
  ata: libata: Improve __ata_qc_complete()
  ata: libata: Move sata_down_spd_limit() to libata-sata.c
  ata: libata: Move sata_std_hardreset() definition to libata-sata.c
  ata: libata: Rename ata_eh_read_sense_success_ncq_log()
  ata: libata: Move sector_buf from struct ata_port to struct ata_device
  ata: libata: Improve CDL resource management

 drivers/ata/libata-core.c      | 265 +++++++++--------------------
 drivers/ata/libata-eh.c        |  10 +-
 drivers/ata/libata-pmp.c       |   3 +-
 drivers/ata/libata-sata.c      | 127 +++++++++++++-
 drivers/ata/libata-scsi.c      |   2 +-
 drivers/ata/libata-transport.c | 299 ++++++++++++++++-----------------
 drivers/ata/libata-zpodd.c     |   2 +-
 drivers/ata/libata.h           |  23 ++-
 include/linux/libata.h         |  39 +++--
 9 files changed, 407 insertions(+), 363 deletions(-)

-- 
2.46.0

