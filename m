Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3400E2C80
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 00:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725235246; cv=none; b=nzNvLt8Rmas3mF7Rsy+F+6qfhCuZTAmiH1RStOHy4meiDOhP+xwOlUtoO7v+8v1B5Ck/ZD6BCueY2Ke9O3VfO1plCyF473s+OgKSVgXdccyCNMzwh8Xs/W4PYE1pj1YtU1onFnq8S4q95/0ffzKD43D3ij9s1wnGImQX/Am9XcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725235246; c=relaxed/simple;
	bh=bzldXluMvXOSgBBOfakTp1rUnCEyMrRFwksdF6Irkgw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ELXMgA9cnsWoQfl8PW66zQCTVrLD03pT5d+tgXfcY9XysVNj4qonb0kDsPEbppV1lJV5rUL5gJGKv7NiA18GwYVc5/hhTrVqQeg8+VSZUjnNGgxYbRae5fF8+EokJB/Njjwzz4AO2RVGLFPSez6sblDrSlxTWjbUgNkneLPhef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCBA0sPJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCBA0sPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69257C4CEC3;
	Mon,  2 Sep 2024 00:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725235245;
	bh=bzldXluMvXOSgBBOfakTp1rUnCEyMrRFwksdF6Irkgw=;
	h=From:To:Subject:Date:From;
	b=bCBA0sPJxl0fp1keu4Lb7BXIzucE7E+92PZe08U6BJty27anKWsr/d4n5QD/sSwhS
	 OOeOoEWQqVPw8v6jGmUQtWBRXsAIge0wMxVDXyrWIcPajg7g/2AKv8sl/+1f2SFB4w
	 sWS2rsGNEyvHUI3fDIpSjYhG3YG85yDY16UTNV/GD9/198p7V8269hRGGknAwdWNPR
	 DK36VpCZu2L1IXxdu8mk8WyUV357R1qFS08uFMTpJgjNMrfjzsyW2b4H03Bm4hMgko
	 mYIKi3cyxiy4QKB7ML4DZHmHB1txW8A5mBBtuY3KAs15oOyu+rmzIJSaNa4iLiTDTZ
	 RmaPHyVNzUsTw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 0/7] Code cleanup and memory usage reduction
Date: Mon,  2 Sep 2024 09:00:36 +0900
Message-ID: <20240902000043.155495-1-dlemoal@kernel.org>
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

 drivers/ata/libata-core.c      | 265 ++++++++++---------------------
 drivers/ata/libata-eh.c        |  10 +-
 drivers/ata/libata-pmp.c       |   3 +-
 drivers/ata/libata-sata.c      | 127 ++++++++++++++-
 drivers/ata/libata-scsi.c      |   2 +-
 drivers/ata/libata-transport.c | 281 ++++++++++++++++-----------------
 drivers/ata/libata-zpodd.c     |   2 +-
 drivers/ata/libata.h           |  23 ++-
 include/linux/libata.h         |  39 +++--
 9 files changed, 397 insertions(+), 355 deletions(-)

-- 
2.46.0

