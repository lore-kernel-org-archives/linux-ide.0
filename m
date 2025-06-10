Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A76228DB72
	for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2025 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553713; cv=none; b=bvgiqm3r7AsinOlMZt+nHoJiC1TcgLtyxGYcBSbC3MFGnxnku39zbko/Q8U8Bhao9STBlQqIfJP4e5PnrgVUilKweiT5LAATNXDI8UjLs+TIH1nUglPInyaT/QOqf4kuwIArOnfOylis5G5aw5oycOJ54m1f46aMxYOzulyy/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553713; c=relaxed/simple;
	bh=lHDA/mhYp+14YF/bp5aIreKaJsKQ8yPLeDiSPt+i09w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sEMKh/ViSQ8uLD99n/IbKaKyQByxVH/11Qa/OAVl56CsEctnxjkdn/5JAMBn1cp4owF8XJjn0rb9HLvOSUeIUM3p8DRpUXbIq8KuO7nTmWLE19A67EDbAxTY9n3ZeVMeTYBPTXtql4cAFRKwdYlQc4VGM0MJXHNGcr+7cI1ZypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3I7Wt+K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3I7Wt+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF48C4CEED;
	Tue, 10 Jun 2025 11:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749553713;
	bh=lHDA/mhYp+14YF/bp5aIreKaJsKQ8yPLeDiSPt+i09w=;
	h=From:To:Cc:Subject:Date:From;
	b=b3I7Wt+KbSK/DKlELl/nCd6JcQNPp1Km66162NH6avVXh9C/H1UTrlfuBZfTo12n9
	 lTpZfzGYAvYHZsNMkY9Ry0/DGUk84E//4md7hCiDkV3YoHwLu88gonYQ+fiHDWGNhh
	 zH89qqFbg5bXuqQkWp29A5sKqEoeKmvdQPrzIzbQNrykRtdup/rE1zMXE216VH7LTn
	 wK2QUclYOJmYEU0L5rl+59Siy44T0W9fRUQ/bTVtUydcQVkGGu40D+alq3EdlJ5E3d
	 R0f8/p2hLoYNUZk0l5rwZGsyP4DPHDch/axr5WbVBZC4BkYagL+f0UZyslDJbuiWNC
	 Ib6HZpdGBiYqQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me,
	Hans de Goede <hansg@kernel.org>,
	Andy Yang <andyybtc79@gmail.com>,
	Mikko Juhani Korhonen <mjkorhon@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 0/3] Cleanup ahci_broken_lpm()
Date: Tue, 10 Jun 2025 13:07:58 +0200
Message-ID: <20250610110757.1318959-5-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=536; i=cassel@kernel.org; h=from:subject; bh=lHDA/mhYp+14YF/bp5aIreKaJsKQ8yPLeDiSPt+i09w=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI8hHg3NZaXXRa8+uik0p/y+fvVPJu/3flgazx7u/LLi bPWftXY21HKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJZBgyMtw0vL2ALfGn2UrW 1qa6CeL/91YZz4t1K/277S2j0TSB1S2MDB0/OAKkjyguaWP94x+v3H3s2kUd2w1KrI8O8V/rtbx lxgsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

This series cleans up ahci_broken_lpm(), and adds ASUSPRO-D840SA to the
table of boards with broken LPM.


Kind regards,
Niklas


Changes since v1:
-Addressed review comments from Hans.


Niklas Cassel (3):
  ata: ahci: Use correct BIOS build date for ThinkPad W541 quirk
  ata: ahci: Refactor ahci_broken_lpm()
  ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard

 drivers/ata/ahci.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

-- 
2.49.0

