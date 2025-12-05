Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C171FCF41
	for <linux-ide@vger.kernel.org>; Fri,  5 Dec 2025 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764927825; cv=none; b=GR8g0g1Wj+HUM8CDX8hhev1GvMLPJlsbi5827IQWbfdslT/53VtDcP4U5GZy9nXuWVEedfWuM7a6F/td93EFpTYou+GckIVcF6+Tfkqz8G4i6YWXcgAFjBvuePqoD9hrDrD9s6HbRGLHzHqputx0iGK/9Doc//SiiokHD3s4zSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764927825; c=relaxed/simple;
	bh=XJpKl6bozBm/7FqrFSL2t644GruW+UyqrXsiw45akvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rlP9+gwmOLDn5XHOEWkkgAkwSAr00DNKR2pa+h0HM3Kg47k3AoiZD/PQpkpRf4t2z0wbO5O7haNOBbQgeEF+netDP3GzZdqyWsTuzlRmy9uPEwE9rkZuMhe3BrAuVt90xtTkHEfIcHYv6o39Dmnbj4Ci6CK2jxayIk2dZmv7BUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8HN5DL4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8HN5DL4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92802C4CEF1;
	Fri,  5 Dec 2025 09:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764927824;
	bh=XJpKl6bozBm/7FqrFSL2t644GruW+UyqrXsiw45akvk=;
	h=From:To:Cc:Subject:Date:From;
	b=O8HN5DL4iFu94AwifOqviUCnP4kVcH+PjttCq/0Rh94CGK1elJJe5B6NT8EWWUlzg
	 YrZcOlkYieHKTfSEhFDBXtTAqrLZlske9dGlHl2fjQ14BaGv8cmMk62ZQDLAO/sM/j
	 aSoYXxNvhELUUeueZhJeumSK91OISoy04NC6vRa4LAT2+QYWHKOoglXGO3ISNdEZZl
	 MdJ4L/DJvLDgja8h41v+FJFnzdm+5FgSSyqBFQjENkugRxyQEHUhr4rmA1qgjAQ1hn
	 9LdqzYguYmYCIuqD7kQP5zEWRT1LKMeRQyIp8KsMcxDFo57Jn5f4Vmjo96MrkvZksv
	 Clrzav2aXD+ow==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fix for 6.19-rc1
Date: Fri,  5 Dec 2025 10:43:39 +0100
Message-ID: <20251205094339.1032996-1-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 6ce0dd9f54ea9773c0aedfaab7b858fc68a848ba:

  ata: libata-core: Disable LPM on Silicon Motion MD619{H,G}XCLDE3TC (2025-11-28 06:58:24 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.19-rc1-part2

for you to fetch changes up to 2e983271363108b3813b38754eb96d9b1cb252bb:

  ata: libata-core: Quirk DELLBOSS VD max_sectors (2025-12-02 11:17:56 +0100)

----------------------------------------------------------------
ata fix for 6.19-rc1

 - The DELLBOSS VD SATA controller times out when sending I/Os of size
   4096 KiB or larger, even though it claims LBA48 support, which per
   the ACS standard requires support for a maximum command size of
   65535 sectors, i.e. 32 MiB - 512. Thus, quirk the device so that it
   sets a lower maximum command size (me)

----------------------------------------------------------------
Niklas Cassel (2):
      ata: libata: Move quirk flags to their own enum
      ata: libata-core: Quirk DELLBOSS VD max_sectors

 drivers/ata/libata-core.c | 11 +++++++
 include/linux/ata.h       |  1 +
 include/linux/libata.h    | 76 +++++++++++++++++++++++++----------------------
 3 files changed, 52 insertions(+), 36 deletions(-)
