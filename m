Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36CB154BD;
	Thu, 11 Jan 2024 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1SxKXb+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F84C433F1;
	Thu, 11 Jan 2024 11:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704973886;
	bh=z6TxmLIdyvD1Zq8k/bcpj3NIFJ1C6rXhwN6VThwZA+M=;
	h=From:To:Cc:Subject:Date:From;
	b=C1SxKXb+6tDDXoKxwFMdcJ4QeMn+SLuqArsR2ql94wtWMs3HmNqXQ2GIaO40vtCiZ
	 Or2EezNTzBZ8jgNZkfipm6p3A5pUTk3aP3PFH/aIo1Z4zwZLnNBgkrV9Ij5H7ayc5B
	 oGp6zGh/09xdqX4Xw/x4l/1g3s+WWmTdg2DAmB+lusA0C4Hc2ExXT+SDkvzllK75uR
	 +SMRDxQaukPc0f/WnJ35WGdiE7eNr4fxI2q6m6RyM05LXJIyIH0AOyj3xbKFiPxGCP
	 Kk8OJzYy3RfzcQ8NbnBzgsA4QWoAzcAB3YpC6k10SgJYRkwlYcKYRxKanlP95oIfcr
	 A8dqWIWOH8zWw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Dieter Mummenschanz <dmummenschanz@web.de>,
	Wang Zhihao <wangzhihao9@hotmail.com>,
	linux-regressions <regressions@lists.linux.dev>
Subject: [PATCH 0/2] Power management fixes
Date: Thu, 11 Jan 2024 20:51:21 +0900
Message-ID: <20240111115123.1258422-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch is a fairly obvious fix. The second one needs testing.

Dieter, Zhihao,

Can you please try these patches to see if they resolve your issues
with system low power state transitions ?

Damien Le Moal (2):
  ata: libata-core: Do not try to set sleeping devices to standby
  ata: libata-core: Revert "ata: libata-core: Fix
    ata_pci_shutdown_one()"

 drivers/ata/libata-core.c | 75 ++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 28 deletions(-)

-- 
2.43.0

