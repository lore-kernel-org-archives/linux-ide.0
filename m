Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1738C22A817
	for <linux-ide@vger.kernel.org>; Thu, 17 Apr 2025 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889616; cv=none; b=Emt4TZnIUqVgMoSKvlRzs1qfID8JlacBguduUhoX97NZMvi9kb6iZFymPNk/Q4vz/gVpcDLJh167yxIXasmBFa2D7EKpvkCNXzdcMj2bxznELlnxdBExc2tMeP0+C6jnxl83i1VYOZqXkfbRNftlH0JSPsBsCMUllA1rBm/OPRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889616; c=relaxed/simple;
	bh=JVTw1ciKuZP4QIsWjjoGsKnHSS6Eg1rt+JCKAC2BhK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lsocf6kUSslcmUCxErlF5ZvucyKLX/p2TLEx8PAsXZvQGwtm0tDz+L3mkRdDKcVIKJ50VSJajZAuuKN2oYYksdD7kjCZtqYLcfwEewdh2uChvnbkip4GaZdY57siYglJgEdFWTcNoaR5SKVypTk5zb0MPSR1SfrVRxhdKHmDMnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4/jOZBF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4/jOZBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0EFC4CEE4;
	Thu, 17 Apr 2025 11:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744889615;
	bh=JVTw1ciKuZP4QIsWjjoGsKnHSS6Eg1rt+JCKAC2BhK8=;
	h=From:To:Cc:Subject:Date:From;
	b=G4/jOZBFfhs5h396qnQDMcELovzosVuLMqC1kuOWzryWvE34kk7rSw+unlMzFibFL
	 vPTiMd0aJDp2eoKAJs3smpJv1CtMCgx5vs4vlAR1zVwwqdqPta9g7rzGJKUNlQTLku
	 DxyyrvcJQ9c7vgtNUSc9prYxyItpz8jDgL1xbIY5JYTNMnV0SXzGQ/KzIp7GC5MPqW
	 QFmurP9IICA+NmQipqGxbcWv0EdM3s2dA1l8Fb6ef+7JdD8CWPVQbQOjVpwt0Em7Mo
	 oGTiGeF72oCQiW7ipCGgKn0TcxsjiORDNNqIYfaIQ3txxmv/4dWTQ4szJU8ASSvPDD
	 oFxFZ3aCd4B3g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.15-rc3
Date: Thu, 17 Apr 2025 20:32:47 +0900
Message-ID: <20250417113247.272720-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 8d46a27085039158eb5e253ab8a35a0e33b5e864:

  ata: sata_sx4: Add error handling in pdc20621_i2c_read() (2025-04-09 15:24:49 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.15-rc3

for you to fetch changes up to 399eab7f92fb73ffe621294a2d6bec8fc9f3b36b:

  ata: libata-sata: Save all fields from sense data descriptor (2025-04-16 17:33:17 +0900)

----------------------------------------------------------------
ata fixes for 6.15-rc3

 - Fix how sense data from the sense data for successfull NCQ commands
   log page is used to fully initialize the result_tf of a completed
   command, so that the sense data returned to the scsi layer is fully
   initialized with all the device provided information (from Niklas).

----------------------------------------------------------------
Niklas Cassel (1):
      ata: libata-sata: Save all fields from sense data descriptor

 drivers/ata/libata-sata.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
