Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48C2277CA5
	for <linux-ide@vger.kernel.org>; Fri,  7 Aug 2026 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145310; cv=none; b=uxGLbE/oiU0bTuAmrKEc8/BGM77HW5DVZArhQ82LB7gxVmip8ZxbfWyE5rEFS+6UUwOWLHF8vTdzQAyQLw4PA6IHT+LTF8JGK843lneflFWGs37TbxcofeCjSocgTnnZsZ75jnXMubqqia8/Xa1Agz9zqESWhazHiVO0r+Z+Myg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145310; c=relaxed/simple;
	bh=d4+FNn3+ZT7qgpbiFwm9E+6iJxHU74lKR9e9Uf359v0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HjMG45zshC20yKxcFBDZNTEk8sr6aF4v2po3ikWdVnlyGzDw7K8i0WWALxROBGUXgf0PC+051uMtzz1MQcTjBSiGjcHIh82wG7di09RnzKQGqUjQruu2MKNaT8CzH7Fmk1QVZa0BKG1UmihizdLY5ajhrkEhFpYIrDQP2npCh90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiRO4v3j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiRO4v3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405AA1F000E9;
	Fri,  7 Aug 2026 23:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786145309;
	bh=usDaRYuv1QBP1Yh7dJyLwIfoCVlqZt55ozDO8kaIriU=;
	h=From:To:Cc:Subject:Date;
	b=UiRO4v3jK/Cul5nmHpk9b1jC5oK9DNm98eH3JqqIC4y4Ct3JcUkOSTnVCz9JWQq45
	 Yl58+PXUtebBAZuCisvcA7Fxo34TOrVqi2Z6ZLlj+YegAPOMLNWqAb9BGJLweCK6oa
	 1I6qN1xt9HZGyZ1j1osTVqjW6fMvjY3gj0FKqwHhr0HyKDGdcB1mWQe9aGZc4ZRThO
	 uRV/q3hvNuJGmwMcURmB/fvGyU/PQtWwSj7E/QHCz6E3fQVAHSyTZzonLC/Jx+5BQz
	 jABmJq17qbVBt3Jl18qvDJBoxwcEzXThPUrpTxlUjoxpxaE21IHrvKV+FRts2ALZuH
	 prNKTzX9p18TQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 7.2-rc7
Date: Sat,  8 Aug 2026 08:28:17 +0900
Message-ID: <20260807232818.860137-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 3fd70e96914d761c17c376aadd0b0d1a3c9badba:

  ata: libata-sata: fix ata_scsi_lpm_supported() iteration (2026-07-29 10:55:11 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc7

for you to fetch changes up to 7700a31039cdc6715cb6cce7e7a664ee4e945f67:

  ata: pata_sl82c105: fix bridge revision use-after-free (2026-08-07 00:55:53 +0900)

----------------------------------------------------------------
ata fixes for 7.2-rc7

 - Disable liknk power management on yet another misbehaving WD drive
   (Niklas).

 - Fix a use after free issue in the pata_sl82c105 driver (Hongyan).

----------------------------------------------------------------
Hongyan Xu (1):
      ata: pata_sl82c105: fix bridge revision use-after-free

Niklas Cassel (1):
      ata: libata-core: Disable LPM on WDC WD141KFGX-68FH9N0

 drivers/ata/libata-core.c   | 1 +
 drivers/ata/pata_sl82c105.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)
