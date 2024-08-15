Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3671714CC
	for <linux-ide@vger.kernel.org>; Thu, 15 Aug 2024 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725809; cv=none; b=bGKHnciuvekvlzHAXeGFUaVKRGjvcc5SoXNc7VVxrnZ6hFGIsKK3TOPh/R0ZQuUHrgzTBJNnwEsjkO9f/LNZz02cf1+Y8423Nh5C22WzXpV2SSiD8HsJ77HIawmjjalXyaJ9zGhqCT6OtyDVEprJm5lxgo6wYMmtGXz1UNEJ/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725809; c=relaxed/simple;
	bh=xjKwxLtVNcX9s7+cOLi4dNAy5lwI1++5Oz+zW4JZo68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LpQ81sXh9bHbhk1YYAEtJTM3SDQWKHpCOTtjoEszysmB75lPhNOWtmisiP47q8pB1KYo2ByD0K0Ok/+k1ALoxg8a7L7/oS9US2XTcdRmAegM0E5xIJr3bDAvfJuGMbCHRtaO+Bs5rKHWBSOpzJf2rviKLpMdRroMAbM25ZHVGrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqsaDAlr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqsaDAlr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D21EC32786;
	Thu, 15 Aug 2024 12:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723725808;
	bh=xjKwxLtVNcX9s7+cOLi4dNAy5lwI1++5Oz+zW4JZo68=;
	h=From:To:Cc:Subject:Date:From;
	b=lqsaDAlrtJxZnsOTh0gkg/bpT4yLaQMhxbovcGV3tD7AURzQWgOxG0Xlo+gUMIMnu
	 m8zx291e24B+pSZ1H7YIgOxEeIfSvqWwdrmEuW2DAAZp3MMvJH5G9XJ4hI3i+DnDxJ
	 uIRpAfcGYM6Ra9XInt31eUBuObL0gwp8Ar/nxwr7pR90XDN8MVEHfnTd0ePYWStXwG
	 wZNDcNps82YG6PcdK0K/+3epphveyCfKF4SivMHX0W2J636M+2nZ7LihzyvEmOIduG
	 MLooBXnfZErBdjNXZfWs5ncKQ6t9YRlzKm/u2vag2PO0dqeVFDOrenyqWCVvyRgh0d
	 CbIzumkB8kCdg==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.11-rc4
Date: Thu, 15 Aug 2024 14:43:10 +0200
Message-ID: <20240815124310.1349324-1-cassel@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 89fb4dfacbb33750e0243848f4c54d73e558ba9a:

  dt-bindings: ata: rockchip-dwc-ahci: add missing power-domains (2024-07-29 09:04:09 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.11-rc4

for you to fetch changes up to fa0db8e568787c665384430eaf2221b299b85367:

  Revert "ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error" (2024-08-14 15:49:37 +0200)

----------------------------------------------------------------
ata fixes for 6.11-rc4

 - Revert a recent change to sense data generation.

   Sense data can be in either fixed format or descriptor format.

   The D_SENSE bit in the Control mode page controls which format to
   generate. All places but one respected the D_SENSE bit.

   The recent change fixed the one place that didn't respect the D_SENSE
   bit. However, it turns out that hdparm, hddtemp and udisks
   (incorrectly) assumes sense data in descriptor format.

   Therefore, even while the change was technically correct, revert it,
   since even if these user space programs are fixed to (correctly) look
   at the format type before parsing the data, older versions of these
   tools will be around roughly forever.

----------------------------------------------------------------
Niklas Cassel (1):
      Revert "ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error"

 drivers/ata/libata-scsi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)
