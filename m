Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B4274649
	for <linux-ide@vger.kernel.org>; Fri, 29 Aug 2025 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454742; cv=none; b=f6Nvfhd1xDYFP01ISyElRr8kStjFcpvq0DOzTSsT3b0VDzueOWPCXykx5mW15oWqn5xYLegpDatKx1Z8c5kDVUoKT3vMW7dpwInyGUShvla+kKp007fNgPWc8zS7QRZB8wzQ/M2fnbU51I/Z1pQ2+LRPfSagQoM8VDx8BSebeTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454742; c=relaxed/simple;
	bh=rNMOnKby+sZHsR+49Ik0Y2ZWwtLXfKtG/JD6dKZ6Z5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2jl3bqnbvTnYPAtM6QgIHCHv+eAzvK9S7OuyEE9lyXoEmxDPjCVxbFkjED8BllxV79vg5h4kBeqyjjvMtPLejVoCTxIxHV4X5AqlYxHKtjTaimPJUMRcCOPbIv/ch7YkWE/Sam5ouqTjCEZqghOkJCbIcqv4ruk1Y7FQ3VGkWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ48uGbI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ48uGbI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C257BC4CEF0;
	Fri, 29 Aug 2025 08:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756454742;
	bh=rNMOnKby+sZHsR+49Ik0Y2ZWwtLXfKtG/JD6dKZ6Z5g=;
	h=From:To:Cc:Subject:Date:From;
	b=MJ48uGbIlpjrN8vu10or7l9JO5lHNetr/q169B102JyZI2OFyYj8nrvQGQTOeg+DG
	 4Kx9N/QoP/smNcjYyEnsSdvRN7FhyVAfQ1incJUH73/GhE2YoVnu48E9uOiumq4xdM
	 TOONMyhyUtrh6u/O1khTIyac6vrsY3CvQ7v+bQzlnuW08looMP08Dsu18Uy8ghRT8D
	 BrAKiHKynzmcHVLElyu+fZVg0nZUtpfoRrn2z8NyCDbIt7jMp0ypve51q0r/JvQkQm
	 vXqXI1jbBCpXNriBWVylNuqg/nqo/tN/lp0F94rkmDv6E02uCXQqS5eyPYQwWxdeNQ
	 nCQROdOO8VwLg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.17-rc4
Date: Fri, 29 Aug 2025 17:02:47 +0900
Message-ID: <20250829080247.32183-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 58768b0563916ddcb73d8ed26ede664915f8df31:

  ata: libata-scsi: Fix CDL control (2025-08-14 18:58:12 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.17-rc4

for you to fetch changes up to 82b8166171bdebbc74717e4a0cfb4b89cd0510aa:

  ata: ahci_xgene: Use int type for 'rc' to store error codes (2025-08-28 13:36:14 +0900)

----------------------------------------------------------------
ata fixes for 6.17-rc4

 - Fix the type of return values to be signed in the ahci_xgen driver
   (Qianfeng).

 - Add the mask_port_ext module parameter to the ahci driver. This is to
   allow a user to ignore ports that are advertized as external (hotplug
   capable) in favor of lower link power management policies instead of
   the default max_performance for these ports. This is useful to allow
   e.g. laptops to go into low power states when hooked up to docking
   station with sata slots, connected with an external port for hotplug
   (me).

----------------------------------------------------------------
Damien Le Moal (1):
      ata: ahci: Allow ignoring the external/hotplug capability of ports

Qianfeng Rong (1):
      ata: ahci_xgene: Use int type for 'rc' to store error codes

 drivers/ata/ahci.c       | 57 +++++++++++++++++++++++++++++++++---------------
 drivers/ata/ahci.h       |  1 +
 drivers/ata/ahci_xgene.c |  7 ++----
 3 files changed, 43 insertions(+), 22 deletions(-)
