Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD014A7CB8
	for <linux-ide@vger.kernel.org>; Fri, 18 Sep 2026 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731460; cv=none; b=RlaF2FSIgQcF1IbYZgWLpUT/7+QEWIMgYO9zYF1OG++I6mOZ8k5ePc0mx/hR2etrluRj3wpVNn7jT/hMZrUuzcOLzmBcWDJycsX6gC8k34rdmQGF3E8bf8FN+AaMNCtcueK1NyIib6BbFX4YJwldDAnZ6Thie8BmLdhpyrK/jW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731460; c=relaxed/simple;
	bh=P2BuB+A/c5vZT9xd/wyMG1h77kXlO44ZigLRuAR7Nuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7SwhFVmjMnWDa1wNqQ2YGcYGRvTKCFWmPAfk8vD1dg/CbK4zQqvcJdntCxrpkBvs39kryZSZCU/IoAD9NBVDe/Va2kbxJQqfWTaALiWxDhkzT7oD1y/hHiKS2OvYwUJOskZYseDitMR+7kNXx1AxElS0GhcHBZwELR7h6daJgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETlb5ebp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETlb5ebp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17901F000FF;
	Fri, 18 Sep 2026 11:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789731458;
	bh=4tDEQvuUGT9a9PGJOycR1s3STIF4wPrJ5JElmDa26Kg=;
	h=From:To:Cc:Subject:Date;
	b=ETlb5ebpoKMksa5McCxrG74BCQinIQJb38aQfsJg9Hn1ozftXI86zuR5vjEhXBaly
	 hvHR9zyER9MJqbfp9nBQj5iupWjbIc2G9GuDd0RnYMtfcivB/iCr8adav1RmAzSG2b
	 ILJZaxZKNI2IEmSbRdj5mgP6FkXvTj2gjwAxASgAfmUkBTTLybqWzk8XBCBLhPOT+h
	 93ib1Imgt3WJjIwzDq6BC5O47TK0cjvs4VWXNSV4WnaXeTNsDcjmpCIl22qCJg8H+c
	 WHNgzsxGNT8o/ewSY165RfSCwgbQtIoar1MkWsTmoriiZjLD1OcnyzoN01eNVe+TPL
	 9jdcJtB9EYKWQ==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 7.3-rc4
Date: Fri, 18 Sep 2026 13:37:08 +0200
Message-ID: <20260918113708.1894735-1-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit a19d4f9b8befdcfcd5a87bab91312fe64af3bbb8:

  ata: pata_legacy: remove documentation for removed module parameters (2026-09-10 19:25:48 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3-rc4

for you to fetch changes up to 8d836581f9b1f57ceaa2b47654754ef1260b410b:

  ata: libata-scsi: fix ata_dsm_trim_pages() kernel-doc (2026-09-16 16:18:00 +0200)

----------------------------------------------------------------
ata fixes for 7.4-rc4

 - Explicitly clear upper address bits on quirked AHCI controllers

   AHCI controllers that claim to support 64-bit DMA, but which have
   been quirked to only do 32-bit DMA, could start the DMA engine
   with a non-zero value in the upper address bits registers (me)

 - Fix a resource leak in ahci_platform_get_resources() (Wentao)

 - Fix invalid kernel-doc formatting for ata_dsm_trim_pages() (me)

----------------------------------------------------------------
Niklas Cassel (2):
      ata: libahci: clear PxCLBU and PxFBU for AHCI_HFLAG_32BIT_ONLY
      ata: libata-scsi: fix ata_dsm_trim_pages() kernel-doc

Wentao Liang (1):
      ata: libahci_platform: Fix device reference leak in ahci_platform_get_resources()

 drivers/ata/libahci.c          | 15 ++++++++++++++-
 drivers/ata/libahci_platform.c |  2 +-
 drivers/ata/libata-scsi.c      |  7 +++----
 3 files changed, 18 insertions(+), 6 deletions(-)
