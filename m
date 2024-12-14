Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E88FA47
	for <linux-ide@vger.kernel.org>; Sat, 14 Dec 2024 05:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734154688; cv=none; b=plmAqclYzqwJBhJtKEkGGiEVtS7bePwEtGf4+zFFMoe5QiKePqJWX6vkYu3YzRFS8lspHC8a3i6W/tyXpeKrlo8ArOk+EeoOMG75HOMqEuJrMR5bDC4tCLfHOxVoH04HmNCz1XsiNAtYIh+ykt//4z/tBTURvvhLEtFbwQeeeJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734154688; c=relaxed/simple;
	bh=QV/BCjLsfdfKn7EdIKlsPKKjAbTbZhc4HZbvWdZ/6tU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JSSj/Z7fUiNYW6n0kc2FfaWw9uw2KekbP9Y2u5TmpS5bFn3yfLsS0IHG/TET630QumA0n0/MAAuhppY31NoKkiAOaZvpis1wRUPL6cCZx6GfB+oBsTue7ba7mlMG0pTlAGYmJRQo4k6nyNhrSZkY64WGZAbEG5xa2xRLgd55GvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvkh6pTk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvkh6pTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CE6C4CED1;
	Sat, 14 Dec 2024 05:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734154687;
	bh=QV/BCjLsfdfKn7EdIKlsPKKjAbTbZhc4HZbvWdZ/6tU=;
	h=From:To:Cc:Subject:Date:From;
	b=qvkh6pTktseBo6WnB8SxgiHGyMAX9ASEmEkQazaRgXPV9/kHSo1xlVoiouFj5KdUv
	 FgBXCBSA+SJH6uQItLYos/WdWAQqcfVbqoAf2aQ8hRwNR8B9nmoO1gIjRjDZJ4NySl
	 9jVpAGAikOpUWZvLDat45ZLMXgaocD8TcHs30GxwcRJvAp21Mf8jXibvFUT0Ay/Rnd
	 W2VtK6ks1XWiHeZCpYBD43t1RicdZxQahS3Vy0DoROioP4Nj7OutlyuqtFXqThWGHR
	 aiC6JV+ef8bFN9kOqPIO5u30zSr3DixCiFxsxWeUkA/2BIPhVscnM1K+3t63N/docR
	 24jtBhSRbtvCg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.13-rc3
Date: Sat, 14 Dec 2024 14:37:48 +0900
Message-ID: <20241214053748.162468-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.13-rc3

for you to fetch changes up to 676fe1f6f74db988191dab5df3bf256908177072:

  ata: sata_highbank: fix OF node reference leak in highbank_initialize_phys() (2024-12-09 09:06:58 +0900)

----------------------------------------------------------------
ata fixes for 6.13-rc3

 - Fix an OF node reference leak in the sata_highbank driver.

----------------------------------------------------------------
Joe Hattori (1):
      ata: sata_highbank: fix OF node reference leak in highbank_initialize_phys()

 drivers/ata/sata_highbank.c | 1 +
 1 file changed, 1 insertion(+)
