Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96072186A
	for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706598; cv=none; b=QG0PXXmUph1+edHG9qTZEDwzbBEtGlpeX0SE8Lp9eF6McuJOGMgFdzwh3pmyFuPSRVzT6KTmytlZbw7A+38Vp2yv7FaOngOofu4/vT/dyptuugJPMbUyhadRSmCxVAaDvzrlGoQDls1/cs13so66LuKrC1LEpxfDOJW3R9VSiGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706598; c=relaxed/simple;
	bh=CpNo77ckprgmf9oC/l5pY69qBusCpUSku9e8wVcFnY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HW1Fej1CTm7UoDt9LW2AYXNUPftPgzZbyObRhJ5klFqBWfjuDgT3+PcjH97rtNQo52vEUbYjb05repjijY1hlxgGcieEX2UV03VFsILFHGNkIyi88r+/caxl2DmVMjuAzrJiHcftLFUf8tuAGuEvjGE2Mg8vv4KRsu/RMYiwN/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHX8jwPK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHX8jwPK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571B5C433F1;
	Fri, 23 Feb 2024 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708706598;
	bh=CpNo77ckprgmf9oC/l5pY69qBusCpUSku9e8wVcFnY8=;
	h=From:To:Cc:Subject:Date:From;
	b=FHX8jwPKTfoSVFqobiv8awb9g6jOBeOBRsUVeLdV0vxEfXkxXedVTJ2hMTjmiR/22
	 KrxzYDiw8vUQLAlBvxW0jk+urVu6NW9KeoIC9eTAfw8CJIZ3r3bCn1ItnMzMIDBB1B
	 hsf9eWcfPOQDdwpJFUg3g5IZ909dFGQp9HYy1Mn9X8aq9P6lSl3Xr7C5rf0IDiu6tR
	 6/i2eOTwpyGMsUIFl4s940Cthq7+6NEiP06mhBEz698XKjqd8AVdCZ2ZEnYNJZc1/Q
	 oLFFFkGusfdI8lLH97rH4v8GWf+YHaxQKuUu8wESN2nFdg2NsBdwz/WOvkuK4QYGyF
	 Yi7yf5J+gYEXg==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.8-rc6
Date: Fri, 23 Feb 2024 17:43:02 +0100
Message-ID: <20240223164302.193697-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 51af8f255bdaca6d501afc0d085b808f67b44d91:

  ahci: Extend ASM1061 43-bit DMA address quirk to other ASM106x parts (2024-01-31 12:09:34 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.8-rc6

for you to fetch changes up to 9cec467d0502b24660f413a0e8fc782903b46d5b:

  ata: libata-core: Do not call ata_dev_power_set_standby() twice (2024-02-21 19:09:17 +0100)

----------------------------------------------------------------
ata changes for 6.8-rc6

 - Do not try to set a sleeping device to standby. Sleep is a deeper
   sleep state than standby, and needs a reset to wake up the drive.
   A system resume will reset the port. Sending a command other than
   reset to a sleeping device is not wise, as the command will timeout.
   (Damien Le Moal)

 - Do not try to put a device to standby twice during system shutdown.
   ata_dev_power_set_standby() is currently called twice during
   shutdown, once after the scsi device is removed, and another when
   ata_pci_shutdown_one() executes. Modify ata_dev_power_set_standby()
   to do nothing if the device is already in standby. (Damien Le Moal)

 - Add a quirk for ASM1064 to fixup the number of implemented ports.
   We probe all ports that the hardware reports to be implemented.
   Probing ports that are not implemented causes significantly increased
   boot time. (Andrey Jr. Melnikov)

 - Fix error handling for the ahci_ceva driver.
   Ensure that the ahci_ceva driver does a proper cleanup of its
   resources in the error path. (Radhey Shyam Pandey)

----------------------------------------------------------------
Andrey Jr. Melnikov (1):
      ahci: asm1064: correct count of reported ports

Damien Le Moal (2):
      ata: libata-core: Do not try to set sleeping devices to standby
      ata: libata-core: Do not call ata_dev_power_set_standby() twice

Radhey Shyam Pandey (1):
      ata: ahci_ceva: fix error handling for Xilinx GT PHY support

 drivers/ata/ahci.c        |  14 ++++--
 drivers/ata/ahci_ceva.c   | 125 +++++++++++++++++++++++++++++-----------------
 drivers/ata/libata-core.c |  59 ++++++++++++----------
 3 files changed, 122 insertions(+), 76 deletions(-)
