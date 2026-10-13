Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B852BE31;
	Tue, 13 Oct 2026 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897608; cv=none; b=pHAXxoedwaoMK43jkMFfBLzGkcBUxV3fmDF3959zKJ6CQzWny/OvMuknIBHwNgfdtjd4GuimDEi8i6/ntP/+GkEyghzXIne0sPshHyyJqgefml++tLLJY1HUE5mIZCiDt7d6KXzMROgSJw67THPcYhfWhlOTxMAbzrL8Ra9GwjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897608; c=relaxed/simple;
	bh=a2w0pxd7qkkN9gG85gc3cuvyVXHYjkOjPA17mVGPhMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sg/+ChtOzk8avAf6mjMQpwxD2cHrV2xsQqsJX2rWvePO3c8OsqPxRwm3NMG1AHM+FJAVjAsVPaKW3uCz8XIH9qHC0wlsCXmA+HA0rLbk7LB/Lu/OqYHU2Sh7EvuLgIgAW5kjb3LxsKyM1hr/vrMCWC3SjkqXZtcVzbYNM3ND81k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lY3BtV7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY3BtV7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087AD1F00893;
	Tue, 13 Oct 2026 13:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897607;
	bh=cuYWs1nQ+WZdkccxXDyRboJzFrnZwgbW7zMkiE2i1O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lY3BtV7m0Oox5pJixXm3yIq74EPRtw1o+ENN8Wf4P4GJAy8IryMulziYaqq5hkmL/
	 0wGUUZljyuPCNQVww5PeTSm+QvRYa049Xltowhc3vPLdtSpnE2V6gv4PMddwXhSj2Q
	 6RDco83l0i2Bl/Vhar6pt/asvTPNG9JHLFraQMua/Ogu+rAzFZIcAUxUiWAZeS9Oh/
	 FFLE10Tj7G0rB59lstlWr7eRIhP9eAbX546XYqtGoFyBzoFPZfHpmNjFz3+Qkkl/lm
	 j5qkoJ5JjphcmqiKYtiO8eTQwI59gX27O+YysUBQjQvjbP8u942TVNDjZHYPIi19d8
	 ZoOmJDCDPzsmg==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 47/53] MAINTAINERS: add an entry for the SGI IOC4 ATA driver
Date: Tue, 13 Oct 2026 15:17:07 +0200
Message-ID: <7e185e14e16f071b0850087e30f6cac4af85b1f1.1791890466.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791890466.git.kaloz@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for drivers/ata/pata_sgiioc4.c, the libata driver for the
IOC4 ATA/ATAPI controller.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a30c09a55c72..826f0ffb71fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24925,6 +24925,12 @@ F:	include/linux/phylink.h
 F:	include/linux/sfp.h
 K:	phylink\.h|struct\s+phylink|\.phylink|>phylink_|phylink_(autoneg|clear|connect|create|destroy|disconnect|ethtool|helper|mac|mii|of|set|start|stop|test|validate)
 
+SGI IOC4 ATA DRIVER
+M:	Imre Kaloz <kaloz@kernel.org>
+L:	linux-ide@vger.kernel.org
+S:	Maintained
+F:	drivers/ata/pata_sgiioc4.c
+
 SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
 M:	D. Wythe <alibuda@linux.alibaba.com>
 M:	Dust Li <dust.li@linux.alibaba.com>
-- 
2.47.3

