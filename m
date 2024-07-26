Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EBAFC19
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 03:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721963996; cv=none; b=WNloQpTEkDeo85LUcVtZdXKeQGClkK6olLG5ugXCtOju33dzmdFBrsqxS6bHmKrz9pmwvFKn+pssCBFhbxbuSCcAlEK2ts2gJXZZkkg6rjrzddTaXHY9hKVQt31stZc3gS1yu4S1n82CewVJ6uCwSCvw+JsxqbVpncXL8+4zoaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721963996; c=relaxed/simple;
	bh=aP3dROZRjb33gXmM0lY43ecHyN7uI9gtC8OFdd3+tYg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=G0o6ohD/8KIGgU+9ybTCXA2upDT93Df9vFdG6YDreYm69P+czqfebKXv/FZHEeSyn3QCT2xp4BObnhF3vcaSJq2SGVfh54ltypX/+zmn9XPPxpXDuAbxQ+gJvDbzWx9pE8CTUpX7x3p9lCpYpU+zJKuAp6kjHNHIa5u/75Z5Yhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2BZXACB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2BZXACB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD494C32782;
	Fri, 26 Jul 2024 03:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721963996;
	bh=aP3dROZRjb33gXmM0lY43ecHyN7uI9gtC8OFdd3+tYg=;
	h=From:To:Subject:Date:From;
	b=B2BZXACB9YlhDphu5PBnjrwY1q9Mu3yp3EyyqLcGQpesnmS/NhwHAx0KCcKqOyU8d
	 ADuIAkzfAHomb6RN9lanlA/0vUvDL9sG884T/GJeyyUi0gFZBFlKgcYh3zhBVBFC+U
	 vl3PLjAeEqOLYRd7YFSalh9Bh6+zi5NNxE/VFhJxI+fPQlx3m+XBuSM9EpnZXH64Ei
	 J76vqg5kQ0yLVIe8EddKC2iXMAyiMu0Yma6h9BZOqcCvjU0VIDqhQgdiHA+5Zr6gpI
	 7FPJSry66zu7GbBZ8DmsZHU2SJqLNmpSis6xPY1miB9Kuc4MbuNB+fDqEYEXI21YWu
	 a4Ck2Pt38chyw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v6 0/4] Some cleanup, renaming and horkage improvements
Date: Fri, 26 Jul 2024 12:19:43 +0900
Message-ID: <20240726031954.566882-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 cleanups the function ata_dev_knobble() and patch 2 renames the
function ata_dma_blacklisted(). Patch 3 does a larger cleanup, changing
the use of the term horkage to the more common quirk term. All 3 patches
do not introduce any functional change.

Patch 4 adds printing on device scan of the quirk flags that will be
applied to the device,. This is to help with debugging any issue with
devices.

Finally, patches 5 to 11 do some additional renaming and comment
cleanups in various drivers to remove the use of the term blacklist,
replacing it with more descriptive comments and names. Of note is that
many of the "broken" device handling in these driver should probably be
moved to libata quirk handling so that any controller seeing one of the
broken device listed can get similar quirks. But it is unclear if the
quirks handled are controller specific or not.

Changes from v5:
 - Moved patch 3 as patch 1
 - Changed patch 2 to do the horkage renaming, including renaming of
   ata_dev_blacklisted(). That is now patch 3.
 - Changed patch 4 to be compatible with the changes introduced in
   patch 3.
 - Added patch 5 to 11

Changes from v4:
 - Removed the useless !! in patch 1
 - Added Igor's review tags to patch 1 and 2
 - Added patch 3
 - In patch 4, corrected comment about __ATA_HORKAGE_MAX, added missing
   newline for the horkage warning message and corrected the commit
   message.

Changes from v3:
 - Corrected the BUILD_BUG_ON() call in patch 3
 - Corrected alignment of horkage definition comments in patch 3

Changes from v2:
 - Simplified ata_dev_print_horkage() to always print the device
   revision (patch 3)
 - Simplified ata_dev_horkage() to having 2 different calls to
   ata_dev_print_horkage() and to always print the device revision
   (patch 3)
 - Added a BUILD_BUG_ON() check in patch 3 to ensure that the horkage
   flags all fit within an unsigned int.

Changes from v1:
 - Remove unused macro definition in patch 3
 - Use unsigned int for horkage flags (patch 3)

Damien Le Moal (11):
  ata: libata: Change ata_dev_knobble() to return a bool
  ata: libata: Rename ata_dma_blacklisted()
  ata: libata: Use QUIRK instead of HORKAGE
  ata: libata: Print quirks applied to devices
  ata: pata_serverworks: Do not use the term blacklist
  ata: ahci: Rephrase comment to not use the term blacklist
  ata: sata_sil: Rename sil_blacklist to sil_quirks
  ata: ata_piix: Remove useless comment in piix_init_sidpr()
  ata: pata_cs5520: Rephrase file header comment
  ata: pata_hpt366: Rename hpt_dma_blacklisted()
  ata: pata_hpt37x: Rename hpt_dma_blacklisted()

 drivers/ata/ahci.c             |   2 +-
 drivers/ata/ata_piix.c         |   1 -
 drivers/ata/libata-core.c      | 581 ++++++++++++++++++---------------
 drivers/ata/libata-sata.c      |   2 +-
 drivers/ata/libata-scsi.c      |   9 +-
 drivers/ata/libata-sff.c       |  10 +-
 drivers/ata/libata-transport.c |   6 +-
 drivers/ata/pata_cs5520.c      |   6 +-
 drivers/ata/pata_hpt366.c      |  10 +-
 drivers/ata/pata_hpt37x.c      |  10 +-
 drivers/ata/pata_it821x.c      |   4 +-
 drivers/ata/pata_serverworks.c |  16 +-
 drivers/ata/sata_sil.c         |  14 +-
 include/linux/libata.h         | 115 ++++---
 14 files changed, 446 insertions(+), 340 deletions(-)

-- 
2.45.2

