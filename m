Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206A382F1A
	for <linux-ide@vger.kernel.org>; Sat, 26 Sep 2026 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444936; cv=none; b=LeSllXUf1tYEaDyizx7QwISvWxJQkdRU3NUQDcZ+mDPsrtkeaqcFi8Yww3MMF/+trc5D01dcbhXbRJKk2n3trlUX/FrNhjimMXo+W7ZQDVINrCv4s6HKyCZXCELe/To63CLoiRs6YQvBpyR+Ki+RwQX5hOZH+PEKFSw2CwBrkEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444936; c=relaxed/simple;
	bh=fLDiMmSuEXs4wFlpnp1j9z5ztXujkmvKqPAJVQli+Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FttOznbQQWUKnOOhAMN7ZRHzw/nFfw3hJLAUWr7YSh77cG5w9KnSRLFHarHf8jofkpRqZtrNgOr+keqPVsBloph/yTwaZjJfZ6BVZMmmTAjt56rrioKDDswd2weBgSFgqqCHkpJdBcccH9znniL+PzCxEsXd3o6qc+aZ7zdALhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enJKWBYX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enJKWBYX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A263B1F000FF;
	Sat, 26 Sep 2026 17:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790444934;
	bh=d5aYKitjSUrbVpf3InFMolKkxTvNle6goa/+H2VvXrA=;
	h=From:To:Cc:Subject:Date;
	b=enJKWBYXnimctMVRq2gbx/t0/FN7zN3/aKQ+MTi5IztoKquNUG/fv/AsOlsvqCY/y
	 trlve7UdiXC6qsY0Ujb2WrOXun52nzY5U2+KTtF1SHd/T69uxnn5P33iyY5XrixP6+
	 5EgF9RqTTZDzhB0H+emRLNBbUDX7Hw5s3HHi/Zf/KL3NndZqswxjIVgNQxSspJYeAC
	 vMjI/W1hAsmQjOAj6F2H7tO/wUvH0VnIPSP5y6CLFHuoQUyQnXWgS7uRYWw8gpoZ7t
	 OoYukB6tgOB+DItqw+N7n4qG36opTiGhvGZpuKgZt4vI1PesUTRsLh8u9yhYzosGHY
	 OLAhfUB9fV55A==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 7.3-rc5
Date: Sat, 26 Sep 2026 19:48:49 +0200
Message-ID: <20260926174849.501378-1-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 8d836581f9b1f57ceaa2b47654754ef1260b410b:

  ata: libata-scsi: fix ata_dsm_trim_pages() kernel-doc (2026-09-16 16:18:00 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3-rc5

for you to fetch changes up to 113dcdfadf30ea11fbbdfcd4f6ea87687655cc5b:

  MAINTAINERS: name the libata/linux for-next branch (2026-09-25 11:08:37 +0200)

----------------------------------------------------------------
ata fixes for 7.3-rc5

 - Extend the quirk "no LPM on ATI" quirk, that is currently only
   applied for Samsung drives, to include AMD controllers as well.
   The AMD AHCI controllers are newer versions of the ATI AHCI
   controllers, and these controllers still have LPM issues with
   Samsung drives - LPM works with drives from other vendors (me)

 - Fix errors in the libata.force parameter documentation (me)

 - Verify the sense data descriptor lengths for ATA PASS-THROUGH
   command, so that a malicious device cannot write past the buffer
   length (Matthias)

 - Mention the libata for-next branch in MAINTAINERS such that the
   git ls-remote command done by get_maintainer.pl --self-test=scm
   can verify it (Matthias)

----------------------------------------------------------------
Matthias Goergens (2):
      ata: libata-scsi: bound the ATA passthru sense descriptor writes
      MAINTAINERS: name the libata/linux for-next branch

Niklas Cassel (2):
      ata: libata-core: Extend Samsung LPM quirk to AMD controllers
      ata: libata: Correct libata.force parameter documentation

 Documentation/admin-guide/kernel-parameters.txt | 10 ++++------
 MAINTAINERS                                     |  2 +-
 drivers/ata/libata-core.c                       | 15 ++++++++-------
 drivers/ata/libata-scsi.c                       | 10 ++++++++--
 include/linux/libata.h                          |  4 ++--
 5 files changed, 23 insertions(+), 18 deletions(-)
