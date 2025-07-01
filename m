Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B7A25B1CE
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374532; cv=none; b=Tk4Mb30ADv/SU2QHkYddHOkKDb1syjSA2n2xZBXYLdxLH4Ca4TvA23d5yPUShh5unlXlwxxcdzvkUNAxyyEqX3dZM4goG8dRI0G0oOkW/7AxPn7pjUEBjbPOFSsk0vFU/2XiFlsUQCss17CjDpE4KI2PuOn5NzVmQyJ8bAcEHoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374532; c=relaxed/simple;
	bh=o3I1/Ijk6B+sqHX+PcXdXcW7H4K8z62o+myCzPG65D4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p0d/DnZ94eDhORizw05C94illkfY+tllcFUpavbtjktuD3EwhHkW2XCzoJpgLdXKdXc2S8A1bk/LBbW62HyQ8sGlDmYVQTHRrnl6gw0EHg8SxuKxV8mtNclDanmKGacmGBgCuiQfpyMNq/ff5Kl7gKKiXwFSdn8KmJbTpiv2Das=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH/WOP5N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH/WOP5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DD4C4CEEB;
	Tue,  1 Jul 2025 12:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751374532;
	bh=o3I1/Ijk6B+sqHX+PcXdXcW7H4K8z62o+myCzPG65D4=;
	h=From:To:Subject:Date:From;
	b=fH/WOP5NtlZBPdPOEEK7RpyOKQZawBkUmqsglySWxPo00Zvb5gnafcxhys500yhJ6
	 aSU75ojwVDVFSal6c1syj0T7ioc/ZW0kW9VcIc3LrtQLx+6P/R0EgLQh7/bRqWnnSu
	 zbUAwaM7p0q0bhPPKLVrCePi6Wowd8fWsKciuZ15HIMEFfjBzbJ9ZJnvgRLxtz8F0M
	 QH3JhZ823hZj7NMkt8SyWntdNuGsOtdxM/t4EFjeCE4GsITvR8MGaOnZTOVsp25qFi
	 Lub5jsCP0scxNB1tsrRd8RHKggD0NX0McMV4G5CXeQ7yrgYHov9Ajzqz+NmhcCQ8AN
	 70WaDY9kRrnOA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 00/10] Improve link power management
Date: Tue,  1 Jul 2025 21:53:11 +0900
Message-ID: <20250701125321.69496-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series improves ATA link power management, mainly for the
AHCI driver. Follow-up patches will address libsas and AHCI platform
adapters.

These patches are a mix of code cleanup and LPM management improvements
around the application of an appropriate initial link power management
policy and preventing users or system daemons from changing a port link
power management policy through sysfs when the port or the device does
not support LPM policies or the port is an external port (and using LPM
would break the port hotplug capability).

Changes from v2:
 - Improved comments in ata_dev_config_lpm() and the commit message of
   patch 1
 - Improved commit message of patch 7
 - Added review tags

Changes from v1:
 - Improved commit message of patch 1 as suggested by Niklas.
 - Removed warning message in patch 7.
 - Changed warning message in patch 8 to be a debug message. Also fixed
   a typo in the commit message.
 - Changed message to be a single line in patch 10.

Damien Le Moal (10):
  ata: libata-core: Introduce ata_dev_config_lpm()
  ata: libata-core: Move device LPM quirk settings to ata_dev_config_lpm()
  ata: libata-core: Advertize device support for DIPM and HIPM features
  ata: libata-eh: Avoid unnecessary resets when revalidating devices
  ata: libata-sata: Disallow changing LPM state if not supported
  ata: ahci: Disable DIPM if host lacks support
  ata: ahci: Disallow LPM policy control for external ports
  ata: ahci: Disallow LPM policy control if not supported
  ata: libata-core: Reduce the number of messages signaling broken LPM
  ata: libata_eh: Add debug messages to ata_eh_link_set_lpm()

 drivers/ata/ahci.c        | 15 ++++++--
 drivers/ata/libata-core.c | 73 +++++++++++++++++++++++++++++----------
 drivers/ata/libata-eh.c   | 31 ++++++++++++++++-
 drivers/ata/libata-sata.c |  5 +++
 4 files changed, 103 insertions(+), 21 deletions(-)

-- 
2.50.0

