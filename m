Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2A14AD2B
	for <linux-ide@vger.kernel.org>; Fri,  2 Feb 2024 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893919; cv=none; b=Vo9wkUOgAZx0XcTEJJFRok56sl7vmSrl38eDeK8bpdtGUjX61a3TmGr0uXW+EcwNIrlE7qtPILuHvjMQX8R1WqYTEUF45/EPCjzHZF2RaUHzGdPdsAZnTmjezO/5NBjGO78Jqyo8ZcjL56PPPUXFIxYrcbs6/601UmeI8B00xx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893919; c=relaxed/simple;
	bh=t+aUMTKogAzFhLLonoSvP2MS76xyMnlu0/mU9uqaEas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hXd8pbs4ykhuwH9TTLARTOUxdoXF+G0SH6+X9AsRgTjcRuN3lv3Mrk8Nzb2u9yJx389de2hmoyVPE7yR+3TJ6sO4lyFnUAJTTg2SDOZxkJVFjTm86gdLfSwKWTMXKjSiYca58IcFv9gWVH5pW1kzXFTcb5yG1oie9FWyoDsF7hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxXjiqmv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxXjiqmv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C189C433F1;
	Fri,  2 Feb 2024 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706893918;
	bh=t+aUMTKogAzFhLLonoSvP2MS76xyMnlu0/mU9uqaEas=;
	h=From:To:Cc:Subject:Date:From;
	b=SxXjiqmvJ2KzafiEntjHfHV9oYadbuM03/1CeJ9lK+lDvcM1K3MD/5NtvaOqZkUAP
	 i3etDgOG05sWnqdMrE+sWV4A6OozWNh4mWJywbXLRn6WO3m2kFnZ5lsqov/RULXG9t
	 H6/KfhTtRpWdzpq0q7XHtmsP8vfRkEwD6jRnNxM/F1dE9VXdTKx++0I73C+xaKVpLB
	 4Ny6OtyTr0oOKVGZdppR4lOdo5napQdVyOismj7+bQI3/6kWr9zuY0dcKZu+EFnOu6
	 ZS9h0E9zN/6ne6aWv3k5N8LCzpdcwsbNUKOXeqNXXR2+5s4wAinzCyjsoHZSneUvSr
	 XY5J0tLw+XEFg==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.8-rc3
Date: Fri,  2 Feb 2024 18:11:46 +0100
Message-ID: <20240202171146.1299344-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 20730e9b277873deeb6637339edcba64468f3da3:

  ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers (2024-01-25 16:59:09 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.8-rc3

for you to fetch changes up to 51af8f255bdaca6d501afc0d085b808f67b44d91:

  ahci: Extend ASM1061 43-bit DMA address quirk to other ASM106x parts (2024-01-31 12:09:34 +0100)

----------------------------------------------------------------
ata changes for 6.8-rc3

 - Following up on last week's ASMedia ASM1061 43-bit dma_mask quirk, we
   sent an email to ASMedia developers that have previously been active on
   the mailing list, asking exactly which SATA controllers that are
   affected by this hardware limitation.
   We got a reply that it affects all the SATA controllers in the ASM106x
   family, thus extend the existing 43-bit dma_mask quirk to apply to all
   the affected ASMedia SATA controllers.

----------------------------------------------------------------
Lennert Buytenhek (1):
      ahci: Extend ASM1061 43-bit DMA address quirk to other ASM106x parts

 drivers/ata/ahci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
