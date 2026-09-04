Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC953A0EB8
	for <linux-ide@vger.kernel.org>; Fri,  4 Sep 2026 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532954; cv=none; b=ugcdCUfMliWYBsXl5eoxIAUqjCD5KSvXdDjwObeceVYekFiANCAK1+LEtsll5PQttFy0v77tuOJcEAnG1XRan9idjEQ+07Vl7Hxk2c/63ZBMMvUhHNo7StcbgT8fQUCT1MdOr00+tHWzJ60d4VzTMaCUnvabXsWRNiXsdq3D6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532954; c=relaxed/simple;
	bh=RI1wuYf8AetZIVJferlAXN9MEPmDbvVFPd/SZpU+YCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M8AJlNiAIgTBo4iwulJufCLb3z24fhxpJynyQWwGdfbWzYaBm9KYlVJ6YG9L2jTxsSKEff7AbP1837+Fidem4expHkQZK3qs2wjV/glbUUGXALrysHgzrIe3WXZspukMwxMgMkW7SXxEt7fhn+SObeZCKDFRyx0H/vYtMgsc+/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7ibRsrP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7ibRsrP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC391F00A3D;
	Fri,  4 Sep 2026 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532953;
	bh=BRatBflK6kxXMGV+fdmLVdEh1RvyyLvNMG3L3YsH5pg=;
	h=From:To:Cc:Subject:Date;
	b=C7ibRsrPhNt2A0nb5lJA0Y2OCJUrgB5adDQBSnQCV5EzppXvriviGyD0cXH6RTx63
	 /5J0VOXbTJxefPYrhXFnRlbAQgl1yHhHHAg3sLCzy9KXwgW0vXB6xmnD1gHcSZwwIu
	 r4aoXQ8U2j1wbmWUhvkXWj1yksz9CB5hCNNb8KP9MOTxsiRaGn6Vb8zUxfJ/iD+Stz
	 v7b4NgsjEptu104+nczfCMYi0SbI2ilMATdCguJRdXqmKAsTME4FTauahPUdY/dzVU
	 Y2a+2vY7RrM+m+XEcWQWE5/3r/zr+060p7pCUVU7bkaxfcBLw0eWPN/5WafnHdpuL9
	 wdQGa7MyLLf3w==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 7.3-rc2
Date: Fri,  4 Sep 2026 16:42:28 +0200
Message-ID: <20260904144228.1473602-1-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3-rc2

for you to fetch changes up to 6d81700ad7c4871f94fb72e469cb0f3f55843ef7:

  ata: libata-scsi: do not raise UA for storage element depopulation and restoration (2026-09-03 16:10:44 +0200)

----------------------------------------------------------------
ata fixes for 7.3-rc2

 - Work around lost interrupts on Marvell 88SE61xx.
   The Marvell AHCI controller requires you to clear interrupts in the
   opposite order from what is specified in the AHCI specification in
   order to not lose interrupts (Hajo)

 - Do not raise UNIT ATTENTION for depopulation commands.
   The libata completion function unconditionally sets sense data with
   sense key UNIT ATTENTION (UA) for depopulation commands. The SCSI
   layer will fail a command when seeing this sense data. UA is only
   supposed to be raised if the capacity actually changed. Since these
   commands are currently only supported as passthrough commands, the
   user is expected to revalidate the device, which will detect a
   capacity change anyway. Thus drop the unconditional UA until a
   better solution has been implemented (Damien)

----------------------------------------------------------------
Damien Le Moal (1):
      ata: libata-scsi: do not raise UA for storage element depopulation and restoration

Hajo Noerenberg (1):
      ata: ahci: work around lost interrupts on Marvell 88SE61xx

 drivers/ata/ahci.c        | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-scsi.c | 24 -----------------------
 2 files changed, 49 insertions(+), 24 deletions(-)
