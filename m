Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029C6221F24
	for <linux-ide@vger.kernel.org>; Fri,  6 Mar 2026 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800717; cv=none; b=pJn55RhdVIP5BkVRhGqx44trbLWKVzQIW4Z6vE5qpmIl0FQ/qf5hGdwqXqsuuvSMUyHZcPcr831EHD3ovxJ7YQmVVH+XCapB09XDrvQq+5L1A2NPAMo/B69r0AqZXLBg5nT7857tCvYsugQ/WPkM0zfmExdkEU5WaWKes+D4kS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800717; c=relaxed/simple;
	bh=9zdAi2PiuWA9szvJTCKPea+RhBpvISPL734SMX1FPzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYhAHiTiH9LkrWboygF7XqDPuVdE3IlL3PTxFG7tpOhO3ErH2A1IQ0QbxIH7I2fioZ2IPUBNxEpdAgJI7q4WVi8p/M068H9wssYPH9/tT7fERyGAdp06O1Khxk8411BUgEMCwK5kQ8bSSNa0iqqQK9TYSj+e65TjBMYsput7htA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ds7sZf4q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ds7sZf4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E434C4CEF7;
	Fri,  6 Mar 2026 12:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772800716;
	bh=9zdAi2PiuWA9szvJTCKPea+RhBpvISPL734SMX1FPzc=;
	h=From:To:Cc:Subject:Date:From;
	b=Ds7sZf4q0jhxDRyACPeOBnEy3wBQyMGqcafTdnAHJrwwil+loeRq+mM+BTNNicHxR
	 Ena0lhPGNFfniCRtmGVZaIcbT7pnUVKYckhgUbyfKuwL0uXyLVgXzv4Cp7YkX5bZj4
	 rC9w4OufBnG2tWVyNqFda1TN/Cvqm0n7J+b69p8M3qhOcSKOc9++kr81c4/b1s/NDp
	 2lLPeI02wrHcmFWgzLRJgu40cAytkwgqgZVUns2Oxj15z9QioAyf+HZvl2188FymtT
	 49MB3yO+qyCZIUYQTZHqlX9KAZbIgI9YSO5w4xd/zuSGK3ym3HhNf1efwd900YHGib
	 t+1KYMcgIoAaw==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 7.0-rc3
Date: Fri,  6 Mar 2026 13:38:32 +0100
Message-ID: <20260306123832.991363-1-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 55db009926634b20955bd8abbee921adbc8d2cb4:

  ata: libata-core: fix cancellation of a port deferred qc work (2026-02-24 09:38:55 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.0-rc3

for you to fetch changes up to ee0e6e69a772d601e152e5368a1da25d656122a8:

  ata: libata-eh: Fix detection of deferred qc timeouts (2026-03-06 09:58:47 +0100)

----------------------------------------------------------------
ata fixes for 7.0-rc3

 - Fix a problem where the deferred non-NCQ command would incorrectly get
   completed as a failed command, if there was another command that timed
   out. Found by Gemini. (Guenter)

 - The deferred non-NCQ command work is only supposed to run after the
   last NCQ command finishes. However, because the work was never canceled
   on error (e.g. a timeout), the work could incorrectly run when commands
   were still in flight. Found by syzbot. (me)

 - Add a quirk to make sure that QEMU harddrives can potentially use up to
   32 MiB I/Os. (Pedro)

 - Add a quirk to disable LPM on Seagate ST1000DM010-2EP102. (Maximilian)

----------------------------------------------------------------
Guenter Roeck (1):
      ata: libata-eh: Fix detection of deferred qc timeouts

Maximilian Pezzullo (1):
      ata: libata-core: Disable LPM on ST1000DM010-2EP102

Niklas Cassel (1):
      ata: libata: cancel pending work after clearing deferred_qc

Pedro Falcato (1):
      ata: libata-core: Add BRIDGE_OK quirk for QEMU drives

 drivers/ata/libata-core.c | 2 ++
 drivers/ata/libata-eh.c   | 3 ++-
 drivers/ata/libata-scsi.c | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)
