Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D84A17547
	for <linux-ide@vger.kernel.org>; Fri,  2 Aug 2024 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559107; cv=none; b=dEibDA6LypL+4Hvgk2wNSvh/8a4MXeuL12pOY4qvI/hNViFKB/ZOjZh73KHDu/pqOgfUrSNdtGxD4F1tRARSoKg26x0vmeGA9boROl7QKpMWcN+MKGZsmNYc1vd1SqB9jZ/EdD/R1suULq8ENvhr1GsP9xUbKgJxDE/eGMwL+yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559107; c=relaxed/simple;
	bh=2HQYjbMqyZi2cia+ChoubsGwvbvtCgBl6fZhFjlDe6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIFnL9Lp1yKT8bjHNezF2CT2dnYzZ3lzf3Vz8TQGYxoLgkgPub4ooVU80/Wdm9e8v/mmxZA2Wtpa7/kjbZVoDKx4p72UuAib/4ui0w08sTmusFfducxf43suhAWeZSU+iui2nKQjzW9f/j8soq2VqN8wg2bDjNnNFUaGO2QTvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hS2bBiHF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hS2bBiHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743A0C32786;
	Fri,  2 Aug 2024 00:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559106;
	bh=2HQYjbMqyZi2cia+ChoubsGwvbvtCgBl6fZhFjlDe6Y=;
	h=From:To:Cc:Subject:Date:From;
	b=hS2bBiHFK2p763T1tw0NcwsuDB+o09ayUAGCBcJaNJ1hcWg4q1KIrUymaD84lFI3J
	 0steM/BpGJS/JfFR8kAu4/rob4W77KnQsc9acFopyOXcCtjsrB0Pc6vON5gHxBL+n/
	 e5q89DVYnjogFjE1FisWbRcyBwWLGrsMYcndX9Klpsz9vscW0jypMF4n4DmetOTapw
	 nZsAJPoeVlUbnQu0YpMwiCLY1xik/22qTNSNkTtFDEHcR4YQ928jTqYZeJTXpW+CwV
	 t5mXzXt3mxI7hfaBqaSPfP70GJQxtQlJ5G+6jozgBA4RAe076jYzaykkFEBfX/Sj4Q
	 oopsuVgYPVf4Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.11-rc2
Date: Fri,  2 Aug 2024 09:38:25 +0900
Message-ID: <20240802003825.19420-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.11-rc2

for you to fetch changes up to 89fb4dfacbb33750e0243848f4c54d73e558ba9a:

  dt-bindings: ata: rockchip-dwc-ahci: add missing power-domains (2024-07-29 09:04:09 +0900)

----------------------------------------------------------------
ata fixes for 6.11-rc2

 - Add missing power-domains property to the device tree bindings for
   the Rockchip Designware AHCI adapter (from Heiko).

----------------------------------------------------------------
Heiko Stuebner (1):
      dt-bindings: ata: rockchip-dwc-ahci: add missing power-domains

 Documentation/devicetree/bindings/ata/rockchip,dwc-ahci.yaml | 3 +++
 1 file changed, 3 insertions(+)
