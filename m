Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B89F2D23BC
	for <linux-ide@vger.kernel.org>; Fri, 20 Feb 2026 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771625997; cv=none; b=pdMYb0hD2YWX2o5HxbGkH0CRq4zoAN4htvjnps4yaPgQj1QhKiO/ZJNX1+dcETp67pJR68TkUZee0oR+kLfSDY/B3Q1g5uM80qEQrZuxsr3fxoAprzoHJhfVKsCxMOVZZb0n9WUz7ia1CiC5odO46fCKY83Lc4L7taGUSIjDcME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771625997; c=relaxed/simple;
	bh=GOyhatqzw2/d0CfhA4/YuPj9mK14nMXfKS0qPwdIWWg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Xbx4m1gPSOr7qmeW2349irCL4QTNpjY+W3tydan4GYYAfVLoBRP5b0AP+47DmiOS5Iq74fY1jnuUQTiI9XvV8IhPGHUPf7OHYVb5MZ++Iwf2MdJQkwfc07vklFudicXhIDbgxwlqCl4vH8V8Tc4aa7jQLW2Nb9jLaGyJt7JYS94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F12/qY64; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F12/qY64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777F3C116C6;
	Fri, 20 Feb 2026 22:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771625996;
	bh=GOyhatqzw2/d0CfhA4/YuPj9mK14nMXfKS0qPwdIWWg=;
	h=From:To:Subject:Date:From;
	b=F12/qY64iUp36abhC8HNtbXcldBUPyAcj4IwHw7Hyois1g6tMgECs3eOO/DvTQjJN
	 XwNyFmQ8HoOWn3jihqybodfmUun3kUVkqp3xzTkEAjFfFJUP3ZIkU1uQnhcLFIqgfd
	 PrhmRuA0vMu8wGTP5SxVgLVGunMBhDTjj7WcdibRNq1YdR8QhjC5ze1wXAySZNFbbP
	 tf+tnTKWv8VNZpfZ+oi1H7MwHmknm6obP3NtTxFEINZ71q8xuBk3hBzI0d3NMnSmzA
	 BBkd42l/DGEGSIKSVg8HSfhF9R8knuBui2pgnll5TvWGdL8fsqkm7oTU50QfYgyfwv
	 jWvLxqq8nojCA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 0/2] ATA port deferred qc fixes
Date: Sat, 21 Feb 2026 07:14:37 +0900
Message-ID: <20260220221439.533771-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch addresses a use-after-free issue when a deferred qc
times out. The second patch avoids a call to a potentially sleeping
function while a port spinlock is held.

Changes from v1:
 - Corrected typo in patch 1 message, improved comment in code and added
   a WARN_ON_ONCE() call to verify that a timed out qc is not active.
 - Fixed patch 2 to not call ata_scsi_requeue_deferred_qc() without the
   port lock held. This call is in fact removed: it is not needed as
   ata_scsi_requeue_deferred_qc() is called in EH, which is always run
   when removing a port.

Damien Le Moal (2):
  ata: libata-eh: correctly handle deferred qc timeouts
  ata: libata-core: fix cancellation of a port deferred qc work

 drivers/ata/libata-core.c |  8 +++-----
 drivers/ata/libata-eh.c   | 22 +++++++++++++++++++---
 2 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.53.0

