Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F61CD13
	for <linux-ide@vger.kernel.org>; Tue, 19 Mar 2024 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848286; cv=none; b=hXoHbMAFdVI+pfGRN6cMAnT1DAdoKVfn3Xy6VWTlEJR0xfhfauYn8DlZdDhc9LU/uQ5CCMSyyMzcRyAaPjAje3IUtig7E589iKDjYaIrhCk8VgdJFF7GeSOhjMKoYJqx0cyj1YsMQEXDGx0zPhSSAmuHRike8F2fnoeJ5WeYueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848286; c=relaxed/simple;
	bh=LwuHaoaIjrxvC2XvRWrxpMnUkiae5ssuymoDyHsHXnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EECo6f7K1EopPrlVR2reTCA6Dvi0jG0KvxhA/2T7udqcc726/M4CLYbi5rgpFCTg4sffejJPug78WiqsyW3Mt1TqlfIf15f8zZXs5JxLQNzeuCVfHqw/srNzq/6ISXCpjw3oWgm/pUwHt2f04A6YKJtHGWN4P+vWV0lMHBdsxlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXKgYrM/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXKgYrM/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FACC433C7;
	Tue, 19 Mar 2024 11:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710848286;
	bh=LwuHaoaIjrxvC2XvRWrxpMnUkiae5ssuymoDyHsHXnw=;
	h=From:To:Cc:Subject:Date:From;
	b=uXKgYrM/JyC544wFQcW8akoqQkmbLNrlLagBOPqH4bzHA2gYspDqYnSPtgaGi9Ns3
	 Uk8TTSGrVHrunkS0Q0noYFLI+yYHgxRs4LKLMIWnMoMIEX6dyaT5YPPmcDjQ3B3EIx
	 DvRrmlMLx+yfGqcJ/qk3OOHUR8pspmAKpunEeoY4pPs5bPGDAkNeM55xohuMqQemkB
	 wITiAwVq0iwsleehKcJInOJ+80DRrrFDrhpIeKOluTlq1Rd9lZn6oB6ff/yoE+CeR2
	 L+CeF3tYEfaFMxSQfu8MPAEvtsLj++085HZzYpeTnjLuTr5XgbIp4G7cuM/0/Y7z6h
	 kWXK5loxao+5w==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.9-rc1
Date: Tue, 19 Mar 2024 12:37:58 +0100
Message-ID: <20240319113758.197709-1-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit b3603fcb79b1036acae10602bffc4855a4b9af80:

  Merge tag 'dlm-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm (2024-03-18 15:39:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.9-rc1-2

for you to fetch changes up to 6cd8adc3e18960f6e59d797285ed34ef473cc896:

  ahci: asm1064: asm1166: don't limit reported ports (2024-03-19 12:06:54 +0100)

----------------------------------------------------------------
ata fixes for 6.9-rc1

 - A single fix for ASMedia HBAs.
   These HBAs do not indicate that they support SATA Port Multipliers
   CAP.SPM (Supports Port Multiplier) is not set.

   Likewise, they do not allow you to probe the devices behind an
   attached PMP, as defined according to the SATA-IO PMP specification.

   Instead, they have decided to implement their own version of PMP,
   and because of this, plugging in a PMP actually works, even if the
   HBA claims that it does not support PMP.

   Revert a recent quirk for these HBAs, as that breaks ASMedia's own
   implementation of PMP.

   Unfortunately, this will once again give some users of these HBAs
   significantly increased boot time. However, a longer boot time for
   some, is the lesser evil compared to some other users not being able
   to detect their drives at all.

----------------------------------------------------------------
Conrad Kostecki (1):
      ahci: asm1064: asm1166: don't limit reported ports

 drivers/ata/ahci.c | 13 -------------
 1 file changed, 13 deletions(-)
