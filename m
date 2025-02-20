Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262261F540F
	for <linux-ide@vger.kernel.org>; Thu, 20 Feb 2025 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054301; cv=none; b=s+fFU3x+czVWs/zln5BNt71fjTGHqPYkA3Xu7O2f+3ah/pJzli1e8KJegj+VE7T+HV6oJEIdorwkAAw0JQdZH7xXRGqE0ZdDBpIFzY1Li2yajiPLAwLYmK5VvM300KnqnSLrsiNm000bH1uEeZ8cVS75K7O69JcRuMuzPWIEDS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054301; c=relaxed/simple;
	bh=nhe7N2zykwgRbKoBPKMHpEQypAi1rZ1cprJayXr/gL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GWkl9D9zNs6p55QqEiSJHFf3GW0TUXx5OLXY2gF9iNqz1XsSSXr/1GpXtzvAdpsLR1D+DhKExD/rvLBNSv+qAZik+14VDeXmSNfaJfjBYrQhD72qlO+EipJrFJXQKS4SBvsQeQL6zsST8NB8hhroZJarqyXlKmQrV1U9AOqCqEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUoKxzUK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUoKxzUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD38C4CED1;
	Thu, 20 Feb 2025 12:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740054300;
	bh=nhe7N2zykwgRbKoBPKMHpEQypAi1rZ1cprJayXr/gL8=;
	h=From:To:Cc:Subject:Date:From;
	b=jUoKxzUKruVA6gR0sEkehvr+uIB6W9z0ih4FBAMBQNxbL0DBX44x4l1mq9S7cVQdK
	 HFBV50Sbiug+PoKIVGp8ci1xJrKc91Kn6erjc8rz1miX/SMJTKkekmmaSkXtfyX2gl
	 zEJiaw1pY6pwoaAB9LCqBuvMIKORIq/Ls6LCsM+1ibUPwhMu9H1j62VUR70FGHFYCu
	 sMbQecDrHxfvijCVtlmvCZrK/xr0vxHO3Gfa9kROlmytXI3l7faCDVp5yl1zTV/+iO
	 EH+J5CC7kj03aBfr4GiJ7yGJRtiKk23AyD47U09/E5+wRsJW3GqVAgOe3MQqUQd1Mc
	 iW9r1zmSLKamg==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 6.14-rc4
Date: Thu, 20 Feb 2025 13:24:55 +0100
Message-ID: <20250220122455.56387-1-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 6e74e53b34b6dec5a50e1404e2680852ec6768d2:

  ata: libata-sff: Ensure that we cannot write outside the allocated buffer (2025-01-28 11:44:47 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.14-rc4

for you to fetch changes up to 2c202e6c4f4dd19d2e8c1dfac9df05170aa3934f:

  ata: libahci_platform: Do not set mask_port_map when not needed (2025-02-10 11:54:38 +0100)

----------------------------------------------------------------
ata fix for 6.14-rc4

 - Fix an unintentional masking of AHCI ports when the device tree
   does not define port child nodes (Damien)

----------------------------------------------------------------
Damien Le Moal (1):
      ata: libahci_platform: Do not set mask_port_map when not needed

 drivers/ata/libahci_platform.c | 2 --
 1 file changed, 2 deletions(-)
