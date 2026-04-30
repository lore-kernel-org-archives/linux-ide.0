Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EAF40B6EC
	for <linux-ide@vger.kernel.org>; Thu, 30 Apr 2026 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553825; cv=none; b=j3OXUIKCf96Xybx/Po9UQS6rOwgd3vyJeuNYMGrusbUIxx249OCMSQrDSU8YR9qbGYqEdrSypTxJz3UtbOUqdoihyi2XjVXr2eERYOWd78I3LmufzXJtOzOtKndT0W+bzid6Vm4914ydH5Jo2vA8os5/a/V9c3L3tFT6gpucbIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553825; c=relaxed/simple;
	bh=sI3Fjcw+qCm4Uph5hmPRNQKU6XyTCOXsTbxvwzLGFcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IwTbFAWwFm6Ja0BaR5azDhRfc6Tu+FjjR4jfifCuMXxNde1A27TgC3Eky/ixxVxlnPKHweeQk+2c3gwKFi3i1fecH9RYbaiZxFMR6u1xXC1x8inBexpxqqLmsTUrXeTA4aiL9CLclyBuD6FpYeIswIZp7zQyHO0EzPMJiNMDBb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFD1Bxqe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFD1Bxqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098F7C2BCC4;
	Thu, 30 Apr 2026 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777553825;
	bh=sI3Fjcw+qCm4Uph5hmPRNQKU6XyTCOXsTbxvwzLGFcc=;
	h=From:To:Cc:Subject:Date:From;
	b=aFD1BxqeD4HSMeAYDt4XfZY6VNjy2UGbNnZOoYF5NPYPue3yRmkij/RT0vRe9nJ2o
	 rCaP5nqYErfxZAWOeP7J0Ba7vsvmbRrp7vGBxwT1OCCEPiyhf5zyJcGPs2/CZ8EikT
	 R54uIGi6aGeTYi0zNNJW9WJk+laPF/khzYpCWA+2rgHcIOh5T31HPAffYUypZWrnCh
	 mObkLcfOn5liPyyPoHirtiE4PZo3Sl8GiFfn+0fpy856ERWGOnvFDme7kzHqZlVRlL
	 yOHeq8SFeWvw5mycgfCDbrag6VCH3vZBsHp8a6f+PgYc5trAQVbZJ6tXCerr9ZvUe1
	 NiEca2jeNkRyA==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fix for 7.1-rc2
Date: Thu, 30 Apr 2026 14:56:38 +0200
Message-ID: <20260430125638.854389-1-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.1-rc2

for you to fetch changes up to 163f6494233e1679ec6fa6a4803f74ae7b1c94db:

  ata: pata_parport: switch to dynamic root device (2026-04-27 11:38:16 +0200)

----------------------------------------------------------------
ata fix for 7.1-rc2

 - Fix a reference leak on device_register() failure in pata_parport

----------------------------------------------------------------
Johan Hovold (1):
      ata: pata_parport: switch to dynamic root device

 drivers/ata/pata_parport/pata_parport.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)
