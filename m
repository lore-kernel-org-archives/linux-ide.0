Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98D826CE25
	for <linux-ide@vger.kernel.org>; Mon, 19 Jan 2026 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852950; cv=none; b=sQrRSSX8iF9USs13cnAyuiBAyXB40FuBXoaTxRWbDMLm0aX3T7t9nGiTFnlKUlEM3OuJtueNcDJL45/zzQB8Z4Dy+3vqAPGzjW+K3TorY4/mFve1gFZ9MUFuwW7v7O5aEzMxnbMsBEksvf8lzRJ35gdq0ly5lDke3pyZwPjZPus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852950; c=relaxed/simple;
	bh=ZsLUjS8VKgsm4XzKkjhDhTBMqQX1rXXCreO1kotlJBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yzq3H/0k6c5fxuJUtDmiZIwnJa3d+WZjAB/rTOLaBJ04cVmt1/6sD1gsx+PgmI4z1C+IGzuAxEsGwxEUDQgoRSiL4PE5E80RvHdmeJjHnRd/ZM+gORLYrnslrgrpImg1bPDOoUxi4i/GzjEVcUDsvxywt1WfsgbTJhJ5mc4wFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXxlZ0LK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXxlZ0LK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E9CC116C6;
	Mon, 19 Jan 2026 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768852950;
	bh=ZsLUjS8VKgsm4XzKkjhDhTBMqQX1rXXCreO1kotlJBg=;
	h=From:To:Cc:Subject:Date:From;
	b=TXxlZ0LKQcIXM68grf3Tqwpuc8iNC4e+tiT53xwaD4wgHgtVHj6RyuGKk/hbpg37B
	 M+bCu7wC2zVmYCx1f5efvsJHtaHwyGB0Yvz278f35npHZK5RjFUWbuUHjW76RkQQWw
	 koc9tdiQs/kY6ZFDKJz1A4VVHpdqdEqHV4XeQlManXzl8u2RB+c8A2Nym8zRKim/nt
	 NQKVV8rgAoGqets0/YGZRHg7khG62ocCxxsMYAhsIF2G111WnJ2D8uxQhXMVGvwgP7
	 pvhwf5b8Xz/iGjeADu36BpJZqghudneOL4hSJAEr5rfHnW9L+6iMa9eLO/VJBxokLK
	 5hiUxW25nNbcw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.19-rc7
Date: Tue, 20 Jan 2026 04:57:42 +0900
Message-ID: <20260119195742.320390-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 0f61b1860cc3f52aef9036d7235ed1f017632193:

  Linux 6.19-rc5 (2026-01-11 17:03:14 -1000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.19-rc7

for you to fetch changes up to c8c6fb886f57d5bf71fb6de6334a143608d35707:

  ata: libata: Print features also for ATAPI devices (2026-01-13 22:00:02 +0900)

----------------------------------------------------------------
ata fixes for 6.19-rc7

 * A set of fixes for link power management as the recent changes/fixes
   introduced regressions with ATAPI devices and with adapters that have
   DUMMY ports, preventing an adapter to fully reach a low power state
   and thus preventing the system CPU from reaching low power C-states
   (from Niklas).

----------------------------------------------------------------
Niklas Cassel (6):
      ata: ahci: Do not read the per port area for unimplemented ports
      ata: libata: Call ata_dev_config_lpm() for ATAPI devices
      ata: libata-sata: Improve link_power_management_supported sysfs attribute
      ata: libata: Add cpr_log to ata_dev_print_features() early return
      ata: libata: Add DIPM and HIPM to ata_dev_print_features() early return
      ata: libata: Print features also for ATAPI devices

 drivers/ata/ahci.c        | 10 +++++-----
 drivers/ata/libata-core.c |  8 +++++++-
 drivers/ata/libata-sata.c |  2 +-
 3 files changed, 13 insertions(+), 7 deletions(-)
