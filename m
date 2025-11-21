Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A12F6939
	for <linux-ide@vger.kernel.org>; Fri, 21 Nov 2025 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763737871; cv=none; b=R/kAH9OSlLCzpLswRM71g43ZljvoefWFwZh1lS9X/tBZ0i92uC/6T/p9UscQWrcEyFtHqTjrE1VS6IVcE8HmhCIdRv4A+eupg/VfUuV+E5ChidL9oJRA/QQDV6ZvYTQWhKlsBNUr75kKnBA329MB0DvJ4hdDqAKUNzDQJcZKlrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763737871; c=relaxed/simple;
	bh=9wMsVyDNRzc6c8Qj62tD0g0upZE0lnIn/fjlA8mbjUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NnJ0/gxHtWX/THLNGc3/JxHK8UlKj9PcnnBWgCcfVz07RMM6NaTliaKvEHQVt7yEnX7v6SXOw4+JEpzyVVaY0KrJoGOO0kYPKcKaGcae8SJQetotxuonZQ1zXHoJwTuo7uX+dTJIEYJV3Sw4+UsWTysvDs9eXjKHtQvEBrdfwVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qique0Zk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qique0Zk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF27C4CEFB;
	Fri, 21 Nov 2025 15:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763737870;
	bh=9wMsVyDNRzc6c8Qj62tD0g0upZE0lnIn/fjlA8mbjUs=;
	h=From:To:Cc:Subject:Date:From;
	b=qique0ZkGYrY9rYaemQ7sRdsewW7y0T18elyx9zwQBXxrfdkMp6AVqcnXmt3NRO5C
	 2Td0BFnPPdy2RJ5x2UFCApkdBthB7WZ6X3umLVRiLbeNuQL7Xdr5qhmgrKrXFKsY03
	 eA3irGn3VZFPiWWHk/k7dgkJPklqQWMP395n5NHY8I6qIgPUTqkB/07ov7XEf8g9K1
	 SCZu4ar42+6cFXHZyoXdU3HGplQlcfXxqwjgQxWd6k1BWIfOkMqh/Boa3zhbFIhmg8
	 cstoUayoMWw6TeV+bK9xFSglnin/gUL3lQ5KFjeSn/Y7SOGFa4YXSIrP2bR5lg/NzM
	 J4PTFTk+IEvXw==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.18-rc7
Date: Fri, 21 Nov 2025 16:11:04 +0100
Message-ID: <20251121151104.2645094-1-cassel@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 12d724f2852d094d68dccaf5101e0ef89a971cde:

  ata: libata-core: relax checks in ata_read_log_directory() (2025-10-13 09:12:36 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.18-rc7

for you to fetch changes up to 91842ed844a068a41a38f97a1ac5535b909279cd:

  ata: libata-core: Set capacity to zero for a security locked drive (2025-11-20 13:37:18 +0100)

----------------------------------------------------------------
ata fixes for 6.18-rc7

 - Add a missing refcount decrement in ata_scsi_dev_rescan() when
   the device or its queue is not running. In the case where the
   device is running, the recount is already decremented properly
   (Yihang Li)

 - Generate the proper sense code for a Security locked device.
   There was a regression caused by a recent change of how sense
   data is generated for commands that did not provide any sense
   data. This broke system suspend for Security locked devices.
   Generate the sense data that the SCSI disk driver expects for
   a Security locked device so that system supend works again
   (me)

 - Set capacity to zero for a Security locked device.
   All I/O commands will be aborted by a Security locked device.
   Thus, the block layer disk partition scanning will result in
   a bunch of, for the user, confusing I/O errors in dmesg during
   boot. Since a Security locked device is unusable anyway, set
   the capacity to zero, to avoid the disk partition scanning
   during boot. We still create the block device in /dev such
   that the user may unlock the device using e.g. hdparm (me)

----------------------------------------------------------------
Niklas Cassel (2):
      ata: libata-scsi: Fix system suspend for a security locked drive
      ata: libata-core: Set capacity to zero for a security locked drive

Yihang Li (1):
      ata: libata-scsi: Add missing scsi_device_put() in ata_scsi_dev_rescan()

 drivers/ata/libata-core.c | 10 ++++++++++
 drivers/ata/libata-scsi.c | 11 ++++++++++-
 include/linux/ata.h       |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)
