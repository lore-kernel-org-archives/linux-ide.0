Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47215FBF6
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 00:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751328979; cv=none; b=ksvlasf7XZ+p6uKIRL4h/A4inI3kwqG7i9n1hq/Vd/eJQM+LD4nT3ugkz5BRr65ij2JMlafnlvKV74T4yaDERavo0bY8MLVj/5ZaunyL5aoJJPLu0Mb9k5NECOtoWrRWe4OXNq4cRdgqIZ/KAI1ibro/LE7MU8Qk0XnTPnQqa9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751328979; c=relaxed/simple;
	bh=vdAsgwQsLA/0HOmtPjhOWcdP7ASzdg/mE1tVxiqEpNo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LYJUTYARBTbwtv0X6lofSRe4mQUOtjOrturt+gWAoLsmfrghSmVDgkw+WuxJvw0Hyb5ZpJzU/GIH59tt34TGu63HXegdfmjcBSSujxQ7A3FlE1c049pYkRFRx2QIJxnMTmyvGNQZcUi6+EcWXGXkvRKUt4c/mKw3uFbwl31Sc6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/Qj6L+J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/Qj6L+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDC2C4CEE3;
	Tue,  1 Jul 2025 00:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751328978;
	bh=vdAsgwQsLA/0HOmtPjhOWcdP7ASzdg/mE1tVxiqEpNo=;
	h=From:To:Subject:Date:From;
	b=I/Qj6L+JSJnqnKfT1ukNW8eeSBRzvB++xSqudcdg/Ljao73U96b24ELHEPO+sXEVC
	 lTF5/YIcbNGoH/G8hZMxbH68NlcZIzxuQLBwAj/sc1LvZqDAT+BOmaxoKG6cVwKDEp
	 aVDisXopVX+lZivobQyVRqdb9LdVsZoFhiMVSgxyEueXvLPjAXuqJgq9YBgGhGHDVr
	 VGCi4XlBKcJfsWHk0Hhxtpq9B1FI/qhFRKMHp/CDnxRJC++4Kle+XJT9/84Lpl0FbO
	 jX35+nwtUerigBzH3q/uMGsvde9rKxzhsazTL292mKvIeUP+HRAwio10BKhQMObC/N
	 v5Lgamkrbt+CQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 00/10] Improve link power management
Date: Tue,  1 Jul 2025 09:13:58 +0900
Message-ID: <20250701001408.330364-1-dlemoal@kernel.org>
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

 drivers/ata/ahci.c        | 15 +++++++--
 drivers/ata/libata-core.c | 70 +++++++++++++++++++++++++++++----------
 drivers/ata/libata-eh.c   | 31 ++++++++++++++++-
 drivers/ata/libata-sata.c |  5 +++
 4 files changed, 100 insertions(+), 21 deletions(-)

-- 
2.50.0

