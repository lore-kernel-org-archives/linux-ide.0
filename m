Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B9E1F4E57
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264928; cv=none; b=J0e3WfvvvrUUo8OB7CDLY99+Gkuby5CdQiCtyHaBprARak0fyMENUhJ7LzWYx/32jTiGQ5ACzWwFUsyz+nG+YV87JOmAPR9sgR6xr1nUnYccPcqQ2ARmVzvTVwhpB2744gN5D99kU5cxkoHKAHKT7MBYJAbmEVIsTgQVDZO2eNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264928; c=relaxed/simple;
	bh=3HhXg2lkxPYwq2aw9+C9avCrjdbvQEu49yFHB792eGs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=APdjIrdTdO0ByIrtXVMp9xeelLubx3qKIhwEvEelxSouLPpGPmfsDLoNqecRNG3iTqJUK7/NMmRrObY/lyjVshjDBiq9LZvJHu2LydZTnWb6CQKytZcAXN4O+Y74D/VRFyZ73sWp1ppX1TpTdQCJLr+bh8bZZjSO2kGvYJ261XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNw/5Rxm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNw/5Rxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC3CC4CEEF;
	Mon, 30 Jun 2025 06:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751264927;
	bh=3HhXg2lkxPYwq2aw9+C9avCrjdbvQEu49yFHB792eGs=;
	h=From:To:Subject:Date:From;
	b=BNw/5Rxm/OutVA9VJ7TG7k6eXqik4xchny6uOOcjFrIVX8lS62NJkuRcRxRweqelk
	 HIDGx7d+bTHjGeDf8QE5Uzv8qOJ+967Myxn2MtyqhmbcJ2FboQ2Chbi2cY581zFFoW
	 YRx8ScfguzYq1hfMIqeGDWFHhf9TPF/cGNlpl1z1v11a/mtUsQns+tzj4cG/ATsKSL
	 +gnfpIMwy6Bqdvnt6MR1yI7qQm7NjncoedZnhX2d72UCMuzSU1vG6ShtFeQTpv6olP
	 T8JzdSAcy6XGK7MUYJLiV4yb4zZazXh6Dvot28lq/NJzr8atC49kF8IT0eiJ5Q7yMX
	 fF/2AVHy3HQxw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 00/10] Improve link power management
Date: Mon, 30 Jun 2025 15:26:27 +0900
Message-ID: <20250630062637.258329-1-dlemoal@kernel.org>
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

 drivers/ata/ahci.c        | 16 +++++++--
 drivers/ata/libata-core.c | 70 +++++++++++++++++++++++++++++----------
 drivers/ata/libata-eh.c   | 32 +++++++++++++++++-
 drivers/ata/libata-sata.c |  5 +++
 4 files changed, 102 insertions(+), 21 deletions(-)

-- 
2.50.0

