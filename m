Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407D22857F5;
	Fri,  6 Jun 2025 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749200499; cv=none; b=WjncppOy34YbIT43DuA90UJECYh+yjfueFPLjKdSTClPsTySlzT9WnTe5PyT7ertDxs3xhJEsVl0pWKU7Js7zlC6hHoSgj0geEROApPzzBKT8fjDoKHrrFCteIUur5MofKu+E7MIMaThnMk1n5vV3lIoDtsW0xVtkLG/37bQzHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749200499; c=relaxed/simple;
	bh=ohL+btFfgpdhtKelY1Y8ebWgP4pB+nV8VoY8zvTjM1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Alm83mBZE2yrgEbLofgJAxcHJXg+y3p2qiAoqM13QlCy0G4UIH83lAYiuoONCjmf5M5FlBaAcCLjWNe8FzhPXWokzagB4VxKDHytcTkiuZ8OxTqkdiA7o7KcLOgqqp073ret6wFRvB0HJ7Nt6nCqB/2wBb4WXTQul0/AFi5EnGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ijnjazfg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ijnjazfg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=cltWH0Pdf2xnkg0LSwjiml4ayLwECkb1Q68tVB+aZJY=; t=1749200498; x=1750410098; 
	b=IjnjazfgXC3iIWFioKDEa8fb7Ze0dSZ1uMIrJ7vWtadfUh9NXE1mZprWzCHUPVZZ8dMSWVgmGFx
	Nu5To6Tu0xIwQfFTQkHg327RLHPmh5AnFDCCCPBwGxCCZMvtxIUi6uv/STUC2+W5Y/g70Pwe9g9iT
	/M7wbbZ21YH1Xf7ai2CufgEj3MOjbOiCUDS+S3yPnyJYl6/vqCDREyo8+4jjh5cBGZXfGaLL/jegv
	jXz2UuxBSxhgOCAJvbErgf9luQYd90iTy3FCaAW3Laq3q/hSoZuNcyGzxB2FIKFnnnKUP0EpLRNtn
	frSObZxP8bMKM7yxRKvNeILVSmwWa/6zovIQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uNSxD-00000007Yht-1Czm;
	Fri, 06 Jun 2025 11:01:35 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ata: pata_cs5536: fix build on 32-bit UML
Date: Fri,  6 Jun 2025 11:01:11 +0200
Message-ID: <20250606090110.15784-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

On 32-bit ARCH=um, CONFIG_X86_32 is still defined, so it
doesn't indicate building on real X86 machines. There's
no MSR on UML though, so add a check for CONFIG_X86.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/ata/pata_cs5536.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index b811efd2cc34..73e81e160c91 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -27,7 +27,7 @@
 #include <scsi/scsi_host.h>
 #include <linux/dmi.h>
 
-#ifdef CONFIG_X86_32
+#if defined(CONFIG_X86) && defined(CONFIG_X86_32)
 #include <asm/msr.h>
 static int use_msr;
 module_param_named(msr, use_msr, int, 0644);
-- 
2.49.0

