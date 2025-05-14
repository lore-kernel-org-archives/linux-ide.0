Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384941C862D
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747243338; cv=none; b=U8OX2oEoMm1Q8bviRGVzWABuY/RTrFsckuEzcuKmepnMWWVSCLcdVyy41CS8CtBf8UuUSsqFD89aNuK4q+ANS08Sg0m6V9A1qo3gqj0IJ0vo7gdpV3Va47kZBh77knmIeCzWozegXZesDhfFGtyBMGQLb5r7jcpmYiFNLkbWy7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747243338; c=relaxed/simple;
	bh=wSO7sLabDJNx5rdBnAaZaYAX579JnwjKT6bQXYX4cRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eM4fAgThVxHGEJLlkIAPw2dG6QS2pEya4W5T3s4vrFj9l8Axm0JJGdI+fQ6PKpJQQa91H17vSvygwOvNyNVJYi3Z654Gxt4mRAynAH65ULM27o5INWWX/3tgIuyOklQER/u9o2T4pgw2ZRCXuFVOPN16+sG8gOERq2/mVvBvM/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqmQE6pi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqmQE6pi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AE7C4CEE3;
	Wed, 14 May 2025 17:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747243337;
	bh=wSO7sLabDJNx5rdBnAaZaYAX579JnwjKT6bQXYX4cRs=;
	h=From:To:Cc:Subject:Date:From;
	b=dqmQE6piFGQBBTx43b6+Xz1ExlSBqnZ4sKeRHbJnAXvDG/Y09CFjQl1pMwPwPqR2t
	 FNjE79O9vWk2pgA3jbEGQpT8pKZitNbRmBUNO5L16ZKPS3NWlcEYcLRECKSR6p/UDe
	 70DzlMTm3bWriKFlF/rvUY0N1lMerxU/ljXkyfKDo7UBcjiA6F7lt33qfJZjx9npAI
	 lZNxiggV7IHmpkoxbE6gYYXSF9sL6RZjHVt2CcSxKOBMZwmgf134k0jCYD5YEYGrJw
	 +9elfNLVZNIHft53qTf9+DZ7mYvo0/Cw3rZ9SGF95HwO3uzVCeUdpGdzSZSat4FnVo
	 80wNZB/gWPtLQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 0/7] ata_eh_set_lpm() cleanups
Date: Wed, 14 May 2025 19:22:10 +0200
Message-ID: <20250514172210.383801-9-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=749; i=cassel@kernel.org; h=from:subject; bh=wSO7sLabDJNx5rdBnAaZaYAX579JnwjKT6bQXYX4cRs=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJULjpF3mhuOHzqaZHeBc2Vy5Y9WHKEQVB2V6gfp+9TY fVdG99/6ihlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEptoz/PcR5/k344bFBwPD CXmB+7Je3M+YkDdHe/HJgEnTmWLYrz1gZJjQPv+5yoUE413XGN6xP696b7nD5PfyC68FOlMTGoR OTWYEAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello Damien,

I was trying to understand ata_eh_set_lpm(), and decided that
it needed some cleanups to make the code more understandable.

Please have a look.


Niklas Cassel (7):
  ata: libata-eh: Update DIPM comments to reflect reality
  ata: libata-eh: Add ata_eh_set_lpm() WARN_ON
  ata: libata-eh: Drop dipm variable
  ata: libata-eh: Introduce dev_has_dipm and dev_has_hipm variables
  ata: libata-eh: Rename no_dipm variable to be more clear
  ata: libata-eh: Host support has nothing to do with disabling DIPM
  ata: libata-eh: Always disable DIPM before calling set_lpm() callback

 drivers/ata/libata-eh.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

-- 
2.49.0

