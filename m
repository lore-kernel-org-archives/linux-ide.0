Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C884B5CDF1
	for <linux-ide@vger.kernel.org>; Wed,  6 Aug 2025 04:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754456051; cv=none; b=oAV6/XLRTg6DWf8XJYuoLzkXmxQ8mtx+N9mT9KoON8Pka30e8TJvhlAxF9vMo77gWK/X3aHPVP6gfpAgIdXrOf9tB/z43Q20+mXiF3AWVZqPaDiW+umX6OnPXTfDfG2Tx2KkfGjQUjEVqlhvp60tsFKfZIwIgefxNnRfgZOFK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754456051; c=relaxed/simple;
	bh=r3XZDxvgv7Q0g/utrcCwBZBvJ0C7rjQ8cbxlxUEQZI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bCR5FZj16Qb+KO1+CNjcFOlI817Ag9FfX4+e1eaX8yv30kQYTzHGdhnOzszJaht2qIl1ISRCW+fIH0niEmaT5J3VnEWH9CEHqRYqmKoYT4Fgpfg0jA6MnLvvfdo0gM0xX0C+qGD0n6YUGB/nMNzhEd7IbxADy9WswdInMlsxB/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZFwP5Um; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZFwP5Um"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168D8C4CEE7;
	Wed,  6 Aug 2025 04:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754456050;
	bh=r3XZDxvgv7Q0g/utrcCwBZBvJ0C7rjQ8cbxlxUEQZI0=;
	h=From:To:Cc:Subject:Date:From;
	b=FZFwP5Um5gn6vena3LVu+CfvjCcOF4i5qxgdIB4YJCyXyY4VFSFBGG4PoxRq+wyVQ
	 hvFC2rTPonvKyhI0+GGKzWqC3whaYKFZSNSaaqXfHoFaqR/C/v3KLa7YE4SEEqN33f
	 aSKzQd8FwqR/XMLPT7cLAaxR4L5dvvlIdMkBOpRBDTtTox7zKlkLFjxFt++JNOHHZ6
	 dnvTJX3VnGQnExfBOVH5VnrnU9Q3nRa7+mwB/pBusRdEesqpTAB9PfmStnuablsw27
	 DlFaxiX0r+KN+zR7ts/CkwGsNylymA9Ta0b7RutA8yoxuP1CPUsg2Zvj6mk6izhXeK
	 0ub60NFen12hg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.17-rc1-fixes
Date: Wed,  6 Aug 2025 13:51:37 +0900
Message-ID: <20250806045137.729300-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 260f6f4fda93c8485c8037865c941b42b9cba5d2:

  Merge tag 'drm-next-2025-07-30' of https://gitlab.freedesktop.org/drm/kernel (2025-07-30 19:26:49 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.17-rc1-fixes

for you to fetch changes up to 6cb43739b93c64c4a2148222bd606e6920257752:

  ata: pata_pdc2027x: Remove space before newline and abbreviations (2025-08-01 08:43:11 +0900)

----------------------------------------------------------------
ata fixes for 6.17-rc1

 - Cleanup whitespace in messages in libata-core and the pata_pdc2027x,
   pata_macio drivers (Colin).

 - Fix ata_to_sense_error() to avoid seeing nonsensical sense data for
   rare cases where we fail to get sense data from the drive. The
   complementary fix to this is to ensure that we always return the
   generic "ABORTED COMMAND" sense data for a failed command for which
   we have no status or error fields.

 - The recent changes to link power management (LPM) which now prevent
   the user from attempting to set an LPM policy through the
   link_power_management_policy caused some regressions in test
   environments because of the error that is now returned when writing
   to that attribute when LPM is not supported. To allow users to not
   trip on this, introduce the new link_power_management_supported
   attribute to allow simple testing of a port/device LPM support (me).

----------------------------------------------------------------
Colin Ian King (3):
      ata: libata-core: Remove space before newline
      ata: pata_macio: Remove space before newline
      ata: pata_pdc2027x: Remove space before newline and abbreviations

Damien Le Moal (3):
      ata: libata-scsi: Fix ata_to_sense_error() status handling
      ata: libata-scsi: Return aborted command when missing sense and result TF
      ata: libata-sata: Add link_power_management_supported sysfs attribute

 drivers/ata/ata_piix.c      |  1 +
 drivers/ata/libahci.c       |  1 +
 drivers/ata/libata-core.c   |  2 +-
 drivers/ata/libata-sata.c   | 53 +++++++++++++++++++++++++++++++++++----------
 drivers/ata/libata-scsi.c   | 38 ++++++++++++++++----------------
 drivers/ata/pata_macio.c    |  2 +-
 drivers/ata/pata_pdc2027x.c | 12 +++++-----
 include/linux/libata.h      |  1 +
 8 files changed, 71 insertions(+), 39 deletions(-)
