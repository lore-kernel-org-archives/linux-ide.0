Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6A3C8713
	for <linux-ide@vger.kernel.org>; Fri, 10 Jul 2026 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667991; cv=none; b=tmrAb5Y2UeQtPMYfxb9vaBqV8umrBc1EuOkWxVL1qMLcS9LP0IVe0tZCicXHwx36+KYq3yHoejd754gx+IYKEzDoQEQUg7UsE7T+XZU4sRVQOnCdozLJAreNxOH4R1GNGyCHOW0gbfeodlcPaRDWYrRgwyYEt3d5gfi8wdbmITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667991; c=relaxed/simple;
	bh=5CHt4SycZvY4xmYTLEx9yirw0YxoesHvxYcmQROxbWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+8KqhmcPFSee1ce7A5ve4xgIKicNayYDOMCO/YdjX6gs+ztY510bnSHEJhCmZR/0mFvjqILvj0xJjldrR7xyE7HM4F/1c43qvdYiwZfqgOzkB8VETfZwQ2Q3156BwA0m1KM9WbUmxRDXfv8Y/hlR51LklyJycj+Y2K8QF/bMmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXkOGjwJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXkOGjwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2050F1F000E9;
	Fri, 10 Jul 2026 07:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783667990;
	bh=Bh5J26+dqcq5AswtgRPcjstt1YdJl5pf+d4TGJVb3tc=;
	h=From:To:Cc:Subject:Date;
	b=SXkOGjwJpJ6YKwR3uFKYs5B0jNvP4TxvWNll16rYpTQ1oLsmE3WKh5vqKjgP7JvzN
	 Jl3y+nfbfBWUR3tsj+2P/QPCv6VfbfHTZIbAUE7rS9sb05ofeedPVYvU3YmPF/9OLT
	 QkY/eAUzpY2KOv2sJrfzQe5ePGYqLpe2gwoxccujWDQZpXOh0HO1R/zUs+f3ZXxBVh
	 roTMefsb5nesSZfYBTyTpW2E5OMPoSs69CamF5GUwvd264q9h/fCH52AlgfVcw2OgT
	 uR0e2HysuPkz3Mb7SczfzE+wF1lRO7PZ/C4vOL5iz8o6QCNUQwvOx3+rZsgwQwmLt+
	 6k8TLmLSGgvCQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 7.2-rc3
Date: Fri, 10 Jul 2026 16:19:38 +0900
Message-ID: <20260710071938.1624639-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit cd64be0ecd399fa2b1ab60b3aaf2b2b744243467:

  ata: libata-scsi: limit simulated SCSI command copy to response length (2026-07-03 13:44:18 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc3

for you to fetch changes up to 793bf193b18e9bff6c4280268bbffd16a5b533e5:

  ata: libata-core: Allow capacity transition to zero for locked drives (2026-07-08 13:49:48 +0900)

----------------------------------------------------------------
ata fixes for 7.2-rc3

 - Fix handling of security locked drive revalidation. This prevents
   such drives from being dropped when locked on resume (Terrence).

----------------------------------------------------------------
TJ Adams (2):
      ata: libata-core: Skip HPA resize for locked drives
      ata: libata-core: Allow capacity transition to zero for locked drives

 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
