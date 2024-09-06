Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5701D554
	for <linux-ide@vger.kernel.org>; Fri,  6 Sep 2024 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725587929; cv=none; b=MYKVuAG7fkn/5DYFk9Hqig1M+Lgk3dCleXl/QXDZL7CrVvJIgvNoVKRPH0P1ovIKyEJ1spl1u+3KXg+IOioSBQX9Fzu5kwvNO/kT9o0l1M6eehlmka9/g3Cy0GTorw4CgJszquy1lbIhxJeuYCPJf5DmDaWTbWpNg0vf2AdIHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725587929; c=relaxed/simple;
	bh=wK4xJqldS5T99DIPUcVi+WX9sEraenwrZLhVsEW3N0E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L9iliIIElea9RfjbePN2QfnOtuf3zg4gjlrSlP3+6nprs2qQKy8r7EQAmrt9P6LtadUTlkiRm/cg3cDM7dqgsDq5gRrtwqspgrySQ+sWNBGKb5RdWnkm1OnAIgcPJ64mi6+H/ZA/2JmWVbzRc2PG297RKsnb1V2nYwT1hIytzHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtCicH6G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtCicH6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE38EC4CEC3;
	Fri,  6 Sep 2024 01:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725587929;
	bh=wK4xJqldS5T99DIPUcVi+WX9sEraenwrZLhVsEW3N0E=;
	h=From:To:Subject:Date:From;
	b=MtCicH6GBX0uIjsUQPzvOnDJK/eKBG1ks3fyYGFRMyjRM0hx8iuMXmgQowff8vstA
	 5JiX0DWoWqinCn7vfFv78D/Zuot1N7RU+Zd7W54bxM8FRGn79B2ZDEQ6MV2kv4nXeL
	 ixAj/okbpxREwvVcdKhcDLHoxnXlTFK8OzoKtEsgi/VGYOn5bd+Fs/qD23lBJOxnks
	 zeSe57yEP+ZHTMLwWQEnfwFfcD4n9L5z3v0VBuZ7XBqETWPVCvjz3sa8N50TZl9mkm
	 uvA+37DqCUYx2EjI+XT6JDCJ5xIHnuG4o0nNiLC8v2RIgx1sb7D0dFpz/UaNKRrw5+
	 NE0IKbwAWP7TA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 0/9] Code cleanup and memory usage reduction
Date: Fri,  6 Sep 2024 10:58:38 +0900
Message-ID: <20240906015847.229539-1-dlemoal@kernel.org>
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

Patch 2 improves device flag manipulation in
ata_scsi_handle_link_detach().

Patch 3 introduces a small simplification/improvement of
__ata_qc_complete().

Patches 4 and 5 move code that is SATA specific from libata-core.c to
libata-sata.c, without any functional change. The benefits of this code
reorganization is a smaller libata binary size for hosts that do not
support SATA.

Patch 6 renames some functions to make it clearer what the functions do.

Finally, patch 7 to 9 reduce memory usage of libata by:
 - Moving the sector_buf buffer from struct ata_port to struct
   ata_device
 - Agregating CDL related buffers together into a new ata_cdl structure
   and referencing this new structure from struct ata_device only for
   devices that support CDL.

Changes from V4:
 - Added patch 2 and 8
 - Modified patch 9 to use the ata_dev_free_resources() function
   introduced in patch 8.

Changes from V3:
 - Small change to struct ata_cdl kzalloc() call as suggested by Niklas
 - Removed bogus call to ata_dev_cleanup_cdl_resources() in patch 7
 - Added review tags

Changes from V2:
 - Reworked patch 1 to address Hannes' comments
 - Added Hannes' review tags

Changes from V1:
 - Reworked patch 1 to do more cleanups
 - Added patch 6. The former patch 6 of v1 is now squashed into patch 7
 - Added Niklas review tags

Damien Le Moal (9):
  ata: libata: Cleanup libata-transport
  ata: libata-scsi: Improve ata_scsi_handle_link_detach()
  ata: libata: Improve __ata_qc_complete()
  ata: libata: Move sata_down_spd_limit() to libata-sata.c
  ata: libata: Move sata_std_hardreset() definition to libata-sata.c
  ata: libata: Rename ata_eh_read_sense_success_ncq_log()
  ata: libata: Move sector_buf from struct ata_port to struct ata_device
  ata: libata: Introduce ata_dev_free_resources
  ata: libata: Improve CDL resource management

 drivers/ata/libata-core.c      | 278 ++++++++++--------------------
 drivers/ata/libata-eh.c        |  13 +-
 drivers/ata/libata-pmp.c       |   3 +-
 drivers/ata/libata-sata.c      | 127 +++++++++++++-
 drivers/ata/libata-scsi.c      |  11 +-
 drivers/ata/libata-transport.c | 299 ++++++++++++++++-----------------
 drivers/ata/libata-zpodd.c     |   2 +-
 drivers/ata/libata.h           |  24 ++-
 include/linux/libata.h         |  39 +++--
 9 files changed, 419 insertions(+), 377 deletions(-)

-- 
2.46.0

