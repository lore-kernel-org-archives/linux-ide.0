Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B374F215
	for <linux-ide@vger.kernel.org>; Sun, 30 Jun 2024 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719782885; cv=none; b=P2pReipbDxxDnHjEReiYPKjFacq4dyoLcpdSRRmMdQetfCjPxRCPn93oA28w3dLVphaGHp2rWTzQIbXkGhkSdW//L09rB+hdqG629a5ycUGIYc4GjiLnCLwttYkIJeCKfvoc1vZWZ/4fCNlKQAryfEyRWmiCf3wsMIiYRyrOpQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719782885; c=relaxed/simple;
	bh=tQLWhgL8vWgthQJC1rqEhDjq03+nNBEobf3oql+48hA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hxd3SPLDzBWEKlDAzFxMKicU/zXb0hNPs8FdF2UPzVwn6SLq6lvYm5WbxNLhluOaHzqVVIWz4SxMK7xXcgwkkX1mygW7KAPYuAvErUJVqZseGs+KLNaHACGjg2BrdUp3ZzOYILwFCApLRhv/Bo/EnYFWQaiBQEbyAnkkqAnzFbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bETPVfvt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bETPVfvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAADC2BD10;
	Sun, 30 Jun 2024 21:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719782884;
	bh=tQLWhgL8vWgthQJC1rqEhDjq03+nNBEobf3oql+48hA=;
	h=From:To:Cc:Subject:Date:From;
	b=bETPVfvt+Jm+We9VU37nPgohz4W6/qsAxYQkKZnJO65IDzARnYYeHD7xdqOJSQXW6
	 Lbykh1x3hOZa5C4rW2+Xc4ADGtuRzxU8mzoo/sFkugCMYv1QVg4lko9fNJrjyTz28f
	 eCaxPcmuJ1sXoizKNOQdIrVn5fCwB7zqWRXY6b+5FqeyIXJbPM6voyjRUlDmFhXL68
	 DinTOMLWLTg0nEemBNXI7o1hiyutHLwsjU87bp62kZyZg2RPqAmO8lXFNnxQOvBQhH
	 l2leJnd97yMSgqRIT18P1o7A5j0GHjJrV8mQkXgny+rbXDQdYKGUWDcCwxc/vrgeGK
	 OMW+tnLQdbo1Q==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.10-rc6
Date: Sun, 30 Jun 2024 23:27:54 +0200
Message-ID: <20240630212754.207691-1-cassel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Linus,

The following changes since commit fa997b0576c9df635ee363406f5e014dba0f9264:

  ata: ahci: Do not enable LPM if no LPM states are supported by the HBA (2024-06-19 13:19:38 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc6

for you to fetch changes up to eeb25a09c5e0805d92e4ebd12c4b0ad0df1b0295:

  ata: ahci: Clean up sysfs file on error (2024-06-30 22:23:39 +0200)

----------------------------------------------------------------
ata fixes for 6.10-rc6 (or 6.10-rc7 if this PR was sent out too late.)

- Add NOLPM quirk for for all Crucial BX SSD1 models.
  Considering that we now have had bug reports for 3 different BX SSD1
  variants from Crucial with the same product name, make the quirk more
  inclusive, to catch more device models from the same generation.

- Fix a trivial null pointer dereference in the error path for
  ata_host_release().

- Create a ata_port_free(), so that we don't miss freeing ata_port struct
  members when freeing a struct ata_port.

- Fix a trivial double free in the error path for ata_host_alloc().

- Ensure that we remove the libata "remapped NVMe device count" sysfs
  entry on .probe() error.

----------------------------------------------------------------
Niklas Cassel (5):
      ata: libata-core: Add ATA_HORKAGE_NOLPM for all Crucial BX SSD1 models
      ata: libata-core: Fix null pointer dereference on error
      ata,scsi: libata-core: Do not leak memory for ata_port struct members
      ata: libata-core: Fix double free on error
      ata: ahci: Clean up sysfs file on error

 drivers/ata/ahci.c                 | 17 ++++++++++++-----
 drivers/ata/libata-core.c          | 32 +++++++++++++++++++-------------
 drivers/scsi/libsas/sas_ata.c      |  6 +++---
 drivers/scsi/libsas/sas_discover.c |  2 +-
 include/linux/libata.h             |  1 +
 5 files changed, 36 insertions(+), 22 deletions(-)
