Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5833A16ABFA
	for <linux-ide@vger.kernel.org>; Fri,  5 Apr 2024 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322350; cv=none; b=opBuAneadDLJR7eMvtvnHM0jqAHz4a3ehQTz5+OIemI/ibBrnzBfGpZkO/yi/IeJ9BC0SPeUyeukpuEwPEGJfsIpkxg1VTKacJx/O/Nbh8qUQmVU2OJVIUoafrFBcmklR1uVA71KCj5RwYcTVEDrF6v368v2iDHM/GAd8hd8520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322350; c=relaxed/simple;
	bh=lxQkxDS0b2DDL5a3+vmHPq1sejT7Wp2BMYSkqKviSXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lHDZLh9eWxuhhObUAD4/NLRzN9oOKa/38RRWVhUY+rCwt2I6aaFjq9o57rtajnSuC0RifN8Xdrt9G6xLRsv70ONXaBSxMOQY0Xwd/w03+X8H83Kb0Jk7W6wUJFSVVo06oVE1mKGtQhvjoRkxJcNynOIuGCyNgYkNGUpe0dsXPP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0HFAjo9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0HFAjo9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E35CC433C7;
	Fri,  5 Apr 2024 13:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712322349;
	bh=lxQkxDS0b2DDL5a3+vmHPq1sejT7Wp2BMYSkqKviSXM=;
	h=From:To:Cc:Subject:Date:From;
	b=Z0HFAjo9moLQ6heCRGBVFpw1p3ZlnMOarenqqpmXaM3Uboghbe9tN0RV/MJN9K3kN
	 GH8KuA5qVIv7Deg4LxrnWqKFbp7oMlOYsCvSVzApfta9X4OiAFKr3UeqMOYjHjRiNd
	 dUhsxgbCxlPVrinfpzO1keT2BSm75EoC2J01AyXdwEo2y5okwIBtgqeLbzb30Z5m4i
	 XlUzPBnBza0Z0merMK/LSb2iDG2JmYHLP9B780C/PcA0wnxGqCNjxpuVSlPDRDHTkI
	 yu3tfjDSoPZXhNCkpiOsEk7eFgdCSwM6GgLUsATNmJyk42efBTd0FoBNdMJD7T4CAI
	 xPgLv/3JnVwLA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.9-rc3
Date: Fri,  5 Apr 2024 22:05:48 +0900
Message-ID: <20240405130548.1135183-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.9-rc3

for you to fetch changes up to e85006ae7430aef780cc4f0849692e266a102ec0:

  ata: sata_gemini: Check clk_enable() result (2024-04-04 12:42:00 +0900)

----------------------------------------------------------------
ata fixes for 6.9-rc3

 - Compilation warning fixes from Arnd: one in the sata_sx4 driver due
   to an incorrect calculation of the parameters passed to memcpy() and
   another one in the sata_mv driver when CONFIG_PCI is not set.

 - Drop the owner driver field assignment in the pata_macio driver. That
   is not needed as the PCI core code does that already (Krzysztof).

 - Remove an unusued field in struct st_ahci_drv_data of the ahci_st
   driver (Christophe).

 - Add a missing clock probe error check in the sata_gemini driver
   (Chen).

----------------------------------------------------------------
Arnd Bergmann (2):
      ata: sata_sx4: fix pdc20621_get_from_dimm() on 64-bit
      ata: sata_mv: Fix PCI device ID table declaration compilation warning

Chen Ni (1):
      ata: sata_gemini: Check clk_enable() result

Christophe JAILLET (1):
      ata: ahci_st: Remove an unused field in struct st_ahci_drv_data

Krzysztof Kozlowski (1):
      ata: pata_macio: drop driver owner assignment

 drivers/ata/ahci_st.c     |  1 -
 drivers/ata/pata_macio.c  |  3 ---
 drivers/ata/sata_gemini.c |  5 +++-
 drivers/ata/sata_mv.c     | 63 +++++++++++++++++++++++------------------------
 drivers/ata/sata_sx4.c    |  6 ++---
 5 files changed, 37 insertions(+), 41 deletions(-)
