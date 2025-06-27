Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88D7293B7D
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019276; cv=none; b=V1EwYFqqMkt8JL5B6gyxrNjnGxE7MR56u8gn5YTXMTGl/6FVrgpv+TgXLGqEwMiHYa3eI2tqdN9sQORg79IYQQ6I0ZmVSuS82ZXopLCsNgoVzc1OwhZZ1Q0ss05qzK6bRQ1FseFxRt1P0HQBzjTQ3Ylc5fOF9t5Kq9bBipeYAG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019276; c=relaxed/simple;
	bh=OnF7erlqRPWCeVSmuTPuZQ6DC0WBKmCpzz1uypyo3kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pyc8T/LkhVfz9o4h+S6LR3P/7KQkmlLseFnLdktP04RsJpcp8V1PWn/t9OtMP6tTnayy0ul8TeZr0TOhd/81PFfaA3qOjypBzEatTe5CiJhQ1jUJAdSCAa+WmssoGs2l7pKvQMu/czNVSpRw0x9B/+tr6dHljUdmzrMZspjBHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sh+6icRK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh+6icRK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A22C4CEE3;
	Fri, 27 Jun 2025 10:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751019276;
	bh=OnF7erlqRPWCeVSmuTPuZQ6DC0WBKmCpzz1uypyo3kk=;
	h=From:To:Cc:Subject:Date:From;
	b=sh+6icRK3Ghq/OM3itswxAEd0X13HAfOPk7NnohFHavZVDV5BrsWq7o5zxtA9DB8D
	 cMJFpAas429rNs2c5ANrD1NO+Xw7oOZzx1j6lcBSKhH4qeZ5EjPmgNC4esCmSw3JVY
	 Mz5KCPZA91UHTYYnXz4/d1OQqAw4eDaKiZfLbV+1ShqKWQs6Vuza1Y+e6inQ5j+yW7
	 jaf2CkuQ0+jOLdq5glyFNeqtBzgV08IsGsAE08dpI7QMbiq1i0Vp3QdbHMSD9AoD0t
	 6ObKpK9dJoyn3/MNPz+pd7ZtG9QkpeOQ4jTe2jvETEeC5IrQPZr5lpzxS2HPTISdrD
	 DaITKUqQnsiaw==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.16-rc4
Date: Fri, 27 Jun 2025 12:14:31 +0200
Message-ID: <20250627101431.1667919-1-cassel@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit a7b3b77fd111d49f8e25624e4ea1046322a57baf:

  ata: ahci: Disallow LPM for Asus B550-F motherboard (2025-06-17 11:11:39 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.16-rc4

for you to fetch changes up to 3e0809b1664b9dc650d9dbca9a2d3ac690d4f661:

  ata: ahci: Use correct DMI identifier for ASUSPRO-D840SA LPM quirk (2025-06-25 15:17:57 +0200)

----------------------------------------------------------------
ata fix for 6.16-rc4

 - Use the correct DMI identifier for ASUSPRO-D840SA LPM quirk such that
   the quirk actually gets applied (me)

----------------------------------------------------------------
Niklas Cassel (1):
      ata: ahci: Use correct DMI identifier for ASUSPRO-D840SA LPM quirk

 drivers/ata/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
