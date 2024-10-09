Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BF61684A5
	for <linux-ide@vger.kernel.org>; Wed,  9 Oct 2024 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461759; cv=none; b=F/1b+8tzvlQsIU5ZDe8ck89S8dtNG+NkUkkzP65d8uGbb7MZo5bs77SQo5hvu1MuGxZtuCgS9zy42tdNazem19eaHdVI0CBZ8cwmxyxMNg1zLtBAVeV4nKmDERPUdvDtubulytYP7UIl02MQRyTWmLB70tcG8/OFCA89C1NrqZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461759; c=relaxed/simple;
	bh=uHkPpynOwk3ZMg7cTSCuBkYkVYZZpZMF4f0s2JPncX8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CG0uUl8kJcvKPaZU/KbhqFiTgsaB+LO5/rEUalNRct871nQGu/a+M8eY9kRCG8M1638LY8xbPJ9lGyzcz2pCVvQJUFFtkiVONlvtBMKASHHsOdgZJIeFopMtRtU66J10h4BUBc17d/ksmVRI14CchkmKwmAXcXFFNQd3Oq223dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtlL5jDi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtlL5jDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FD6C4CECF;
	Wed,  9 Oct 2024 08:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728461759;
	bh=uHkPpynOwk3ZMg7cTSCuBkYkVYZZpZMF4f0s2JPncX8=;
	h=From:To:Subject:Date:From;
	b=dtlL5jDi7sqZ38JkQ4yVH9NNxUkmy/CG2wBbK6+DBawMOupnR/RFKp0PT5eOjuQsI
	 /EFAP7wwIXn6RhvrLP00+rTyGvpWvME7LMFdZGXGQG1vnpyMB4/AwJO7rdjfonsJWD
	 3GsRIOdCHLsDpxx8T9qqFiODSan4VdJxxqgLxd3glWWHWz2EEsPUrcbzZb/1CjfyuI
	 3fTwaZKjHo0O2+3z4xgdLQGTGtDPHztlbFglTp9Wi17lGMK2CWSsasr0JQiAztASyC
	 YKOiqjrlPDoOZgtszMjSkeW68IZnnoC/1q8z7Ppf7fppWxbNks7o+Zb3Jg5nDp4Jh7
	 isBKZJQ/f8zRQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] ata: ahci_platform: Modify MAINTAINERS entry
Date: Wed,  9 Oct 2024 17:15:57 +0900
Message-ID: <20241009081557.377035-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the MAINTAINERS entry for the ahci_platform driver (LIBATA SATA
AHCI PLATFORM devices support) to remove Jens as maintainer.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..d377e81ab2bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12961,7 +12961,6 @@ F:	drivers/ata/sata_gemini.h
 
 LIBATA SATA AHCI PLATFORM devices support
 M:	Hans de Goede <hdegoede@redhat.com>
-M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-ide@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
-- 
2.46.2

